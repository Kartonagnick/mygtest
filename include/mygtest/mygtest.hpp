// [2021y-06m-08d][15:00:00] Idrisov Denis R. 001
// [2021y-06m-05d][12:10:00] Idrisov Denis R. 001 PRE
//==============================================================================
//==============================================================================

#pragma once
#ifndef dMYGTEST_USED_ 
#define dMYGTEST_USED_ 1

#if defined(__GNUC__)
    #pragma GCC system_header
#endif

#include <mygtest/private/features.hpp>

//==============================================================================
//==============================================================================

#ifdef _MSC_VER
    #if defined(dGMOCK_LIBRARY_USED_)
        #pragma message("InitGoogleMock...")

    #elif defined(dGTEST_LIBRARY_USED_)
        #pragma message("InitGoogleTest...")

    #else
        #pragma message("[WARNING] InitGoogleTest by default...")
    #endif
#endif

//==============================================================================
//==============================================================================

#if defined(dGMOCK_LIBRARY_USED_)
    #include <gtest/gtest.h>
    #include <gmock/gmock.h>

#elif defined(dGTEST_LIBRARY_USED_)
    #include <gtest/gtest.h>

#else
    #define dGMOCK_LIBRARY_USED_ 1
    #include <gmock/gmock.h>

#endif

//==============================================================================
//==============================================================================
#endif // !dMYGTEST_USED_