cmake_minimum_required(VERSION 3.14)
project(powerix_bench LANGUAGES CXX)

# Exiger C++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Configuration des optimisations par défaut
if(MSVC)
    add_compile_options(/W4 /permissive-)
else()
    add_compile_options(-Wall -Wextra -pedantic)
endif()

include(FetchContent)

# Télécharger Google Benchmark
FetchContent_Declare(
    googlebenchmark
    GIT_REPOSITORY https://github.com/google/benchmark.git
    GIT_TAG v1.8.3
)
# Google Benchmark requiert GoogleTest pour les tests internes mais on peut désactiver
set(BENCHMARK_ENABLE_TESTING OFF CACHE BOOL "Disable benchmark's tests" FORCE)
FetchContent_MakeAvailable(googlebenchmark)

# Fonction pour créer un exécutable avec des optimisations spécifiques
function(create_benchmark_executable name optimization_flags)
    add_executable(${name}
        benchmark/benchmark_pow.cpp
    )
    
    # Inclure les headers du projet
    target_include_directories(${name} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/src)
    
    # Appliquer les optimisations spécifiques
    target_compile_options(${name} PRIVATE ${optimization_flags})
    
    # Lier Google Benchmark
    target_link_libraries(${name} PRIVATE benchmark::benchmark)
    
    # Sur certaines plateformes, linker pthread est nécessaire
    if (UNIX AND NOT APPLE)
        target_link_libraries(${name} PRIVATE pthread)
    endif()
endfunction()

# 1. Version ultra-agressive (-Ofast, etc.)
if(MSVC)
    create_benchmark_executable(benchmark_pow_fast "/O2 /GL /fp:fast")
else()
    create_benchmark_executable(benchmark_pow_fast "-Ofast;-mtune=native;-march=native;-mavx2;-ffast-math;-funroll-loops")
endif()

# 2. Version agressive (-O3 avec optimisations natives)
if(MSVC)
    create_benchmark_executable(benchmark_pow_aggressive "/O2 /GL")
else()
    create_benchmark_executable(benchmark_pow_aggressive "-O3;-mtune=native;-march=native;-mavx2")
endif()

# 3. Version standard (-O2 seulement)
if(MSVC)
    create_benchmark_executable(benchmark_pow_standard "/O2")
else()
    create_benchmark_executable(benchmark_pow_standard "-O2")
endif() 