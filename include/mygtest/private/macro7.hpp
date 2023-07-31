// --- local/mygtest                                                [macro7.hpp]
// [2023-08-05][19:00:00] 004 Kartonagnick    
//   --- Katonagnick/mygtest                              [macro/overload-7.hpp]
//   [2021-06-08][15:00:00] 003 Kartonagnick
//   [2021-04-19][08:07:24] 002 Kartonagnick
//   [2019-54-16][11:15:19] 001 Kartonagnick
//==============================================================================
//==============================================================================

#pragma once
#ifndef dMYGTEST_MACRO7_USED_
#define dMYGTEST_MACRO7_USED_ 4

//==============================================================================
//=== [support max 7 arguments [0 : 7] =========================================

    #define dMYGTEST_CHOOSER(f1, f2, f3, f4, f5, f6, f7, N, ... ) N
    #define dMYGTEST_RECOMPOSER(args) dMYGTEST_CHOOSER args
    #define dMYGTEST_NO_ARG(macro) ,,,,,,,macro##_0

    #define dMYGTEST_MACRO_7(macro, ...)  \
        dMYGTEST_RECOMPOSER((__VA_ARGS__, \
            macro##_7, macro##_6, macro##_5, macro##_4, \
            macro##_3, macro##_2, macro##_1, macro##_0  \
        ))

    #define dMYGTEST_MACRO(macro, ...) \
        dMYGTEST_MACRO_7(macro, dMYGTEST_NO_ARG __VA_ARGS__ (macro))

//==============================================================================
//==============================================================================
#endif // dMYGTEST_MACRO7_USED_
