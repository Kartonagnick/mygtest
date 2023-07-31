// --- local/mygtest                                      [sources/features.hpp]
// [2023-08-05][19:00:00] 002 Kartonagnick    
//   --- Katonagnick/mygtest                              [private/features.hpp]
//   [2021-06-08][15:00:00] 002 Kartonagnick
//   [2021-06-05][12:10:00] 001 Kartonagnick
//==============================================================================
//==============================================================================

#pragma once
#ifndef dMYGTEST_SOURCES_FEATURES_USED_
#define dMYGTEST_SOURCES_FEATURES_USED_ 2

#include <mygtest/private/noexcept.hpp>

//==============================================================================
//=== dHAS_ATOMIC ==============================================================

#if !defined(_MSC_VER) || _MSC_VER >= 1700                    // [msvc2012: new]
    #define dMYGTEST_HAS_ATOMIC 1
#endif

//==============================================================================
//=== dSTATIC_CHECK ============================================================

#if !defined(_MSC_VER) || _MSC_VER >= 1600                    // [msvc2010: new]
    #define dMYGTEST_STATIC_CHECK(msg, ...) \
        static_assert((__VA_ARGS__), #msg)
#else
    template<bool> struct static_assert_;
    template<> struct static_assert_<true> {};
    #define dMYGTEST_STATIC_CHECK(msg, ...)  \
    {                                        \
        ::static_assert_<(__VA_ARGS__)> msg; \
        (void) msg;                          \
    } void()
#endif

//==============================================================================
//==============================================================================
#endif // dMYGTEST_SOURCES_FEATURES_USED_
