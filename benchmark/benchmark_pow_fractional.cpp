#include <benchmark/benchmark.h>
#include <cmath>
#include <cstdint>
#include <vector>
#include "../src/pow_impl.hpp"

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

// -------------------------------------------------------------
// 1. std::pow (reference)
// -------------------------------------------------------------

static void BM_PowStd_Int32_FracExp(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset_frac([](int32_t base, [[maybe_unused]] double e) { 
            return std::pow(static_cast<double>(base), kFracExp); 
        }, kIntBasesFrac);
    }
}
BENCHMARK(BM_PowStd_Int32_FracExp);

static void BM_PowStd_Float32_FracExp(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset_frac([](float base, [[maybe_unused]] double e) { 
            return std::pow(base, static_cast<float>(kFracExp)); 
        }, kFloat32BasesFrac);
    }
}
BENCHMARK(BM_PowStd_Float32_FracExp);

static void BM_PowStd_Float64_FracExp(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset_frac([](double base, [[maybe_unused]] double e) { 
            return std::pow(base, kFracExp); 
        }, kFloat64BasesFrac);
    }
}
BENCHMARK(BM_PowStd_Float64_FracExp);

// -------------------------------------------------------------
// 2. C raw pow function
// -------------------------------------------------------------

static void BM_PowCRaw_Int32_FracExp(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset_frac([](int32_t base, [[maybe_unused]] double e) { 
            return powerix::pow_c_raw(base, kFracExp); 
        }, kIntBasesFrac);
    }
}
BENCHMARK(BM_PowCRaw_Int32_FracExp);

static void BM_PowCRaw_Float32_FracExp(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset_frac([](float base, [[maybe_unused]] double e) { 
            return powerix::pow_c_raw_float(base, static_cast<float>(kFracExp)); 
        }, kFloat32BasesFrac);
    }
}
BENCHMARK(BM_PowCRaw_Float32_FracExp);

static void BM_PowCRaw_Float64_FracExp(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset_frac([](double base, [[maybe_unused]] double e) { 
            return powerix::pow_c_raw(base, kFracExp); 
        }, kFloat64BasesFrac);
    }
}
BENCHMARK(BM_PowCRaw_Float64_FracExp);

// -------------------------------------------------------------
// 3. cbrt version (cube root)
// -------------------------------------------------------------

static void BM_PowCbrt_Int32_FracExp(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset_frac([](int32_t base, [[maybe_unused]] double e) { 
            return powerix::pow_2_3_cbrt(base); 
        }, kIntBasesFrac);
    }
}
BENCHMARK(BM_PowCbrt_Int32_FracExp);

static void BM_PowCbrt_Float32_FracExp(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset_frac([](float base, [[maybe_unused]] double e) { 
            return powerix::pow_2_3_cbrt_float(base); 
        }, kFloat32BasesFrac);
    }
}
BENCHMARK(BM_PowCbrt_Float32_FracExp);

static void BM_PowCbrt_Float64_FracExp(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset_frac([](double base, [[maybe_unused]] double e) { 
            return powerix::pow_2_3_cbrt(base); 
        }, kFloat64BasesFrac);
    }
}
BENCHMARK(BM_PowCbrt_Float64_FracExp);

// -------------------------------------------------------------
// 4. exp(y*log(x)) version
// -------------------------------------------------------------

static void BM_PowExpLog_Int32_FracExp(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset_frac([](int32_t base, [[maybe_unused]] double e) { 
            return powerix::pow_2_3_exp_log(base); 
        }, kIntBasesFrac);
    }
}
BENCHMARK(BM_PowExpLog_Int32_FracExp);

static void BM_PowExpLog_Float32_FracExp(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset_frac([](float base, [[maybe_unused]] double e) { 
            return powerix::pow_2_3_exp_log_float(base); 
        }, kFloat32BasesFrac);
    }
}
BENCHMARK(BM_PowExpLog_Float32_FracExp);

static void BM_PowExpLog_Float64_FracExp(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset_frac([](double base, [[maybe_unused]] double e) { 
            return powerix::pow_2_3_exp_log(base); 
        }, kFloat64BasesFrac);
    }
}
BENCHMARK(BM_PowExpLog_Float64_FracExp);

// -------------------------------------------------------------
// 5. Eigen version
// -------------------------------------------------------------

static void BM_PowEigen_Int32_FracExp(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset_frac([](int32_t base, [[maybe_unused]] double e) { 
            return powerix::pow_2_3_eigen(base); 
        }, kIntBasesFrac);
    }
}
BENCHMARK(BM_PowEigen_Int32_FracExp);

static void BM_PowEigen_Float32_FracExp(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset_frac([](float base, [[maybe_unused]] double e) { 
            return powerix::pow_2_3_eigen_float(base); 
        }, kFloat32BasesFrac);
    }
}
BENCHMARK(BM_PowEigen_Float32_FracExp);

static void BM_PowEigen_Float64_FracExp(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset_frac([](double base, [[maybe_unused]] double e) { 
            return powerix::pow_2_3_eigen(base); 
        }, kFloat64BasesFrac);
    }
}
BENCHMARK(BM_PowEigen_Float64_FracExp);

// -------------------------------------------------------------
// 6. Binomial series version
// -------------------------------------------------------------

static void BM_PowSeries_Int32_FracExp(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset_frac([](int32_t base, [[maybe_unused]] double e) { 
            return powerix::pow_2_3_series(base); 
        }, kIntBasesFrac);
    }
}
BENCHMARK(BM_PowSeries_Int32_FracExp);

static void BM_PowSeries_Float32_FracExp(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset_frac([](float base, [[maybe_unused]] double e) { 
            return powerix::pow_2_3_series_float(base); 
        }, kFloat32BasesFrac);
    }
}
BENCHMARK(BM_PowSeries_Float32_FracExp);

static void BM_PowSeries_Float64_FracExp(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset_frac([](double base, [[maybe_unused]] double e) { 
            return powerix::pow_2_3_series(base); 
        }, kFloat64BasesFrac);
    }
}
BENCHMARK(BM_PowSeries_Float64_FracExp);

// Main function
int main(int argc, char** argv) {
    ::benchmark::Initialize(&argc, argv);
    ::benchmark::RunSpecifiedBenchmarks();
    return 0;
} 