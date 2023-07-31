// --- local/mygtest                                             [extension.hpp]
// [2023-08-05][19:00:00] 003 Kartonagnick PRE
//   --- Katonagnick/mygtest                                     [extension.hpp]
//   [2021-06-08][15:00:00] 002 Kartonagnick
//   [2021-06-05][12:10:00] 001 Kartonagnick
//==============================================================================
//==============================================================================

#pragma once
#ifndef dMYGTEST_EXTENSION_USED_ 
#define dMYGTEST_EXTENSION_USED_ 3

//==============================================================================
//==============================================================================

#define dEXTRA(...) __VA_ARGS__
#define dEXPAND(...) dEXTRA(__VA_ARGS__)

//==============================================================================
//=== dREGISTER_UNIT_TEST ======================================================

#ifdef GTEST_MAYBE_5046_
    // used: google test 1.0.x
    #include "reg10.hpp"
#else
    // used: google test 0.8.x
    #include "reg08.hpp"
#endif

//==============================================================================
//=== TEST_COMPONENT ===========================================================

#include "macro7.hpp"

#define dMYGTEST_CLASS_0()                           unittest_
#define dMYGTEST_CLASS_1(a1)                         unittest_##a1
#define dMYGTEST_CLASS_2(a1, a2)                     unittest_##a1##_##a2
#define dMYGTEST_CLASS_3(a1, a2, a3)                 unittest_##a1##_##a2##_##a3
#define dMYGTEST_CLASS_4(a1, a2, a3, a4)             unittest_##a1##_##a2##_##a3##_##a4
#define dMYGTEST_CLASS_5(a1, a2, a3, a4, a5)         unittest_##a1##_##a2##_##a3##_##a4##_##a5
#define dMYGTEST_CLASS_6(a1, a2, a3, a4, a5, a6)     unittest_##a1##_##a2##_##a3##_##a4##_##a5##_##a6
#define dMYGTEST_CLASS_7(a1, a2, a3, a4, a5, a6, a7) unittest_##a1##_##a2##_##a3##_##a4##_##a5##_##a6##_##a7

#define dMYGTEST_NAME_0() invalid_component_name
#define dMYGTEST_NAME_1(a1) a1
#define dMYGTEST_NAME_2(a1, a2) a1/a2
#define dMYGTEST_NAME_3(a1, a2, a3) a1/a2/a3
#define dMYGTEST_NAME_4(a1, a2, a3, a4) a1/a2/a3/a4
#define dMYGTEST_NAME_5(a1, a2, a3, a4, a5) a1/a2/a3/a4/a5
#define dMYGTEST_NAME_6(a1, a2, a3, a4, a5, a6) a1/a2/a3/a4/a5/a6
#define dMYGTEST_NAME_7(a1, a2, a3, a4, a5, a6, a7) a1/a2/a3/a4/a5/a6/a7

#define dMYGTEST_AS_TYPE(...) \
    dMYGTEST_MACRO(dMYGTEST_CLASS, __VA_ARGS__)(__VA_ARGS__)

#define dMYGTEST_AS_NAME(...) \
    dMYGTEST_MACRO(dMYGTEST_NAME, __VA_ARGS__)(__VA_ARGS__)

#define dMYGTEST_REGISTRY(classN, testN, methodN) \
    dREGISTER_UNIT_TEST(classN, testN, methodN)

#define dTEST_NAME_METHOD_CONCAT(method, tag, n) \
    method##_##n(tag)

#define dMYGTEST_INDEX_CONCAT(method, tag, n) \
    method##_##tag##_##n

#define dMYGTEST_NAME_METHOD(method, tag, n) \
    dTEST_NAME_METHOD_CONCAT(method, tag, n)

#define dMYGTEST_INDEX(method, tag, n) \
    dMYGTEST_INDEX_CONCAT(method, tag, n)

#define dMYGTEST_DECLARATE_TYPE(i)                 \
    dEXPAND(dMYGTEST_AS_TYPE(                      \
        dTEST_COMPONENT,                           \
        dMYGTEST_INDEX(dTEST_METHOD, dTEST_TAG, i) \
    ))

#define dMYGTEST_DISABLED_TYPE(i)                  \
    dEXPAND(dMYGTEST_AS_TYPE(                      \
        DISABLED, dTEST_COMPONENT,                 \
        dMYGTEST_INDEX(dTEST_METHOD, dTEST_TAG, i) \
    ))

#define dMYGTEST_DECLARATE_NAME() \
    dEXPAND(dMYGTEST_AS_NAME(dTEST_COMPONENT))

#define dMYGTEST_DECLARATE_METHOD(index) \
    dMYGTEST_NAME_METHOD(dTEST_METHOD, dTEST_TAG, index)

#undef  TEST_COMPONENT
#undef _TEST_COMPONENT

#define TEST_COMPONENT(index)            \
    dMYGTEST_REGISTRY(                   \
        dMYGTEST_DECLARATE_TYPE(index),  \
        dMYGTEST_DECLARATE_NAME(),       \
        dMYGTEST_DECLARATE_METHOD(index) \
    )

#define _TEST_COMPONENT(index) \
    dREGISTER_DISABLED_UNIT_TEST(dMYGTEST_DISABLED_TYPE(index))

//==============================================================================
//==============================================================================
#endif // dMYGTEST_EXTENSION_USED_
