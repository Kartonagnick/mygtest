// [2021y-06m-05d][12:10:00] Idrisov Denis R. 001 PRE
#pragma once
#ifndef dMYGTEST_EXTENSION_USED_ 
#define dMYGTEST_EXTENSION_USED_ 001

//==============================================================================
//==============================================================================

#undef  TEST_COMPONENT
#undef _TEST_COMPONENT

//==============================================================================
//==============================================================================

#define dEXTRA(...) __VA_ARGS__
#define dEXPAND(...) dEXTRA(__VA_ARGS__)

//==============================================================================
//=== dREGISTER_UNIT_TEST ======================================================

#ifdef GTEST_MAYBE_5046_
    // dMESSAGE("mygtest: used 'google test 1.0.x'")
    #include <mygtest/private/reg10.hpp>
#else
    // dMESSAGE("mygtest: used 'google test 0.8.x'")
    #include <mygtest/private/reg08.hpp>
#endif

//==============================================================================
//=== TEST_COMPONENT ===========================================================
#include <mygtest/private/macro/overload-7.hpp>

#define dUNIT_TEST_CLASS_0()                           unittest_
#define dUNIT_TEST_CLASS_1(a1)                         unittest_##a1
#define dUNIT_TEST_CLASS_2(a1, a2)                     unittest_##a1##_##a2
#define dUNIT_TEST_CLASS_3(a1, a2, a3)                 unittest_##a1##_##a2##_##a3
#define dUNIT_TEST_CLASS_4(a1, a2, a3, a4)             unittest_##a1##_##a2##_##a3##_##a4
#define dUNIT_TEST_CLASS_5(a1, a2, a3, a4, a5)         unittest_##a1##_##a2##_##a3##_##a4##_##a5
#define dUNIT_TEST_CLASS_6(a1, a2, a3, a4, a5, a6)     unittest_##a1##_##a2##_##a3##_##a4##_##a5##_##a6
#define dUNIT_TEST_CLASS_7(a1, a2, a3, a4, a5, a6, a7) unittest_##a1##_##a2##_##a3##_##a4##_##a5##_##a6##_##a7

#define dUNIT_TEST_NAME_0() invalid_component_name
#define dUNIT_TEST_NAME_1(a1) a1
#define dUNIT_TEST_NAME_2(a1, a2) a1/a2
#define dUNIT_TEST_NAME_3(a1, a2, a3) a1/a2/a3
#define dUNIT_TEST_NAME_4(a1, a2, a3, a4) a1/a2/a3/a4
#define dUNIT_TEST_NAME_5(a1, a2, a3, a4, a5) a1/a2/a3/a4/a5
#define dUNIT_TEST_NAME_6(a1, a2, a3, a4, a5, a6) a1/a2/a3/a4/a5/a6
#define dUNIT_TEST_NAME_7(a1, a2, a3, a4, a5, a6, a7) a1/a2/a3/a4/a5/a6/a7

#define dUNIT_TEST_CLASS(...) \
    dMACRO_CHOOSER_7(dUNIT_TEST_CLASS, __VA_ARGS__)(__VA_ARGS__)

#define dUNIT_TEST_NAME(...) \
    dMACRO_CHOOSER_7(dUNIT_TEST_NAME, __VA_ARGS__)(__VA_ARGS__)

#define dUNIT_TEST_EX(classN, testN, methodN) \
    dREGISTER_UNIT_TEST(classN, testN, methodN)

#define dDISABLE_UNIT_TEST_EX(classN, testN, methodN) \
    dREGISTER_DISABLED_UNIT_TEST(classN, testN, methodN)

#define dTEST_NAME_METHOD_EX(n, method, tag) \
    method##_##n(tag)

#define dTEST_NAME_METHOD(n, method, tag) \
    dTEST_NAME_METHOD_EX(n, method,tag)

#define dTEST_INDEX_EX(n, method, tag) \
    method##_##tag##_##n

#define dTEST_INDEX(n, method, tag) \
    dTEST_INDEX_EX(n, method, tag)

#define dUNIT_TEST(index)                                   \
    dUNIT_TEST_EX(                                          \
        dEXPAND(dUNIT_TEST_CLASS(                           \
            dTEST_COMPONENT,                                \
            dTEST_INDEX(index, dTEST_METHOD, dTEST_TAG)     \
        )),                                                 \
        dEXPAND(dUNIT_TEST_NAME(                            \
            dTEST_COMPONENT                                 \
        )),                                                 \
        dTEST_NAME_METHOD(index, dTEST_METHOD, dTEST_TAG)   \
    )

#define _dUNIT_TEST(index)                                  \
    dDISABLE_UNIT_TEST_EX(                                  \
        dEXPAND(dUNIT_TEST_CLASS(                           \
            DISABLED, dTEST_COMPONENT,                      \
            dTEST_INDEX(index, dTEST_METHOD, dTEST_TAG)     \
        )),                                                 \
        dEXPAND(dUNIT_TEST_NAME(                            \
            DISABLED, dTEST_COMPONENT                       \
        )),                                                 \
        dTEST_NAME_METHOD(index, dTEST_METHOD, dTEST_TAG)   \
    )

#define  TEST_COMPONENT(index)  dUNIT_TEST(index)
#define _TEST_COMPONENT(index) _dUNIT_TEST(index)

//==============================================================================
//==============================================================================
#endif // !dMYGTEST_EXTENSION_USED_