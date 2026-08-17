#!/bin/sh
# Replace CMake's compiler in a CXX_COMPILER_LAUNCHER / CXX_LINKER_LAUNCHER
# (or RULE_LAUNCH_LINK) command line.
#
# CMake has no per-target CXX_COMPILER property. Launchers are invoked as:
#   override_cxx_compiler.sh <desired_compiler> <cmake_compiler> [args...]
# This drops CMake's compiler and execs the requested one with the same args.
set -eu

if [ "$#" -lt 2 ]; then
    echo "override_cxx_compiler.sh: expected <desired_compiler> <cmake_compiler> [args...]" >&2
    exit 2
fi

desired=$1
shift
# Discard CMAKE_CXX_COMPILER (first remaining argument).
shift

exec "$desired" "$@"
