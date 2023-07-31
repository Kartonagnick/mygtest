// --- local/mygtest                                          [test-modern.cpp]
// [2023-08-05][19:00:00] 003 Kartonagnick    
//   --- Katonagnick/mygtest                                  [test-modern.cpp]
//   [2021-06-08][15:00:00] 003 Kartonagnick
//   [2021-06-05][12:10:00] 002 Kartonagnick
//   [2021-02-05][20:06:30] 001 Kartonagnick
//==============================================================================
//==============================================================================

#include <mygtest/modern.hpp>

#ifdef TEST_MODERN

#define dTEST_COMPONENT modern, example
#define dTEST_METHOD method
#define dTEST_TAG tdd

#define TEST_CASE_NAME old_example
#define TEST_NUMBER(n) old_method_##n

#include <stdexcept>
#include <cassert>

//==============================================================================
//==============================================================================

namespace
{
    template <class callable> void death_test(callable& call)
    {
        #ifdef NDEBUG
            // release
            (void) call;
        #else
            // debug
            ASSERT_DEATH(call(), ".*");
        #endif
    }

    void foo()
    {
        assert(false);
        dprint(std::cerr << "INVALID\n");
        throw ::std::runtime_error("test");
    }
  
} // namespace

//==============================================================================
//==============================================================================

TEST(TEST_CASE_NAME, TEST_NUMBER(001))
{
    ASSERT_DEATH_DEBUG(foo());
}

TEST(TEST_CASE_NAME, TEST_NUMBER(002))
{
    death_test(foo);
}

dREGISTER_UNIT_TEST(SampleTest_Method, tools\\ololo\\SampleTest, Method)
{
    dprint(std::cout << "ok\n");
}

TEST_COMPONENT(003)
{
    ASSERT_DEATH_DEBUG(foo());
}

TEST_COMPONENT(004)
{
    death_test(foo);
}

_TEST_COMPONENT(005)
{
    // --- check compile
}

_TEST_COMPONENT(006)
{
    // --- check compile
}

TEST_COMPONENT(007)
{
    #ifdef _VARIADIC_MAX
        dprint(std::cout << "macro: " << _VARIADIC_MAX << '\n');
    #endif
}

//==============================================================================
//==============================================================================
#endif // TEST_MODERN
