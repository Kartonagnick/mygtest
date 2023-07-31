// --- local/mygtest                                      [private/noexcept.hpp]
// [2023-08-05][19:00:00] 001 Kartonagnick    
//==============================================================================
//==============================================================================

#pragma once
#ifndef dMYGTEST_NOEXCEPT_USED_
#define dMYGTEST_NOEXCEPT_USED_ 1

//==============================================================================
//=== noexcept =================================================================

#if defined(__clang__)
    #if __has_feature(cxx_noexcept)
        #define dMYGTEST_HAS_NOEXCEPT 1
    #endif
#endif

#if defined(__GXX_EXPERIMENTAL_CXX0X__)
    #if __GNUC__ * 10 + __GNUC_MINOR__ >= 46                    // [gcc460: new]
        #define dMYGTEST_HAS_NOEXCEPT 1
    #endif
#endif

#if defined(_MSC_FULL_VER) && _MSC_FULL_VER >= 190023026      // [msvc2015: new]
    #define dMYGTEST_HAS_NOEXCEPT 1
#endif
                
#ifndef dMYGTEST_HAS_NOEXCEPT
    #define noexcept throw()
#endif

//==============================================================================
//==============================================================================
#endif // dMYGTEST_NOEXCEPT_USED_
