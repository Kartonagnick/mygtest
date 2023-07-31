// --- local/mygtest                                               [mygtest.hpp]
// [2023-08-05][19:00:00] 002 Kartonagnick    
//   --- Katonagnick/mygtest                                       [mygtest.hpp]
//   [2021-06-08][15:00:00] 002 Kartonagnick
//   [2021-06-05][12:10:00] 001 Kartonagnick
//==============================================================================
//==============================================================================

#pragma once
#ifndef dMYGTEST_USED_ 
#define dMYGTEST_USED_ 2

#if defined(__GNUC__)
    #pragma GCC system_header
#endif

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
#endif // dMYGTEST_USED_
