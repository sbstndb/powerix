#include <benchmark/benchmark.h>
#include <cstdint>
#include <cmath>
#include <vector>
#include <iostream>
#include <random>
#include <immintrin.h>
#include "../src/pow_impl.hpp"

// ============================================================================
// DOUBLE BASE x INTEGER EXPONENT: BRANCHLESS ASM INVESTIGATION
// ============================================================================
//
// CONTEXT:
// For uint64_t (integer base, integer exp), the cmov trick gave 10-23% wins
// over GCC's branchy code. The question now: does the same idea help for
// double bases?
//
// KEY DIFFERENCES FROM INTEGER CASE:
// 1. Multiplication: mulsd (SSE2) instead of imul. mulsd has ~4-5 cycle
//    latency on modern Intel (vs 3 for imul). This makes the multiply more
//    expensive, so eliminating branch overhead is proportionally less impactful.
//
// 2. No cmov for FP: cmov only works on GPR registers. For XMM/YMM, the
//    branchless alternatives are:
//    a) vblendvpd: select based on a mask register. Requires the condition
//       in an XMM register, which means extra instructions to broadcast.
//    b) Multiply by 1.0: if exp bit is 0, multiply result by 1.0 (identity).
//       This costs a mulsd every iteration but eliminates the branch.
//    c) andpd/orpd mask trick: zero out one operand based on condition.
//       Doesn't preserve the "multiply or don't" semantics cleanly.
//
// 3. Compiler behavior: GCC/Clang with -Ofast may already vectorize or
//    use conditional moves for FP code via the ternary pattern. The question
//    is whether hand-tuned asm can beat it.
//
// STRATEGY:
// Test three approaches:
//   1. Scalar loop with branch (baseline) -- standard binary exp
//   2. Branchless scalar C++ -- ternary to select current vs 1.0
//   3. Inline asm with vblendvpd -- true branchless FP selection
// Compare all against std::pow for reference.
//
// ============================================================================

// ============================================================================
// IMPLEMENTATION 1: Scalar loop with branch (baseline)
// ============================================================================
// Standard binary exponentiation for double base, unsigned int exp.
// The "if (exp & 1)" is a branch; the compiler may or may not convert it.
__attribute__((noinline))
static double pow_scalar_double(double base, unsigned int exp) {
    if (exp == 0) return 1.0;
    if (exp == 1) return base;
    double result = 1.0;
    double current = base;
    while (exp > 0) {
        if (exp & 1) result *= current;
        current *= current;
        exp >>= 1;
    }
    return result;
}

// ============================================================================
// IMPLEMENTATION 2: Branchless scalar C++ (multiply-by-1.0 trick)
// ============================================================================
// Instead of branching on exp&1, always multiply by either 'current' or '1.0'.
// The ternary *may* compile to a branch anyway, or the compiler might use
// a conditional move / blend. With -Ofast, GCC sometimes does the right thing.
__attribute__((noinline))
static double pow_branchless_double(double base, unsigned int exp) {
    if (exp == 0) return 1.0;
    double result = 1.0;
    double current = base;
    while (exp > 0) {
        // Branchless: multiply by either 'current' or '1.0'
        double selector = (exp & 1) ? current : 1.0;
        result *= selector;
        current *= current;
        exp >>= 1;
    }
    return result;
}

// ============================================================================
// IMPLEMENTATION 3: Inline asm with SSE2 branchless selection
// ============================================================================
// Strategy: use integer test + setne to build a mask, then use the mask
// to blend between (result * current) and result.
//
// Since vblendvpd uses the sign bit of the mask, we need to construct
// a proper mask. Approach:
//   - test exp, 1 -> sets ZF
//   - Use integer ops to create an all-ones or all-zeros mask in a GPR
//   - movq the mask into an XMM register
//   - Use andpd/andnpd/orpd to blend
//
// Alternative simpler approach: compute result*current unconditionally,
// then use vblendvpd with a mask derived from exp&1.
//
// Actually, the simplest correct approach for SSE2 (no AVX needed):
//   temp = result * current          (mulsd)
//   mask = (exp & 1) ? all_ones : 0  (integer ops + movq)
//   result = (temp & mask) | (result & ~mask)  -- but this corrupts FP bits!
//
// The CORRECT approach for FP conditional select without AVX:
//   temp = result * current
//   Move exp&1 to a GPR, negate to get 0 or 0xFFFFFFFFFFFFFFFF
//   movq to xmm, then:
//     blended = (temp AND mask) OR (result AND NOT mask)
//   But AND/OR on FP values works at the bit level, which is fine for
//   selecting one of two values (not for arithmetic blending).
//
// With AVX2: vblendvpd is cleaner -- it uses the sign bit of the mask operand.
//   We set the mask to all-ones (sign bit = 1) when exp&1 == 1.

__attribute__((noinline))
static double pow_asm_blend(double base, unsigned int exp) {
    double result;
    double one = 1.0;

    // We use:
    //   xmm0 = result (initialized to 1.0)
    //   xmm1 = current (base)
    //   xmm2 = temp (result * current)
    //   xmm3 = mask (for blending)
    //   edi  = exp (modified in loop)
    //   rax  = scratch for mask construction
    //
    // Loop body:
    //   temp = result * current
    //   mask = (exp & 1) ? 0xFFFF...F : 0x0000...0
    //   result = blend(result, temp, mask)   -- select temp when mask is set
    //   current *= current
    //   exp >>= 1
    //   loop if exp != 0

    asm volatile(
        "movsd %[one], %%xmm0\n\t"          // result = 1.0
        "movsd %[base], %%xmm1\n\t"         // current = base
        "test %[exp], %[exp]\n\t"            // if exp == 0, skip
        "jz 2f\n\t"
        ".p2align 4\n\t"
    "1:\n\t"
        // temp = result * current
        "movapd %%xmm0, %%xmm2\n\t"         // temp = result
        "mulsd %%xmm1, %%xmm2\n\t"          // temp *= current

        // Build mask: if exp&1, mask = all ones; else mask = all zeros
        "mov %[exp], %%eax\n\t"              // eax = exp
        "and $1, %%eax\n\t"                  // eax = exp & 1
        "neg %%eax\n\t"                      // eax = 0 or 0xFFFFFFFF
        "movsx %%eax, %%rax\n\t"             // sign extend to 64-bit: 0 or 0xFFFFFFFFFFFFFFFF
        "movq %%rax, %%xmm3\n\t"            // xmm3 = mask

        // Blend: result = (mask) ? temp : result
        // Using AND/ANDN/OR (SSE2, no AVX needed):
        //   result = (temp & mask) | (result & ~mask)
        "movapd %%xmm2, %%xmm4\n\t"         // xmm4 = temp
        "andpd %%xmm3, %%xmm4\n\t"          // xmm4 = temp & mask
        "andnpd %%xmm0, %%xmm3\n\t"         // xmm3 = ~mask & result (andnpd: xmm3 = ~xmm3 & xmm0)
        "orpd %%xmm4, %%xmm3\n\t"           // xmm3 = (temp & mask) | (result & ~mask)
        "movapd %%xmm3, %%xmm0\n\t"         // result = blended

        // current *= current
        "mulsd %%xmm1, %%xmm1\n\t"          // current = current * current

        // exp >>= 1
        "shr %[exp]\n\t"                     // exp >>= 1
        "jnz 1b\n\t"                         // loop while exp != 0
    "2:\n\t"
        "movsd %%xmm0, %[result]\n\t"        // store result
        : [result] "=m"(result), [exp] "+r"(exp)
        : [base] "m"(base), [one] "m"(one)
        : "rax", "xmm0", "xmm1", "xmm2", "xmm3", "xmm4", "cc", "memory"
    );
    return result;
}

// ============================================================================
// IMPLEMENTATION 4: Inline asm with multiply-by-1.0 trick (no blend needed)
// ============================================================================
// Instead of blending, always multiply -- but multiply by 1.0 when exp&1==0.
// This means: select = (exp&1) ? current : 1.0, then result *= select.
// The selection still needs a blend/cmov, but on 1.0 vs current, not on
// result vs result*current. This avoids one mulsd on the critical path
// because the "temp = result * current" computation is replaced by
// "result *= selector" where selector is pre-computed.
//
// Wait -- that's the same number of multiplies. The advantage is that
// the blend is on (current, 1.0) which might pipeline better since
// both values are available before the multiply, allowing the blend
// to complete while the previous multiply retires.

__attribute__((noinline))
static double pow_asm_mul1(double base, unsigned int exp) {
    double result;
    double one = 1.0;

    asm volatile(
        "movsd %[one], %%xmm0\n\t"          // result = 1.0
        "movsd %[base], %%xmm1\n\t"         // current = base
        "movsd %[one], %%xmm5\n\t"          // xmm5 = constant 1.0
        "test %[exp], %[exp]\n\t"
        "jz 2f\n\t"
        ".p2align 4\n\t"
    "1:\n\t"
        // Build mask for selecting current vs 1.0
        "mov %[exp], %%eax\n\t"
        "and $1, %%eax\n\t"
        "neg %%eax\n\t"
        "movsx %%eax, %%rax\n\t"
        "movq %%rax, %%xmm3\n\t"            // xmm3 = mask (all 1s or all 0s)

        // selector = (exp&1) ? current : 1.0
        "movapd %%xmm1, %%xmm4\n\t"         // xmm4 = current
        "andpd %%xmm3, %%xmm4\n\t"          // xmm4 = current & mask
        "andnpd %%xmm5, %%xmm3\n\t"         // xmm3 = ~mask & 1.0
        "orpd %%xmm4, %%xmm3\n\t"           // xmm3 = selector

        // result *= selector
        "mulsd %%xmm3, %%xmm0\n\t"

        // current *= current
        "mulsd %%xmm1, %%xmm1\n\t"

        "shr %[exp]\n\t"
        "jnz 1b\n\t"
    "2:\n\t"
        "movsd %%xmm0, %[result]\n\t"
        : [result] "=m"(result), [exp] "+r"(exp)
        : [base] "m"(base), [one] "m"(one)
        : "rax", "xmm0", "xmm1", "xmm3", "xmm4", "xmm5", "cc", "memory"
    );
    return result;
}

// ============================================================================
// IMPLEMENTATION 5: Library pow_hierarchical (double base, unsigned int exp)
// ============================================================================
// The library's pow_hierarchical already supports double base with unsigned exp.
__attribute__((noinline))
static double wrap_pow_hierarchical(double base, unsigned int exp) {
    return powerix::pow_hierarchical(base, exp);
}

// ============================================================================
// IMPLEMENTATION 6: Library pow_binary (double base, unsigned int exp)
// ============================================================================
__attribute__((noinline))
static double wrap_pow_binary(double base, unsigned int exp) {
    return powerix::pow_binary(base, exp);
}

// ============================================================================
// IMPLEMENTATION 7: std::pow reference
// ============================================================================
__attribute__((noinline))
static double wrap_std_pow(double base, unsigned int exp) {
    return std::pow(base, static_cast<double>(exp));
}


// ============================================================================
// TEST DATA GENERATION
// ============================================================================
struct TestCase {
    double base;
    unsigned int exp;
};

static std::vector<TestCase> generate_test_data(unsigned int exponent, size_t count = 1024) {
    std::mt19937_64 rng(42 + exponent); // deterministic seed per exponent
    std::uniform_real_distribution<double> dist(0.5, 2.0);

    std::vector<TestCase> data;
    data.reserve(count);
    for (size_t i = 0; i < count; ++i) {
        data.push_back({dist(rng), exponent});
    }
    return data;
}

// Pre-generated test sets for exponents 3, 7, 13
static const auto kTestExp3  = generate_test_data(3);
static const auto kTestExp7  = generate_test_data(7);
static const auto kTestExp13 = generate_test_data(13);

// ============================================================================
// CORRECTNESS VERIFICATION
// ============================================================================
static bool verify_correctness() {
    bool all_ok = true;
    // Test a range of bases and exponents
    double bases[] = {0.0, 0.5, 1.0, 1.5, 2.0, 3.14159, 0.001, 100.0, -2.5};
    unsigned int exps[] = {0, 1, 2, 3, 4, 5, 7, 8, 10, 13, 20};

    for (double b : bases) {
        for (unsigned int e : exps) {
            double ref = pow_scalar_double(b, e);
            double v_branchless = pow_branchless_double(b, e);
            double v_asm_blend  = pow_asm_blend(b, e);
            double v_asm_mul1   = pow_asm_mul1(b, e);
            double v_hier       = wrap_pow_hierarchical(b, e);
            double v_binary     = wrap_pow_binary(b, e);

            // Use relative tolerance for FP comparison
            auto close_enough = [](double a, double c) {
                if (a == c) return true;
                if (std::isnan(a) && std::isnan(c)) return true;
                if (std::isinf(a) || std::isinf(c)) return a == c;
                double denom = std::max(std::abs(a), std::abs(c));
                if (denom == 0.0) return true;
                return std::abs(a - c) / denom < 1e-12;
            };

            if (!close_enough(v_branchless, ref) ||
                !close_enough(v_asm_blend, ref) ||
                !close_enough(v_asm_mul1, ref) ||
                !close_enough(v_hier, ref) ||
                !close_enough(v_binary, ref)) {
                std::cerr << "MISMATCH: base=" << b << " exp=" << e
                          << " ref=" << ref
                          << " branchless=" << v_branchless
                          << " asm_blend=" << v_asm_blend
                          << " asm_mul1=" << v_asm_mul1
                          << " hier=" << v_hier
                          << " binary=" << v_binary
                          << "\n";
                all_ok = false;
            }
        }
    }
    return all_ok;
}

// ============================================================================
// BENCHMARK TEMPLATE
// ============================================================================
using PowFn = double(*)(double, unsigned int);

template<PowFn Func>
static void BM_Double(benchmark::State& state, const std::vector<TestCase>& data) {
    for (auto _ : state) {
        double sum = 0.0;
        for (const auto& tc : data) {
            sum += Func(tc.base, tc.exp);
        }
        benchmark::DoNotOptimize(sum);
    }
    state.SetItemsProcessed(state.iterations() * static_cast<int64_t>(data.size()));
}

// ============================================================================
// EXPONENT = 3
// ============================================================================
static void BM_ScalarLoop_Exp3(benchmark::State& s)      { BM_Double<pow_scalar_double>(s, kTestExp3); }
static void BM_Branchless_Exp3(benchmark::State& s)      { BM_Double<pow_branchless_double>(s, kTestExp3); }
static void BM_AsmBlend_Exp3(benchmark::State& s)        { BM_Double<pow_asm_blend>(s, kTestExp3); }
static void BM_AsmMul1_Exp3(benchmark::State& s)         { BM_Double<pow_asm_mul1>(s, kTestExp3); }
static void BM_Hierarchical_Exp3(benchmark::State& s)    { BM_Double<wrap_pow_hierarchical>(s, kTestExp3); }
static void BM_Binary_Exp3(benchmark::State& s)          { BM_Double<wrap_pow_binary>(s, kTestExp3); }
static void BM_StdPow_Exp3(benchmark::State& s)          { BM_Double<wrap_std_pow>(s, kTestExp3); }

BENCHMARK(BM_ScalarLoop_Exp3);
BENCHMARK(BM_Branchless_Exp3);
BENCHMARK(BM_AsmBlend_Exp3);
BENCHMARK(BM_AsmMul1_Exp3);
BENCHMARK(BM_Hierarchical_Exp3);
BENCHMARK(BM_Binary_Exp3);
BENCHMARK(BM_StdPow_Exp3);

// ============================================================================
// EXPONENT = 7
// ============================================================================
static void BM_ScalarLoop_Exp7(benchmark::State& s)      { BM_Double<pow_scalar_double>(s, kTestExp7); }
static void BM_Branchless_Exp7(benchmark::State& s)      { BM_Double<pow_branchless_double>(s, kTestExp7); }
static void BM_AsmBlend_Exp7(benchmark::State& s)        { BM_Double<pow_asm_blend>(s, kTestExp7); }
static void BM_AsmMul1_Exp7(benchmark::State& s)         { BM_Double<pow_asm_mul1>(s, kTestExp7); }
static void BM_Hierarchical_Exp7(benchmark::State& s)    { BM_Double<wrap_pow_hierarchical>(s, kTestExp7); }
static void BM_Binary_Exp7(benchmark::State& s)          { BM_Double<wrap_pow_binary>(s, kTestExp7); }
static void BM_StdPow_Exp7(benchmark::State& s)          { BM_Double<wrap_std_pow>(s, kTestExp7); }

BENCHMARK(BM_ScalarLoop_Exp7);
BENCHMARK(BM_Branchless_Exp7);
BENCHMARK(BM_AsmBlend_Exp7);
BENCHMARK(BM_AsmMul1_Exp7);
BENCHMARK(BM_Hierarchical_Exp7);
BENCHMARK(BM_Binary_Exp7);
BENCHMARK(BM_StdPow_Exp7);

// ============================================================================
// EXPONENT = 13
// ============================================================================
static void BM_ScalarLoop_Exp13(benchmark::State& s)     { BM_Double<pow_scalar_double>(s, kTestExp13); }
static void BM_Branchless_Exp13(benchmark::State& s)     { BM_Double<pow_branchless_double>(s, kTestExp13); }
static void BM_AsmBlend_Exp13(benchmark::State& s)       { BM_Double<pow_asm_blend>(s, kTestExp13); }
static void BM_AsmMul1_Exp13(benchmark::State& s)        { BM_Double<pow_asm_mul1>(s, kTestExp13); }
static void BM_Hierarchical_Exp13(benchmark::State& s)   { BM_Double<wrap_pow_hierarchical>(s, kTestExp13); }
static void BM_Binary_Exp13(benchmark::State& s)         { BM_Double<wrap_pow_binary>(s, kTestExp13); }
static void BM_StdPow_Exp13(benchmark::State& s)         { BM_Double<wrap_std_pow>(s, kTestExp13); }

BENCHMARK(BM_ScalarLoop_Exp13);
BENCHMARK(BM_Branchless_Exp13);
BENCHMARK(BM_AsmBlend_Exp13);
BENCHMARK(BM_AsmMul1_Exp13);
BENCHMARK(BM_Hierarchical_Exp13);
BENCHMARK(BM_Binary_Exp13);
BENCHMARK(BM_StdPow_Exp13);

// ============================================================================
// MAIN
// ============================================================================
int main(int argc, char** argv) {
    std::cout << "=== DOUBLE BASE x INTEGER EXPONENT: BRANCHLESS ASM BENCHMARK ===\n\n";

    std::cout << "=== CORRECTNESS VERIFICATION ===\n";
    if (!verify_correctness()) {
        std::cerr << "CORRECTNESS CHECK FAILED -- aborting benchmarks.\n";
        return 1;
    }
    std::cout << "All implementations produce identical results.\n\n";

    std::cout << "=== IMPLEMENTATION NOTES ===\n";
    std::cout << "ScalarLoop:    Standard binary exp with branch on exp&1\n";
    std::cout << "Branchless:    C++ ternary selecting current vs 1.0 (compiler decides cmov/branch)\n";
    std::cout << "AsmBlend:      Inline asm with andpd/andnpd/orpd mask blend (fully branchless)\n";
    std::cout << "AsmMul1:       Inline asm selecting current vs 1.0 via mask, then always multiply\n";
    std::cout << "Hierarchical:  powerix::pow_hierarchical (recursive divide & conquer)\n";
    std::cout << "Binary:        powerix::pow_binary (library binary exp)\n";
    std::cout << "StdPow:        std::pow(double, double) reference\n";
    std::cout << "\n";
    std::cout << "Test data: 1024 random doubles in [0.5, 2.0] per exponent value\n";
    std::cout << "Exponents tested: 3, 7, 13\n\n";

    benchmark::Initialize(&argc, argv);
    benchmark::RunSpecifiedBenchmarks();
    benchmark::Shutdown();
    return 0;
}
