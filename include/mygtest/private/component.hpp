// [2021y-06m-05d][12:10:00] Idrisov Denis R. 001 PRE
#pragma once
#ifndef dMYGTEST_COMPONENT_USED_
#define dMYGTEST_COMPONENT_USED_ 001 PRE

#if defined(__GNUC__)
    #pragma GCC system_header
#endif

#undef  TEST_COMPONENT
#undef _TEST_COMPONENT

//==============================================================================
//=== diagnostic`s messages ====================================================

#ifdef STABLE_RELEASE
    #define dDISABLE_DPRINT 1
#endif

#ifdef dDISABLE_DPRINT
    #define dprint(message) \
        void()
#else
    #include <mygtest/private/dprint.hpp>

#endif // dDISABLE_DPRINT

//==============================================================================
//==============================================================================

#ifdef NDEBUG
    // release
    #define ASSERT_DEATH_DEBUG(...) \
        void()

    #define dDEATH_TEST(...) \
        void()
#else
    // debug
    #define ASSERT_DEATH_DEBUG(...) \
        ASSERT_DEATH(__VA_ARGS__, ".*")

    #define dDEATH_TEST(...) \
        ASSERT_DEATH((void)(__VA_ARGS__), ".*")
#endif

#define TEST_COMPONENT(n)   \
    TEST(TEST_CASE_NAME, TEST_NUMBER(n))

#define _TEST_COMPONENT(n)  \
   _TEST(TEST_CASE_NAME, TEST_NUMBER(n))

#define dCLASSNAME(a, b) a##b##_test

#define _TEST(a, b)         \
    struct dCLASSNAME(a, b) \
    {                       \
        void TestBody();    \
    };                      \
    void dCLASSNAME(a, b)::TestBody()

//==============================================================================
//==============================================================================

namespace testing
{
    extern bool stress;
    extern bool generate;

} // namespace testing 

//==============================================================================
//==============================================================================

#define SKIP_STRESS_TEST                                \
    if(testing::stress)                                 \
    {                                                   \
        dprint(::std::cout << "skip stress-test...\n"); \
        return;                                         \
    } void() 

#define SKIP_TEST_GENERATOR                                  \
    if(!testing::generate)                                   \
    {                                                        \
        dprint(::std::cout << "skip test`s generator...\n"); \
        return;                                              \
    } void() 

//==============================================================================
//==============================================================================
#endif // !dMYGTEST_COMPONENT_USED_
