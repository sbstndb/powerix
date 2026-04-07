cmake_minimum_required(VERSION 3.16)
project(powerix VERSION 1.0.0 LANGUAGES CXX)

# Set C++20 standard
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find Google Benchmark
find_package(benchmark REQUIRED)

# Fetch Eigen library
include(FetchContent)
FetchContent_Declare(
    Eigen3
    GIT_REPOSITORY https://gitlab.com/libeigen/eigen.git
    GIT_TAG 3.4.0
)
FetchContent_MakeAvailable(Eigen3)

# Fetch Google Test
FetchContent_Declare(
    googletest
    GIT_REPOSITORY https://github.com/google/googletest.git
    GIT_TAG v1.14.0
)
FetchContent_MakeAvailable(googletest)

enable_testing()

# Detect available compilers
find_program(GCC_COMPILER g++)
find_program(CLANG_COMPILER clang++)

# Function to create benchmark executable with specific optimization flags
function(create_benchmark_executable name optimization_flags)
    add_executable(${name} 
        benchmark/benchmark_pow.cpp
    )
    target_compile_features(${name} PRIVATE cxx_std_20)
    target_compile_options(${name} PRIVATE ${optimization_flags})
    target_link_libraries(${name} PRIVATE benchmark::benchmark Eigen3::Eigen)
endfunction()

# Function to create fractional benchmark executable with specific optimization flags
function(create_fractional_benchmark_executable name optimization_flags)
    add_executable(${name} 
        benchmark/benchmark_pow_fractional.cpp
    )
    target_compile_features(${name} PRIVATE cxx_std_20)
    target_compile_options(${name} PRIVATE ${optimization_flags})
    target_link_libraries(${name} PRIVATE benchmark::benchmark Eigen3::Eigen)
endfunction()

# Function to create benchmark executable with specific compiler and optimization flags
function(create_benchmark_executable_with_compiler name optimization_flags compiler)
    add_executable(${name} 
        benchmark/benchmark_pow.cpp
    )
    set_target_properties(${name} PROPERTIES
        CXX_COMPILER ${compiler}
    )
    target_compile_features(${name} PRIVATE cxx_std_20)
    target_compile_options(${name} PRIVATE ${optimization_flags})
    target_link_libraries(${name} PRIVATE benchmark::benchmark Eigen3::Eigen)
endfunction()

# Function to create fractional benchmark executable with specific compiler and optimization flags
function(create_fractional_benchmark_executable_with_compiler name optimization_flags compiler)
    add_executable(${name} 
        benchmark/benchmark_pow_fractional.cpp
    )
    set_target_properties(${name} PROPERTIES
        CXX_COMPILER ${compiler}
    )
    target_compile_features(${name} PRIVATE cxx_std_20)
    target_compile_options(${name} PRIVATE ${optimization_flags})
    target_link_libraries(${name} PRIVATE benchmark::benchmark Eigen3::Eigen)
endfunction()

# Create GCC versions if GCC is available
if(GCC_COMPILER)
    # Create standard optimization binary (-O2)
    create_benchmark_executable(benchmark_pow_standard_gcc "-O2")
    create_fractional_benchmark_executable(benchmark_pow_fractional_standard_gcc "-O2")

    # Create aggressive optimization binary (-O3 -mtune=native -march=native -mavx2)
    create_benchmark_executable(benchmark_pow_aggressive_gcc "-O3;-mtune=native;-march=native;-mavx2")
    create_fractional_benchmark_executable(benchmark_pow_fractional_aggressive_gcc "-O3;-mtune=native;-march=native;-mavx2")

    # Create ultra-fast optimization binary (-Ofast -mtune=native -march=native -mavx2 -ffast-math -funroll-loops)
    create_benchmark_executable(benchmark_pow_fast_gcc "-Ofast;-mtune=native;-march=native;-mavx2;-ffast-math;-funroll-loops")
    create_fractional_benchmark_executable(benchmark_pow_fractional_fast_gcc "-Ofast;-mtune=native;-march=native;-mavx2;-ffast-math;-funroll-loops")
endif()

# Create Clang versions if Clang is available
if(CLANG_COMPILER)
    create_benchmark_executable_with_compiler(benchmark_pow_standard_clang "-O2" "clang++")
    create_fractional_benchmark_executable_with_compiler(benchmark_pow_fractional_standard_clang "-O2" "clang++")
    create_benchmark_executable_with_compiler(benchmark_pow_aggressive_clang "-O3;-mtune=native;-march=native;-mavx2" "clang++")
    create_fractional_benchmark_executable_with_compiler(benchmark_pow_fractional_aggressive_clang "-O3;-mtune=native;-march=native;-mavx2" "clang++")
    create_benchmark_executable_with_compiler(benchmark_pow_fast_clang "-Ofast;-mtune=native;-march=native;-mavx2;-ffast-math;-funroll-loops" "clang++")
    create_fractional_benchmark_executable_with_compiler(benchmark_pow_fractional_fast_clang "-Ofast;-mtune=native;-march=native;-mavx2;-ffast-math;-funroll-loops" "clang++")
endif()

# Function to create a custom benchmark executable from a specific source file
function(create_custom_benchmark_executable name source_file optimization_flags)
    add_executable(${name} ${source_file})
    target_compile_features(${name} PRIVATE cxx_std_20)
    target_compile_options(${name} PRIVATE ${optimization_flags})
    target_link_libraries(${name} PRIVATE benchmark::benchmark)
endfunction()

# Unit test executable
add_executable(test_pow test/test_pow.cpp)
target_compile_features(test_pow PRIVATE cxx_std_20)
target_compile_options(test_pow PRIVATE "-O2;-march=native;-mavx2")
target_link_libraries(test_pow PRIVATE GTest::gtest_main)
add_test(NAME test_pow COMMAND test_pow)

# SIMD and ASM benchmark executables
if(GCC_COMPILER)
    create_custom_benchmark_executable(benchmark_simd
        benchmark/benchmark_simd.cpp
        "-Ofast;-mtune=native;-march=native;-mavx2;-ffast-math;-funroll-loops")
    create_custom_benchmark_executable(benchmark_simd_extra
        benchmark/benchmark_simd_extra.cpp
        "-Ofast;-mtune=native;-march=native;-mavx2;-ffast-math;-funroll-loops")
    create_custom_benchmark_executable(benchmark_asm
        benchmark/benchmark_asm.cpp
        "-Ofast;-mtune=native;-march=native;-mavx2;-ffast-math;-funroll-loops")
    create_custom_benchmark_executable(benchmark_asm_double
        benchmark/benchmark_asm_double.cpp
        "-Ofast;-mtune=native;-march=native;-mavx2;-ffast-math;-funroll-loops")
endif()

# Print information about available compilers
if(GCC_COMPILER)
    message(STATUS "GCC found: ${GCC_COMPILER}")
else()
    message(STATUS "GCC not found")
endif()

if(CLANG_COMPILER)
    message(STATUS "Clang found: ${CLANG_COMPILER}")
else()
    message(STATUS "Clang not found")
endif() 