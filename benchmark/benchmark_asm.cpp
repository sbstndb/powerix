#include <benchmark/benchmark.h>
#include <cstdint>
#include <cmath>
#include <vector>
#include <iostream>
#include "../src/pow_impl.hpp"

// ============================================================================
// ANALYSIS OF GCC's ASSEMBLY OUTPUT FOR pow_hierarchical
// ============================================================================
//
// WHAT GCC DOES WELL:
// - Unrolls 9 recursion levels into straight-line imul+shr+and+je chains
// - Each level: imul rX,rX (square); shr rY (halve exp); cmp+je (done?);
//   conditional imul for odd exponents
// - The binary version (test_binary) compiles to a tight 5-instruction loop
//
// WHAT GCC DOES POORLY:
// 1. NO CMOV: every odd-exponent check is a branch (je/jne) with a separate
//    mov fallthrough. The "if odd, multiply" pattern is IDEAL for cmov.
//
// 2. REGISTER SPILLS: pushes 6 callee-saved regs (r15,r14,r13,r12,rbp,rbx)
//    plus 56 bytes of stack. The algorithm only needs ~3 live values at a time.
//
// 3. RECURSIVE FALLBACK: for exp >= 512, falls to a real call instruction
//    with full prologue/epilogue overhead.
//
// 4. REDUNDANT MOVs: many register shuffles just to maintain the
//    "branch taken vs fallthrough" structure. A branchless approach
//    eliminates most of these.
//
// CAN WE USE MULX INSTEAD OF IMUL?
// MULX (BMI2) computes r1:r0 = rdx * src, without touching flags.
// For uint64_t where we only need the low 64 bits, MULX has the SAME
// throughput as IMUL on modern Intel (1 cycle throughput), but:
//   - It requires the multiplicand in RDX (constraining register allocation)
//   - It writes TWO output registers (we discard the high one)
//   - Its advantage (no flag clobbering) doesn't help us here
// Verdict: MULX would NOT help. IMUL is the right choice.
//
// ============================================================================
// STRATEGY FOR HAND-CRAFTED VERSION
// ============================================================================
//
// The binary exponentiation loop:
//   result = 1; while(exp > 0) { if(exp&1) result*=base; base*=base; exp>>=1; }
//
// The branch "if(exp&1) result*=base" can be made branchless with cmov:
//   temp = result * base;     // always compute
//   cmov(exp&1, result, temp) // select: if odd, use temp; else keep result
//
// This eliminates the branch entirely. On modern CPUs with good branch
// prediction (the exp&1 pattern is essentially random for arbitrary exponents),
// the branch version suffers ~50% mispredict rate on random data.
//
// The loop itself (shr+jnz) is a well-predicted backward branch and is
// essentially free on modern CPUs. Unrolling it would just bloat icache
// without benefit for the general case.
//
// Key insight: the hierarchical (unrolled) version beats binary for SMALL
// exponents because it avoids loop overhead entirely. For LARGE exponents,
// you MUST loop. So the question is: can a branchless loop beat the
// unrolled version even for small exponents?
//
// ============================================================================

// --- Hand-crafted inline asm: branchless binary exponentiation ---
// Uses cmov to eliminate the "if (exp & 1)" branch.
// Only needs 4 registers: result, base, exp, temp.
// No stack frame, no spills, no recursive fallback.
__attribute__((noinline))
static uint64_t pow_asm_cmov(uint64_t base, uint64_t exp) {
    uint64_t result;
    // Strategy:
    //   result = 1
    //   while (exp != 0):
    //     temp = result * base
    //     if (exp & 1): result = temp   [via cmov]
    //     base = base * base
    //     exp >>= 1
    //
    // Registers:
    //   rax = result
    //   rdi = base (input, clobbered)
    //   rsi = exp  (input, clobbered)
    //   rcx = temp
    //
    asm volatile(
        "mov $1, %%rax\n\t"          // result = 1
        "test %%rsi, %%rsi\n\t"      // if exp == 0, skip
        "jz 2f\n\t"
        ".p2align 4\n\t"
    "1:\n\t"
        "mov %%rax, %%rcx\n\t"       // temp = result
        "imul %%rdi, %%rcx\n\t"      // temp = result * base
        "test $1, %%sil\n\t"         // test exp & 1
        "cmovnz %%rcx, %%rax\n\t"    // if odd: result = temp
        "imul %%rdi, %%rdi\n\t"      // base = base * base
        "shr %%rsi\n\t"              // exp >>= 1
        "jnz 1b\n\t"                 // loop while exp != 0
    "2:\n\t"
        : "=a"(result), "+D"(base), "+S"(exp)
        :
        : "rcx", "cc"
    );
    return result;
}

// --- Variant 2: Fully unrolled branchless for 64-bit exponents ---
// Since uint64_t exponents have at most 64 bits, we can unroll all 64
// iterations. This eliminates the loop branch entirely.
// Trade-off: 64 * 4 instructions = 256 instructions of straight-line code.
// This will be HUGE in icache but completely branchless.
__attribute__((noinline))
static uint64_t pow_asm_unrolled64(uint64_t base, uint64_t exp) {
    uint64_t result;
    // We unroll the loop 64 times with a macro
    // Each iteration: temp=result*base; cmov if bit set; base*=base
    // After bit 63, we're done (no more shr needed on last iteration).

    // Actually, for practical exponents (anything that doesn't overflow uint64_t),
    // base^64 = 0 for any base > 1 (since 2^64 overflows). So most of the
    // unrolled iterations are dead for practical inputs. But the CPU still
    // has to execute them all.
    //
    // This is illustrative -- the cmov-loop version above should be better
    // because the loop exit (jnz) terminates early.

    asm volatile(
        "mov $1, %%rax\n\t"          // result = 1
        "test %%rsi, %%rsi\n\t"      // if exp == 0, done
        "jz 2f\n\t"

        // We'll do a semi-unrolled version: unroll 8 iterations at a time
        // with an early exit check every 8 bits.
        // This gives us 8x fewer loop branches while keeping code size sane.

        ".p2align 4\n\t"
    "1:\n\t"
        // Iteration 1
        "mov %%rax, %%rcx\n\t"
        "imul %%rdi, %%rcx\n\t"
        "test $1, %%sil\n\t"
        "cmovnz %%rcx, %%rax\n\t"
        "imul %%rdi, %%rdi\n\t"
        "shr %%rsi\n\t"
        "jz 2f\n\t"

        // Iteration 2
        "mov %%rax, %%rcx\n\t"
        "imul %%rdi, %%rcx\n\t"
        "test $1, %%sil\n\t"
        "cmovnz %%rcx, %%rax\n\t"
        "imul %%rdi, %%rdi\n\t"
        "shr %%rsi\n\t"
        "jz 2f\n\t"

        // Iteration 3
        "mov %%rax, %%rcx\n\t"
        "imul %%rdi, %%rcx\n\t"
        "test $1, %%sil\n\t"
        "cmovnz %%rcx, %%rax\n\t"
        "imul %%rdi, %%rdi\n\t"
        "shr %%rsi\n\t"
        "jz 2f\n\t"

        // Iteration 4
        "mov %%rax, %%rcx\n\t"
        "imul %%rdi, %%rcx\n\t"
        "test $1, %%sil\n\t"
        "cmovnz %%rcx, %%rax\n\t"
        "imul %%rdi, %%rdi\n\t"
        "shr %%rsi\n\t"
        "jz 2f\n\t"

        // Iteration 5
        "mov %%rax, %%rcx\n\t"
        "imul %%rdi, %%rcx\n\t"
        "test $1, %%sil\n\t"
        "cmovnz %%rcx, %%rax\n\t"
        "imul %%rdi, %%rdi\n\t"
        "shr %%rsi\n\t"
        "jz 2f\n\t"

        // Iteration 6
        "mov %%rax, %%rcx\n\t"
        "imul %%rdi, %%rcx\n\t"
        "test $1, %%sil\n\t"
        "cmovnz %%rcx, %%rax\n\t"
        "imul %%rdi, %%rdi\n\t"
        "shr %%rsi\n\t"
        "jz 2f\n\t"

        // Iteration 7
        "mov %%rax, %%rcx\n\t"
        "imul %%rdi, %%rcx\n\t"
        "test $1, %%sil\n\t"
        "cmovnz %%rcx, %%rax\n\t"
        "imul %%rdi, %%rdi\n\t"
        "shr %%rsi\n\t"
        "jz 2f\n\t"

        // Iteration 8
        "mov %%rax, %%rcx\n\t"
        "imul %%rdi, %%rcx\n\t"
        "test $1, %%sil\n\t"
        "cmovnz %%rcx, %%rax\n\t"
        "imul %%rdi, %%rdi\n\t"
        "shr %%rsi\n\t"
        "jnz 1b\n\t"

    "2:\n\t"
        : "=a"(result), "+D"(base), "+S"(exp)
        :
        : "rcx", "cc"
    );
    return result;
}


// --- Variant 3: C++ branchless version (let's see if the compiler ---
// --- can generate cmov from C++ source when we hint it right)     ---
__attribute__((noinline))
static uint64_t pow_cpp_branchless(uint64_t base, uint64_t exp) {
    uint64_t result = 1;
    while (exp > 0) {
        // Branchless: multiply conditionally using arithmetic mask
        // (exp & 1) is 0 or 1. We want: result = (exp&1) ? result*base : result
        // Equivalent: result *= (exp&1) ? base : 1
        // Which the compiler MIGHT turn into cmov.
        uint64_t temp = result * base;
        result = (exp & 1) ? temp : result;
        base *= base;
        exp >>= 1;
    }
    return result;
}

// --- Variant 4: Pure C++ with ternary that GCC might turn into cmov ---
__attribute__((noinline))
static uint64_t pow_cpp_ternary(uint64_t base, uint64_t exp) {
    uint64_t result = 1;
    while (exp) {
        uint64_t multiplier = (exp & 1) ? base : 1;
        result *= multiplier;
        base *= base;
        exp >>= 1;
    }
    return result;
}


// ============================================================================
// CORRECTNESS VERIFICATION
// ============================================================================
static bool verify_correctness() {
    bool all_ok = true;
    // Test against pow_binary as reference
    uint64_t bases[] = {0, 1, 2, 3, 5, 7, 10, 13, 100, 12345, UINT64_MAX};
    uint64_t exps[]  = {0, 1, 2, 3, 4, 5, 8, 10, 13, 20, 30, 40, 63};

    for (uint64_t b : bases) {
        for (uint64_t e : exps) {
            uint64_t ref = powerix::pow_binary(b, e);
            uint64_t v1 = pow_asm_cmov(b, e);
            uint64_t v2 = pow_asm_unrolled64(b, e);
            uint64_t v3 = pow_cpp_branchless(b, e);
            uint64_t v4 = pow_cpp_ternary(b, e);
            if (v1 != ref || v2 != ref || v3 != ref || v4 != ref) {
                std::cerr << "MISMATCH: base=" << b << " exp=" << e
                          << " ref=" << ref
                          << " asm_cmov=" << v1
                          << " asm_unrolled=" << v2
                          << " cpp_branchless=" << v3
                          << " cpp_ternary=" << v4
                          << "\n";
                all_ok = false;
            }
        }
    }
    return all_ok;
}

// ============================================================================
// BENCHMARKS
// ============================================================================

// Test data: small exponents (0-10) -- this is where hierarchical shines
static const std::vector<std::pair<uint64_t, uint64_t>> kSmallExp = {
    {2, 0}, {2, 1}, {2, 2}, {2, 3}, {2, 5}, {2, 8}, {2, 10},
    {3, 0}, {3, 1}, {3, 2}, {3, 3}, {3, 5}, {3, 8}, {3, 10},
    {5, 0}, {5, 1}, {5, 2}, {5, 3}, {5, 5}, {5, 8}, {5, 10},
    {7, 0}, {7, 1}, {7, 2}, {7, 3}, {7, 5}, {7, 8}, {7, 10},
};

// Test data: medium exponents (10-30)
static const std::vector<std::pair<uint64_t, uint64_t>> kMedExp = {
    {2, 10}, {2, 15}, {2, 20}, {2, 25}, {2, 30},
    {3, 10}, {3, 15}, {3, 20}, {3, 25}, {3, 30},
    {5, 10}, {5, 15}, {5, 20}, {5, 25}, {5, 30},
    {7, 10}, {7, 15}, {7, 20}, {7, 25}, {7, 30},
};

// Test data: large exponents (30-63)
static const std::vector<std::pair<uint64_t, uint64_t>> kLargeExp = {
    {2, 30}, {2, 40}, {2, 50}, {2, 60}, {2, 63},
    {3, 30}, {3, 35}, {3, 40},
    {5, 25}, {5, 27},
    {7, 20}, {7, 22},
    {13, 15}, {13, 17},
    {100, 9},
};

// Template for benchmarking with a dataset
template<uint64_t (*Func)(uint64_t, uint64_t)>
static void BM_Pow(benchmark::State& state, const std::vector<std::pair<uint64_t, uint64_t>>& data) {
    for (auto _ : state) {
        uint64_t sum = 0;
        for (const auto& [b, e] : data) {
            sum += Func(b, e);
        }
        benchmark::DoNotOptimize(sum);
    }
    state.SetItemsProcessed(state.iterations() * data.size());
}

// Wrappers for the library functions (need noinline to prevent inlining artifacts)
__attribute__((noinline))
static uint64_t wrap_hierarchical(uint64_t b, uint64_t e) {
    return powerix::pow_hierarchical(b, e);
}

__attribute__((noinline))
static uint64_t wrap_binary(uint64_t b, uint64_t e) {
    return powerix::pow_binary(b, e);
}

__attribute__((noinline))
static uint64_t wrap_ultra_fast(uint64_t b, uint64_t e) {
    return powerix::pow_ultra_fast(b, e);
}

// ---- SMALL EXPONENTS ----
static void BM_Hierarchical_Small(benchmark::State& s) { BM_Pow<wrap_hierarchical>(s, kSmallExp); }
static void BM_Binary_Small(benchmark::State& s)       { BM_Pow<wrap_binary>(s, kSmallExp); }
static void BM_UltraFast_Small(benchmark::State& s)    { BM_Pow<wrap_ultra_fast>(s, kSmallExp); }
static void BM_AsmCmov_Small(benchmark::State& s)      { BM_Pow<pow_asm_cmov>(s, kSmallExp); }
static void BM_AsmUnrolled_Small(benchmark::State& s)  { BM_Pow<pow_asm_unrolled64>(s, kSmallExp); }
static void BM_CppBranchless_Small(benchmark::State& s) { BM_Pow<pow_cpp_branchless>(s, kSmallExp); }
static void BM_CppTernary_Small(benchmark::State& s)   { BM_Pow<pow_cpp_ternary>(s, kSmallExp); }

BENCHMARK(BM_Hierarchical_Small);
BENCHMARK(BM_Binary_Small);
BENCHMARK(BM_UltraFast_Small);
BENCHMARK(BM_AsmCmov_Small);
BENCHMARK(BM_AsmUnrolled_Small);
BENCHMARK(BM_CppBranchless_Small);
BENCHMARK(BM_CppTernary_Small);

// ---- MEDIUM EXPONENTS ----
static void BM_Hierarchical_Med(benchmark::State& s) { BM_Pow<wrap_hierarchical>(s, kMedExp); }
static void BM_Binary_Med(benchmark::State& s)       { BM_Pow<wrap_binary>(s, kMedExp); }
static void BM_UltraFast_Med(benchmark::State& s)    { BM_Pow<wrap_ultra_fast>(s, kMedExp); }
static void BM_AsmCmov_Med(benchmark::State& s)      { BM_Pow<pow_asm_cmov>(s, kMedExp); }
static void BM_AsmUnrolled_Med(benchmark::State& s)  { BM_Pow<pow_asm_unrolled64>(s, kMedExp); }
static void BM_CppBranchless_Med(benchmark::State& s) { BM_Pow<pow_cpp_branchless>(s, kMedExp); }
static void BM_CppTernary_Med(benchmark::State& s)   { BM_Pow<pow_cpp_ternary>(s, kMedExp); }

BENCHMARK(BM_Hierarchical_Med);
BENCHMARK(BM_Binary_Med);
BENCHMARK(BM_UltraFast_Med);
BENCHMARK(BM_AsmCmov_Med);
BENCHMARK(BM_AsmUnrolled_Med);
BENCHMARK(BM_CppBranchless_Med);
BENCHMARK(BM_CppTernary_Med);

// ---- LARGE EXPONENTS ----
static void BM_Hierarchical_Large(benchmark::State& s) { BM_Pow<wrap_hierarchical>(s, kLargeExp); }
static void BM_Binary_Large(benchmark::State& s)       { BM_Pow<wrap_binary>(s, kLargeExp); }
static void BM_UltraFast_Large(benchmark::State& s)    { BM_Pow<wrap_ultra_fast>(s, kLargeExp); }
static void BM_AsmCmov_Large(benchmark::State& s)      { BM_Pow<pow_asm_cmov>(s, kLargeExp); }
static void BM_AsmUnrolled_Large(benchmark::State& s)  { BM_Pow<pow_asm_unrolled64>(s, kLargeExp); }
static void BM_CppBranchless_Large(benchmark::State& s) { BM_Pow<pow_cpp_branchless>(s, kLargeExp); }
static void BM_CppTernary_Large(benchmark::State& s)   { BM_Pow<pow_cpp_ternary>(s, kLargeExp); }

BENCHMARK(BM_Hierarchical_Large);
BENCHMARK(BM_Binary_Large);
BENCHMARK(BM_UltraFast_Large);
BENCHMARK(BM_AsmCmov_Large);
BENCHMARK(BM_AsmUnrolled_Large);
BENCHMARK(BM_CppBranchless_Large);
BENCHMARK(BM_CppTernary_Large);

// ============================================================================
// MAIN -- verify correctness first, then run benchmarks
// ============================================================================
int main(int argc, char** argv) {
    std::cout << "=== CORRECTNESS VERIFICATION ===\n";
    if (!verify_correctness()) {
        std::cerr << "CORRECTNESS CHECK FAILED -- aborting benchmarks.\n";
        return 1;
    }
    std::cout << "All implementations produce identical results.\n\n";

    // Dump the asm for our inline asm version so we can see what we got
    std::cout << "=== IMPLEMENTATION NOTES ===\n";
    std::cout << "pow_asm_cmov:      Inline asm, cmov-based branchless loop (4 regs, no stack)\n";
    std::cout << "pow_asm_unrolled64: Inline asm, 8x unrolled cmov loop with early exit\n";
    std::cout << "pow_cpp_branchless: C++ ternary (compiler-generated, may or may not use cmov)\n";
    std::cout << "pow_cpp_ternary:    C++ multiplier=(exp&1)?base:1 (may use cmov)\n";
    std::cout << "\n";

    benchmark::Initialize(&argc, argv);
    benchmark::RunSpecifiedBenchmarks();
    benchmark::Shutdown();
    return 0;
}
