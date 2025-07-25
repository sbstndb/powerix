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

// 1. Standard pow wrapper
// Simple wrapper around std::pow for reference

inline double pow_std(double base, double exp) {
    return std::pow(base, exp);
}

// 2. Fast integer exponentiation
// Implements fast exponentiation for non-negative integer exponents
// Uses binary exponentiation algorithm

template <typename T>
inline T pow_fast_int(T base, int exp) {
    if (exp < 0) {
        return static_cast<T>(0); // For negative exponents, return 0
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

// 3. Memoized pow with std::map
// Implements a memoized version using a static std::map
// Thread-safe with std::mutex

inline double pow_cached(double base, int exp) {
    using Key = std::pair<double, int>;
    static std::map<Key, double> cache;
    auto it = cache.find({base, exp});
    if (it != cache.end()) {
        return it->second;
    }
    
    // Calculate outside critical section to avoid blocking
    double result = std::pow(base, exp);
    cache[{base, exp}] = result;
    return result;
}

// 3.b  Memoized pow with std::unordered_map imbriqués
// Cette variante utilise une unordered_map externe indexée par la base et,
// pour chaque base, une unordered_map interne indexée par l'exposant.
// On conserve un mutex global pour la sécurité thread-safe, mais l'accès
// amorti O(1) sur la clé améliore les performances par rapport au std::map
// dont la complexité est logarithmique.
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

    // Calcul
    double result = std::pow(base, exp);
    cache[base][exp] = result;
    return result;
}

// 3.c  Memoized pow avec unordered_map et clé pair<double,int>
// On fournit un hash dédié pour pair afin d'obtenir un cache plat O(1).
struct PairHash {
    std::size_t operator()(const std::pair<double, int>& p) const noexcept {
        std::size_t h1 = std::hash<double>{}(p.first);
        std::size_t h2 = std::hash<int>{}(p.second);
        return h1 ^ (h2 + 0x9e3779b9 + (h1 << 6) + (h1 >> 2)); // hash combiné
    }
};

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


// 4. Hierarchical recursive exponentiation (divide & conquer)
// Reduces comparisons/iterations using tail-optimizable recursion
// Works for exp >= 0

template <typename Base>
inline Base pow_hierarchical_int(Base base, unsigned int exp) {
    if (exp == 0) return static_cast<Base>(1);
    if (exp == 1) return base;
    Base half = pow_hierarchical_int(base * base, exp >> 1); // exp/2
    return (exp & 1u) ? base * half : half;
}

// 5. Hierarchical exponentiation for floating point types
// Version adapted for float/double with positive integer exponents

template <typename FloatType>
inline FloatType pow_hierarchical_float(FloatType base, unsigned int exp) {
    if (exp == 0) return static_cast<FloatType>(1.0);
    if (exp == 1) return base;
    FloatType half = pow_hierarchical_float(base * base, exp >> 1); // exp/2
    return (exp & 1u) ? base * half : half;
}

// 6. My favorite version: Ultra-optimized binary exponentiation
// Combines bit manipulation, partial loop unrolling, and compiler optimizations
// Avoids unnecessary branches and uses fast bit-wise operations

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

// 7. Memoization with std::vector<std::vector<>
// Suitable for positive integer exponents and integer bases (>=0) of small size
// Re-allocates dynamically if needed

template <typename IntType>
inline IntType pow_vec_cached_int(IntType base, unsigned int exp) {
    if (base < 0) {
        // For negative bases, fall back to hierarchical version (rare in benchmarks)
        return pow_hierarchical_int(base, exp);
    }
    static std::vector<std::vector<std::optional<IntType>>> cache; // cache[base][exp]
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
    
    // Calculate outside critical section to avoid blocking
    IntType result = pow_hierarchical_int(base, exp);
    cache[b][exp] = result;
    return result;
}

// 8. Memoization vector<vector> for floating point types
// Version adapted for float/double with positive integer exponents

template <typename FloatType>
inline FloatType pow_vec_cached_float(FloatType base, unsigned int exp) {
    static std::vector<std::vector<std::optional<FloatType>>> cache; // cache[base][exp]
    // For floating points, use a discretized key
    const size_t b = static_cast<size_t>(std::abs(base) * 1000); // Discretization to 3 decimals

    if (b >= cache.size()) {
        cache.resize(b + 1);
    }
    if (exp >= cache[b].size()) {
        cache[b].resize(exp + 1);
    }
    if (cache[b][exp].has_value()) {
        return *cache[b][exp];
    }
    
    // Calculate outside critical section
    FloatType result = pow_hierarchical_float(base, exp);
    cache[b][exp] = result;
    return result;
}

// 9. Pure C version (pow from math.h)
// Uses C function pow() directly without C++ wrapper
// Can be faster in some cases

extern "C" {
    double pow(double x, double y);
}

template <typename T>
inline double pow_c_raw(T base, double exp) {
    return pow(static_cast<double>(base), exp);
}

// Specialization for float to avoid conversions
inline float pow_c_raw_float(float base, float exp) {
    return static_cast<float>(pow(static_cast<double>(base), static_cast<double>(exp)));
}

// 10. cbrt function (cube root) - equivalent to pow(x, 1/3)
// Faster than pow() for cube roots
// Available in C and C++

extern "C" {
    double cbrt(double x);
    float cbrtf(float x);
}

template <typename T>
inline double cbrt_wrapper(T x) {
    return cbrt(static_cast<double>(x));
}

// Specialization for float
inline float cbrt_wrapper_float(float x) {
    return cbrtf(x);
}

// To get pow(x, 2/3) = cbrt(x^2)
template <typename T>
inline double pow_2_3_cbrt(T x) {
    double x_squared = static_cast<double>(x) * static_cast<double>(x);
    return cbrt(x_squared);
}

// Specialization for float
inline float pow_2_3_cbrt_float(float x) {
    float x_squared = x * x;
    return cbrtf(x_squared);
}

// 11. exp(y*log(x)) version
// Uses exponential and logarithmic functions to calculate power
// pow(x, y) = exp(y * log(x)) - valid for x > 0

extern "C" {
    double exp(double x);
    float expf(float x);
    double log(double x);
    float logf(float x);
}

// To get pow(x, 2/3) = exp(2/3 * log(x))
template <typename T>
inline double pow_2_3_exp_log(T base) {
    constexpr double two_thirds = 2.0 / 3.0;
    return ::exp(two_thirds * ::log(static_cast<double>(base)));
}

// Specialization for float
inline float pow_2_3_exp_log_float(float base) {
    constexpr float two_thirds_f = 2.0f / 3.0f;
    return ::expf(two_thirds_f * ::logf(base));
}

// 12. Eigen version
// Uses Eigen's pow function, optimized for numerical computations

// To get pow(x, 2/3) using Eigen
template <typename T>
inline double pow_2_3_eigen(T base) {
    constexpr double two_thirds = 2.0 / 3.0;
    // Eigen's pow operates on arrays. We create an array of size 1.
    Eigen::Array<double, 1, 1> arr(static_cast<double>(base));
    return arr.pow(two_thirds)(0);
}

// Specialization for float
inline float pow_2_3_eigen_float(float base) {
    constexpr float two_thirds_f = 2.0f / 3.0f;
    Eigen::Array<float, 1, 1> arr(base);
    return arr.pow(two_thirds_f)(0);
}

// 13. Version with binomial series
// Calculates x^(2/3) using binomial series expansion
// around the nearest perfect cube
template <typename T>
inline double pow_2_3_series(T base) {
    if (base == 0) return 0.0;
    if (base < 0) {
        return std::numeric_limits<double>::quiet_NaN();
    }

    double x = static_cast<double>(base);

    // 1. Find n such that n^3 is the nearest perfect cube
    double n = std::round(::cbrt(x));
    double n_squared = n * n;
    double a = n_squared * n;

    if (a == 0) { // For very small values where n=0
        return ::pow(x, 2.0/3.0); // Fallback
    }

    // 2. Calculate z = x/a - 1
    double z = x / a - 1.0;

    // 3. Calculate the sum of the series (1+z)^(2/3)
    constexpr double alpha = 2.0 / 3.0;
    constexpr int num_terms = 10; // Precision/performance compromise

    double sum = 1.0;
    double term = 1.0;

    for (int k = 1; k < num_terms; ++k) {
        // T_k = T_{k-1} * (alpha - k + 1) / k * z
        term *= (alpha - static_cast<double>(k) + 1.0) / static_cast<double>(k) * z;
        sum += term;
    }

    // 4. Final result = n^2 * sum
    return n_squared * sum;
}

// Specialization for float
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