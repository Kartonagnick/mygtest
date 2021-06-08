// [2021y-06m-08d][15:00:00] Idrisov Denis R. 001
// [2021y-06m-05d][12:10:00] Idrisov Denis R. 001 PRE
#pragma once
#ifndef dMYGTEST_PRINT_USED_
#define dMYGTEST_PRINT_USED_ 1

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
#endif // !dMYGTEST_PRINT_USED_
