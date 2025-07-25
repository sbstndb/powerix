# Powerix – Benchmark de différentes implémentations de `pow`

## Objectif

Ce projet a pour but d'explorer l'impact de différentes stratégies d'implémentation de la fonction puissance (`pow`) en C++. Nous souhaitons :

1. Comparer les performances de plusieurs implémentations :
   - `std::pow` (référence)
   - Exponentiation rapide pour exposants entiers (`pow_fast_int`)
   - Version mémoïsée pour appels répétitifs (`pow_cached`)
2. Quantifier l'erreur (absolue et relative) introduite par les implémentations alternatives par rapport à `std::pow`.
3. Évaluer les performances sur différents types de données :
   - Entiers signés : `int16_t`, `int32_t`, `int64_t`
   - Entiers non signés : `uint32_t`, `uint64_t`
   - Flottants : `float` (Float32), `double` (Float64)
   - Cas mixtes : entiers/flottants, Float32/Float64

Les benchmarks sont réalisés avec la bibliothèque [Google Benchmark](https://github.com/google/benchmark).

---

## Arborescence

```
.
├── benchmark/
│   └── benchmark_pow.cpp   # Points d'entrée des benchmarks
├── src/
│   ├── pow_impl.hpp        # Implémentations des différentes variantes
│   └── error_util.hpp      # Outils de mesure d'erreur
├── CMakeLists.txt          # Configuration du projet / dépendances
└── README.md               # Ce fichier
```

---

## Prérequis

- Un compilateur C++17 (GCC 9+, Clang 10+, MSVC 2019+)
- CMake ≥ 3.14
- `git` pour le téléchargement automatique des dépendances

---

## Compilation

Le projet génère trois binaires avec différents niveaux d'optimisation :

```bash
mkdir -p build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build . -j$(nproc)
```

Cela génère :
- `benchmark_pow_standard` : Optimisations `-O2`
- `benchmark_pow_aggressive` : Optimisations `-O3 -mtune=native -march=native -mavx2`
- `benchmark_pow_fast` : Optimisations ultra-agressives `-Ofast -mtune=native -march=native -mavx2 -ffast-math -funroll-loops`

---

## Exécution des benchmarks

Toujours dans `build/` :

```bash
# Version standard
./benchmark_pow_standard

# Version avec optimisations agressives
./benchmark_pow_aggressive

# Version ultra-agressive (recommandée)
./benchmark_pow_fast
```

Vous obtiendrez :

1. Un résumé de l'erreur maximale (absolue et relative) entre les implémentations alternatives et `std::pow`.
2. Les tableaux de performance Google Benchmark pour chaque type de données.

---

## Résultats de performance

### Résultats avec optimisations ultra-agressives (`-Ofast`)

| Benchmark | Temps | Type | Gain vs std::pow |
|-----------|-------|------|------------------|
| `BM_PowStd_Int16Int16` | 314 ns | `(int16_t, int16_t)` | - |
| `BM_PowFast_Int16Int16` | **75.9 ns** | `(int16_t, int16_t)` | **4.1x** |
| `BM_PowStd_Int32Int32` | 305 ns | `(int32_t, int32_t)` | - |
| `BM_PowFast_Int32Int32` | **69.3 ns** | `(int32_t, int32_t)` | **4.4x** |
| `BM_PowStd_Int64Int64` | 285 ns | `(int64_t, int64_t)` | - |
| `BM_PowFast_Int64Int64` | **70.8 ns** | `(int64_t, int64_t)` | **4.0x** |
| `BM_PowStd_UInt32UInt32` | 285 ns | `(uint32_t, uint32_t)` | - |
| `BM_PowFast_UInt32UInt32` | **62.9 ns** | `(uint32_t, uint32_t)` | **4.5x** |
| `BM_PowStd_UInt64UInt64` | 294 ns | `(uint64_t, uint64_t)` | - |
| `BM_PowFast_UInt64UInt64` | **68.9 ns** | `(uint64_t, uint64_t)` | **4.3x** |
| `BM_PowStd_Float32Float32` | **99.3 ns** | `(float, float)` | - |
| `BM_PowStd_Float64Float64` | **192 ns** | `(double, double)` | - |

### Observations clés

1. **Exponentiation rapide** : 4.0-4.5x plus rapide pour tous les types entiers
2. **Entiers non signés** : Légèrement plus performants que les signés
3. **Flottants** : `float` (99.3 ns) plus rapide que `double` (192 ns)
4. **Précision** : Erreur relative maximale de 3.9e-16 (excellente)

### Recommandations d'usage

- **Pour les entiers non signés** : `UInt32` avec exponentiation rapide (62.9 ns)
- **Pour les entiers signés** : `Int32` avec exponentiation rapide (69.3 ns)
- **Pour les flottants** : `Float32` pour la vitesse (99.3 ns), `Float64` pour la précision (192 ns)
- **Pour les gros entiers** : `Int64`/`UInt64` avec exponentiation rapide (~70 ns)

---

## Personnalisation

Vous pouvez modifier les jeux de données testés dans `benchmark/benchmark_pow.cpp` :
- `kInt16Bases`, `kInt16Exps` : Pour les entiers 16-bit
- `kInt32Bases`, `kInt32Exps` : Pour les entiers 32-bit
- `kFloat32Bases`, `kFloat32Exps` : Pour les flottants 32-bit
- `kFloat64Bases`, `kFloat64Exps` : Pour les flottants 64-bit

Pour profiler plus finement ou ajouter de nouvelles implémentations, créez simplement de nouvelles fonctions dans `src/pow_impl.hpp` puis déclarez des benchmarks supplémentaires.

---

## Licence

Ce projet est distribué sous licence MIT. 