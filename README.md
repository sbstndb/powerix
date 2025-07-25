# Powerix - High Performance Power Function Benchmarks

## Overview

This project implements and benchmarks various `pow` function implementations to achieve maximum performance. It uses Google Benchmark to measure performance and calculates errors compared to `std::pow` as reference.

## Objectives

- Implement different `pow` strategies (including `std::pow`)
- Use caching strategies for frequently repeated power calculations
- Benchmark `pow(a,b)` with:
  - Integer bases and exponents
  - Floating-point bases and exponents  
  - Mixed integer/floating-point combinations
- Calculate absolute and relative errors compared to `std::pow`
- Support multiple data types: `Int16`, `Int32`, `Int64`, `UInt32`, `UInt64`, `Float32`, `Float64`

## Implementations

### 1. Standard pow wrapper
Simple wrapper around `std::pow` for reference.

### 2. Fast integer exponentiation
Binary exponentiation algorithm for non-negative integer exponents.

### 3. Memoized pow with std::map
Thread-safe memoization using static `std::map` with mutex protection.

### 4. Hierarchical recursive exponentiation
Divide & conquer approach using tail-optimizable recursion.

### 5. Ultra-optimized binary exponentiation
My favorite version combining bit manipulation, partial loop unrolling, and compiler optimizations.

### 6. Memoization with std::vector<std::vector<>
Dynamic reallocation memoization suitable for small integer bases and positive exponents.

### 7. Pure C version
Direct calls to C `pow()` function from `math.h`.

### 8. cbrt version
Uses `cbrt(x^2)` for `x^(2/3)` calculations.

### 9. exp(y*log(x)) version
Uses exponential and logarithmic functions for power calculations.

### 10. Eigen version
Uses Eigen's optimized `pow` function for numerical computations.

### 11. Binomial series expansion
Calculates `x^(2/3)` using binomial series around the nearest perfect cube.

## Compilation

The project uses CMake and generates multiple binaries with different optimization levels:

### Generated Binaries

1. **benchmark_pow_standard** (`-O2`)
   - Standard optimization level
   - Good balance between performance and compilation time

2. **benchmark_pow_aggressive** (`-O3 -mtune=native -march=native -mavx2`)
   - Aggressive optimization with native CPU tuning
   - AVX2 vectorization enabled

3. **benchmark_pow_fast** (`-Ofast -mtune=native -march=native -mavx2 -ffast-math -funroll-loops`)
   - Ultra-aggressive optimization
   - Fast math approximations and loop unrolling

### Clang Versions

The same optimization levels are also available with Clang compiler:
- **benchmark_pow_standard_clang**
- **benchmark_pow_aggressive_clang** 
- **benchmark_pow_fast_clang**

### Fractional Exponent Binaries

Separate binaries for fractional exponent benchmarks:
- **benchmark_pow_fractional_standard**
- **benchmark_pow_fractional_aggressive**
- **benchmark_pow_fractional_fast**
- **benchmark_pow_fractional_standard_clang**
- **benchmark_pow_fractional_aggressive_clang**
- **benchmark_pow_fractional_fast_clang**

## Execution

```bash
# Compile the project
mkdir build && cd build
cmake ..
make

# Run all benchmarks
./benchmark_pow_fast

# Run specific benchmark types
./benchmark_pow_fast --benchmark_filter=Int32
./benchmark_pow_fast --benchmark_filter=Float64
./benchmark_pow_fractional_fast --benchmark_filter=FracExp

# Run with different optimization levels
./benchmark_pow_standard
./benchmark_pow_aggressive
./benchmark_pow_fast

# Run with Clang compiler
./benchmark_pow_fast_clang
./benchmark_pow_fractional_fast_clang
```

## Performance Results (Latest -Ofast Results)

### Integer and Floating-Point Benchmarks

| Method | Int16 | Int32 | Int64 | UInt32 | UInt64 | Float32 | Float64 | Gain vs std::pow |
|--------|-------|-------|-------|--------|--------|---------|---------|------------------|
| **std::pow** | 286 ns | 282 ns | 287 ns | 298 ns | 303 ns | 155 ns | 291 ns | - |
| **pow_fast_int** | 67.6 ns | 54.0 ns | 65.3 ns | 69.2 ns | 69.3 ns | - | - | **+81%** |
| **pow_hierarchical** | 50.0 ns | 50.3 ns | 50.6 ns | 49.0 ns | 49.8 ns | 46.7 ns | 46.0 ns | **+83%** |
| **pow_ultra_fast** | 66.8 ns | 70.3 ns | 72.7 ns | 73.8 ns | 71.0 ns | 65.5 ns | 64.6 ns | **+76%** |
| **pow_cached** | - | 360 ns | - | - | - | - | 398 ns | **-28%** |
| **pow_vec_cached** | 214 ns | 226 ns | 194 ns | 211 ns | 211 ns | 219 ns | 233 ns | **+22%** |

### Fractional Exponent Benchmarks (x^(2/3))

| Method | Int32 | Float32 | Float64 |
|--------|-------|---------|---------|
| **std::pow** | 125 ns | 47.5 ns | 98.2 ns |
| **pow C raw** | 95.9 ns | 134 ns | 92.6 ns |
| **cbrt** | 98.3 ns | 45.3 ns | 91.3 ns |
| **exp(y*log(x))** | 74.4 ns | 50.3 ns | 71.7 ns |
| **Eigen** | 93.2 ns | 43.4 ns | 89.7 ns |
| **Binomial series** | 174 ns | 95.3 ns | 166 ns |

### Compiler Comparison (GCC vs Clang)

For fractional exponents with -Ofast optimization:

| Method | GCC | Clang | Difference |
|--------|-----|-------|------------|
| **std::pow Int32** | 125 ns | **129 ns** | **-3.2%** |
| **std::pow Float32** | 47.5 ns | **43.2 ns** | **+9.9%** |
| **std::pow Float64** | 98.2 ns | **89.3 ns** | **+10.0%** |
| **exp(y*log(x)) Int32** | **74.4 ns** | 74.5 ns | **+0.1%** |
| **exp(y*log(x)) Float32** | 50.3 ns | **49.4 ns** | **+1.8%** |
| **exp(y*log(x)) Float64** | **71.7 ns** | 71.2 ns | **+0.7%** |
| **Eigen Float32** | 43.4 ns | **43.5 ns** | **-0.2%** |
| **Eigen Float64** | **89.7 ns** | 89.8 ns | **+0.1%** |

### Key Observations

1. **pow_hierarchical** is the fastest for all types (83% faster than std::pow)
2. **pow_ultra_fast** provides excellent performance (76% faster than std::pow)
3. **pow_cached** is slower due to overhead but useful for repeated calculations
4. **Float32** operations are generally faster than **Float64**
5. **Clang** outperforms **GCC** for std::pow operations (9-10% faster)
6. **exp(y*log(x))** is the fastest for fractional exponents
7. **Eigen** provides the best performance for Float32 fractional exponents
8. **Binomial series** is the slowest but most mathematically accurate
9. **Int16** and **Int64** show similar performance patterns to **Int32**
10. **Unsigned integers** (UInt32, UInt64) perform slightly better than signed integers

## Benchmark Organization

The benchmarks are organized in logical order:

### Main Benchmarks (`benchmark_pow.cpp`)
1. **std::pow** (reference implementation) - All types
2. **pow_fast_int** (fast exponentiation) - Integer types only
3. **pow_hierarchical** (divide & conquer) - All types
4. **pow_ultra_fast** (optimized binary) - All types
5. **pow_cached** (memoization std::map) - Limited types
6. **pow_vec_cached** (memoization vector) - All types

### Fractional Benchmarks (`benchmark_pow_fractional.cpp`)
1. **std::pow** (reference)
2. **pow C raw** (C function)
3. **cbrt** (cube root)
4. **exp(y*log(x))** (exponential/logarithmic)
5. **Eigen** (numerical library)
6. **Binomial series** (mathematical expansion)

## Usage Recommendations

### For Integer Exponents
- Use **pow_hierarchical** for maximum performance
- Use **pow_ultra_fast** for good balance of speed and accuracy
- Use **pow_cached** if you have repeated calculations with same parameters

### For Floating-Point Exponents
- Use **std::pow** for maximum accuracy
- Use **exp(y*log(x))** for good performance with acceptable accuracy
- Use **Eigen** for numerical computations requiring high precision

### For Fractional Exponents (2/3)
- Use **exp(y*log(x))** for best performance
- Use **Eigen** for Float32 operations
- Use **cbrt** for cube root related calculations
- Use **std::pow** for maximum accuracy

### Compiler Choice
- Use **Clang** for std::pow operations (9-10% faster)
- Use **GCC** for custom implementations (similar performance)
- Both compilers perform similarly for most custom implementations

### Data Type Recommendations
- Use **Int32** for general integer operations (best balance)
- Use **Float32** for speed-critical floating-point operations
- Use **Float64** for high-precision calculations
- Use **Int16** for memory-constrained applications
- Use **Int64** for large number calculations

## Customization

You can modify the benchmark datasets by editing these variables in `benchmark_pow.cpp`:

- `kInt16Bases`, `kInt16Exps` - Integer 16-bit datasets
- `kInt32Bases`, `kInt32Exps` - Integer 32-bit datasets
- `kInt64Bases`, `kInt64Exps` - Integer 64-bit datasets
- `kUInt32Bases`, `kUInt32Exps` - Unsigned integer 32-bit datasets
- `kUInt64Bases`, `kUInt64Exps` - Unsigned integer 64-bit datasets
- `kFloat32Bases`, `kFloat32Exps` - Single precision datasets
- `kFloat64Bases`, `kFloat64Exps` - Double precision datasets

## Dependencies

- **Google Benchmark** - Performance measurement framework
- **Eigen** - Numerical computation library
- **CMake** - Build system
- **C++17** - Programming language standard

## Error Analysis

The benchmarks include error analysis comparing implementations to `std::pow`:
- **Absolute error**: Direct difference from reference
- **Relative error**: Error normalized by reference value

All custom implementations maintain high accuracy with relative errors typically below 1e-15.

## Precision and Accuracy

- **std::pow**: Highest accuracy, IEEE 754 compliant
- **pow_hierarchical**: Excellent accuracy for integer exponents
- **pow_ultra_fast**: Good accuracy with optimized performance
- **exp(y*log(x))**: Good accuracy for fractional exponents
- **Eigen**: High precision for numerical computations
- **Binomial series**: Highest mathematical accuracy for specific cases 