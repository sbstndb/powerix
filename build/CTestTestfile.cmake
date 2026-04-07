# CMake generated Testfile for 
# Source directory: /tmp/powerix
# Build directory: /tmp/powerix/build
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(test_pow "/tmp/powerix/build/test_pow")
set_tests_properties(test_pow PROPERTIES  _BACKTRACE_TRIPLES "/tmp/powerix/CMakeLists.txt;118;add_test;/tmp/powerix/CMakeLists.txt;0;")
subdirs("_deps/eigen3-build")
subdirs("_deps/googletest-build")
