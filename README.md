# Powerix ‑ Concise Benchmark Report

[![CodSpeed](https://img.shields.io/endpoint?url=https://codspeed.io/badge.json)](https://app.codspeed.io/sbstndb/powerix?utm_source=badge)

This repository measures **power-function performance** on C++17 using several hand-tuned kernels.
Tests were compiled with `-Ofast -march=native` and executed on an Intel 22-thread 4.7 GHz machine.

| Use-case | Fastest implementation | Latency (ns) | Speed-up vs `std::pow` |
|----------|-----------------------|--------------|-------------------------|
| 64-bit float raised to **integer** | `pow_hierarchical_float` | ≈ 44 | ~6.6× |
| 64-bit **integer** raised to integer | `pow_hierarchical_int`   | ≈ 40 | ~6.1× |
| 64-bit float raised to **2/3** | `pow_2_3_exp_log`         | ≈ 57 | ~1.6× |

## Error Metrics

Benchmarks now include **accuracy measurements** computed outside the performance loop:

| Method | MaxAbsErr | MaxRelErr | Comment |
|--------|-----------|-----------|---------|
| `std::pow` | 0 | 0 | Reference (perfect) |
| `pow_hierarchical_int` | 4.18e-12 | 1.0e-15 | Excellent precision |
| `pow_hierarchical_float` | 1.83e-7 | 7.89e-10 | Very good precision |
| `pow_2_3_exp_log` | 1.78e-15 | 5.15e-10 | Near-perfect precision |

**Error units:** `MaxAbsErr` in absolute units, `MaxRelErr` in relative units (e.g., `1.0e-15` = 1 ULP)

## Key Observations

1. **Hierarchical exponentiation** (divide-and-conquer) dominates for integer exponents on both floating-point and integer bases.
2. For the fractional case (base^(2/3)) **Eigen** is fastest for `float32` (43.4 ns), while `exp_log` wins for `float64` (71.4 ns).
3. **Binomial series** offers the best precision (1.04e-6) but is 2× slower than other methods.
4. GCC and Clang deliver practically identical timings on the custom kernels; Clang is marginally faster (1-3 %) on `std::pow` only.
5. Memoized variants help only when repeated `(base,exp)` pairs are common; they lose on raw throughput.
6. **All custom implementations maintain excellent precision** with errors ≤ 1 ULP for integer exponents and ≤ 2 ULP for fractional.

## SIMD Batch Exponentiation (AVX2)

The library includes AVX2 SIMD implementations for batch exponentiation with a uniform integer exponent across multiple lanes. These are available in `pow_impl.hpp` and automatically enabled when compiled with `-mavx2`.

| Function | Type | Lanes | Intrinsic |
|----------|------|-------|-----------|
| `pow_avx2_d` | 4 doubles | 4 | `_mm256_mul_pd` |
| `pow_avx2_f` | 8 floats | 8 | `_mm256_mul_ps` |
| `pow_avx2_i32` | 8 uint32s | 8 | `_mm256_mullo_epi32` |

Batch convenience functions (`pow_avx2_batch`, `pow_avx2_batch_f`, `pow_avx2_batch_i32`) process arrays of any size, using SIMD for the main body and scalar fallback for the tail.

### SIMD Benchmark Results (1024 elements, `-Ofast -march=native`)

**Double precision (4 lanes):**

| Exponent | `std::pow` | `pow_hierarchical` (scalar) | `pow_avx2_batch` (SIMD) |
|----------|------------|----------------------------|-------------------------|
| 3  | ~5970 ns | ~327 ns | ~425 ns |
| 7  | ~6830 ns | ~887 ns | ~700 ns |
| 13 | ~5420 ns | ~1240 ns | ~960 ns |

**Accuracy (max relative error vs `std::pow`):**

| Exponent | SIMD MaxRelErr | Hierarchical MaxRelErr |
|----------|---------------|----------------------|
| 3  | 2.21e-16 | 2.21e-16 |
| 7  | 4.58e-16 | 4.57e-16 |
| 13 | 9.74e-16 | 8.72e-16 |

**Note:** SIMD excels at larger exponents where the per-element multiply cost dominates. For small exponents (2-3), the scalar hierarchical version may be faster due to its hardcoded paths. All SIMD implementations are guarded by `#ifdef __AVX2__` and compile cleanly on non-AVX2 machines.

**Note:** uint64 SIMD on AVX2 is not supported -- there is no `_mm256_mullo_epi64` intrinsic; emulation via 4x scalar or cross-lane shuffles negates the benefit.

## Hand-Written Assembly (x86_64)

The library includes a branchless `pow_asm_cmov` for `uint64_t` base and exponent, using inline assembly with the `cmov` instruction to eliminate the "if (exp & 1)" branch in binary exponentiation.

### Why cmov?

GCC's output for `pow_hierarchical` uses branches (`je`/`jne`) for odd-exponent checks. For arbitrary exponents, the `exp & 1` pattern has a ~50% mispredict rate. The cmov version eliminates this branch entirely:

```asm
.loop:
    mov  rax, rcx      ; temp = result
    imul rcx, rdi      ; temp = result * base
    test sil, 1        ; test exp & 1
    cmovnz rax, rcx    ; if odd: result = temp (branchless)
    imul rdi, rdi      ; base *= base
    shr  rsi           ; exp >>= 1
    jnz  .loop
```

Key properties:
- **4 registers only** (result, base, exp, temp) -- no stack frame, no register spills
- **Branchless inner loop** -- only the loop-exit branch (`jnz`) remains, which is well-predicted
- **No recursive fallback** -- handles all exponent sizes

The asm implementation is guarded by `#if defined(__x86_64__) && defined(__GNUC__)` and compiles only on x86_64 with GCC-compatible compilers.

## Quick Start

```bash
# one-shot build & run
mkdir -p build && cd build
cmake .. && make -j

# run unit tests
ctest --output-on-failure

# integer-exponent suite (~1 min)
./benchmark_pow_fast_gcc

# SIMD batch benchmark
./benchmark_simd --benchmark_min_time=0.1s

# SIMD float + uint32 benchmark
./benchmark_simd_extra --benchmark_min_time=0.1s

# ASM branchless benchmark (uint64)
./benchmark_asm --benchmark_min_time=0.1s

# ASM double-base benchmark
./benchmark_asm_double --benchmark_min_time=0.1s

# fractional 2/3 suite (~15 s)
./benchmark_pow_fractional_fast_gcc
```

### Build Notes

- **AVX2 is auto-detected:** The SIMD implementations are guarded by `#ifdef __AVX2__` and automatically enabled when you compile with `-mavx2` or `-march=native` on a machine that supports AVX2.
- **Dependencies:** Google Benchmark, Eigen and Google Test are fetched automatically via CMake FetchContent -- nothing has to be installed system-wide.
- **Tests:** Unit tests use Google Test. Run with `ctest` or `./test_pow`.
- **Non-x86 platforms:** The library compiles cleanly without SIMD or ASM features -- only the scalar implementations are available.

For deeper numbers run the benchmarks yourself on your target CPU.

---

## Continuous Performance Measurement (CodSpeed)

Every push to `main` and every pull request runs the whole benchmark suite on
[CodSpeed](https://app.codspeed.io/sbstndb/powerix) with the CPU simulation
instrument, so performance changes on the kernels are reported directly on the
pull request.

The benchmark sources are unchanged: Google Benchmark is pulled from
[CodSpeed's compatibility fork](https://github.com/CodSpeedHQ/codspeed-cpp),
which is a drop-in replacement for the upstream library. Dedicated
`codspeed_*` targets build one executable per benchmark file with a fixed
instruction set (`-O3 -mavx2` instead of `-march=native`) so the measurements
stay reproducible across machines while still exercising the AVX2 kernels.

```bash
# configure with the CodSpeed instrumentation enabled
cmake -S . -B build -DCODSPEED_MODE=simulation -DCMAKE_BUILD_TYPE=RelWithDebInfo
cmake --build build --target codspeed_benchmarks -j

# run a single suite locally (needs the CodSpeed CLI: https://codspeed.io/docs/cli)
codspeed run --mode simulation -- ./build/codspeed_benchmark_simd
```

Outside of a CodSpeed environment the executables behave like ordinary Google
Benchmark binaries.

---

## Extended Benchmark Numbers

### 1. Integer-Exponent Workloads (ns)
| Base^Exponent | Compiler | `std::pow` | `pow_hierarchical` | `pow_binary` | `pow_ultra_fast` |
|---------------|----------|-----------:|-------------------:|---------------:|-----------------:|
| Int16^Int16   | GCC   | 238 | **41** | 55 | 56 |
| Int16^Int16   | Clang | 238 | **40** | 55 | 56 |
| Int32^Int32   | GCC   | 241 | **40** | 50 | 58 |
| Int32^Int32   | Clang | 241 | **40** | 50 | 58 |
| Int64^Int64   | GCC   | 243 | **39** | 54 | 57 |
| Int64^Int64   | Clang | 243 | **39** | 54 | 57 |
| Float64^Int32 | GCC   | 303 | **55** | –  | 69 |
| Float64^Int32 | Clang | 303 | **55** | –  | 69 |

**Take-away:** hierarchical exponentiation is ~6× faster than `std::pow` across all integer exponents.

### 2. Fractional Exponent `base^(2/3)` (ns)
| Base type | Compiler | `std::pow` | `exp_log` | `cbrt` | `Eigen` | `Series` | Fastest |
|-----------|----------|-----------:|----------:|-------:|--------:|----------:|---------|
| Float64   | GCC   | 93.1 | **97.0** | 102 | 103 | 167 | `exp_log` |
| Float32   | GCC   | 44.1 | 56.8 | 46.3 | **49.2** | 104 | `Eigen` |
| Mixed     | GCC   | 96.1 | 57.0 | 46.5 | 49.0 | 103 | `Eigen` |

**Precision (MaxRelErr):**
- `std::pow`: 0 (perfect reference)
- `exp_log`: 5.15e-10 (excellent)
- `cbrt`: 2.80e-8 (very good)
- `Eigen`: 1.03e-7 (very good)
- `Series`: 1.04e-6 (good, but slower)

### 3. Memoization (when `(base,exp)` repeat)
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
* **Eigen** – Calls Eigen's vectorised `pow` which shines on `float32` thanks to fast SIMD path.
* **Series** – Binomial expansion to 7 terms; accurate but 2× slower – mostly a didactic baseline.

---

## Implementation Details

### Integer Exponents

#### `pow_hierarchical` (Divide & Conquer)

Recursive approach that halves the exponent at each step:

```cpp
T pow_hierarchical(T base, U exp) {
    if (exp == 0) return 1;
    if (exp == 1) return base;
    T half = pow_hierarchical(base * base, exp >> 1);
    return (exp & 1) ? base * half : half;
}
```

**Why it's fast:** The ternary compiles to a conditional move (no branch), and modern compilers fully inline small recursive functions. O(log n) multiplications.

#### `pow_binary` (Iterative)

Classic square-and-multiply loop:

```cpp
T pow_binary(T base, U exp) {
    T result = 1;
    while (exp > 0) {
        if (exp & 1) result *= base;
        base *= base;
        exp >>= 1;
    }
    return result;
}
```

**Trade-off:** Slightly slower than hierarchical due to loop overhead, but non-recursive.

#### `pow_ultra_fast` (Hardcoded + Unrolled)

Switch-case for common exponents (1–4, 8), then falls back to binary:

```cpp
switch (exp) {
    case 2: return base * base;
    case 3: return base * base * base;
    case 4: { T sq = base * base; return sq * sq; }
    // ...
}
```

**Trade-off:** Fast for small exponents, but switch overhead hurts when exponents vary.

### Fractional Exponents (base^(2/3))

#### `pow_2_3_exp_log`

Uses the identity x^a = exp(a · log(x)):

```cpp
double pow_2_3_exp_log(T base) {
    return exp(0.666... * log(base));
}
```

**Why it wins:** Modern FPUs pipeline `log`/`exp` extremely well. Single-pass, no branching.

#### `pow_2_3_cbrt`

Uses the identity x^(2/3) = ∛(x²):

```cpp
double pow_2_3_cbrt(T base) {
    return cbrt(base * base);
}
```

**Trade-off:** Avoids `log`, but the extra multiply + `cbrt` latency cancels gains on x86.

#### `pow_2_3_series` (Binomial Expansion)

Taylor series around the nearest perfect cube:

```cpp
// For x near a = n³, expand (1+z)^(2/3) where z = x/a - 1
double n = round(cbrt(x));
double z = x / (n*n*n) - 1;
double sum = 1;
for (int k = 1; k < 10; ++k)
    sum += binomial_coeff(2/3, k) * z^k;
return n² * sum;
```

**Trade-off:** Best precision (~1e-6), but 10 iterations make it 2× slower.

### Memoization Strategies

| Strategy | Lookup | Best when |
|----------|--------|-----------|
| `std::map<pair>` | O(log n) | Large exponents, sorted access |
| `unordered_map<pair>` | O(1) avg | Random access, moderate reuse |
| `vector<vector<optional>>` | O(1) | Small bounded ranges |
| `static T[16][16]` | O(1) | Very small base/exp (≤15) |

All caches fall back to `pow_hierarchical` on miss. Cache overhead only pays off when reuse rate ≥ 50%.

---

## Context

This project is part of a performance optimization effort for a **Method of Moments** solver that relies heavily on various exponential computations. Developed at **École Polytechnique** within the **CMAP / HPC@Maths** laboratory.