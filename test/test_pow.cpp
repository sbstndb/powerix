#include <gtest/gtest.h>
#include <cmath>
#include <cstdint>
#include <vector>
#include <random>
#include "../src/pow_impl.hpp"

// ============================================================
// Scalar implementation tests
// ============================================================

// --- pow_binary ---

TEST(PowBinary, ExpZeroReturnsOne) {
    EXPECT_EQ(powerix::pow_binary(0u, 0u), 1u);
    EXPECT_EQ(powerix::pow_binary(1u, 0u), 1u);
    EXPECT_EQ(powerix::pow_binary(42u, 0u), 1u);
}

TEST(PowBinary, ExpOneReturnsBase) {
    EXPECT_EQ(powerix::pow_binary(0u, 1u), 0u);
    EXPECT_EQ(powerix::pow_binary(1u, 1u), 1u);
    EXPECT_EQ(powerix::pow_binary(7u, 1u), 7u);
}

TEST(PowBinary, BaseZero) {
    EXPECT_EQ(powerix::pow_binary(0u, 0u), 1u);
    EXPECT_EQ(powerix::pow_binary(0u, 1u), 0u);
    EXPECT_EQ(powerix::pow_binary(0u, 5u), 0u);
}

TEST(PowBinary, BaseOne) {
    EXPECT_EQ(powerix::pow_binary(1u, 0u), 1u);
    EXPECT_EQ(powerix::pow_binary(1u, 1u), 1u);
    EXPECT_EQ(powerix::pow_binary(1u, 100u), 1u);
}

TEST(PowBinary, KnownValues) {
    EXPECT_EQ(powerix::pow_binary(2u, 10u), 1024u);
    EXPECT_EQ(powerix::pow_binary(3u, 5u), 243u);
    EXPECT_EQ(powerix::pow_binary(5u, 3u), 125u);
    EXPECT_EQ(powerix::pow_binary(7u, 4u), 2401u);
    EXPECT_EQ(powerix::pow_binary(10u, 6u), 1000000u);
}

TEST(PowBinary, FloatAccuracy) {
    for (unsigned int e = 2; e <= 13; ++e) {
        double base = 1.5;
        double result = powerix::pow_binary(base, e);
        double ref = std::pow(base, static_cast<double>(e));
        EXPECT_NEAR(result, ref, std::abs(ref) * 1e-12)
            << "base=1.5 exp=" << e;
    }
}

// --- pow_hierarchical ---

TEST(PowHierarchical, ExpZeroReturnsOne) {
    EXPECT_EQ(powerix::pow_hierarchical(0u, 0u), 1u);
    EXPECT_EQ(powerix::pow_hierarchical(1u, 0u), 1u);
    EXPECT_EQ(powerix::pow_hierarchical(42u, 0u), 1u);
}

TEST(PowHierarchical, ExpOneReturnsBase) {
    EXPECT_EQ(powerix::pow_hierarchical(0u, 1u), 0u);
    EXPECT_EQ(powerix::pow_hierarchical(1u, 1u), 1u);
    EXPECT_EQ(powerix::pow_hierarchical(7u, 1u), 7u);
}

TEST(PowHierarchical, BaseZero) {
    EXPECT_EQ(powerix::pow_hierarchical(0u, 0u), 1u);
    EXPECT_EQ(powerix::pow_hierarchical(0u, 1u), 0u);
    EXPECT_EQ(powerix::pow_hierarchical(0u, 5u), 0u);
}

TEST(PowHierarchical, BaseOne) {
    EXPECT_EQ(powerix::pow_hierarchical(1u, 0u), 1u);
    EXPECT_EQ(powerix::pow_hierarchical(1u, 1u), 1u);
    EXPECT_EQ(powerix::pow_hierarchical(1u, 100u), 1u);
}

TEST(PowHierarchical, KnownValues) {
    EXPECT_EQ(powerix::pow_hierarchical(2u, 10u), 1024u);
    EXPECT_EQ(powerix::pow_hierarchical(3u, 5u), 243u);
    EXPECT_EQ(powerix::pow_hierarchical(5u, 3u), 125u);
    EXPECT_EQ(powerix::pow_hierarchical(7u, 4u), 2401u);
    EXPECT_EQ(powerix::pow_hierarchical(10u, 6u), 1000000u);
}

TEST(PowHierarchical, FloatAccuracy) {
    for (unsigned int e = 2; e <= 13; ++e) {
        double base = 1.5;
        double result = powerix::pow_hierarchical(base, e);
        double ref = std::pow(base, static_cast<double>(e));
        EXPECT_NEAR(result, ref, std::abs(ref) * 1e-12)
            << "base=1.5 exp=" << e;
    }
}

// --- pow_ultra_fast ---

TEST(PowUltraFast, ExpZeroReturnsOne) {
    EXPECT_EQ(powerix::pow_ultra_fast(0u, 0u), 1u);
    EXPECT_EQ(powerix::pow_ultra_fast(1u, 0u), 1u);
    EXPECT_EQ(powerix::pow_ultra_fast(42u, 0u), 1u);
}

TEST(PowUltraFast, ExpOneReturnsBase) {
    EXPECT_EQ(powerix::pow_ultra_fast(0u, 1u), 0u);
    EXPECT_EQ(powerix::pow_ultra_fast(1u, 1u), 1u);
    EXPECT_EQ(powerix::pow_ultra_fast(7u, 1u), 7u);
}

TEST(PowUltraFast, BaseZero) {
    EXPECT_EQ(powerix::pow_ultra_fast(0u, 0u), 1u);
    EXPECT_EQ(powerix::pow_ultra_fast(0u, 1u), 0u);
    EXPECT_EQ(powerix::pow_ultra_fast(0u, 5u), 0u);
}

TEST(PowUltraFast, BaseOne) {
    EXPECT_EQ(powerix::pow_ultra_fast(1u, 0u), 1u);
    EXPECT_EQ(powerix::pow_ultra_fast(1u, 1u), 1u);
    EXPECT_EQ(powerix::pow_ultra_fast(1u, 100u), 1u);
}

TEST(PowUltraFast, KnownValues) {
    EXPECT_EQ(powerix::pow_ultra_fast(2u, 10u), 1024u);
    EXPECT_EQ(powerix::pow_ultra_fast(3u, 5u), 243u);
    EXPECT_EQ(powerix::pow_ultra_fast(5u, 3u), 125u);
    EXPECT_EQ(powerix::pow_ultra_fast(7u, 4u), 2401u);
    EXPECT_EQ(powerix::pow_ultra_fast(10u, 6u), 1000000u);
}

TEST(PowUltraFast, SpecialCases) {
    // Switch-case paths: exp=2,3,4,8
    EXPECT_EQ(powerix::pow_ultra_fast(5u, 2u), 25u);
    EXPECT_EQ(powerix::pow_ultra_fast(5u, 3u), 125u);
    EXPECT_EQ(powerix::pow_ultra_fast(5u, 4u), 625u);
    EXPECT_EQ(powerix::pow_ultra_fast(2u, 8u), 256u);
}

TEST(PowUltraFast, FloatAccuracy) {
    for (unsigned int e = 2; e <= 13; ++e) {
        double base = 1.5;
        double result = powerix::pow_ultra_fast(base, e);
        double ref = std::pow(base, static_cast<double>(e));
        EXPECT_NEAR(result, ref, std::abs(ref) * 1e-12)
            << "base=1.5 exp=" << e;
    }
}

// --- Cross-implementation consistency ---

TEST(ScalarConsistency, AllImplementationsAgree) {
    unsigned int bases[] = {2, 3, 5, 7, 10, 13};
    unsigned int exps[] = {0, 1, 2, 3, 4, 5, 8, 10, 13};

    for (unsigned int b : bases) {
        for (unsigned int e : exps) {
            auto ref = powerix::pow_binary(b, e);
            EXPECT_EQ(powerix::pow_hierarchical(b, e), ref)
                << "hierarchical mismatch: base=" << b << " exp=" << e;
            EXPECT_EQ(powerix::pow_ultra_fast(b, e), ref)
                << "ultra_fast mismatch: base=" << b << " exp=" << e;
        }
    }
}

TEST(ScalarConsistency, DoubleBaseAllImplementationsAgree) {
    double bases[] = {0.5, 1.0, 1.5, 2.0, 3.14};
    unsigned int exps[] = {0, 1, 2, 3, 5, 7, 10, 13};

    for (double b : bases) {
        for (unsigned int e : exps) {
            double ref = powerix::pow_binary(b, e);
            double hier = powerix::pow_hierarchical(b, e);
            double ultra = powerix::pow_ultra_fast(b, e);

            double tol = std::max(1e-12, std::abs(ref) * 1e-14);
            EXPECT_NEAR(hier, ref, tol)
                << "hierarchical mismatch: base=" << b << " exp=" << e;
            EXPECT_NEAR(ultra, ref, tol)
                << "ultra_fast mismatch: base=" << b << " exp=" << e;
        }
    }
}

// ============================================================
// SIMD AVX2 tests (guarded by __AVX2__)
// ============================================================
#ifdef __AVX2__

TEST(SimdAvx2Double, KnownValues) {
    // Test pow_avx2_d with known values
    unsigned int exps[] = {0, 1, 2, 3, 5, 7, 10, 13};
    double bases_arr[4] = {2.0, 3.0, 1.5, 0.5};

    for (unsigned int e : exps) {
        __m256d bases = _mm256_loadu_pd(bases_arr);
        __m256d result = powerix::pow_avx2_d(bases, e);
        double out[4];
        _mm256_storeu_pd(out, result);

        for (int i = 0; i < 4; ++i) {
            double ref = std::pow(bases_arr[i], static_cast<double>(e));
            EXPECT_NEAR(out[i], ref, std::abs(ref) * 1e-12 + 1e-15)
                << "lane=" << i << " base=" << bases_arr[i] << " exp=" << e;
        }
    }
}

TEST(SimdAvx2Double, ExpZero) {
    double bases_arr[4] = {2.0, 3.0, 0.0, 100.0};
    __m256d bases = _mm256_loadu_pd(bases_arr);
    __m256d result = powerix::pow_avx2_d(bases, 0);
    double out[4];
    _mm256_storeu_pd(out, result);
    for (int i = 0; i < 4; ++i) {
        EXPECT_DOUBLE_EQ(out[i], 1.0) << "lane=" << i;
    }
}

TEST(SimdAvx2Double, ExpOne) {
    double bases_arr[4] = {2.0, 3.0, 0.5, 100.0};
    __m256d bases = _mm256_loadu_pd(bases_arr);
    __m256d result = powerix::pow_avx2_d(bases, 1);
    double out[4];
    _mm256_storeu_pd(out, result);
    for (int i = 0; i < 4; ++i) {
        EXPECT_DOUBLE_EQ(out[i], bases_arr[i]) << "lane=" << i;
    }
}

TEST(SimdAvx2Double, BatchAccuracy) {
    // Test batch function with random data
    std::mt19937_64 rng(42);
    std::uniform_real_distribution<double> dist(0.5, 4.0);
    constexpr size_t N = 1024;
    std::vector<double> input(N), output(N);
    for (auto& x : input) x = dist(rng);

    unsigned int exps[] = {3, 7, 13};
    for (unsigned int e : exps) {
        powerix::pow_avx2_batch(input.data(), output.data(), N, e);
        double max_rel_err = 0.0;
        for (size_t i = 0; i < N; ++i) {
            double ref = std::pow(input[i], static_cast<double>(e));
            if (ref != 0.0) {
                double rel = std::abs(output[i] - ref) / std::abs(ref);
                max_rel_err = std::max(max_rel_err, rel);
            }
        }
        EXPECT_LT(max_rel_err, 1e-10) << "exp=" << e;
    }
}

TEST(SimdAvx2Float, KnownValues) {
    unsigned int exps[] = {0, 1, 2, 3, 5, 7, 10, 13};
    float bases_arr[8] = {2.0f, 3.0f, 1.5f, 0.5f, 1.0f, 4.0f, 0.25f, 2.5f};

    for (unsigned int e : exps) {
        __m256 bases = _mm256_loadu_ps(bases_arr);
        __m256 result = powerix::pow_avx2_f(bases, e);
        float out[8];
        _mm256_storeu_ps(out, result);

        for (int i = 0; i < 8; ++i) {
            float ref = std::pow(bases_arr[i], static_cast<float>(e));
            EXPECT_NEAR(out[i], ref, std::abs(ref) * 1e-5f + 1e-7f)
                << "lane=" << i << " base=" << bases_arr[i] << " exp=" << e;
        }
    }
}

TEST(SimdAvx2Float, BatchAccuracy) {
    std::mt19937 rng(42);
    std::uniform_real_distribution<float> dist(0.5f, 4.0f);
    constexpr size_t N = 1024;
    std::vector<float> input(N), output(N);
    for (auto& x : input) x = dist(rng);

    unsigned int exps[] = {3, 7, 13};
    for (unsigned int e : exps) {
        powerix::pow_avx2_batch_f(input.data(), output.data(), N, e);
        double max_rel_err = 0.0;
        for (size_t i = 0; i < N; ++i) {
            float ref = std::pow(input[i], static_cast<float>(e));
            if (ref != 0.0f) {
                double rel = std::abs(
                    static_cast<double>(output[i]) - static_cast<double>(ref))
                    / std::abs(static_cast<double>(ref));
                max_rel_err = std::max(max_rel_err, rel);
            }
        }
        EXPECT_LT(max_rel_err, 1e-5) << "exp=" << e;
    }
}

TEST(SimdAvx2Int32, KnownValues) {
    unsigned int exps[] = {0, 1, 2, 3, 5};
    uint32_t bases_arr[8] = {2, 3, 5, 7, 1, 10, 4, 6};

    for (unsigned int e : exps) {
        __m256i bases = _mm256_loadu_si256(
            reinterpret_cast<const __m256i*>(bases_arr));
        __m256i result = powerix::pow_avx2_i32(bases, e);
        uint32_t out[8];
        _mm256_storeu_si256(reinterpret_cast<__m256i*>(out), result);

        for (int i = 0; i < 8; ++i) {
            uint32_t ref = powerix::pow_hierarchical(bases_arr[i], e);
            EXPECT_EQ(out[i], ref)
                << "lane=" << i << " base=" << bases_arr[i] << " exp=" << e;
        }
    }
}

TEST(SimdAvx2Int32, BatchExactMatch) {
    std::mt19937 rng(123);
    std::uniform_int_distribution<uint32_t> dist(1, 50);
    constexpr size_t N = 1024;
    std::vector<uint32_t> input(N), output(N);
    for (auto& x : input) x = dist(rng);

    unsigned int exps[] = {3, 5, 7};
    for (unsigned int e : exps) {
        powerix::pow_avx2_batch_i32(input.data(), output.data(), N, e);
        for (size_t i = 0; i < N; ++i) {
            uint32_t ref = powerix::pow_hierarchical(input[i], e);
            EXPECT_EQ(output[i], ref)
                << "i=" << i << " base=" << input[i] << " exp=" << e;
        }
    }
}

#endif // __AVX2__

// ============================================================
// ASM cmov tests (guarded by __x86_64__)
// ============================================================
#if defined(__x86_64__) && defined(__GNUC__)

TEST(AsmCmov, ExpZeroReturnsOne) {
    EXPECT_EQ(powerix::pow_asm_cmov(0, 0), 1u);
    EXPECT_EQ(powerix::pow_asm_cmov(1, 0), 1u);
    EXPECT_EQ(powerix::pow_asm_cmov(42, 0), 1u);
}

TEST(AsmCmov, ExpOneReturnsBase) {
    EXPECT_EQ(powerix::pow_asm_cmov(0, 1), 0u);
    EXPECT_EQ(powerix::pow_asm_cmov(1, 1), 1u);
    EXPECT_EQ(powerix::pow_asm_cmov(7, 1), 7u);
}

TEST(AsmCmov, BaseZero) {
    EXPECT_EQ(powerix::pow_asm_cmov(0, 0), 1u);
    EXPECT_EQ(powerix::pow_asm_cmov(0, 1), 0u);
    EXPECT_EQ(powerix::pow_asm_cmov(0, 5), 0u);
}

TEST(AsmCmov, BaseOne) {
    EXPECT_EQ(powerix::pow_asm_cmov(1, 0), 1u);
    EXPECT_EQ(powerix::pow_asm_cmov(1, 1), 1u);
    EXPECT_EQ(powerix::pow_asm_cmov(1, 100), 1u);
}

TEST(AsmCmov, KnownValues) {
    EXPECT_EQ(powerix::pow_asm_cmov(2, 10), 1024u);
    EXPECT_EQ(powerix::pow_asm_cmov(3, 5), 243u);
    EXPECT_EQ(powerix::pow_asm_cmov(5, 3), 125u);
    EXPECT_EQ(powerix::pow_asm_cmov(7, 4), 2401u);
    EXPECT_EQ(powerix::pow_asm_cmov(10, 6), 1000000u);
}

TEST(AsmCmov, MatchesHierarchical) {
    uint64_t bases[] = {0, 1, 2, 3, 5, 7, 10, 13, 100};
    uint64_t exps[] = {0, 1, 2, 3, 4, 5, 8, 10, 13, 20, 30};

    for (uint64_t b : bases) {
        for (uint64_t e : exps) {
            uint64_t ref = powerix::pow_hierarchical(b, e);
            uint64_t asm_result = powerix::pow_asm_cmov(b, e);
            EXPECT_EQ(asm_result, ref)
                << "base=" << b << " exp=" << e;
        }
    }
}

TEST(AsmCmov, LargeExponents) {
    // These will overflow, but both implementations should overflow identically
    uint64_t bases[] = {2, 3, 5};
    uint64_t exps[] = {40, 50, 63};

    for (uint64_t b : bases) {
        for (uint64_t e : exps) {
            uint64_t ref = powerix::pow_binary(b, e);
            uint64_t asm_result = powerix::pow_asm_cmov(b, e);
            EXPECT_EQ(asm_result, ref)
                << "base=" << b << " exp=" << e;
        }
    }
}

#endif // defined(__x86_64__) && defined(__GNUC__)
