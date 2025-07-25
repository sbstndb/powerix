# Powerix – Benchmark de différentes implémentations de `pow`

## Objectif

Ce projet a pour but d'explorer l'impact de différentes stratégies d'implémentation de la fonction puissance (`pow`) en C++. Nous souhaitons :

1. Comparer les performances de plusieurs implémentations :
   - `std::pow` (référence)
   - Exponentiation rapide pour exposants entiers (`pow_fast_int`)
   - Version mémoïsée pour appels répétitifs (`pow_cached`)
2. Quantifier l'erreur (absolue et relative) introduite par les implémentations alternatives par rapport à `std::pow`.
3. Évaluer les cas d'usage suivants :
   - Base entière / exposant entier
   - Base flottante / exposant entier
   - Base flottante / exposant flottant

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

À la racine du dépôt :

```bash
mkdir -p build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build . -j$(nproc)
```

CMake télécharge automatiquement Google Benchmark (sans ses tests) et génère l'exécutable `benchmark_pow`.

---

## Exécution des benchmarks

Toujours dans `build/` :

```bash
./benchmark_pow
```

Vous obtiendrez :

1. Un résumé de l'erreur maximale (absolue et relative) entre les implémentations alternatives et `std::pow`.
2. Les tableaux de performance Google Benchmark pour chaque scénario.

Exemple de sortie tronqué :

```
=== Analyse d'erreur (par rapport à std::pow) ===
Erreur absolue max : 0
Erreur relative max : 0

------------------------------------------------------------------------------
Benchmark                            Time             CPU   Iterations
------------------------------------------------------------------------------
BM_PowStd_IntInt                 5.20 ns         5.19 ns    134353709
BM_PowFast_IntInt                1.20 ns         1.20 ns    583359025
BM_PowCached_IntInt              0.80 ns         0.80 ns    869351270
...
```

> L'exemple ci-dessus est purement indicatif ; les valeurs réelles dépendront de votre machine et du compilateur.

---

## Personnalisation

Vous pouvez modifier les jeux de données testés dans `benchmark/benchmark_pow.cpp` (vecteurs `kIntBases`, `kIntExps`, `kDoubleBases`, `kDoubleExps`).

Pour profiler plus finement ou ajouter de nouvelles implémentations, créez simplement de nouvelles fonctions dans `src/pow_impl.hpp` puis déclarez des benchmarks supplémentaires.

---

## Licence

Ce projet est distribué sous licence MIT. 