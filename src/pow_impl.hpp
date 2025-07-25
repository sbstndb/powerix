#pragma once

#include <cmath>
#include <vector>
#include <map>
#include <type_traits>
#include <functional>
#include <optional>
#include <limits>
#include <Eigen/Core>
#include <unordered_map>

namespace powerix {

/*
 * CACHE STRATEGY SUMMARY:
 * 
 * 1. pow_cached_map: std::map with pair<double,int> key
 *    - Complexity: O(log n) for lookups
 *    - Advantages: Simple, ordered, thread-safe
 *    - Disadvantages: Slower than other implementations
 * 
 * 2. pow_cached_unordered_nested: nested std::unordered_maps
 *    - Complexity: O(1) amortized
 *    - Advantages: Fast access, hierarchical structure
 *    - Disadvantages: High memory usage
 * 
 * 3. pow_cached_unordered_pair: std::unordered_map with pair key and custom hash
 *    - Complexity: O(1) amortized
 *    - Advantages: Simple structure, very fast
 *    - Disadvantages: Requires hash function
 * 
 * 4. pow_cached_vector_optional: std::vector<std::vector<std::optional<>>
 *    - Complexity: O(1) direct index access
 *    - Advantages: Ultra-fast access, no hash needed
 *    - Disadvantages: High memory usage, expensive resizing
 * 
 * 5. pow_cached_static_array: Static C-style array
 *    - Complexity: O(1) ultra-fast
 *    - Advantages: Fastest possible, no dynamic allocation
 *    - Disadvantages: Fixed limited size
 * 
 * RECOMMENDATIONS:
 * - For small known ranges: pow_cached_static_array
 * - For medium ranges: pow_cached_vector_optional
 * - For wide ranges: pow_cached_unordered_pair
 * - For compatibility: pow_cached_map
 */

// Fast integer exponentiation using binary exponentiation algorithm
template <typename T>
inline T pow_fast_int(T base, int exp) {
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

// Hierarchical recursive exponentiation (divide & conquer)
template <typename Base>
inline Base pow_hierarchical_int(Base base, unsigned int exp) {
    if (exp == 0) return static_cast<Base>(1);
    if (exp == 1) return base;
    Base half = pow_hierarchical_int(base * base, exp >> 1);
    return (exp & 1u) ? base * half : half;
}

// Hierarchical exponentiation for floating point types
template <typename FloatType>
inline FloatType pow_hierarchical_float(FloatType base, unsigned int exp) {
    if (exp == 0) return static_cast<FloatType>(1.0);
    if (exp == 1) return base;
    FloatType half = pow_hierarchical_float(base * base, exp >> 1);
    return (exp & 1u) ? base * half : half;
}

// Ultra-optimized binary exponentiation with loop unrolling
template <typename T>
inline T pow_ultra_fast(T base, unsigned int exp) {
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
inline double pow_cached_map(double base, int exp) {
    using Key = std::pair<double, int>;
    static std::map<Key, double> cache;
    auto it = cache.find({base, exp});
    if (it != cache.end()) {
        return it->second;
    }
    
    double result = std::pow(base, exp);
    cache[{base, exp}] = result;
    return result;
}

// Memoization with nested std::unordered_maps
inline double pow_cached_unordered_nested(double base, int exp) {
    using InnerMap = std::unordered_map<int, double>;
    static std::unordered_map<double, InnerMap> cache;

    auto outer = cache.find(base);
    if (outer != cache.end()) {
        auto inner = outer->second.find(exp);
        if (inner != outer->second.end()) {
            return inner->second;
        }
    }

    double result = std::pow(base, exp);
    cache[base][exp] = result;
    return result;
}

// Custom hash for pair<double,int>
struct PairHash {
    std::size_t operator()(const std::pair<double, int>& p) const noexcept {
        std::size_t h1 = std::hash<double>{}(p.first);
        std::size_t h2 = std::hash<int>{}(p.second);
        return h1 ^ (h2 + 0x9e3779b9 + (h1 << 6) + (h1 >> 2));
    }
};

// Memoization with unordered_map and pair key
inline double pow_cached_unordered_pair(double base, int exp) {
    using Key = std::pair<double, int>;
    static std::unordered_map<Key, double, PairHash> cache;

    auto key = Key{base, exp};
    auto it = cache.find(key);
    if (it != cache.end()) {
        return it->second;
    }

    double result = std::pow(base, exp);
    cache[key] = result;
    return result;
}

// Memoization with vector<vector<optional>> for integer types
template <typename IntType>
inline IntType pow_cached_vector_optional_int(IntType base, unsigned int exp) {
    if (base < 0) {
        return pow_hierarchical_int(base, exp);
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
    
    IntType result = pow_hierarchical_int(base, exp);
    cache[b][exp] = result;
    return result;
}

// Static array cache for small integer ranges
template <typename IntType, size_t MAX_BASE = 16, size_t MAX_EXP = 16>
inline IntType pow_cached_static_array(IntType base, unsigned int exp) {
    if (base >= 0 && static_cast<size_t>(base) < MAX_BASE && exp < MAX_EXP) {
        static IntType cache[MAX_BASE][MAX_EXP] = {};
        static bool is_cached[MAX_BASE][MAX_EXP] = {};

        if (is_cached[base][exp]) {
            return cache[base][exp];
        }

        IntType result = pow_hierarchical_int(base, exp);
        cache[base][exp] = result;
        is_cached[base][exp] = true;
        return result;
    }

    return pow_hierarchical_int(base, exp);
}

// C raw pow function wrapper
extern "C" {
    double pow(double x, double y);
}

template <typename T>
inline double pow_c_raw(T base, double exp) {
    return pow(static_cast<double>(base), exp);
}

inline float pow_c_raw_float(float base, float exp) {
    return static_cast<float>(pow(static_cast<double>(base), static_cast<double>(exp)));
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

inline float cbrt_wrapper_float(float x) {
    return cbrtf(x);
}

// pow(x, 2/3) = cbrt(x^2)
template <typename T>
inline double pow_2_3_cbrt(T x) {
    double x_squared = static_cast<double>(x) * static_cast<double>(x);
    return cbrt(x_squared);
}

inline float pow_2_3_cbrt_float(float x) {
    float x_squared = x * x;
    return cbrtf(x_squared);
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

inline float pow_2_3_exp_log_float(float base) {
    constexpr float two_thirds_f = 2.0f / 3.0f;
    return ::expf(two_thirds_f * ::logf(base));
}

// Eigen version for pow(x, 2/3)
template <typename T>
inline double pow_2_3_eigen(T base) {
    constexpr double two_thirds = 2.0 / 3.0;
    Eigen::Array<double, 1, 1> arr(static_cast<double>(base));
    return arr.pow(two_thirds)(0);
}

inline float pow_2_3_eigen_float(float base) {
    constexpr float two_thirds_f = 2.0f / 3.0f;
    Eigen::Array<float, 1, 1> arr(base);
    return arr.pow(two_thirds_f)(0);
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

inline float pow_2_3_series_float(float base) {
    if (base == 0.0f) return 0.0f;
    if (base < 0.0f) {
        return std::numeric_limits<float>::quiet_NaN();
    }

    float n = std::round(::cbrtf(base));
    float n_squared = n * n;
    float a = n_squared * n;

    if (a == 0.0f) {
        return ::powf(base, 2.0f/3.0f);
    }

    float z = base / a - 1.0f;
    constexpr float alpha = 2.0f / 3.0f;
    constexpr int num_terms = 10;

    float sum = 1.0f;
    float term = 1.0f;

    for (int k = 1; k < num_terms; ++k) {
        term *= (alpha - static_cast<float>(k) + 1.0f) / static_cast<float>(k) * z;
        sum += term;
    }
    
    return n_squared * sum;
}

} // namespace powerix 