#pragma once

#include <cmath>
#include <vector>
#include <map>
#include <type_traits>
#include <functional>
#include <optional>
#include <limits>
#include <unordered_map>

namespace powerix {


// Binary exponentiation algorithm (exponentiation rapide)
template <typename T, typename ExpType>
inline T pow_binary(T base, ExpType exp) {
    static_assert(std::is_integral_v<ExpType>, "ExpType must be an integral type");
    if (exp < 0) {
        return static_cast<T>(0);
    }
    if (exp == 0) return static_cast<T>(1);
    if (exp == 1) return base;
    
    T result = static_cast<T>(1);
    T current = base;
    
    while (exp > 0) {
        if (exp & 1) {
            result *= current;
        }
        current *= current;
        exp >>= 1;
    }
    
    return result;
}

// Hierarchical recursive exponentiation (divide & conquer) - works for both int and float
template <typename T, typename ExpType>
inline T pow_hierarchical(T base, ExpType exp) {
    static_assert(std::is_integral_v<ExpType>, "ExpType must be an integral type");
    if (exp == 0) return static_cast<T>(1);
    if (exp == 1) return base;
    T half = pow_hierarchical(base * base, exp >> 1);
    return (exp & 1u) ? base * half : half;
}

// Ultra-optimized binary exponentiation with loop unrolling
template <typename T, typename ExpType>
inline T pow_ultra_fast(T base, ExpType exp) {
    static_assert(std::is_integral_v<ExpType>, "ExpType must be an integral type");
    if (exp == 0) [[likely]] return static_cast<T>(1);
    
    T result = static_cast<T>(1);
    
    // Fast handling of common power of 2 cases
    switch (exp) {
        case 1: return base;
        case 2: return base * base;
        case 3: return base * base * base;
        case 4: { T sq = base * base; return sq * sq; }
        case 8: { 
            T sq = base * base; 
            T quad = sq * sq;
            return quad * quad;
        }
        default: break;
    }
    
    // Optimized binary algorithm for other cases
    while (exp > 1) {
        if (exp & 1) {
            result *= base;
        }
        base *= base;
        exp >>= 1;
    }
    
    return result * base;
}

// Memoization with std::map
template <typename T1, typename T2, typename ResultType = std::conditional_t<std::is_floating_point_v<T1> || std::is_floating_point_v<T2>, std::common_type_t<T1, T2>, T1>>
inline ResultType pow_cached_map(T1 base, T2 exp) {
    static_assert(std::is_integral_v<T1>, "T1 must be an integral type");
    static_assert(std::is_integral_v<T2>, "T2 must be an integral type");
    
    using Key = std::pair<T1, T2>;
    static std::map<Key, ResultType> cache;
    auto it = cache.find({base, exp});
    if (it != cache.end()) {
        return it->second;
    }
    
    ResultType result = std::pow(static_cast<double>(base), static_cast<double>(exp));
    cache[{base, exp}] = result;
    return result;
}

// Memoization with nested std::unordered_maps
template <typename T1, typename T2, typename ResultType = std::conditional_t<std::is_floating_point_v<T1> || std::is_floating_point_v<T2>, std::common_type_t<T1, T2>, T1>>
inline ResultType pow_cached_unordered_nested(T1 base, T2 exp) {
    static_assert(std::is_integral_v<T1>, "T1 must be an integral type");
    static_assert(std::is_integral_v<T2>, "T2 must be an integral type");
    
    using InnerMap = std::unordered_map<T2, ResultType>;
    static std::unordered_map<T1, InnerMap> cache;

    auto outer = cache.find(base);
    if (outer != cache.end()) {
        auto inner = outer->second.find(exp);
        if (inner != outer->second.end()) {
            return inner->second;
        }
    }

    ResultType result = std::pow(static_cast<double>(base), static_cast<double>(exp));
    cache[base][exp] = result;
    return result;
}

// Custom hash for pair<T1,T2>
template <typename T1, typename T2>
struct PairHash {
    std::size_t operator()(const std::pair<T1, T2>& p) const noexcept {
        std::size_t h1 = std::hash<T1>{}(p.first);
        std::size_t h2 = std::hash<T2>{}(p.second);
        return h1 ^ (h2 + 0x9e3779b9 + (h1 << 6) + (h1 >> 2));
    }
};

// Memoization with unordered_map and pair key
template <typename T1, typename T2, typename ResultType = std::conditional_t<std::is_floating_point_v<T1> || std::is_floating_point_v<T2>, std::common_type_t<T1, T2>, T1>>
inline ResultType pow_cached_unordered_pair(T1 base, T2 exp) {
    static_assert(std::is_integral_v<T1>, "T1 must be an integral type");
    static_assert(std::is_integral_v<T2>, "T2 must be an integral type");
    
    using Key = std::pair<T1, T2>;
    static std::unordered_map<Key, ResultType, PairHash<T1, T2>> cache;

    auto key = Key{base, exp};
    auto it = cache.find(key);
    if (it != cache.end()) {
        return it->second;
    }

    ResultType result = std::pow(static_cast<double>(base), static_cast<double>(exp));
    cache[key] = result;
    return result;
}

// Memoization with vector<vector<optional>> for integer types
template <typename IntType, typename ExpType>
inline IntType pow_cached_vector_optional(IntType base, ExpType exp) {
    static_assert(std::is_integral_v<ExpType>, "ExpType must be an integral type");
    if (base < 0) {
        return pow_hierarchical(base, exp);
    }
    static std::vector<std::vector<std::optional<IntType>>> cache;
    const size_t b = static_cast<size_t>(base);

    if (b >= cache.size()) {
        cache.resize(b + 1);
    }
    if (exp >= cache[b].size()) {
        cache[b].resize(exp + 1);
    }
    if (cache[b][exp].has_value()) {
        return *cache[b][exp];
    }
    
    IntType result = pow_hierarchical(base, exp);
    cache[b][exp] = result;
    return result;
}

// Static array cache for small integer ranges
template <typename IntType, typename ExpType, size_t MAX_BASE = 16, size_t MAX_EXP = 16>
inline IntType pow_cached_static_array(IntType base, ExpType exp) {
    static_assert(std::is_integral_v<ExpType>, "ExpType must be an integral type");
    if (base >= 0 && static_cast<size_t>(base) < MAX_BASE && exp < MAX_EXP) {
        static IntType cache[MAX_BASE][MAX_EXP] = {};
        static bool is_cached[MAX_BASE][MAX_EXP] = {};

        if (is_cached[base][exp]) {
            return cache[base][exp];
        }

        IntType result = pow_hierarchical(base, exp);
        cache[base][exp] = result;
        is_cached[base][exp] = true;
        return result;
    }

    return pow_hierarchical(base, exp);
}

// C raw pow function wrapper
extern "C" {
    double pow(double x, double y);
}

template <typename T>
inline double pow_c_raw(T base, double exp) {
    return pow(static_cast<double>(base), exp);
}

// Cube root functions
extern "C" {
    double cbrt(double x);
    float cbrtf(float x);
}

template <typename T>
inline double cbrt_wrapper(T x) {
    return cbrt(static_cast<double>(x));
}

// pow(x, 2/3) = cbrt(x^2)
template <typename T>
inline double pow_2_3_cbrt(T x) {
    double x_squared = static_cast<double>(x) * static_cast<double>(x);
    return cbrt(x_squared);
}

// Exponential and logarithmic functions
extern "C" {
    double exp(double x);
    float expf(float x);
    double log(double x);
    float logf(float x);
}

// pow(x, 2/3) = exp(2/3 * log(x))
template <typename T>
inline double pow_2_3_exp_log(T base) {
    constexpr double two_thirds = 2.0 / 3.0;
    return ::exp(two_thirds * ::log(static_cast<double>(base)));
}

// Binomial series expansion for pow(x, 2/3)
template <typename T>
inline double pow_2_3_series(T base) {
    if (base == 0) return 0.0;
    if (base < 0) {
        return std::numeric_limits<double>::quiet_NaN();
    }

    double x = static_cast<double>(base);
    double n = std::round(::cbrt(x));
    double n_squared = n * n;
    double a = n_squared * n;

    if (a == 0) {
        return ::pow(x, 2.0/3.0);
    }

    double z = x / a - 1.0;
    constexpr double alpha = 2.0 / 3.0;
    constexpr int num_terms = 10;

    double sum = 1.0;
    double term = 1.0;

    for (int k = 1; k < num_terms; ++k) {
        term *= (alpha - static_cast<double>(k) + 1.0) / static_cast<double>(k) * z;
        sum += term;
    }

    return n_squared * sum;
}

} // namespace powerix 