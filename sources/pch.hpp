// --- local/mygtest                                                   [pch.hpp]
// [2023-08-05][19:00:00] 005 Kartonagnick PRE
//   --- Katonagnick/mygtest                                           [pch.hpp]
//   [2021-06-08][15:00:00] 004 Kartonagnick
//   [2021-06-05][12:10:00] 003 Kartonagnick
//   [2021-05-15][00:42:36] 002 Kartonagnick
//   [2020-02-10][00:36:45] 001 Kartonagnick
//==============================================================================
//==============================================================================

#pragma once
#include <cassert>
#include <cstring>
#include <cassert>

#include "features.hpp"

#ifdef dMYGTEST_HAS_ATOMIC
    #include <mutex>
#else
    #include <new>
    #ifdef _WIN32
        #define NOMINMAX 1
        #define WIN32_LEAN_AND_MEAN
        #include <windows.h> 
    #endif
#endif

#include "synch.hpp"

//==============================================================================
//==============================================================================
