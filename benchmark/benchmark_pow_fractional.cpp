#include <benchmark/benchmark.h>
#include <cmath>
#include <cstdint>
#include <vector>
#include <iostream>
#include "../src/pow_impl.hpp"
#include "../src/error_util.hpp"

// Datasets for fractional exponent benchmarks
static const std::vector<int32_t> kIntBasesFrac{1, 2, 3, 5, 8, 13, 21, 34, 55, 89};
static const std::vector<float> kFloat32BasesFrac{0.1f, 0.5f, 1.0f, 2.0f, 3.0f, 5.0f, 8.0f, 13.0f, 21.0f, 34.0f};
static const std::vector<double> kFloat64BasesFrac{0.1, 0.5, 1.0, 2.0, 3.0, 5.0, 8.0, 13.0, 21.0, 34.0};

// Fixed exponent: 2/3
static constexpr double kFracExp = 2.0/3.0;

// Helper to run dataset and prevent dead code elimination
template <typename F, typename BasesT>
inline void run_dataset_frac(F&& func, const BasesT& bases) {
    volatile double sink = 0.0;
    for (auto base : bases) {
        sink += func(base, kFracExp);
    }
    benchmark::DoNotOptimize(sink);
}

// Helper function to compute error for a specific benchmark
template<typename Func, typename BaseType>
powerix::Error calculate_error_for_benchmark_frac(Func&& func, const std::vector<BaseType>& bases) {
    double max_abs_err = 0.0;
    double max_rel_err = 0.0;
    
    for (auto base : bases) {
        double d_base = static_cast<double>(base);
        double reference = std::pow(d_base, kFracExp);
        double test_value = static_cast<double>(func(base, kFracExp));
        
        auto error = powerix::compute_error(reference, test_value);
        max_abs_err = std::max(max_abs_err, error.abs_err);
        max_rel_err = std::max(max_rel_err, error.rel_err);
    }
    
    return {max_abs_err, max_rel_err};
}

#define ADD_METRICS_AND_NS_PER_POW_FRAC(state, func, bases) \
    auto error = calculate_error_for_benchmark_frac(func, bases); \
    state.counters["MaxAbsErr"] = error.abs_err; \
    state.counters["MaxRelErr"] = error.rel_err;

// -------------------------------------------------------------
// 1. std::pow (reference)
// -------------------------------------------------------------

static void BM_PowStd_Int32_FracExp(benchmark::State& state) {
    auto func = [](int32_t base, [[maybe_unused]] double e) { return std::pow(static_cast<double>(base), kFracExp); };
    for (auto _ : state) {
        run_dataset_frac(func, kIntBasesFrac);
    }
    ADD_METRICS_AND_NS_PER_POW_FRAC(state, func, kIntBasesFrac);
}
BENCHMARK(BM_PowStd_Int32_FracExp);

static void BM_PowStd_Float32_FracExp(benchmark::State& state) {
    auto func = [](float base, [[maybe_unused]] double e) { return std::pow(base, static_cast<float>(kFracExp)); };
    for (auto _ : state) {
        run_dataset_frac(func, kFloat32BasesFrac);
    }
    ADD_METRICS_AND_NS_PER_POW_FRAC(state, func, kFloat32BasesFrac);
}
BENCHMARK(BM_PowStd_Float32_FracExp);

static void BM_PowStd_Float64_FracExp(benchmark::State& state) {
    auto func = [](double base, [[maybe_unused]] double e) { return std::pow(base, kFracExp); };
    for (auto _ : state) {
        run_dataset_frac(func, kFloat64BasesFrac);
    }
    ADD_METRICS_AND_NS_PER_POW_FRAC(state, func, kFloat64BasesFrac);
}
BENCHMARK(BM_PowStd_Float64_FracExp);

// -------------------------------------------------------------
// 2. C raw pow function
// -------------------------------------------------------------

static void BM_PowCRaw_Int32_FracExp(benchmark::State& state) {
    auto func = [](int32_t base, [[maybe_unused]] double e) { return powerix::pow_c_raw(base, kFracExp); };
    for (auto _ : state) {
        run_dataset_frac(func, kIntBasesFrac);
    }
    ADD_METRICS_AND_NS_PER_POW_FRAC(state, func, kIntBasesFrac);
}
BENCHMARK(BM_PowCRaw_Int32_FracExp);

static void BM_PowCRaw_Float32_FracExp(benchmark::State& state) {
    auto func = [](float base, [[maybe_unused]] double e) { return powerix::pow_c_raw_float(base, static_cast<float>(kFracExp)); };
    for (auto _ : state) {
        run_dataset_frac(func, kFloat32BasesFrac);
    }
    ADD_METRICS_AND_NS_PER_POW_FRAC(state, func, kFloat32BasesFrac);
}
BENCHMARK(BM_PowCRaw_Float32_FracExp);

static void BM_PowCRaw_Float64_FracExp(benchmark::State& state) {
    auto func = [](double base, [[maybe_unused]] double e) { return powerix::pow_c_raw(base, kFracExp); };
    for (auto _ : state) {
        run_dataset_frac(func, kFloat64BasesFrac);
    }
    ADD_METRICS_AND_NS_PER_POW_FRAC(state, func, kFloat64BasesFrac);
}
BENCHMARK(BM_PowCRaw_Float64_FracExp);

// -------------------------------------------------------------
// 3. cbrt version (cube root)
// -------------------------------------------------------------

static void BM_PowCbrt_Int32_FracExp(benchmark::State& state) {
    auto func = [](int32_t base, [[maybe_unused]] double e) { return powerix::pow_2_3_cbrt(base); };
    for (auto _ : state) {
        run_dataset_frac(func, kIntBasesFrac);
    }
    ADD_METRICS_AND_NS_PER_POW_FRAC(state, func, kIntBasesFrac);
}
BENCHMARK(BM_PowCbrt_Int32_FracExp);

static void BM_PowCbrt_Float32_FracExp(benchmark::State& state) {
    auto func = [](float base, [[maybe_unused]] double e) { return powerix::pow_2_3_cbrt_float(base); };
    for (auto _ : state) {
        run_dataset_frac(func, kFloat32BasesFrac);
    }
    ADD_METRICS_AND_NS_PER_POW_FRAC(state, func, kFloat32BasesFrac);
}
BENCHMARK(BM_PowCbrt_Float32_FracExp);

static void BM_PowCbrt_Float64_FracExp(benchmark::State& state) {
    auto func = [](double base, [[maybe_unused]] double e) { return powerix::pow_2_3_cbrt(base); };
    for (auto _ : state) {
        run_dataset_frac(func, kFloat64BasesFrac);
    }
    ADD_METRICS_AND_NS_PER_POW_FRAC(state, func, kFloat64BasesFrac);
}
BENCHMARK(BM_PowCbrt_Float64_FracExp);

// -------------------------------------------------------------
// 4. exp(y*log(x)) version
// -------------------------------------------------------------

static void BM_PowExpLog_Int32_FracExp(benchmark::State& state) {
    auto func = [](int32_t base, [[maybe_unused]] double e) { return powerix::pow_2_3_exp_log(base); };
    for (auto _ : state) {
        run_dataset_frac(func, kIntBasesFrac);
    }
    ADD_METRICS_AND_NS_PER_POW_FRAC(state, func, kIntBasesFrac);
}
BENCHMARK(BM_PowExpLog_Int32_FracExp);

static void BM_PowExpLog_Float32_FracExp(benchmark::State& state) {
    auto func = [](float base, [[maybe_unused]] double e) { return powerix::pow_2_3_exp_log_float(base); };
    for (auto _ : state) {
        run_dataset_frac(func, kFloat32BasesFrac);
    }
    ADD_METRICS_AND_NS_PER_POW_FRAC(state, func, kFloat32BasesFrac);
}
BENCHMARK(BM_PowExpLog_Float32_FracExp);

static void BM_PowExpLog_Float64_FracExp(benchmark::State& state) {
    auto func = [](double base, [[maybe_unused]] double e) { return powerix::pow_2_3_exp_log(base); };
    for (auto _ : state) {
        run_dataset_frac(func, kFloat64BasesFrac);
    }
    ADD_METRICS_AND_NS_PER_POW_FRAC(state, func, kFloat64BasesFrac);
}
BENCHMARK(BM_PowExpLog_Float64_FracExp);

// -------------------------------------------------------------
// 5. Eigen version
// -------------------------------------------------------------

static void BM_PowEigen_Int32_FracExp(benchmark::State& state) {
    auto func = [](int32_t base, [[maybe_unused]] double e) { return powerix::pow_2_3_eigen(base); };
    for (auto _ : state) {
        run_dataset_frac(func, kIntBasesFrac);
    }
    ADD_METRICS_AND_NS_PER_POW_FRAC(state, func, kIntBasesFrac);
}
BENCHMARK(BM_PowEigen_Int32_FracExp);

static void BM_PowEigen_Float32_FracExp(benchmark::State& state) {
    auto func = [](float base, [[maybe_unused]] double e) { return powerix::pow_2_3_eigen_float(base); };
    for (auto _ : state) {
        run_dataset_frac(func, kFloat32BasesFrac);
    }
    ADD_METRICS_AND_NS_PER_POW_FRAC(state, func, kFloat32BasesFrac);
}
BENCHMARK(BM_PowEigen_Float32_FracExp);

static void BM_PowEigen_Float64_FracExp(benchmark::State& state) {
    auto func = [](double base, [[maybe_unused]] double e) { return powerix::pow_2_3_eigen(base); };
    for (auto _ : state) {
        run_dataset_frac(func, kFloat64BasesFrac);
    }
    ADD_METRICS_AND_NS_PER_POW_FRAC(state, func, kFloat64BasesFrac);
}
BENCHMARK(BM_PowEigen_Float64_FracExp);

// -------------------------------------------------------------
// 6. Binomial series version
// -------------------------------------------------------------

static void BM_PowSeries_Int32_FracExp(benchmark::State& state) {
    auto func = [](int32_t base, [[maybe_unused]] double e) { return powerix::pow_2_3_series(base); };
    for (auto _ : state) {
        run_dataset_frac(func, kIntBasesFrac);
    }
    ADD_METRICS_AND_NS_PER_POW_FRAC(state, func, kIntBasesFrac);
}
BENCHMARK(BM_PowSeries_Int32_FracExp);

static void BM_PowSeries_Float32_FracExp(benchmark::State& state) {
    auto func = [](float base, [[maybe_unused]] double e) { return powerix::pow_2_3_series_float(base); };
    for (auto _ : state) {
        run_dataset_frac(func, kFloat32BasesFrac);
    }
    ADD_METRICS_AND_NS_PER_POW_FRAC(state, func, kFloat32BasesFrac);
}
BENCHMARK(BM_PowSeries_Float32_FracExp);

static void BM_PowSeries_Float64_FracExp(benchmark::State& state) {
    auto func = [](double base, [[maybe_unused]] double e) { return powerix::pow_2_3_series(base); };
    for (auto _ : state) {
        run_dataset_frac(func, kFloat64BasesFrac);
    }
    ADD_METRICS_AND_NS_PER_POW_FRAC(state, func, kFloat64BasesFrac);
}
BENCHMARK(BM_PowSeries_Float64_FracExp);

// Main function
int main(int argc, char** argv) {
    ::benchmark::Initialize(&argc, argv);
    ::benchmark::RunSpecifiedBenchmarks();
    return 0;
} 