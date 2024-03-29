// [2021y-06m-08d][15:00:00] Idrisov Denis R. 001
// [2021y-06m-05d][12:10:00] Idrisov Denis R. 001    
// [2021y-02m-05d][20:06:30] Idrisov Denis R.
#include <mygtest/test-list.hpp>
//==============================================================================
//==============================================================================

#ifdef TEST_CLASSIC

#define TEST_CASE_NAME tools
#define TEST_NUMBER(n) classic_##n

#include <stdexcept>
#include <cassert>

namespace tools {} // namespace tools 
namespace me = ::TEST_CASE_NAME;
//==============================================================================
//=== TDD ======================================================================
namespace
{
    template <class callable> 
    void death_test(callable& call)
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
  
}//namespace
//==============================================================================
//==============================================================================

TEST(TEST_CASE_NAME, TEST_NUMBER(000))
{
    ASSERT_DEATH_DEBUG(foo());
}

TEST(TEST_CASE_NAME, TEST_NUMBER(001))
{
    death_test(foo);
}
TEST_COMPONENT(002)
{
    ASSERT_DEATH_DEBUG(foo());
}
TEST_COMPONENT(003)
{
    death_test(foo);
}

_TEST_COMPONENT(004)
{
    // --- check compile
}

#endif // !TEST_CLASSIC


