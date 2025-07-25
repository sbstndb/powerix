#include <benchmark/benchmark.h>
#include <cmath>
#include <cstdint>
#include <vector>
#include <iostream>
#include "../src/pow_impl.hpp"
#include "../src/error_util.hpp"

// Reusable integer and floating point datasets
static const std::vector<int16_t> kInt16Bases{2, 3, 4, 5};
static const std::vector<int16_t> kInt16Exps{0, 1, 2, 3, 5, 6};
static const std::vector<int32_t> kInt32Bases{2, 3, 4, 5};
static const std::vector<int32_t> kInt32Exps{0, 1, 2, 3, 5, 8, 10};
static const std::vector<int64_t> kInt64Bases{2, 3, 4, 5};
static const std::vector<int64_t> kInt64Exps{0, 1, 2, 3, 5, 8, 10};
static const std::vector<uint32_t> kUInt32Bases{2, 3, 4, 5};
static const std::vector<uint32_t> kUInt32Exps{0, 1, 2, 3, 5, 8, 10};
static const std::vector<uint64_t> kUInt64Bases{2, 3, 4, 5};
static const std::vector<uint64_t> kUInt64Exps{0, 1, 2, 3, 5, 8, 10};

static const std::vector<double> kFloat64Bases{0.1, 0.5, 1.3, 2.7, 5.9};
static const std::vector<double> kFloat64Exps{0.1, 0.5, 1.05, 2.3, 5.7, 5.9};
static const std::vector<float> kFloat32Bases{0.1f, 0.5f, 1.3f, 2.7f, 5.9f};
static const std::vector<float> kFloat32Exps{0.1f, 0.5f, 1.05f, 2.3f, 5.7f, 5.9f};

// Common datasets for mixed types
static const std::vector<int32_t> kCommonIntBases{2, 3, 4, 5};
static const std::vector<int32_t> kCommonIntExps{0, 1, 2, 3, 5, 8, 10};
static const std::vector<double> kCommonFloatExps{0.1, 0.5, 1.0, 2.3, 5.7, 5.9};

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

// Helper function to compute error for a specific benchmark
template<typename Func, typename BaseType, typename ExpType>
powerix::Error calculate_error_for_benchmark(Func&& func, const std::vector<BaseType>& bases, const std::vector<ExpType>& exps) {
    double max_abs_err = 0.0;
    double max_rel_err = 0.0;
    
    for (auto base : bases) {
        for (auto exp : exps) {
            double d_base = static_cast<double>(base);
            double d_exp = static_cast<double>(exp);
            double reference = std::pow(d_base, d_exp);
            double test_value = static_cast<double>(func(base, exp));
            
            auto error = powerix::compute_error(reference, test_value);
            max_abs_err = std::max(max_abs_err, error.abs_err);
            max_rel_err = std::max(max_rel_err, error.rel_err);
        }
    }
    
    return {max_abs_err, max_rel_err};
}

#define ADD_METRICS_AND_NS_PER_POW(state, func, bases, exps) \
    long num_ops = bases.size() * exps.size(); \
    auto error = calculate_error_for_benchmark(func, bases, exps); \
    state.counters["MaxRelErr"] = error.rel_err; \
    state.SetItemsProcessed(num_ops);

// -------------------------------------------------------------
// 1. std::pow (reference implementation)
// -------------------------------------------------------------

static void BM_PowStd_Int16Int16(benchmark::State& state) {
    auto func = [](int16_t a, int16_t b) { return std::pow(a, b); };
    for (auto _ : state) {
        run_dataset(func, kInt16Bases, kInt16Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kInt16Bases, kInt16Exps);
}
BENCHMARK(BM_PowStd_Int16Int16);

static void BM_PowStd_Int32Int32(benchmark::State& state) {
    auto func = [](int32_t a, int32_t b) { return std::pow(a, b); };
    for (auto _ : state) {
        run_dataset(func, kInt32Bases, kInt32Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kInt32Bases, kInt32Exps);
}
BENCHMARK(BM_PowStd_Int32Int32);

static void BM_PowStd_Int64Int64(benchmark::State& state) {
    auto func = [](int64_t a, int64_t b) { return std::pow(a, b); };
    for (auto _ : state) {
        run_dataset(func, kInt64Bases, kInt64Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kInt64Bases, kInt64Exps);
}
BENCHMARK(BM_PowStd_Int64Int64);

static void BM_PowStd_UInt32UInt32(benchmark::State& state) {
    auto func = [](uint32_t a, uint32_t b) { return std::pow(a, b); };
    for (auto _ : state) {
        run_dataset(func, kUInt32Bases, kUInt32Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kUInt32Bases, kUInt32Exps);
}
BENCHMARK(BM_PowStd_UInt32UInt32);

static void BM_PowStd_UInt64UInt64(benchmark::State& state) {
    auto func = [](uint64_t a, uint64_t b) { return std::pow(a, b); };
    for (auto _ : state) {
        run_dataset(func, kUInt64Bases, kUInt64Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kUInt64Bases, kUInt64Exps);
}
BENCHMARK(BM_PowStd_UInt64UInt64);

static void BM_PowStd_Float32Float32(benchmark::State& state) {
    auto func = [](float a, float b) { return std::pow(a, b); };
    for (auto _ : state) {
        run_dataset(func, kFloat32Bases, kFloat32Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kFloat32Bases, kFloat32Exps);
}
BENCHMARK(BM_PowStd_Float32Float32);

static void BM_PowStd_Float64Float64(benchmark::State& state) {
    auto func = [](double a, double b) { return std::pow(a, b); };
    for (auto _ : state) {
        run_dataset(func, kFloat64Bases, kFloat64Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kFloat64Bases, kFloat64Exps);
}
BENCHMARK(BM_PowStd_Float64Float64);

static void BM_PowStd_Float32Int32(benchmark::State& state) {
    auto func = [](float a, int32_t b) { return std::pow(a, b); };
    for (auto _ : state) {
        run_dataset(func, kFloat32Bases, kInt32Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kFloat32Bases, kInt32Exps);
}
BENCHMARK(BM_PowStd_Float32Int32);

static void BM_PowStd_Float64Int32(benchmark::State& state) {
    auto func = [](double a, int32_t b) { return std::pow(a, b); };
    for (auto _ : state) {
        run_dataset(func, kFloat64Bases, kInt32Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kFloat64Bases, kInt32Exps);
}
BENCHMARK(BM_PowStd_Float64Int32);

static void BM_PowStd_Int32Float64(benchmark::State& state) {
    auto func = [](int32_t a, double b) { return std::pow(a, b); };
    for (auto _ : state) {
        run_dataset(func, kInt32Bases, kFloat64Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kInt32Bases, kFloat64Exps);
}
BENCHMARK(BM_PowStd_Int32Float64);

static void BM_PowStd_Float64Float32(benchmark::State& state) {
    auto func = [](double a, float b) { return std::pow(a, b); };
    for (auto _ : state) {
        run_dataset(func, kFloat64Bases, kFloat32Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kFloat64Bases, kFloat32Exps);
}
BENCHMARK(BM_PowStd_Float64Float32);

static void BM_PowStd_Float32Float64(benchmark::State& state) {
    auto func = [](float a, double b) { return std::pow(a, b); };
    for (auto _ : state) {
        run_dataset(func, kFloat32Bases, kFloat64Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kFloat32Bases, kFloat64Exps);
}
BENCHMARK(BM_PowStd_Float32Float64);

// -------------------------------------------------------------
// 2. pow_fast_int (fast exponentiation - integer only)
// -------------------------------------------------------------

static void BM_PowFast_Int16Int16(benchmark::State& state) {
    auto func = [](int16_t a, int16_t b) { return powerix::pow_fast_int(a, b); };
    for (auto _ : state) {
        run_dataset(func, kInt16Bases, kInt16Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kInt16Bases, kInt16Exps);
}
BENCHMARK(BM_PowFast_Int16Int16);

static void BM_PowFast_Int32Int32(benchmark::State& state) {
    auto func = [](int32_t a, int32_t b) { return powerix::pow_fast_int(a, b); };
    for (auto _ : state) {
        run_dataset(func, kInt32Bases, kInt32Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kInt32Bases, kInt32Exps);
}
BENCHMARK(BM_PowFast_Int32Int32);

static void BM_PowFast_Int64Int64(benchmark::State& state) {
    auto func = [](int64_t a, int64_t b) { return powerix::pow_fast_int(a, b); };
    for (auto _ : state) {
        run_dataset(func, kInt64Bases, kInt64Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kInt64Bases, kInt64Exps);
}
BENCHMARK(BM_PowFast_Int64Int64);

static void BM_PowFast_UInt32UInt32(benchmark::State& state) {
    auto func = [](uint32_t a, uint32_t b) { return powerix::pow_fast_int(a, b); };
    for (auto _ : state) {
        run_dataset(func, kUInt32Bases, kUInt32Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kUInt32Bases, kUInt32Exps);
}
BENCHMARK(BM_PowFast_UInt32UInt32);

static void BM_PowFast_UInt64UInt64(benchmark::State& state) {
    auto func = [](uint64_t a, uint64_t b) { return powerix::pow_fast_int(a, b); };
    for (auto _ : state) {
        run_dataset(func, kUInt64Bases, kUInt64Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kUInt64Bases, kUInt64Exps);
}
BENCHMARK(BM_PowFast_UInt64UInt64);

// -------------------------------------------------------------
// 3. pow_hierarchical (divide & conquer - all types)
// -------------------------------------------------------------

static void BM_PowHier_Int16Int16(benchmark::State& state) {
    auto func = [](int16_t a, int16_t b) { return powerix::pow_hierarchical_int(a, static_cast<unsigned int>(b)); };
    for (auto _ : state) {
        run_dataset(func, kInt16Bases, kInt16Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kInt16Bases, kInt16Exps);
}
BENCHMARK(BM_PowHier_Int16Int16);

static void BM_PowHier_Int32Int32(benchmark::State& state) {
    auto func = [](int32_t a, int32_t b) { return powerix::pow_hierarchical_int(a, static_cast<unsigned int>(b)); };
    for (auto _ : state) {
        run_dataset(func, kInt32Bases, kInt32Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kInt32Bases, kInt32Exps);
}
BENCHMARK(BM_PowHier_Int32Int32);

static void BM_PowHier_Int64Int64(benchmark::State& state) {
    auto func = [](int64_t a, int64_t b) { return powerix::pow_hierarchical_int(a, static_cast<unsigned int>(b)); };
    for (auto _ : state) {
        run_dataset(func, kInt64Bases, kInt64Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kInt64Bases, kInt64Exps);
}
BENCHMARK(BM_PowHier_Int64Int64);

static void BM_PowHier_UInt32UInt32(benchmark::State& state) {
    auto func = [](uint32_t a, uint32_t b) { return powerix::pow_hierarchical_int(a, b); };
    for (auto _ : state) {
        run_dataset(func, kUInt32Bases, kUInt32Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kUInt32Bases, kUInt32Exps);
}
BENCHMARK(BM_PowHier_UInt32UInt32);

static void BM_PowHier_UInt64UInt64(benchmark::State& state) {
    auto func = [](uint64_t a, uint64_t b) { return powerix::pow_hierarchical_int(a, b); };
    for (auto _ : state) {
        run_dataset(func, kUInt64Bases, kUInt64Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kUInt64Bases, kUInt64Exps);
}
BENCHMARK(BM_PowHier_UInt64UInt64);

static void BM_PowHier_Float32Int32(benchmark::State& state) {
    auto func = [](float a, int32_t b) { return powerix::pow_hierarchical_float(a, static_cast<unsigned int>(b)); };
    for (auto _ : state) {
        run_dataset(func, kFloat32Bases, kInt32Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kFloat32Bases, kInt32Exps);
}
BENCHMARK(BM_PowHier_Float32Int32);

static void BM_PowHier_Float64Int32(benchmark::State& state) {
    auto func = [](double a, int32_t b) { return powerix::pow_hierarchical_float(a, static_cast<unsigned int>(b)); };
    for (auto _ : state) {
        run_dataset(func, kFloat64Bases, kInt32Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kFloat64Bases, kInt32Exps);
}
BENCHMARK(BM_PowHier_Float64Int32);

static void BM_PowHier_Float32Float32(benchmark::State& state) {
    auto func = [](float a, float b) { return powerix::pow_hierarchical_float(a, static_cast<unsigned int>(b)); };
    for (auto _ : state) {
        run_dataset(func, kFloat32Bases, kFloat32Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kFloat32Bases, kFloat32Exps);
}
BENCHMARK(BM_PowHier_Float32Float32);

static void BM_PowHier_Float64Float64(benchmark::State& state) {
    auto func = [](double a, double b) { return powerix::pow_hierarchical_float(a, static_cast<unsigned int>(b)); };
    for (auto _ : state) {
        run_dataset(func, kFloat64Bases, kFloat64Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kFloat64Bases, kFloat64Exps);
}
BENCHMARK(BM_PowHier_Float64Float64);

// -------------------------------------------------------------
// 4. pow_ultra_fast (optimized binary exponentiation - all types)
// -------------------------------------------------------------

static void BM_PowUltra_Int16Int16(benchmark::State& state) {
    auto func = [](int16_t a, int16_t b) { return powerix::pow_ultra_fast(a, static_cast<unsigned int>(b)); };
    for (auto _ : state) {
        run_dataset(func, kInt16Bases, kInt16Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kInt16Bases, kInt16Exps);
}
BENCHMARK(BM_PowUltra_Int16Int16);

static void BM_PowUltra_Int32Int32(benchmark::State& state) {
    auto func = [](int32_t a, int32_t b) { return powerix::pow_ultra_fast(a, static_cast<unsigned int>(b)); };
    for (auto _ : state) {
        run_dataset(func, kInt32Bases, kInt32Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kInt32Bases, kInt32Exps);
}
BENCHMARK(BM_PowUltra_Int32Int32);

static void BM_PowUltra_Int64Int64(benchmark::State& state) {
    auto func = [](int64_t a, int64_t b) { return powerix::pow_ultra_fast(a, static_cast<unsigned int>(b)); };
    for (auto _ : state) {
        run_dataset(func, kInt64Bases, kInt64Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kInt64Bases, kInt64Exps);
}
BENCHMARK(BM_PowUltra_Int64Int64);

static void BM_PowUltra_UInt32UInt32(benchmark::State& state) {
    auto func = [](uint32_t a, uint32_t b) { return powerix::pow_ultra_fast(a, b); };
    for (auto _ : state) {
        run_dataset(func, kUInt32Bases, kUInt32Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kUInt32Bases, kUInt32Exps);
}
BENCHMARK(BM_PowUltra_UInt32UInt32);

static void BM_PowUltra_UInt64UInt64(benchmark::State& state) {
    auto func = [](uint64_t a, uint64_t b) { return powerix::pow_ultra_fast(a, b); };
    for (auto _ : state) {
        run_dataset(func, kUInt64Bases, kUInt64Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kUInt64Bases, kUInt64Exps);
}
BENCHMARK(BM_PowUltra_UInt64UInt64);

static void BM_PowUltra_Float32Int32(benchmark::State& state) {
    auto func = [](float a, int32_t b) { return powerix::pow_ultra_fast(a, static_cast<unsigned int>(b)); };
    for (auto _ : state) {
        run_dataset(func, kFloat32Bases, kInt32Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kFloat32Bases, kInt32Exps);
}
BENCHMARK(BM_PowUltra_Float32Int32);

static void BM_PowUltra_Float64Int32(benchmark::State& state) {
    auto func = [](double a, int32_t b) { return powerix::pow_ultra_fast(a, static_cast<unsigned int>(b)); };
    for (auto _ : state) {
        run_dataset(func, kFloat64Bases, kInt32Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kFloat64Bases, kInt32Exps);
}
BENCHMARK(BM_PowUltra_Float64Int32);

static void BM_PowUltra_Float32Float32(benchmark::State& state) {
    auto func = [](float a, float b) { return powerix::pow_ultra_fast(a, static_cast<unsigned int>(b)); };
    for (auto _ : state) {
        run_dataset(func, kFloat32Bases, kFloat32Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kFloat32Bases, kFloat32Exps);
}
BENCHMARK(BM_PowUltra_Float32Float32);

static void BM_PowUltra_Float64Float64(benchmark::State& state) {
    auto func = [](double a, double b) { return powerix::pow_ultra_fast(a, static_cast<unsigned int>(b)); };
    for (auto _ : state) {
        run_dataset(func, kFloat64Bases, kFloat64Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kFloat64Bases, kFloat64Exps);
}
BENCHMARK(BM_PowUltra_Float64Float64);

// -------------------------------------------------------------
// 5. pow_cached (memoization with std::map - limited types)
// -------------------------------------------------------------

static void BM_PowCached_Int16Int16(benchmark::State& state) {
    auto func = [](int16_t a, int16_t b) { return powerix::pow_cached(a, b); };
    for (auto _ : state) {
        run_dataset(func, kInt16Bases, kInt16Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kInt16Bases, kInt16Exps);
}
BENCHMARK(BM_PowCached_Int16Int16);

// -------------------------------------------------------------
// 5.b pow_cached_unordered_nested (memoization with nested unordered_maps)
// -------------------------------------------------------------

static void BM_PowCachedUnorderedNested_Int16Int16(benchmark::State& state) {
    auto func = [](int16_t a, int16_t b) { return powerix::pow_cached_unordered_nested(a, b); };
    for (auto _ : state) {
        run_dataset(func, kInt16Bases, kInt16Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kInt16Bases, kInt16Exps);
}
BENCHMARK(BM_PowCachedUnorderedNested_Int16Int16);

// -------------------------------------------------------------
// 5.c pow_cached_unordered_pair (memoization with unordered_map and pair key)
// -------------------------------------------------------------

static void BM_PowCachedUnorderedPair_Int16Int16(benchmark::State& state) {
    auto func = [](int16_t a, int16_t b) { return powerix::pow_cached_unordered_pair(a, b); };
    for (auto _ : state) {
        run_dataset(func, kInt16Bases, kInt16Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kInt16Bases, kInt16Exps);
}
BENCHMARK(BM_PowCachedUnorderedPair_Int16Int16);

// -------------------------------------------------------------
// 6. pow_vec_cached (memoization vector<vector> - all types)
// -------------------------------------------------------------

static void BM_PowVecCached_Int16Int16(benchmark::State& state) {
    auto func = [](int16_t a, int16_t b) { return powerix::pow_vec_cached_int(a, b); };
    for (auto _ : state) {
        run_dataset(func, kInt16Bases, kInt16Exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, kInt16Bases, kInt16Exps);
}
BENCHMARK(BM_PowVecCached_Int16Int16);

// Main function
int main(int argc, char** argv) {
    ::benchmark::Initialize(&argc, argv);
    ::benchmark::RunSpecifiedBenchmarks();
    return 0;
} 