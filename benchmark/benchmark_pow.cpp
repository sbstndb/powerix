#include <benchmark/benchmark.h>
#include <cmath>
#include <cstdint>
#include <vector>
#include <iostream>
#include "../src/pow_impl.hpp"

// Reusable integer and floating point datasets
static const std::vector<int16_t> kInt16Bases{2, 3, 5, 7, 11};
static const std::vector<int16_t> kInt16Exps{0, 1, 2, 3, 5, 10, 15};
static const std::vector<int32_t> kInt32Bases{2, 3, 5, 7, 11};
static const std::vector<int32_t> kInt32Exps{0, 1, 2, 3, 5, 10, 15};
static const std::vector<int64_t> kInt64Bases{2, 3, 5, 7, 11};
static const std::vector<int64_t> kInt64Exps{0, 1, 2, 3, 5, 10, 15};
static const std::vector<uint32_t> kUInt32Bases{2, 3, 5, 7, 11};
static const std::vector<uint32_t> kUInt32Exps{0, 1, 2, 3, 5, 10, 15};
static const std::vector<uint64_t> kUInt64Bases{2, 3, 5, 7, 11};
static const std::vector<uint64_t> kUInt64Exps{0, 1, 2, 3, 5, 10, 15};

static const std::vector<double> kFloat64Bases{0.1, 0.5, 1.3, 2.7, 5.9};
static const std::vector<double> kFloat64Exps{0.0, 0.5, 1.0, 2.3, 5.7, 10.0, 15.0};
static const std::vector<float> kFloat32Bases{0.1f, 0.5f, 1.3f, 2.7f, 5.9f};
static const std::vector<float> kFloat32Exps{0.0f, 0.5f, 1.0f, 2.3f, 5.7f, 10.0f, 15.0f};

// Common datasets for mixed types
static const std::vector<int32_t> kCommonIntBases{2, 3, 5, 7, 11};
static const std::vector<int32_t> kCommonIntExps{0, 1, 2, 3, 5, 10, 15};
static const std::vector<double> kCommonFloatExps{0.0, 0.5, 1.0, 2.3, 5.7, 10.0, 15.0};

// Helper to run a dataset and prevent dead code elimination
template <typename F, typename BasesT, typename ExpsT>
inline void run_dataset(F&& func, const BasesT& bases, const ExpsT& exps) {
    volatile double sink = 0.0;
    for (auto base : bases) {
        for (auto exp : exps) {
            sink += func(base, exp);
        }
    }
    benchmark::DoNotOptimize(sink);
}

// Error analysis function
void AnalyzeError() {
    std::cout << "\n=== Error Analysis (compared to std::pow) ===" << std::endl;
    
    double max_abs_err = 0.0;
    double max_rel_err = 0.0;
    
    // Test with various values
    std::vector<double> test_bases = {0.1, 0.5, 1.0, 2.0, 5.0, 10.0};
    std::vector<double> test_exps = {0.5, 1.0, 2.0, 2.5};
    
    for (double base : test_bases) {
        for (double exp : test_exps) {
            double reference = std::pow(base, exp);
            double test_value = powerix::pow_std(base, exp); // Using std::pow as reference
            
            double abs_err = std::abs(reference - test_value);
            double rel_err = (reference != 0.0) ? abs_err / std::abs(reference) : 0.0;
            
            max_abs_err = std::max(max_abs_err, abs_err);
            max_rel_err = std::max(max_rel_err, rel_err);
        }
    }
    
    std::cout << "Max absolute error: " << max_abs_err << std::endl;
    std::cout << "Max relative error: " << max_rel_err << std::endl;
}

// -------------------------------------------------------------
// 1. std::pow (reference implementation)
// -------------------------------------------------------------

static void BM_PowStd_Int16Int16(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](int16_t a, int16_t b) { return std::pow(a, b); }, kInt16Bases, kInt16Exps);
    }
}
BENCHMARK(BM_PowStd_Int16Int16);

static void BM_PowStd_Int32Int32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](int32_t a, int32_t b) { return std::pow(a, b); }, kInt32Bases, kInt32Exps);
    }
}
BENCHMARK(BM_PowStd_Int32Int32);

static void BM_PowStd_Int64Int64(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](int64_t a, int64_t b) { return std::pow(a, b); }, kInt64Bases, kInt64Exps);
    }
}
BENCHMARK(BM_PowStd_Int64Int64);

static void BM_PowStd_UInt32UInt32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](uint32_t a, uint32_t b) { return std::pow(a, b); }, kUInt32Bases, kUInt32Exps);
    }
}
BENCHMARK(BM_PowStd_UInt32UInt32);

static void BM_PowStd_UInt64UInt64(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](uint64_t a, uint64_t b) { return std::pow(a, b); }, kUInt64Bases, kUInt64Exps);
    }
}
BENCHMARK(BM_PowStd_UInt64UInt64);

static void BM_PowStd_Float32Float32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](float a, float b) { return std::pow(a, b); }, kFloat32Bases, kFloat32Exps);
    }
}
BENCHMARK(BM_PowStd_Float32Float32);

static void BM_PowStd_Float64Float64(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](double a, double b) { return std::pow(a, b); }, kFloat64Bases, kFloat64Exps);
    }
}
BENCHMARK(BM_PowStd_Float64Float64);

static void BM_PowStd_Float32Int32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](float a, int32_t b) { return std::pow(a, b); }, kFloat32Bases, kInt32Exps);
    }
}
BENCHMARK(BM_PowStd_Float32Int32);

static void BM_PowStd_Float64Int32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](double a, int32_t b) { return std::pow(a, b); }, kFloat64Bases, kInt32Exps);
    }
}
BENCHMARK(BM_PowStd_Float64Int32);

static void BM_PowStd_Int32Float64(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](int32_t a, double b) { return std::pow(a, b); }, kInt32Bases, kFloat64Exps);
    }
}
BENCHMARK(BM_PowStd_Int32Float64);

static void BM_PowStd_Float64Float32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](double a, float b) { return std::pow(a, b); }, kFloat64Bases, kFloat32Exps);
    }
}
BENCHMARK(BM_PowStd_Float64Float32);

static void BM_PowStd_Float32Float64(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](float a, double b) { return std::pow(a, b); }, kFloat32Bases, kFloat64Exps);
    }
}
BENCHMARK(BM_PowStd_Float32Float64);

// -------------------------------------------------------------
// 2. pow_fast_int (fast exponentiation - integer only)
// -------------------------------------------------------------

static void BM_PowFast_Int16Int16(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](int16_t a, int16_t b) { return powerix::pow_fast_int(a, b); }, kInt16Bases, kInt16Exps);
    }
}
BENCHMARK(BM_PowFast_Int16Int16);

static void BM_PowFast_Int32Int32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](int32_t a, int32_t b) { return powerix::pow_fast_int(a, b); }, kInt32Bases, kInt32Exps);
    }
}
BENCHMARK(BM_PowFast_Int32Int32);

static void BM_PowFast_Int64Int64(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](int64_t a, int64_t b) { return powerix::pow_fast_int(a, b); }, kInt64Bases, kInt64Exps);
    }
}
BENCHMARK(BM_PowFast_Int64Int64);

static void BM_PowFast_UInt32UInt32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](uint32_t a, uint32_t b) { return powerix::pow_fast_int(a, b); }, kUInt32Bases, kUInt32Exps);
    }
}
BENCHMARK(BM_PowFast_UInt32UInt32);

static void BM_PowFast_UInt64UInt64(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](uint64_t a, uint64_t b) { return powerix::pow_fast_int(a, b); }, kUInt64Bases, kUInt64Exps);
    }
}
BENCHMARK(BM_PowFast_UInt64UInt64);

// -------------------------------------------------------------
// 3. pow_hierarchical (divide & conquer - all types)
// -------------------------------------------------------------

static void BM_PowHier_Int16Int16(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](int16_t a, int16_t b) { return powerix::pow_hierarchical_int(a, static_cast<unsigned int>(b)); }, kInt16Bases, kInt16Exps);
    }
}
BENCHMARK(BM_PowHier_Int16Int16);

static void BM_PowHier_Int32Int32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](int32_t a, int32_t b) { return powerix::pow_hierarchical_int(a, static_cast<unsigned int>(b)); }, kInt32Bases, kInt32Exps);
    }
}
BENCHMARK(BM_PowHier_Int32Int32);

static void BM_PowHier_Int64Int64(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](int64_t a, int64_t b) { return powerix::pow_hierarchical_int(a, static_cast<unsigned int>(b)); }, kInt64Bases, kInt64Exps);
    }
}
BENCHMARK(BM_PowHier_Int64Int64);

static void BM_PowHier_UInt32UInt32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](uint32_t a, uint32_t b) { return powerix::pow_hierarchical_int(a, b); }, kUInt32Bases, kUInt32Exps);
    }
}
BENCHMARK(BM_PowHier_UInt32UInt32);

static void BM_PowHier_UInt64UInt64(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](uint64_t a, uint64_t b) { return powerix::pow_hierarchical_int(a, b); }, kUInt64Bases, kUInt64Exps);
    }
}
BENCHMARK(BM_PowHier_UInt64UInt64);

static void BM_PowHier_Float32Int32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](float a, int32_t b) { return powerix::pow_hierarchical_float(a, static_cast<unsigned int>(b)); }, kFloat32Bases, kInt32Exps);
    }
}
BENCHMARK(BM_PowHier_Float32Int32);

static void BM_PowHier_Float64Int32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](double a, int32_t b) { return powerix::pow_hierarchical_float(a, static_cast<unsigned int>(b)); }, kFloat64Bases, kInt32Exps);
    }
}
BENCHMARK(BM_PowHier_Float64Int32);

static void BM_PowHier_Float32Float32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](float a, float b) { return powerix::pow_hierarchical_float(a, static_cast<unsigned int>(b)); }, kFloat32Bases, kFloat32Exps);
    }
}
BENCHMARK(BM_PowHier_Float32Float32);

static void BM_PowHier_Float64Float64(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](double a, double b) { return powerix::pow_hierarchical_float(a, static_cast<unsigned int>(b)); }, kFloat64Bases, kFloat64Exps);
    }
}
BENCHMARK(BM_PowHier_Float64Float64);

// -------------------------------------------------------------
// 4. pow_ultra_fast (optimized binary exponentiation - all types)
// -------------------------------------------------------------

static void BM_PowUltra_Int16Int16(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](int16_t a, int16_t b) { return powerix::pow_ultra_fast(a, static_cast<unsigned int>(b)); }, kInt16Bases, kInt16Exps);
    }
}
BENCHMARK(BM_PowUltra_Int16Int16);

static void BM_PowUltra_Int32Int32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](int32_t a, int32_t b) { return powerix::pow_ultra_fast(a, static_cast<unsigned int>(b)); }, kInt32Bases, kInt32Exps);
    }
}
BENCHMARK(BM_PowUltra_Int32Int32);

static void BM_PowUltra_Int64Int64(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](int64_t a, int64_t b) { return powerix::pow_ultra_fast(a, static_cast<unsigned int>(b)); }, kInt64Bases, kInt64Exps);
    }
}
BENCHMARK(BM_PowUltra_Int64Int64);

static void BM_PowUltra_UInt32UInt32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](uint32_t a, uint32_t b) { return powerix::pow_ultra_fast(a, b); }, kUInt32Bases, kUInt32Exps);
    }
}
BENCHMARK(BM_PowUltra_UInt32UInt32);

static void BM_PowUltra_UInt64UInt64(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](uint64_t a, uint64_t b) { return powerix::pow_ultra_fast(a, b); }, kUInt64Bases, kUInt64Exps);
    }
}
BENCHMARK(BM_PowUltra_UInt64UInt64);

static void BM_PowUltra_Float32Int32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](float a, int32_t b) { return powerix::pow_ultra_fast(a, static_cast<unsigned int>(b)); }, kFloat32Bases, kInt32Exps);
    }
}
BENCHMARK(BM_PowUltra_Float32Int32);

static void BM_PowUltra_Float64Int32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](double a, int32_t b) { return powerix::pow_ultra_fast(a, static_cast<unsigned int>(b)); }, kFloat64Bases, kInt32Exps);
    }
}
BENCHMARK(BM_PowUltra_Float64Int32);

static void BM_PowUltra_Float32Float32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](float a, float b) { return powerix::pow_ultra_fast(a, static_cast<unsigned int>(b)); }, kFloat32Bases, kFloat32Exps);
    }
}
BENCHMARK(BM_PowUltra_Float32Float32);

static void BM_PowUltra_Float64Float64(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](double a, double b) { return powerix::pow_ultra_fast(a, static_cast<unsigned int>(b)); }, kFloat64Bases, kFloat64Exps);
    }
}
BENCHMARK(BM_PowUltra_Float64Float64);

// -------------------------------------------------------------
// 5. pow_cached (memoization with std::map - limited types)
// -------------------------------------------------------------

static void BM_PowCached_Int32Int32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](int32_t a, int32_t b) { return powerix::pow_cached(a, b); }, kInt32Bases, kInt32Exps);
    }
}
BENCHMARK(BM_PowCached_Int32Int32);

static void BM_PowCached_Float64Int32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](double a, int32_t b) { return powerix::pow_cached(a, b); }, kFloat64Bases, kInt32Exps);
    }
}
BENCHMARK(BM_PowCached_Float64Int32);

// -------------------------------------------------------------
// 6. pow_vec_cached (memoization vector<vector> - all types)
// -------------------------------------------------------------

static void BM_PowVecCached_Int16Int16(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](int16_t a, int16_t b) { return powerix::pow_vec_cached_int(a, static_cast<unsigned int>(b)); }, kInt16Bases, kInt16Exps);
    }
}
BENCHMARK(BM_PowVecCached_Int16Int16);

static void BM_PowVecCached_Int32Int32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](int32_t a, int32_t b) { return powerix::pow_vec_cached_int(a, static_cast<unsigned int>(b)); }, kInt32Bases, kInt32Exps);
    }
}
BENCHMARK(BM_PowVecCached_Int32Int32);

static void BM_PowVecCached_Int64Int64(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](int64_t a, int64_t b) { return powerix::pow_vec_cached_int(a, static_cast<unsigned int>(b)); }, kInt64Bases, kInt64Exps);
    }
}
BENCHMARK(BM_PowVecCached_Int64Int64);

static void BM_PowVecCached_UInt32UInt32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](uint32_t a, uint32_t b) { return powerix::pow_vec_cached_int(a, b); }, kUInt32Bases, kUInt32Exps);
    }
}
BENCHMARK(BM_PowVecCached_UInt32UInt32);

static void BM_PowVecCached_UInt64UInt64(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](uint64_t a, uint64_t b) { return powerix::pow_vec_cached_int(a, b); }, kUInt64Bases, kUInt64Exps);
    }
}
BENCHMARK(BM_PowVecCached_UInt64UInt64);

static void BM_PowVecCached_Float32Int32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](float a, int32_t b) { return powerix::pow_vec_cached_float(a, static_cast<unsigned int>(b)); }, kFloat32Bases, kInt32Exps);
    }
}
BENCHMARK(BM_PowVecCached_Float32Int32);

static void BM_PowVecCached_Float64Int32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](double a, int32_t b) { return powerix::pow_vec_cached_float(a, static_cast<unsigned int>(b)); }, kFloat64Bases, kInt32Exps);
    }
}
BENCHMARK(BM_PowVecCached_Float64Int32);

static void BM_PowVecCached_Float32Float32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](float a, float b) { return powerix::pow_vec_cached_float(a, static_cast<unsigned int>(b)); }, kFloat32Bases, kFloat32Exps);
    }
}
BENCHMARK(BM_PowVecCached_Float32Float32);

static void BM_PowVecCached_Float64Float64(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](double a, double b) { return powerix::pow_vec_cached_float(a, static_cast<unsigned int>(b)); }, kFloat64Bases, kFloat64Exps);
    }
}
BENCHMARK(BM_PowVecCached_Float64Float64);

// Main function
int main(int argc, char** argv) {
    AnalyzeError();
    ::benchmark::Initialize(&argc, argv);
    ::benchmark::RunSpecifiedBenchmarks();
    return 0;
} 