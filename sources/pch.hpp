// [2021y-06m-08d][15:00:00] Idrisov Denis R. 001
// [2021y-06m-05d][12:10:00] Idrisov Denis R. 001    
//------------------------------------------------------------------------------
// [2021y-05m-15d][00:42:36] Idrisov Denis R.
// [2020y-02m-10d][00:36:45] Idrisov Denis R.
#pragma once

#include <cassert>
#include <cstring>

#ifndef NDEBUG
    #include <cassert>
#endif

#include <mygtest/private/features.hpp>

#ifdef dHAS_ATOMIC
    #include <mutex>
#else
    #include <new>

    #ifdef _WIN32
        #define NOMINMAX 1
        #define WIN32_LEAN_AND_MEAN
        #include <windows.h> 
    #endif
#endif

//==============================================================================
//==============================================================================
