#include <benchmark/benchmark.h>
#include <immintrin.h>
#include <cmath>
#include <cstdint>
#include <vector>
#include <iostream>
#include <iomanip>
#include <algorithm>
#include <random>
#include "../src/pow_impl.hpp"

// ============================================================
// SCENARIO 1: float bases, uniform integer exponent (AVX2, 8 lanes)
// ============================================================
inline __m256 pow_avx2_f(__m256 bases, unsigned int n) {
    if (n == 0) return _mm256_set1_ps(1.0f);
    if (n == 1) return bases;
    __m256 result = _mm256_set1_ps(1.0f);
    __m256 current = bases;
    while (n > 0) {
        if (n & 1) result = _mm256_mul_ps(result, current);
        current = _mm256_mul_ps(current, current);
        n >>= 1;
    }
    return result;
}

inline void pow_avx2_batch_f(const float* __restrict__ in,
                             float* __restrict__ out,
                             size_t n,
                             unsigned int exp) {
    size_t i = 0;
    for (; i + 7 < n; i += 8) {
        __m256 bases = _mm256_loadu_ps(in + i);
        __m256 res   = pow_avx2_f(bases, exp);
        _mm256_storeu_ps(out + i, res);
    }
    // Scalar tail
    for (; i < n; ++i) {
        out[i] = static_cast<float>(
            powerix::pow_hierarchical(static_cast<float>(in[i]), exp));
    }
}

// ============================================================
// SCENARIO 2: uint32 bases, uniform integer exponent (AVX2, 8 lanes)
// Uses _mm256_mullo_epi32 (AVX2)
// NOTE: No _mm256_mullo_epi64 in AVX2 -- uint64 SIMD would
//       require emulation and is skipped here.
// ============================================================
inline __m256i pow_avx2_i32(__m256i bases, unsigned int n) {
    if (n == 0) return _mm256_set1_epi32(1);
    if (n == 1) return bases;
    __m256i result = _mm256_set1_epi32(1);
    __m256i current = bases;
    while (n > 0) {
        if (n & 1) result = _mm256_mullo_epi32(result, current);
        current = _mm256_mullo_epi32(current, current);
        n >>= 1;
    }
    return result;
}

inline void pow_avx2_batch_i32(const uint32_t* __restrict__ in,
                               uint32_t* __restrict__ out,
                               size_t n,
                               unsigned int exp) {
    size_t i = 0;
    for (; i + 7 < n; i += 8) {
        __m256i bases = _mm256_loadu_si256(
            reinterpret_cast<const __m256i*>(in + i));
        __m256i res   = pow_avx2_i32(bases, exp);
        _mm256_storeu_si256(reinterpret_cast<__m256i*>(out + i), res);
    }
    // Scalar tail
    for (; i < n; ++i) {
        out[i] = powerix::pow_hierarchical(in[i], exp);
    }
}

// ============================================================
// Test data
// ============================================================
static constexpr size_t N = 1024;

static std::vector<float>& get_float_data() {
    static std::vector<float> data = []() {
        std::mt19937 rng(42);
        std::uniform_real_distribution<float> dist(0.5f, 4.0f);
        std::vector<float> v(N);
        for (auto& x : v) x = dist(rng);
        return v;
    }();
    return data;
}

static std::vector<uint32_t>& get_u32_data() {
    static std::vector<uint32_t> data = []() {
        std::mt19937 rng(123);
        std::uniform_int_distribution<uint32_t> dist(1, 50);
        std::vector<uint32_t> v(N);
        for (auto& x : v) x = dist(rng);
        return v;
    }();
    return data;
}

// ============================================================
// SCENARIO 1 BENCHMARKS: float
// ============================================================

// Scalar std::pow (float)
static void BM_Float_ScalarStdPow(benchmark::State& state) {
    const auto& input = get_float_data();
    std::vector<float> output(N);
    const unsigned int exp = static_cast<unsigned int>(state.range(0));

    for (auto _ : state) {
        for (size_t i = 0; i < N; ++i) {
            output[i] = std::pow(input[i], static_cast<float>(exp));
        }
        benchmark::DoNotOptimize(output.data());
        benchmark::ClobberMemory();
    }
    state.SetItemsProcessed(static_cast<int64_t>(state.iterations()) * N);
    state.counters["ns/elem"] = benchmark::Counter(
        static_cast<double>(N),
        benchmark::Counter::kIsIterationInvariantRate | benchmark::Counter::kInvert,
        benchmark::Counter::kIs1000
    );
}

// Scalar hierarchical (float via cast)
static void BM_Float_ScalarHierarchical(benchmark::State& state) {
    const auto& input = get_float_data();
    std::vector<float> output(N);
    const unsigned int exp = static_cast<unsigned int>(state.range(0));

    for (auto _ : state) {
        for (size_t i = 0; i < N; ++i) {
            output[i] = static_cast<float>(
                powerix::pow_hierarchical(static_cast<float>(input[i]), exp));
        }
        benchmark::DoNotOptimize(output.data());
        benchmark::ClobberMemory();
    }
    state.SetItemsProcessed(static_cast<int64_t>(state.iterations()) * N);
    state.counters["ns/elem"] = benchmark::Counter(
        static_cast<double>(N),
        benchmark::Counter::kIsIterationInvariantRate | benchmark::Counter::kInvert,
        benchmark::Counter::kIs1000
    );
}

// SIMD AVX2 float (8 lanes)
static void BM_Float_SimdAvx2(benchmark::State& state) {
    const auto& input = get_float_data();
    std::vector<float> output(N);
    const unsigned int exp = static_cast<unsigned int>(state.range(0));

    for (auto _ : state) {
        pow_avx2_batch_f(input.data(), output.data(), N, exp);
        benchmark::DoNotOptimize(output.data());
        benchmark::ClobberMemory();
    }
    state.SetItemsProcessed(static_cast<int64_t>(state.iterations()) * N);
    state.counters["ns/elem"] = benchmark::Counter(
        static_cast<double>(N),
        benchmark::Counter::kIsIterationInvariantRate | benchmark::Counter::kInvert,
        benchmark::Counter::kIs1000
    );
}

// ============================================================
// SCENARIO 2 BENCHMARKS: uint32
// ============================================================

// Scalar hierarchical (uint32)
static void BM_U32_ScalarHierarchical(benchmark::State& state) {
    const auto& input = get_u32_data();
    std::vector<uint32_t> output(N);
    const unsigned int exp = static_cast<unsigned int>(state.range(0));

    for (auto _ : state) {
        for (size_t i = 0; i < N; ++i) {
            output[i] = powerix::pow_hierarchical(input[i], exp);
        }
        benchmark::DoNotOptimize(output.data());
        benchmark::ClobberMemory();
    }
    state.SetItemsProcessed(static_cast<int64_t>(state.iterations()) * N);
    state.counters["ns/elem"] = benchmark::Counter(
        static_cast<double>(N),
        benchmark::Counter::kIsIterationInvariantRate | benchmark::Counter::kInvert,
        benchmark::Counter::kIs1000
    );
}

// SIMD AVX2 uint32 (8 lanes, _mm256_mullo_epi32)
static void BM_U32_SimdAvx2(benchmark::State& state) {
    const auto& input = get_u32_data();
    std::vector<uint32_t> output(N);
    const unsigned int exp = static_cast<unsigned int>(state.range(0));

    for (auto _ : state) {
        pow_avx2_batch_i32(input.data(), output.data(), N, exp);
        benchmark::DoNotOptimize(output.data());
        benchmark::ClobberMemory();
    }
    state.SetItemsProcessed(static_cast<int64_t>(state.iterations()) * N);
    state.counters["ns/elem"] = benchmark::Counter(
        static_cast<double>(N),
        benchmark::Counter::kIsIterationInvariantRate | benchmark::Counter::kInvert,
        benchmark::Counter::kIs1000
    );
}

// ============================================================
// Register benchmarks for exponents 3, 7, 13
// ============================================================

// Scenario 1: float
BENCHMARK(BM_Float_ScalarStdPow)->Arg(3)->Arg(7)->Arg(13);
BENCHMARK(BM_Float_ScalarHierarchical)->Arg(3)->Arg(7)->Arg(13);
BENCHMARK(BM_Float_SimdAvx2)->Arg(3)->Arg(7)->Arg(13);

// Scenario 2: uint32
BENCHMARK(BM_U32_ScalarHierarchical)->Arg(3)->Arg(7)->Arg(13);
BENCHMARK(BM_U32_SimdAvx2)->Arg(3)->Arg(7)->Arg(13);

// ============================================================
// Accuracy validation
// ============================================================
static void validate_accuracy() {
    const auto& float_input = get_float_data();
    const auto& u32_input   = get_u32_data();

    std::vector<float>    simd_f_out(N);
    std::vector<uint32_t> simd_u32_out(N);

    unsigned int exponents[] = {3, 7, 13};

    // --- Scenario 1: float accuracy vs std::pow ---
    std::cout << "\n===== SCENARIO 1: FLOAT ACCURACY (max relative error vs std::pow) =====\n";
    std::cout << std::setw(10) << "Exponent"
              << std::setw(25) << "SIMD_f MaxRelErr"
              << std::setw(25) << "Hierarchical MaxRelErr"
              << "\n";
    std::cout << std::string(60, '-') << "\n";

    for (unsigned int exp : exponents) {
        pow_avx2_batch_f(float_input.data(), simd_f_out.data(), N, exp);

        double simd_max_rel = 0.0;
        double hier_max_rel = 0.0;

        for (size_t i = 0; i < N; ++i) {
            float ref = std::pow(float_input[i], static_cast<float>(exp));
            float hier = static_cast<float>(
                powerix::pow_hierarchical(static_cast<float>(float_input[i]), exp));

            if (ref != 0.0f) {
                double simd_rel = std::abs(
                    static_cast<double>(simd_f_out[i]) - static_cast<double>(ref))
                    / std::abs(static_cast<double>(ref));
                double hier_rel = std::abs(
                    static_cast<double>(hier) - static_cast<double>(ref))
                    / std::abs(static_cast<double>(ref));
                simd_max_rel = std::max(simd_max_rel, simd_rel);
                hier_max_rel = std::max(hier_max_rel, hier_rel);
            }
        }

        std::cout << std::setw(10) << exp
                  << std::setw(25) << std::scientific << std::setprecision(6) << simd_max_rel
                  << std::setw(25) << std::scientific << std::setprecision(6) << hier_max_rel
                  << "\n";
    }
    std::cout << "===================================================================\n";

    // --- Scenario 2: uint32 accuracy (exact match expected) ---
    std::cout << "\n===== SCENARIO 2: UINT32 ACCURACY (exact match vs scalar hierarchical) =====\n";
    std::cout << std::setw(10) << "Exponent"
              << std::setw(15) << "Mismatches"
              << std::setw(25) << "vs std::pow MaxAbsErr"
              << "\n";
    std::cout << std::string(50, '-') << "\n";

    for (unsigned int exp : exponents) {
        pow_avx2_batch_i32(u32_input.data(), simd_u32_out.data(), N, exp);

        size_t mismatches = 0;
        double max_abs_err = 0.0;

        for (size_t i = 0; i < N; ++i) {
            uint32_t scalar = powerix::pow_hierarchical(u32_input[i], exp);
            if (simd_u32_out[i] != scalar) {
                ++mismatches;
            }
            // Compare against std::pow for reference (note: overflow wraps for uint32)
            double ref = std::pow(static_cast<double>(u32_input[i]),
                                  static_cast<double>(exp));
            double abs_err = std::abs(
                static_cast<double>(simd_u32_out[i]) - ref);
            max_abs_err = std::max(max_abs_err, abs_err);
        }

        std::cout << std::setw(10) << exp
                  << std::setw(15) << mismatches
                  << std::setw(25) << std::scientific << std::setprecision(6) << max_abs_err
                  << "\n";
    }
    std::cout << "=====================================================================\n";

    std::cout << "\nNOTE: uint64 SIMD on AVX2 is skipped -- no _mm256_mullo_epi64 intrinsic;\n"
              << "      emulation via 4x scalar or cross-lane shuffles negates the benefit.\n\n";
}

// ============================================================
// main: run validation, then Google Benchmark
// ============================================================
int main(int argc, char** argv) {
    validate_accuracy();

    benchmark::Initialize(&argc, argv);
    benchmark::RunSpecifiedBenchmarks();
    benchmark::Shutdown();
    return 0;
}
