# Install script for directory: /tmp/powerix/build/_deps/eigen3-src/unsupported/Eigen

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set path to fallback-tool for dependency-resolution.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Devel" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/eigen3/unsupported/Eigen" TYPE FILE FILES
    "/tmp/powerix/build/_deps/eigen3-src/unsupported/Eigen/AdolcForward"
    "/tmp/powerix/build/_deps/eigen3-src/unsupported/Eigen/AlignedVector3"
    "/tmp/powerix/build/_deps/eigen3-src/unsupported/Eigen/ArpackSupport"
    "/tmp/powerix/build/_deps/eigen3-src/unsupported/Eigen/AutoDiff"
    "/tmp/powerix/build/_deps/eigen3-src/unsupported/Eigen/BVH"
    "/tmp/powerix/build/_deps/eigen3-src/unsupported/Eigen/EulerAngles"
    "/tmp/powerix/build/_deps/eigen3-src/unsupported/Eigen/FFT"
    "/tmp/powerix/build/_deps/eigen3-src/unsupported/Eigen/IterativeSolvers"
    "/tmp/powerix/build/_deps/eigen3-src/unsupported/Eigen/KroneckerProduct"
    "/tmp/powerix/build/_deps/eigen3-src/unsupported/Eigen/LevenbergMarquardt"
    "/tmp/powerix/build/_deps/eigen3-src/unsupported/Eigen/MatrixFunctions"
    "/tmp/powerix/build/_deps/eigen3-src/unsupported/Eigen/MoreVectorization"
    "/tmp/powerix/build/_deps/eigen3-src/unsupported/Eigen/MPRealSupport"
    "/tmp/powerix/build/_deps/eigen3-src/unsupported/Eigen/NonLinearOptimization"
    "/tmp/powerix/build/_deps/eigen3-src/unsupported/Eigen/NumericalDiff"
    "/tmp/powerix/build/_deps/eigen3-src/unsupported/Eigen/OpenGLSupport"
    "/tmp/powerix/build/_deps/eigen3-src/unsupported/Eigen/Polynomials"
    "/tmp/powerix/build/_deps/eigen3-src/unsupported/Eigen/Skyline"
    "/tmp/powerix/build/_deps/eigen3-src/unsupported/Eigen/SparseExtra"
    "/tmp/powerix/build/_deps/eigen3-src/unsupported/Eigen/SpecialFunctions"
    "/tmp/powerix/build/_deps/eigen3-src/unsupported/Eigen/Splines"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Devel" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/eigen3/unsupported/Eigen" TYPE DIRECTORY FILES "/tmp/powerix/build/_deps/eigen3-src/unsupported/Eigen/src" FILES_MATCHING REGEX "/[^/]*\\.h$")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/tmp/powerix/build/_deps/eigen3-build/unsupported/Eigen/CXX11/cmake_install.cmake")

endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "/tmp/powerix/build/_deps/eigen3-build/unsupported/Eigen/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
