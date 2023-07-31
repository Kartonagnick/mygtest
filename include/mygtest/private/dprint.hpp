// --- local/mygtest                                                [dprint.hpp]
// [2023-07-31][19:00:00] 002 Kartonagnick PRE
//   --- Katonagnick/mygtest                                        [dprint.hpp]
//   [2021-06-08][15:00:00] 002 Kartonagnick
//   [2021-06-05][12:10:00] 001 Kartonagnick
//==============================================================================
//==============================================================================

#pragma once
#ifndef dMYGTEST_PRINT_USED_
#define dMYGTEST_PRINT_USED_ 2

//==============================================================================
//=== [dprint] =================================================================

#include <iostream>

struct mygtest_mutex
{
    mygtest_mutex();
   ~mygtest_mutex();
};

#define dprint(out_message_operation) \
{                                     \
    mygtest_mutex g_mut;              \
    out_message_operation;            \
} void()

//==============================================================================
//==============================================================================
#endif // dMYGTEST_PRINT_USED_
