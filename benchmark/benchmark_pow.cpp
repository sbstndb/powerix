#include <benchmark/benchmark.h>
#include <cmath>
#include <cstdint>
#include <vector>
#include <iostream>
#include <tuple>
#include <type_traits>
#include "../src/pow_impl.hpp"
#include "../src/error_util.hpp"

// Base datasets - only integer and double
static const std::vector<int32_t> kIntBases{2, 3, 4, 5};
static const std::vector<int32_t> kIntExps{0, 1, 2, 3, 5, 8, 10};
static const std::vector<double> kDoubleBases{0.1, 0.5, 1.3, 2.7, 5.9};
static const std::vector<double> kDoubleExps{0.1, 0.5, 1.05, 2.3, 5.7, 5.9};

// Helper to run dataset and prevent dead code elimination
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

// Helper to get bases dataset by type
template <typename T> 
const auto& get_bases() {
    static const auto bases = []() {
        if constexpr (std::is_integral_v<T>) {
            return std::vector<T>(kIntBases.begin(), kIntBases.end());
        } else {
            return std::vector<T>(kDoubleBases.begin(), kDoubleBases.end());
        }
    }();
    return bases;
}

// Helper to get exponents dataset by type
template <typename T> 
const auto& get_exps() {
    static const auto exps = []() {
        if constexpr (std::is_integral_v<T>) {
            return std::vector<T>(kIntExps.begin(), kIntExps.end());
        } else {
            return std::vector<T>(kDoubleExps.begin(), kDoubleExps.end());
        }
    }();
    return exps;
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

// Generic benchmark template
template <auto PowFunc, typename BaseType, typename ExpType>
void BM_PowGeneric_T(benchmark::State& state) {
    auto func = [](BaseType a, ExpType b) {
        return PowFunc(a, b); // Aucune conversion explicite
    };
    const auto& bases = get_bases<BaseType>();
    const auto& exps = get_exps<ExpType>();

    for (auto _ : state) {
        run_dataset(func, bases, exps);
    }
    ADD_METRICS_AND_NS_PER_POW(state, func, bases, exps);
}

// Specializations for hierarchical power due to its branching logic
template <typename BaseType, typename ExpType>
auto hierarchical_pow_wrapper(BaseType a, ExpType b) {
    if constexpr (std::is_integral_v<BaseType>) {
        return powerix::pow_hierarchical_int(a, b);
    } else {
        return powerix::pow_hierarchical_float(a, b);
    }
}

// Specialization for cached_vector_optional which is templated
template<typename BaseType, typename ExpType>
auto cached_vector_optional_wrapper(BaseType a, ExpType b) {
    return powerix::pow_cached_vector_optional_int<BaseType>(a, b);
}

// Specialization for cached_static_array which is templated
template<typename BaseType, typename ExpType>
auto cached_static_array_wrapper(BaseType a, ExpType b) {
    return powerix::pow_cached_static_array<BaseType>(a, b);
}

// Wrapper sans cast pour std::pow
template<typename BaseType, typename ExpType>
inline auto std_pow_wrapper(BaseType a, ExpType b) {
    return std::pow(a, b); // Aucune conversion explicite
}

// Specialisation pour fast_int wrapper (integer exponent)
template<typename BaseType, typename ExpType>
inline BaseType pow_fast_int_wrapper(BaseType a, ExpType b) {
    return powerix::pow_fast_int<BaseType>(a, b); // conversion implicite éventuelle ok
}

// Specialisation pour ultra_fast wrapper (unsigned exponent)
template<typename BaseType, typename ExpType>
inline BaseType pow_ultra_fast_wrapper(BaseType a, ExpType b) {
    return powerix::pow_ultra_fast<BaseType>(a, b); // conversion implicite éventuelle ok
}

// Register all benchmarks
// Standard pow (all types)
BENCHMARK_TEMPLATE(BM_PowGeneric_T, std_pow_wrapper<int16_t,int16_t>, int16_t, int16_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, std_pow_wrapper<uint16_t,uint16_t>, uint16_t, uint16_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, std_pow_wrapper<int32_t,int32_t>, int32_t, int32_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, std_pow_wrapper<int64_t,int64_t>, int64_t, int64_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, std_pow_wrapper<uint32_t,uint32_t>, uint32_t, uint32_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, std_pow_wrapper<uint64_t,uint64_t>, uint64_t, uint64_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, std_pow_wrapper<float,float>, float, float);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, std_pow_wrapper<double,double>, double, double);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, std_pow_wrapper<float,int32_t>, float, int32_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, std_pow_wrapper<double,int32_t>, double, int32_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, std_pow_wrapper<int32_t,double>, int32_t, double);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, std_pow_wrapper<double,float>, double, float);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, std_pow_wrapper<float,double>, float, double);

// Fast integer exponentiation (integer types only)
BENCHMARK_TEMPLATE(BM_PowGeneric_T, pow_fast_int_wrapper<int16_t, int16_t>, int16_t, int16_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, pow_fast_int_wrapper<uint16_t, uint16_t>, uint16_t, uint16_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, pow_fast_int_wrapper<int32_t, int32_t>, int32_t, int32_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, pow_fast_int_wrapper<int64_t, int64_t>, int64_t, int64_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, pow_fast_int_wrapper<uint32_t, uint32_t>, uint32_t, uint32_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, pow_fast_int_wrapper<uint64_t, uint64_t>, uint64_t, uint64_t);

// Hierarchical exponentiation (all types)
BENCHMARK_TEMPLATE(BM_PowGeneric_T, hierarchical_pow_wrapper<int16_t, int16_t>, int16_t, int16_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, hierarchical_pow_wrapper<uint16_t, uint16_t>, uint16_t, uint16_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, hierarchical_pow_wrapper<int32_t, int32_t>, int32_t, int32_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, hierarchical_pow_wrapper<int64_t, int64_t>, int64_t, int64_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, hierarchical_pow_wrapper<uint32_t, uint32_t>, uint32_t, uint32_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, hierarchical_pow_wrapper<uint64_t, uint64_t>, uint64_t, uint64_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, hierarchical_pow_wrapper<float, int32_t>, float, int32_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, hierarchical_pow_wrapper<double, int32_t>, double, int32_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, hierarchical_pow_wrapper<float, float>, float, float);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, hierarchical_pow_wrapper<double, double>, double, double);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, hierarchical_pow_wrapper<float, double>, float, double);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, hierarchical_pow_wrapper<double, float>, double, float);

// Ultra-fast binary exponentiation (all types)
BENCHMARK_TEMPLATE(BM_PowGeneric_T, pow_ultra_fast_wrapper<int16_t, int16_t>, int16_t, int16_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, pow_ultra_fast_wrapper<uint16_t, uint16_t>, uint16_t, uint16_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, pow_ultra_fast_wrapper<int32_t, int32_t>, int32_t, int32_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, pow_ultra_fast_wrapper<int64_t, int64_t>, int64_t, int64_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, pow_ultra_fast_wrapper<uint32_t, uint32_t>, uint32_t, uint32_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, pow_ultra_fast_wrapper<uint64_t, uint64_t>, uint64_t, uint64_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, pow_ultra_fast_wrapper<float, int32_t>, float, int32_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, pow_ultra_fast_wrapper<double, int32_t>, double, int32_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, pow_ultra_fast_wrapper<float, float>, float, float);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, pow_ultra_fast_wrapper<double, double>, double, double);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, pow_ultra_fast_wrapper<float, double>, float, double);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, pow_ultra_fast_wrapper<double, float>, double, float);

// Cached implementations (integer types only)
BENCHMARK_TEMPLATE(BM_PowGeneric_T, powerix::pow_cached_map, int16_t, int16_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, powerix::pow_cached_map, int32_t, int32_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, powerix::pow_cached_map, int64_t, int64_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, powerix::pow_cached_map, uint16_t, uint16_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, powerix::pow_cached_map, uint32_t, uint32_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, powerix::pow_cached_map, uint64_t, uint64_t);

BENCHMARK_TEMPLATE(BM_PowGeneric_T, powerix::pow_cached_unordered_nested, int16_t, int16_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, powerix::pow_cached_unordered_nested, int32_t, int32_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, powerix::pow_cached_unordered_nested, int64_t, int64_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, powerix::pow_cached_unordered_nested, uint16_t, uint16_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, powerix::pow_cached_unordered_nested, uint32_t, uint32_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, powerix::pow_cached_unordered_nested, uint64_t, uint64_t);

BENCHMARK_TEMPLATE(BM_PowGeneric_T, powerix::pow_cached_unordered_pair, int16_t, int16_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, powerix::pow_cached_unordered_pair, int32_t, int32_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, powerix::pow_cached_unordered_pair, int64_t, int64_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, powerix::pow_cached_unordered_pair, uint16_t, uint16_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, powerix::pow_cached_unordered_pair, uint32_t, uint32_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, powerix::pow_cached_unordered_pair, uint64_t, uint64_t);

BENCHMARK_TEMPLATE(BM_PowGeneric_T, cached_vector_optional_wrapper<int16_t, int16_t>, int16_t, int16_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, cached_vector_optional_wrapper<int32_t, int32_t>, int32_t, int32_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, cached_vector_optional_wrapper<int64_t, int64_t>, int64_t, int64_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, cached_vector_optional_wrapper<uint16_t, uint16_t>, uint16_t, uint16_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, cached_vector_optional_wrapper<uint32_t, uint32_t>, uint32_t, uint32_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, cached_vector_optional_wrapper<uint64_t, uint64_t>, uint64_t, uint64_t);

BENCHMARK_TEMPLATE(BM_PowGeneric_T, cached_static_array_wrapper<int16_t, int16_t>, int16_t, int16_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, cached_static_array_wrapper<int32_t, int32_t>, int32_t, int32_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, cached_static_array_wrapper<int64_t, int64_t>, int64_t, int64_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, cached_static_array_wrapper<uint16_t, uint16_t>, uint16_t, uint16_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, cached_static_array_wrapper<uint32_t, uint32_t>, uint32_t, uint32_t);
BENCHMARK_TEMPLATE(BM_PowGeneric_T, cached_static_array_wrapper<uint64_t, uint64_t>, uint64_t, uint64_t);

BENCHMARK_MAIN(); 