
# --- local/mygtest                                     [deploy][CMakeLists.txt]
# [2023-08-05][19:00:00] 001 Kartonagnick    
# [2023-07-31][17:50:00] birthday of the project  
################################################################################

set(gARTIFACT_PREFIX "{PROJECT_VERSION}")
set(gARTIFACT_SUFFIX "lib-{COMPILER_TAG}-{BUILD_TYPE}-{ADDRESS_MODEL}-{RUNTIME_CPP}")

#-------------------------------------------------------------------------------

cmake_minimum_required(VERSION 3.1)
include("${CMAKE_CURRENT_LIST_DIR}/setup.cmake")
cmake_scenario("minimalist")
project("${gPROJECT_NAME}" CXX)

#-------------------------------------------------------------------------------

make_target(ARTIFACT_FOR_CONFIG "all")
make_target(PATH_TO_SOURCES "test")

#-------------------------------------------------------------------------------
