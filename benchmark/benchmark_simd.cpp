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
// SIMD AVX2 pow: 4 doubles, uniform unsigned int exponent
// Uses binary exponentiation with _mm256_mul_pd
// ============================================================
inline __m256d pow_avx2_d(__m256d bases, unsigned int n) {
    if (n == 0) return _mm256_set1_pd(1.0);
    if (n == 1) return bases;

    __m256d result = _mm256_set1_pd(1.0);
    __m256d current = bases;

    while (n > 0) {
        if (n & 1) {
            result = _mm256_mul_pd(result, current);
        }
        current = _mm256_mul_pd(current, current);
        n >>= 1;
    }
    return result;
}

// ============================================================
// Batch function: process an array of doubles with SIMD
// N must be a multiple of 4 (caller pads if needed)
// ============================================================
inline void pow_avx2_batch(const double* __restrict__ in,
                           double* __restrict__ out,
                           size_t n,
                           unsigned int exp) {
    size_t i = 0;
    // Main SIMD loop: 4 doubles per iteration
    for (; i + 3 < n; i += 4) {
        __m256d bases = _mm256_loadu_pd(in + i);
        __m256d res   = pow_avx2_d(bases, exp);
        _mm256_storeu_pd(out + i, res);
    }
    // Scalar tail for remaining elements
    for (; i < n; ++i) {
        out[i] = powerix::pow_hierarchical(in[i], exp);
    }
}

// ============================================================
// Test data: 1024 random doubles in [0.5, 4.0]
// ============================================================
static constexpr size_t N = 1024;

static std::vector<double>& get_input_data() {
    static std::vector<double> data = []() {
        std::mt19937_64 rng(42);  // fixed seed for reproducibility
        std::uniform_real_distribution<double> dist(0.5, 4.0);
        std::vector<double> v(N);
        for (auto& x : v) x = dist(rng);
        return v;
    }();
    return data;
}

// ============================================================
// Benchmark: scalar std::pow over N doubles
// ============================================================
static void BM_ScalarStdPow(benchmark::State& state) {
    const auto& input = get_input_data();
    std::vector<double> output(N);
    const unsigned int exp = static_cast<unsigned int>(state.range(0));

    for (auto _ : state) {
        for (size_t i = 0; i < N; ++i) {
            output[i] = std::pow(input[i], static_cast<double>(exp));
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

// ============================================================
// Benchmark: scalar pow_hierarchical over N doubles
// ============================================================
static void BM_ScalarHierarchical(benchmark::State& state) {
    const auto& input = get_input_data();
    std::vector<double> output(N);
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

// ============================================================
// Benchmark: SIMD AVX2 batch pow over N doubles
// ============================================================
static void BM_SimdAvx2Batch(benchmark::State& state) {
    const auto& input = get_input_data();
    std::vector<double> output(N);
    const unsigned int exp = static_cast<unsigned int>(state.range(0));

    for (auto _ : state) {
        pow_avx2_batch(input.data(), output.data(), N, exp);
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
BENCHMARK(BM_ScalarStdPow)->Arg(3)->Arg(7)->Arg(13);
BENCHMARK(BM_ScalarHierarchical)->Arg(3)->Arg(7)->Arg(13);
BENCHMARK(BM_SimdAvx2Batch)->Arg(3)->Arg(7)->Arg(13);

// ============================================================
// Accuracy validation: max relative error vs std::pow
// ============================================================
static void validate_accuracy() {
    const auto& input = get_input_data();
    std::vector<double> simd_out(N);
    std::vector<double> hier_out(N);

    unsigned int exponents[] = {3, 7, 13};

    std::cout << "\n===== ACCURACY VALIDATION (max relative error vs std::pow) =====\n";
    std::cout << std::setw(10) << "Exponent"
              << std::setw(25) << "SIMD MaxRelErr"
              << std::setw(25) << "Hierarchical MaxRelErr"
              << "\n";
    std::cout << std::string(60, '-') << "\n";

    for (unsigned int exp : exponents) {
        pow_avx2_batch(input.data(), simd_out.data(), N, exp);

        double simd_max_rel = 0.0;
        double hier_max_rel = 0.0;

        for (size_t i = 0; i < N; ++i) {
            double ref = std::pow(input[i], static_cast<double>(exp));

            hier_out[i] = powerix::pow_hierarchical(input[i], exp);

            if (ref != 0.0) {
                double simd_rel = std::abs(simd_out[i] - ref) / std::abs(ref);
                double hier_rel = std::abs(hier_out[i] - ref) / std::abs(ref);
                simd_max_rel = std::max(simd_max_rel, simd_rel);
                hier_max_rel = std::max(hier_max_rel, hier_rel);
            }
        }

        std::cout << std::setw(10) << exp
                  << std::setw(25) << std::scientific << std::setprecision(6) << simd_max_rel
                  << std::setw(25) << std::scientific << std::setprecision(6) << hier_max_rel
                  << "\n";
    }
    std::cout << "================================================================\n\n";
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
