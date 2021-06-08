// [2021y-06m-08d][15:00:00] Idrisov Denis R. 001
// [2021y-06m-05d][12:10:00] Idrisov Denis R. 001 PRE
#pragma once
#ifndef dMYGTEST_TEST_LIST_USED_ 
#define dMYGTEST_TEST_LIST_USED_ 1
//==============================================================================
//==============================================================================

#include <mygtest/private/component.hpp>
#include <mygtest/mygtest.hpp>
#ifdef STABLE_RELEASE
    #include "test-stable.hpp"
#else
    #include "test-develop.hpp"    
#endif

//==============================================================================
//==============================================================================
#endif // !dMYGTEST_TEST_LIST_USED_