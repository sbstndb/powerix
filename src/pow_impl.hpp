#pragma once

#include <cmath>
#include <cstdint>
#include <vector>
#include <map>
#include <type_traits>
#include <functional>
#include <optional>
#include <limits>
#include <unordered_map>

#ifdef __AVX2__
#include <immintrin.h>
#endif

namespace powerix {

// Concepts for type constraints
template <typename T>
concept IsArithmetic = std::is_arithmetic_v<T>;

template <typename BaseType, typename ExpType>
concept IsArithmeticUnsigned = IsArithmetic<BaseType> && std::is_unsigned_v<ExpType>;

template <typename BaseType, typename ExpType>
concept IsIntegralUnsigned = std::is_integral_v<BaseType> && std::is_unsigned_v<ExpType>;

template <typename BaseType, typename ExpType>
concept IsArithmeticFloating = IsArithmetic<BaseType> && std::is_floating_point_v<ExpType>;

extern "C" {
    double pow(double x, double y);
    float powf(float x, float y);
    double cbrt(double x);
    float cbrtf(float x);
    double exp(double x);
    float expf(float x);
    double log(double x);
    float logf(float x);
}

// Binary exponentiation algorithm (exponentiation rapide)
template <typename BaseType, typename ExpType>
inline BaseType pow_binary(BaseType base, ExpType exp) requires IsArithmeticUnsigned<BaseType, ExpType> {
    if (exp == 0) return static_cast<BaseType>(1);
    if (exp == 1) return base;
    
    BaseType result = static_cast<BaseType>(1);
    BaseType current = base;
    
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
template <typename BaseType, typename ExpType>
inline BaseType pow_hierarchical(BaseType base, ExpType exp) requires IsArithmeticUnsigned<BaseType, ExpType> {
    if (exp == 0) return static_cast<BaseType>(1);
    if (exp == 1) return base;
    BaseType half = pow_hierarchical(static_cast<BaseType>(base * base), static_cast<ExpType>(exp >> 1));
    return (exp & 1u) ? base * half : half;
}

// Ultra-optimized binary exponentiation with loop unrolling
template <typename BaseType, typename ExpType>
inline BaseType pow_ultra_fast(BaseType base, ExpType exp) requires IsArithmeticUnsigned<BaseType, ExpType> {
    if (exp == 0) [[likely]] return static_cast<BaseType>(1);
    
    BaseType result = static_cast<BaseType>(1);
    
    // Fast handling of common power of 2 cases
    switch (exp) {
        case 1: return base;
        case 2: return base * base;
        case 3: return base * base * base;
        case 4: { BaseType sq = base * base; return sq * sq; }
        case 8: { 
            BaseType sq = base * base; 
            BaseType quad = sq * sq;
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
template <typename BaseType, typename ExpType, typename ResultType = std::conditional_t<std::is_floating_point_v<BaseType> || std::is_floating_point_v<ExpType>, std::common_type_t<BaseType, ExpType>, BaseType>>
inline ResultType pow_cached_map(BaseType base, ExpType exp) requires IsIntegralUnsigned<BaseType, ExpType> {
    using Key = std::pair<BaseType, ExpType>;
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
template <typename BaseType, typename ExpType, typename ResultType = std::conditional_t<std::is_floating_point_v<BaseType> || std::is_floating_point_v<ExpType>, std::common_type_t<BaseType, ExpType>, BaseType>>
inline ResultType pow_cached_unordered_nested(BaseType base, ExpType exp) requires IsIntegralUnsigned<BaseType, ExpType> {
    using InnerMap = std::unordered_map<ExpType, ResultType>;
    static std::unordered_map<BaseType, InnerMap> cache;

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

// Custom hash for std::pair
template <typename BaseType, typename ExpType>
struct PairHash {
    std::size_t operator()(const std::pair<BaseType, ExpType>& p) const noexcept {
        std::size_t h1 = std::hash<BaseType>{}(p.first);
        std::size_t h2 = std::hash<ExpType>{}(p.second);
        return h1 ^ (h2 + 0x9e3779b9 + (h1 << 6) + (h1 >> 2));
    }
};

// Memoization with unordered_map and pair key
template <typename BaseType, typename ExpType, typename ResultType = std::conditional_t<std::is_floating_point_v<BaseType> || std::is_floating_point_v<ExpType>, std::common_type_t<BaseType, ExpType>, BaseType>>
inline ResultType pow_cached_unordered_pair(BaseType base, ExpType exp) requires IsIntegralUnsigned<BaseType, ExpType> {
    using Key = std::pair<BaseType, ExpType>;
    static std::unordered_map<Key, ResultType, PairHash<BaseType, ExpType>> cache;

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
template <typename BaseType, typename ExpType>
inline BaseType pow_cached_vector_optional(BaseType base, ExpType exp) requires IsIntegralUnsigned<BaseType, ExpType> {
    if (base < 0) {
        return pow_hierarchical(base, exp);
    }
    static std::vector<std::vector<std::optional<BaseType>>> cache;
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
    
    BaseType result = pow_hierarchical(base, exp);
    cache[b][exp] = result;
    return result;
}

// Static array cache for small integer ranges
template <typename BaseType, typename ExpType, size_t MAX_BASE = 16, size_t MAX_EXP = 16>
inline BaseType pow_cached_static_array(BaseType base, ExpType exp) requires IsIntegralUnsigned<BaseType, ExpType> {
    if (base >= 0 && static_cast<size_t>(base) < MAX_BASE && exp < MAX_EXP) {
        static BaseType cache[MAX_BASE][MAX_EXP] = {};
        static bool is_cached[MAX_BASE][MAX_EXP] = {};

        if (is_cached[base][exp]) {
            return cache[base][exp];
        }

        BaseType result = pow_hierarchical(base, exp);
        cache[base][exp] = result;
        is_cached[base][exp] = true;
        return result;
    }

    return pow_hierarchical(base, exp);
}

// C raw pow function wrapper
template <typename BaseType, typename ExpType>
inline auto pow_c_raw(BaseType base, ExpType exp) requires IsArithmeticFloating<BaseType, ExpType> {
    if constexpr (std::is_same_v<ExpType, float>) {
        return powf(static_cast<float>(base), exp);
    } else {
        return pow(static_cast<double>(base), static_cast<double>(exp));
    }
}

// Cube root functions
template <typename BaseType>
inline double cbrt_wrapper(BaseType x) requires IsArithmetic<BaseType> {
    return cbrt(static_cast<double>(x));
}

// pow(x, 2/3) = cbrt(x^2)
template <typename BaseType>
inline double pow_2_3_cbrt(BaseType x) requires IsArithmetic<BaseType> {
    double x_squared = static_cast<double>(x) * static_cast<double>(x);
    return cbrt(x_squared);
}

// Exponential and logarithmic functions
// pow(x, 2/3) = exp(2/3 * log(x))
template <typename BaseType>
inline double pow_2_3_exp_log(BaseType base) requires IsArithmetic<BaseType> {
    constexpr double two_thirds = 2.0 / 3.0;
    return ::exp(two_thirds * ::log(static_cast<double>(base)));
}

// Binomial series expansion for pow(x, 2/3)
template <typename BaseType>
inline double pow_2_3_series(BaseType base) requires IsArithmetic<BaseType> {
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

// ============================================================
// SIMD AVX2 implementations (guarded by __AVX2__)
// ============================================================
#ifdef __AVX2__

// AVX2 pow: 4 doubles, uniform unsigned int exponent
// Uses binary exponentiation with _mm256_mul_pd
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

// AVX2 pow: 8 floats, uniform unsigned int exponent
// Uses binary exponentiation with _mm256_mul_ps
inline __m256 pow_avx2_f(__m256 bases, unsigned int n) {
    if (n == 0) return _mm256_set1_ps(1.0f);
    if (n == 1) return bases;

    __m256 result = _mm256_set1_ps(1.0f);
    __m256 current = bases;

    while (n > 0) {
        if (n & 1) result = _mm256_mul_ps(result, current);
        current = _mm256_mul_ps(current, current);
        n >>= 1;
    }
    return result;
}

// AVX2 pow: 8 uint32s, uniform unsigned int exponent
// Uses binary exponentiation with _mm256_mullo_epi32
inline __m256i pow_avx2_i32(__m256i bases, unsigned int n) {
    if (n == 0) return _mm256_set1_epi32(1);
    if (n == 1) return bases;

    __m256i result = _mm256_set1_epi32(1);
    __m256i current = bases;

    while (n > 0) {
        if (n & 1) result = _mm256_mullo_epi32(result, current);
        current = _mm256_mullo_epi32(current, current);
        n >>= 1;
    }
    return result;
}

// Batch function: process an array of doubles with SIMD
// Handles non-multiple-of-4 sizes with scalar tail
inline void pow_avx2_batch(const double* __restrict__ in,
                           double* __restrict__ out,
                           size_t n,
                           unsigned int exp) {
    size_t i = 0;
    for (; i + 3 < n; i += 4) {
        __m256d bases = _mm256_loadu_pd(in + i);
        __m256d res   = pow_avx2_d(bases, exp);
        _mm256_storeu_pd(out + i, res);
    }
    for (; i < n; ++i) {
        out[i] = pow_hierarchical(in[i], exp);
    }
}

// Batch function: process an array of floats with SIMD
// Handles non-multiple-of-8 sizes with scalar tail
inline void pow_avx2_batch_f(const float* __restrict__ in,
                             float* __restrict__ out,
                             size_t n,
                             unsigned int exp) {
    size_t i = 0;
    for (; i + 7 < n; i += 8) {
        __m256 bases = _mm256_loadu_ps(in + i);
        __m256 res   = pow_avx2_f(bases, exp);
        _mm256_storeu_ps(out + i, res);
    }
    for (; i < n; ++i) {
        out[i] = static_cast<float>(
            pow_hierarchical(static_cast<float>(in[i]), exp));
    }
}

// Batch function: process an array of uint32s with SIMD
// Handles non-multiple-of-8 sizes with scalar tail
inline void pow_avx2_batch_i32(const uint32_t* __restrict__ in,
                               uint32_t* __restrict__ out,
                               size_t n,
                               unsigned int exp) {
    size_t i = 0;
    for (; i + 7 < n; i += 8) {
        __m256i bases = _mm256_loadu_si256(
            reinterpret_cast<const __m256i*>(in + i));
        __m256i res   = pow_avx2_i32(bases, exp);
        _mm256_storeu_si256(reinterpret_cast<__m256i*>(out + i), res);
    }
    for (; i < n; ++i) {
        out[i] = pow_hierarchical(in[i], exp);
    }
}

#endif // __AVX2__

// ============================================================
// Hand-written asm: branchless binary exponentiation (x86_64 only)
// ============================================================
#if defined(__x86_64__) && defined(__GNUC__)

// Branchless binary exponentiation using cmov for uint64_t.
// Uses only 4 registers: result, base, exp, temp.
// No stack frame, no spills, no recursive fallback.
inline uint64_t pow_asm_cmov(uint64_t base, uint64_t exp) {
    uint64_t result;
    asm volatile(
        "mov $1, %%rax\n\t"          // result = 1
        "test %%rsi, %%rsi\n\t"      // if exp == 0, skip
        "jz 2f\n\t"
        ".p2align 4\n\t"
    "1:\n\t"
        "mov %%rax, %%rcx\n\t"       // temp = result
        "imul %%rdi, %%rcx\n\t"      // temp = result * base
        "test $1, %%sil\n\t"         // test exp & 1
        "cmovnz %%rcx, %%rax\n\t"    // if odd: result = temp
        "imul %%rdi, %%rdi\n\t"      // base = base * base
        "shr %%rsi\n\t"              // exp >>= 1
        "jnz 1b\n\t"                 // loop while exp != 0
    "2:\n\t"
        : "=a"(result), "+D"(base), "+S"(exp)
        :
        : "rcx", "cc"
    );
    return result;
}

#endif // defined(__x86_64__) && defined(__GNUC__)

} // namespace powerix