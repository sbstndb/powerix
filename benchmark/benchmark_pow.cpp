#include <benchmark/benchmark.h>
#include <vector>
#include <iostream>
#include "pow_impl.hpp"
#include "error_util.hpp"

using namespace powerix;

// Jeu de données harmonisé pour les benchmarks

// Valeurs communes pour tous les types entiers
static const std::vector<int> kCommonIntBases{2, 3, 5, 7, 11};
static const std::vector<int> kCommonIntExps{0, 1, 2, 3, 5, 10, 15};

// Valeurs communes pour tous les types flottants
static const std::vector<double> kCommonFloatBases{0.5, 1.1, 1.5, 2.0, 3.14159};
static const std::vector<double> kCommonFloatExps{0.0, 0.5, 1.0, 2.3, 5.7};

// Données pour entiers signés (mêmes valeurs)
static const std::vector<int16_t> kInt16Bases{2, 3, 5, 7, 11};
static const std::vector<int16_t> kInt16Exps{0, 1, 2, 3, 5, 10, 15};

static const std::vector<int32_t> kInt32Bases{2, 3, 5, 7, 11};
static const std::vector<int32_t> kInt32Exps{0, 1, 2, 3, 5, 10, 15};

static const std::vector<int64_t> kInt64Bases{2, 3, 5, 7, 11};
static const std::vector<int64_t> kInt64Exps{0, 1, 2, 3, 5, 10, 15};

// Données pour entiers non signés (mêmes valeurs)
static const std::vector<uint32_t> kUInt32Bases{2, 3, 5, 7, 11};
static const std::vector<uint32_t> kUInt32Exps{0, 1, 2, 3, 5, 10, 15};

static const std::vector<uint64_t> kUInt64Bases{2, 3, 5, 7, 11};
static const std::vector<uint64_t> kUInt64Exps{0, 1, 2, 3, 5, 10, 15};

// Données pour flottants (mêmes valeurs)
static const std::vector<double> kFloat64Bases{0.5, 1.1, 1.5, 2.0, 3.14159};
static const std::vector<double> kFloat64Exps{0.0, 0.5, 1.0, 2.3, 5.7};

static const std::vector<float> kFloat32Bases{0.5f, 1.1f, 1.5f, 2.0f, 3.14159f};
static const std::vector<float> kFloat32Exps{0.0f, 0.5f, 1.0f, 2.3f, 5.7f};

// Helper pour boucler sur le jeu de données et éviter le dead-code elimination
namespace {
    template <typename Func, typename Bases, typename Exps>
    void run_dataset(Func&& f, const Bases& bases, const Exps& exps) {
        for (auto base : bases) {
            for (auto exp : exps) {
                benchmark::DoNotOptimize(f(base, exp));
            }
        }
    }
}

// 1. Benchmarks pour (Int16, Int16)
static void BM_PowStd_Int16Int16(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](int16_t a, int16_t b) { return pow_std(a, b); }, kInt16Bases, kInt16Exps);
    }
}
BENCHMARK(BM_PowStd_Int16Int16);

static void BM_PowFast_Int16Int16(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](int16_t a, int16_t b) { return pow_fast_int(a, static_cast<unsigned int>(b)); }, kInt16Bases, kInt16Exps);
    }
}
BENCHMARK(BM_PowFast_Int16Int16);

// 2. Benchmarks pour (Int32, Int32)
static void BM_PowStd_Int32Int32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](int32_t a, int32_t b) { return pow_std(a, b); }, kInt32Bases, kInt32Exps);
    }
}
BENCHMARK(BM_PowStd_Int32Int32);

static void BM_PowFast_Int32Int32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](int32_t a, int32_t b) { return pow_fast_int(a, static_cast<unsigned int>(b)); }, kInt32Bases, kInt32Exps);
    }
}
BENCHMARK(BM_PowFast_Int32Int32);

static void BM_PowCached_Int32Int32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](int32_t a, int32_t b) { return pow_cached(static_cast<double>(a), b); }, kInt32Bases, kInt32Exps);
    }
}
BENCHMARK(BM_PowCached_Int32Int32);

// 2. Benchmarks pour (Float64, Int32)
static void BM_PowStd_Float64Int32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](double a, int32_t b) { return pow_std(a, b); }, kFloat64Bases, kInt32Exps);
    }
}
BENCHMARK(BM_PowStd_Float64Int32);

static void BM_PowCached_Float64Int32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](double a, int32_t b) { return pow_cached(a, b); }, kFloat64Bases, kInt32Exps);
    }
}
BENCHMARK(BM_PowCached_Float64Int32);

// 3. Benchmarks pour (Float64, Float64)
static void BM_PowStd_Float64Float64(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](double a, double b) { return pow_std(a, b); }, kFloat64Bases, kFloat64Exps);
    }
}
BENCHMARK(BM_PowStd_Float64Float64);

// 4. Benchmarks pour (Int32, Float64)
static void BM_PowStd_Int32Float64(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](int32_t a, double b) { return pow_std(a, b); }, kInt32Bases, kFloat64Exps);
    }
}
BENCHMARK(BM_PowStd_Int32Float64);

// 5. Benchmarks pour (Int64, Int64)
static void BM_PowStd_Int64Int64(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](int64_t a, int64_t b) { return pow_std(a, b); }, kInt64Bases, kInt64Exps);
    }
}
BENCHMARK(BM_PowStd_Int64Int64);

static void BM_PowFast_Int64Int64(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](int64_t a, int64_t b) { return pow_fast_int(a, static_cast<unsigned int>(b)); }, kInt64Bases, kInt64Exps);
    }
}
BENCHMARK(BM_PowFast_Int64Int64);

// 6. Benchmarks pour (UInt32, UInt32)
static void BM_PowStd_UInt32UInt32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](uint32_t a, uint32_t b) { return pow_std(a, b); }, kUInt32Bases, kUInt32Exps);
    }
}
BENCHMARK(BM_PowStd_UInt32UInt32);

static void BM_PowFast_UInt32UInt32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](uint32_t a, uint32_t b) { return pow_fast_int(a, b); }, kUInt32Bases, kUInt32Exps);
    }
}
BENCHMARK(BM_PowFast_UInt32UInt32);

// 7. Benchmarks pour (UInt64, UInt64)
static void BM_PowStd_UInt64UInt64(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](uint64_t a, uint64_t b) { return pow_std(a, b); }, kUInt64Bases, kUInt64Exps);
    }
}
BENCHMARK(BM_PowStd_UInt64UInt64);

static void BM_PowFast_UInt64UInt64(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](uint64_t a, uint64_t b) { return pow_fast_int(a, b); }, kUInt64Bases, kUInt64Exps);
    }
}
BENCHMARK(BM_PowFast_UInt64UInt64);

// 8. Benchmarks pour (Float32, Float32)
static void BM_PowStd_Float32Float32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](float a, float b) { return pow_std(a, b); }, kFloat32Bases, kFloat32Exps);
    }
}
BENCHMARK(BM_PowStd_Float32Float32);

// 9. Benchmarks pour (Float32, Int32)
static void BM_PowStd_Float32Int32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](float a, int32_t b) { return pow_std(a, b); }, kFloat32Bases, kInt32Exps);
    }
}
BENCHMARK(BM_PowStd_Float32Int32);

// 10. Benchmarks pour (Float64, Float32) - double avec exposant float
static void BM_PowStd_Float64Float32(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](double a, float b) { return pow_std(a, b); }, kFloat64Bases, kFloat32Exps);
    }
}
BENCHMARK(BM_PowStd_Float64Float32);

// 11. Benchmarks pour (Float32, Float64) - float avec exposant double
static void BM_PowStd_Float32Float64(benchmark::State& state) {
    for (auto _ : state) {
        run_dataset([](float a, double b) { return pow_std(a, b); }, kFloat32Bases, kFloat64Exps);
    }
}
BENCHMARK(BM_PowStd_Float32Float64);

// -------------------------------------------------------------
// Analyse d'erreur (exécutée une seule fois avant les benchmarks)
// -------------------------------------------------------------
static void AnalyzeError() {
    double max_abs_err = 0.0;
    double max_rel_err = 0.0;

    for (auto base : kInt16Bases) {
        for (auto exp : kInt16Exps) {
            double ref = pow_std(static_cast<double>(base), exp);
            double val = pow_fast_int(static_cast<double>(base), static_cast<unsigned int>(exp));
            auto err = compute_error(ref, val);
            max_abs_err = std::max(max_abs_err, err.abs_err);
            max_rel_err = std::max(max_rel_err, err.rel_err);
        }
    }

    for (auto base : kInt32Bases) {
        for (auto exp : kInt32Exps) {
            double ref = pow_std(static_cast<double>(base), exp);
            double val = pow_fast_int(static_cast<double>(base), static_cast<unsigned int>(exp));
            auto err = compute_error(ref, val);
            max_abs_err = std::max(max_abs_err, err.abs_err);
            max_rel_err = std::max(max_rel_err, err.rel_err);
        }
    }

    for (auto base : kFloat64Bases) {
        for (auto exp : kInt32Exps) {
            double ref = pow_std(base, exp);
            double val = pow_cached(base, exp);
            auto err = compute_error(ref, val);
            max_abs_err = std::max(max_abs_err, err.abs_err);
            max_rel_err = std::max(max_rel_err, err.rel_err);
        }
    }



    // Test pour les gros entiers
    for (auto base : kInt64Bases) {
        for (auto exp : kInt64Exps) {
            double ref = pow_std(static_cast<double>(base), static_cast<double>(exp));
            double val = pow_fast_int(static_cast<double>(base), static_cast<unsigned int>(exp));
            auto err = compute_error(ref, val);
            max_abs_err = std::max(max_abs_err, err.abs_err);
            max_rel_err = std::max(max_rel_err, err.rel_err);
        }
    }

    // Test pour les entiers non signés
    for (auto base : kUInt32Bases) {
        for (auto exp : kUInt32Exps) {
            double ref = pow_std(static_cast<double>(base), static_cast<double>(exp));
            double val = pow_fast_int(static_cast<double>(base), static_cast<unsigned int>(exp));
            auto err = compute_error(ref, val);
            max_abs_err = std::max(max_abs_err, err.abs_err);
            max_rel_err = std::max(max_rel_err, err.rel_err);
        }
    }

    for (auto base : kUInt64Bases) {
        for (auto exp : kUInt64Exps) {
            double ref = pow_std(static_cast<double>(base), static_cast<double>(exp));
            double val = pow_fast_int(static_cast<double>(base), static_cast<unsigned int>(exp));
            auto err = compute_error(ref, val);
            max_abs_err = std::max(max_abs_err, err.abs_err);
            max_rel_err = std::max(max_rel_err, err.rel_err);
        }
    }

    std::cout << "\n=== Analyse d'erreur (par rapport à std::pow) ===\n";
    std::cout << "Erreur absolue max : " << max_abs_err << "\n";
    std::cout << "Erreur relative max : " << max_rel_err << "\n\n";
}

// -------------------------------------------------------------
// Point d'entrée principal
// -------------------------------------------------------------
int main(int argc, char** argv) {
    AnalyzeError();
    ::benchmark::Initialize(&argc, argv);
    if (::benchmark::ReportUnrecognizedArguments(argc, argv)) return 1;
    ::benchmark::RunSpecifiedBenchmarks();
    return 0;
} 