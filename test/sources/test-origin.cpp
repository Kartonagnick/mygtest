// --- local/mygtest                                           [test-origin.cpp]
// [2023-08-05][19:00:00] 001 Kartonagnick PRE
//==============================================================================
//==============================================================================

#include <mygtest/test-list.hpp>

#ifdef TEST_ORIGIN

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

TEST(example, origin_001)
{
    ASSERT_DEATH_DEBUG(foo());
}

TEST(example, origin_002)
{
    death_test(foo);
}

_TEST(example, origin_003)
{
    death_test(foo);
}

_TEST(example, origin_004)
{
    death_test(foo);
}

//==============================================================================
//==============================================================================
#endif // TEST_ORIGIN


