# WorkSpace project.
# Module: myGTest
# [2021y-06m-04d][22:59:48] Idrisov Denis R.
################################################################################
################################################################################

set(gDEBUG "$ENV{eDEBUG}")
cmake_minimum_required(VERSION 3.1)

include("${CMAKE_CURRENT_LIST_DIR}/setup.cmake")
cmake_scenario("minimalist")

project(${gNAME_PROJECT} CXX)

################################################################################
################################################################################

if(gSTABLE_RELEASE)
    message(STATUS "gSTABLE_RELEASE: ON")
else()
    message(STATUS "gSTABLE_RELEASE: OFF")
endif()

make_target()

make_target(PATH_TO_SOURCES "test")

################################################################################
################################################################################

