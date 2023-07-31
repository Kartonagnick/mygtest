// --- local/mygtest                                              [test-list.hpp]
// [2023-08-05][19:00:00] 003 Kartonagnick PRE
//   --- Katonagnick/mygtest                                      [test-list.hpp]
//   [2021-06-08][15:00:00] 002 Kartonagnick
//   [2021-06-05][12:10:00] 001 Kartonagnick
//==============================================================================
//==============================================================================

#pragma once
#ifndef dMYGTEST_TEST_LIST_USED_ 
#define dMYGTEST_TEST_LIST_USED_ 3

#include "private/component.hpp"
#include "mygtest.hpp"

#ifdef STABLE_RELEASE
    #include "test-stable.hpp"
#else
    #include "test-develop.hpp"    
#endif

//==============================================================================
//==============================================================================
#endif // dMYGTEST_TEST_LIST_USED_
