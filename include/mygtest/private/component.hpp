// --- local/mygtest                                             [component.hpp]
// [2023-08-05][19:00:00] 002 Kartonagnick PRE
//   --- Katonagnick/mygtest                                     [component.hpp]
//   [2021-06-08][15:00:00] 002 Kartonagnick
//   [2021-06-05][12:10:00] 001 Kartonagnick
//==============================================================================
//==============================================================================

#pragma once
#ifndef dMYGTEST_COMPONENT_USED_
#define dMYGTEST_COMPONENT_USED_ 2

#if defined(__GNUC__)
    #pragma GCC system_header
#endif

#ifdef STABLE_RELEASE
    #define dDISABLE_DPRINT 1
#endif

#ifdef dDISABLE_DPRINT
    #define dprint(message) void()
#else
    #include "dprint.hpp"
#endif 

//==============================================================================
//==============================================================================

#ifdef NDEBUG
    // release
    #define ASSERT_DEATH_DEBUG(...) void()
    #define dDEATH_TEST(...)        void()
#else
    // debug
    #define ASSERT_DEATH_DEBUG(...) \
        ASSERT_DEATH(__VA_ARGS__, ".*")

    #define dDEATH_TEST(...) \
        ASSERT_DEATH((void)(__VA_ARGS__), ".*")
#endif

#undef  TEST_COMPONENT
#undef _TEST_COMPONENT

#define TEST_COMPONENT(n)   \
    TEST(TEST_CASE_NAME, TEST_NUMBER(n))
#define _TEST_COMPONENT(n)  \
   _TEST(TEST_CASE_NAME, TEST_NUMBER(n))

#define dCLASSNAME(a, b) a##_##b##_test

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
    if(!testing::stress)                                \
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
#endif // dMYGTEST_COMPONENT_USED_
