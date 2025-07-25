# Powerix – Benchmark of different `pow` implementations

## Objective

This project aims to explore the impact of different implementation strategies for the power function (`pow`) in C++. We want to:

1. Compare the performance of several implementations:
   - `std::pow` (reference)
   - Fast exponentiation for integer exponents (`pow_fast_int`)
   - Memoized version for repeated calls (`pow_cached`)
2. Quantify the error (absolute and relative) introduced by alternative implementations compared to `std::pow`.
3. Evaluate performance on different data types:
   - Signed integers: `int16_t`, `int32_t`, `int64_t`
   - Unsigned integers: `uint32_t`, `uint64_t`
   - Floating point: `float` (Float32), `double` (Float64)
   - Mixed cases: integers/floating point, Float32/Float64

Benchmarks are performed using the [Google Benchmark](https://github.com/google/benchmark) library.

---

## Project Structure

```
.
├── benchmark/
│   └── benchmark_pow.cpp   # Benchmark entry points
├── src/
│   ├── pow_impl.hpp        # Different implementation variants
│   └── error_util.hpp      # Error measurement tools
├── CMakeLists.txt          # Project configuration / dependencies
└── README.md               # This file
```

---

## Prerequisites

- A C++17 compiler (GCC 9+, Clang 10+, MSVC 2019+)
- CMake ≥ 3.14
- `git` for automatic dependency download

---

## Compilation

The project generates three binaries with different optimization levels:

```bash
mkdir -p build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build . -j$(nproc)
```

This generates:
- `benchmark_pow_standard` : `-O2` optimizations
- `benchmark_pow_aggressive` : `-O3 -mtune=native -march=native -mavx2` optimizations
- `benchmark_pow_fast` : Ultra-aggressive optimizations `-Ofast -mtune=native -march=native -mavx2 -ffast-math -funroll-loops`

---

## Running Benchmarks

Always in `build/`:

```bash
# Standard version
./benchmark_pow_standard

# Version with aggressive optimizations
./benchmark_pow_aggressive

# Ultra-aggressive version (recommended)
./benchmark_pow_fast
```

You will get:

1. A summary of the maximum error (absolute and relative) between alternative implementations and `std::pow`.
2. Google Benchmark performance tables for each data type.

---

## Performance Results

### Results with ultra-aggressive optimizations (`-Ofast`)

| Benchmark | Time | Type | Gain vs std::pow |
|-----------|------|------|------------------|
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

### Key Observations

1. **Fast exponentiation**: 4.0-4.5x faster for all integer types
2. **Unsigned integers**: Slightly more performant than signed ones
3. **Floating point**: `float` (99.3 ns) faster than `double` (192 ns)
4. **Precision**: Maximum relative error of 3.9e-16 (excellent)

### Usage Recommendations

- **For unsigned integers**: `UInt32` with fast exponentiation (62.9 ns)
- **For signed integers**: `Int32` with fast exponentiation (69.3 ns)
- **For floating point**: `Float32` for speed (99.3 ns), `Float64` for precision (192 ns)
- **For large integers**: `Int64`/`UInt64` with fast exponentiation (~70 ns)

---

## Customization

You can modify the test datasets in `benchmark/benchmark_pow.cpp`:
- `kInt16Bases`, `kInt16Exps` : For 16-bit integers
- `kInt32Bases`, `kInt32Exps` : For 32-bit integers
- `kFloat32Bases`, `kFloat32Exps` : For 32-bit floating point
- `kFloat64Bases`, `kFloat64Exps` : For 64-bit floating point

To profile more finely or add new implementations, simply create new functions in `src/pow_impl.hpp` then declare additional benchmarks.

---

## License

This project is distributed under the MIT license. 