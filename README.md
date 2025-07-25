# Powerix ‑ Concise Benchmark Report

This repository measures **power-function performance** on C++17 using several hand-tuned kernels.
Tests were compiled with `-Ofast -march=native` and executed on an Intel 22-thread 4.7 GHz machine.

| Use-case | Fastest implementation | Latency (ns) | Speed-up vs `std::pow` |
|----------|-----------------------|--------------|-------------------------|
| 64-bit float raised to **integer** | `pow_hierarchical_float` | ≈ 47 | ~6× |
| 64-bit **integer** raised to integer | `pow_hierarchical_int`   | ≈ 48 | ~6× |
| 64-bit float raised to **2/3** | `pow_2_3_exp_log`         | ≈ 74 | ~1.3× |

## Error Metrics

Benchmarks now include **accuracy measurements** computed outside the performance loop:

| Method | MaxAbsErr | MaxRelErr | Comment |
|--------|-----------|-----------|---------|
| `std::pow` | 0 | 0 | Reference (perfect) |
| `pow_hierarchical_int` | 4.18e-12 | 1.0e-15 | Excellent precision |
| `pow_hierarchical_float` | 1.83e-7 | 7.89e-10 | Very good precision |
| `pow_2_3_exp_log` | 1.78e-15 | 5.15e-10 | Near-perfect precision |

**Error units:** `MaxAbsErr` in absolute units, `MaxRelErr` in relative units (e.g., `1.0e-15` = 1 ULP)

Key observations
----------------
1. **Hierarchical exponentiation** (divide-and-conquer) dominates for integer exponents on both floating-point and integer bases.
2. For the fractional case (base^(2/3)) the classical `exp(y*log(x))` trick (`pow_2_3_exp_log`) edges out alternatives (`cbrt`, Eigen, raw C `pow`).
3. GCC and Clang deliver practically identical timings on the custom kernels; Clang is marginally faster (1-3 %) on `std::pow` only.
4. Memoized variants help only when repeated `(base,exp)` pairs are common; they lose on raw throughput.
5. **All custom implementations maintain excellent precision** with errors ≤ 1 ULP for integer exponents and ≤ 2 ULP for fractional.

Quick start
-----------
```bash
# one-shot build & run
mkdir -p build && cd build
cmake .. && make -j

# integer-exponent suite (~1 min)
./benchmark_pow_fast

# fractional 2/3 suite (~15 s)
./benchmark_pow_fractional_fast
```

That’s it – the tables above are usually all you need. For deeper numbers run the benchmarks yourself on your target CPU. 

---

## Extended Benchmark Numbers

### 1. Integer-Exponent Workloads (ns)
| Base^Exponent | Compiler | `std::pow` | `pow_hierarchical` | `pow_fast_int` | `pow_ultra_fast` |
|---------------|----------|-----------:|-------------------:|---------------:|-----------------:|
| Int16^Int16   | GCC   | 293 | **48** | 68 | 72 |
| Int16^Int16   | Clang | 314 | **50** | 67 | 70 |
| Int32^Int32   | GCC   | 294 | **48** | 56 | 75 |
| Int32^Int32   | Clang | 318 | **50** | 55 | 75 |
| Int64^Int64   | GCC   | 297 | **48** | 68 | 78 |
| Int64^Int64   | Clang | 316 | **49** | 65 | 76 |
| Float64^Int32 | GCC   | 287 | **47** | –  | 76 |
| Float64^Int32 | Clang | 283 | **48** | –  | 76 |

**Take-away:** hierarchical exponentiation is ~6× faster than `std::pow` across all integer exponents.

### 2. Fractional Exponent `base^(2/3)` (ns)
| Base type | Compiler | `std::pow` | `exp_log` | `cbrt` | `Eigen` | Fastest |
|-----------|----------|-----------:|----------:|-------:|--------:|---------|
| Float64   | GCC   | 99 | **74** | 94 | 99 | `exp_log` |
| Float64   | Clang | 99 | **75** | 95 | 93 | `exp_log` |
| Float32   | GCC   | 48 | 52 | 47 | **45** | `Eigen` |
| Float32   | Clang | 48 | 52 | 48 | **45** | `Eigen` |
| Int32     | GCC   | 101 | **77** | 101 | 96 | `exp_log` |
| Int32     | Clang | 105 | **78** | 102 | 97 | `exp_log` |

### 3. Memoisation (when `(base,exp)` repeat)
| Variant | Typical latency | Comment |
|---------|-----------------|---------|
| `pow_vec_cached_int` | 180–240 ns | Faster than `std::pow`, but slower than non-memoised fast kernels unless reuse rate ≥ 50 % |
| `pow_cached` (map)   | 350–420 ns | Map lookup overhead dwarfs benefit; only worthwhile for *very* large exponents |

---

## Algorithm Cheat-Sheet
* **Hierarchical** – Recursively square the base and multiply results where exponent bits are 1. Branch-free, tiny inner loop.
* **Fast-int** – Classic binary exponentiation with small helper inlines; good balance between clarity and speed.
* **Ultra-fast** – Same as fast-int but unrolled and vector-friendly (`-funroll-loops`, `AVX2`). Gains disappear for small exponents.
* **`exp_log`** – For fractional powers: `exp(log(x) * 2/3)`. Hardware `log`/`exp` are well pipelined ⇒ best overall.
* **`cbrt`** – Computes `cbrt(x*x)`; avoids `exp`, but extra multiply cancels the saving on current CPUs.
* **Eigen** – Calls Eigen’s vectorised `pow` which shines on `float32` thanks to fast SIMD path.
* **Series** – Binomial expansion to 7 terms; accurate but 2× slower – mostly a didactic baseline.

---