#include <benchmark/benchmark.h>
#include <cmath>
#include <cstdint>
#include <vector>
#include <iostream>
#include <tuple>
#include <type_traits>
#include "../src/pow_impl.hpp"
#include "../src/error_util.hpp"

// Datasets for fractional exponent benchmarks
static const std::vector<float> kFloat32BasesFrac{0.1f, 0.3f, 0.5f, 0.8f, 1.0f, 2.0f, 3.0f, 5.0f, 8.0f, 13.0f};
static const std::vector<double> kFloat64BasesFrac{0.1, 0.3, 0.5, 0.8, 1.0, 2.0, 3.0, 5.0, 8.0, 13.0};

// Fixed exponent: 2/3
static constexpr double kFracExp = 2.0/3.0;

// Helper to get bases dataset by type for fractional benchmarks
template <typename T> 
const auto& get_bases_frac() {
    static const auto bases = []() {
        if constexpr (std::is_same_v<T, float>) {
            return std::vector<T>(kFloat32BasesFrac.begin(), kFloat32BasesFrac.end());
        } else {
            return std::vector<T>(kFloat64BasesFrac.begin(), kFloat64BasesFrac.end());
        }
    }();
    return bases;
}

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
    state.counters["MaxRelErr"] = error.rel_err;

// Generic benchmark template
template <auto PowFunc, typename BaseType, typename ExpType>
void BM_PowGeneric_Frac_T(benchmark::State& state) {
    auto func = [](BaseType base, double exp) {
        return PowFunc(base, static_cast<ExpType>(exp));
    };
    const auto& bases = get_bases_frac<BaseType>();

    for (auto _ : state) {
        run_dataset_frac(func, bases);
    }
    ADD_METRICS_AND_NS_PER_POW_FRAC(state, func, bases);
}

// Wrapper functions for different pow implementations
template<typename BaseType, typename ExpType>
inline auto std_pow_wrapper(BaseType base, ExpType exp) {
    return std::pow(base, exp);
}

template<typename BaseType, typename ExpType>
inline auto c_raw_pow_wrapper(BaseType base, ExpType exp) {
    return powerix::pow_c_raw(base, exp);
}

template<typename BaseType, typename ExpType>
inline auto cbrt_pow_wrapper(BaseType base, [[maybe_unused]] ExpType exp) {
    return powerix::pow_2_3_cbrt(base);
}

template<typename BaseType, typename ExpType>
inline auto exp_log_pow_wrapper(BaseType base, [[maybe_unused]] ExpType exp) {
    return powerix::pow_2_3_exp_log(base);
}

template<typename BaseType, typename ExpType>
inline auto series_pow_wrapper(BaseType base, [[maybe_unused]] ExpType exp) {
    return powerix::pow_2_3_series(base);
}

// Register all benchmarks
// Standard pow (reference)
BENCHMARK_TEMPLATE(BM_PowGeneric_Frac_T, std_pow_wrapper<float, float>, float, float);
BENCHMARK_TEMPLATE(BM_PowGeneric_Frac_T, std_pow_wrapper<float, double>, float, double);
BENCHMARK_TEMPLATE(BM_PowGeneric_Frac_T, std_pow_wrapper<double, float>, double, float);
BENCHMARK_TEMPLATE(BM_PowGeneric_Frac_T, std_pow_wrapper<double, double>, double, double);

// C raw pow function
BENCHMARK_TEMPLATE(BM_PowGeneric_Frac_T, c_raw_pow_wrapper<float, float>, float, float);
BENCHMARK_TEMPLATE(BM_PowGeneric_Frac_T, c_raw_pow_wrapper<float, double>, float, double);
BENCHMARK_TEMPLATE(BM_PowGeneric_Frac_T, c_raw_pow_wrapper<double, float>, double, float);
BENCHMARK_TEMPLATE(BM_PowGeneric_Frac_T, c_raw_pow_wrapper<double, double>, double, double);

// Cube root version
BENCHMARK_TEMPLATE(BM_PowGeneric_Frac_T, cbrt_pow_wrapper<float, float>, float, float);
BENCHMARK_TEMPLATE(BM_PowGeneric_Frac_T, cbrt_pow_wrapper<float, double>, float, double);
BENCHMARK_TEMPLATE(BM_PowGeneric_Frac_T, cbrt_pow_wrapper<double, float>, double, float);
BENCHMARK_TEMPLATE(BM_PowGeneric_Frac_T, cbrt_pow_wrapper<double, double>, double, double);

// Exponential and logarithmic version
BENCHMARK_TEMPLATE(BM_PowGeneric_Frac_T, exp_log_pow_wrapper<float, float>, float, float);
BENCHMARK_TEMPLATE(BM_PowGeneric_Frac_T, exp_log_pow_wrapper<float, double>, float, double);
BENCHMARK_TEMPLATE(BM_PowGeneric_Frac_T, exp_log_pow_wrapper<double, float>, double, float);
BENCHMARK_TEMPLATE(BM_PowGeneric_Frac_T, exp_log_pow_wrapper<double, double>, double, double);

// Binomial series version
BENCHMARK_TEMPLATE(BM_PowGeneric_Frac_T, series_pow_wrapper<float, float>, float, float);
BENCHMARK_TEMPLATE(BM_PowGeneric_Frac_T, series_pow_wrapper<float, double>, float, double);
BENCHMARK_TEMPLATE(BM_PowGeneric_Frac_T, series_pow_wrapper<double, float>, double, float);
BENCHMARK_TEMPLATE(BM_PowGeneric_Frac_T, series_pow_wrapper<double, double>, double, double);

BENCHMARK_MAIN(); 