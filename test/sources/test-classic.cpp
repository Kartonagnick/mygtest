// --- local/mygtest                                          [test-classic.cpp]
// [2023-08-05][19:00:00] 003 Kartonagnick    
//   --- Katonagnick/mygtest                                  [test-classic.cpp]
//   [2021-06-08][15:00:00] 003 Kartonagnick
//   [2021-06-05][12:10:00] 002 Kartonagnick
//   [2021-02-05][20:06:30] 001 Kartonagnick
//==============================================================================
//==============================================================================

#include <mygtest/test-list.hpp>

#ifdef TEST_CLASSIC

#define TEST_CASE_NAME tools
#define TEST_NUMBER(n) classic_##n

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

//==============================================================================
//==============================================================================
#endif // TEST_CLASSIC


