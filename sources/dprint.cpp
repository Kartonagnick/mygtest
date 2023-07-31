// --- local/mygtest                                                [dprint.cpp]
// [2023-08-05][19:00:00] 003 Kartonagnick PRE
//   --- Katonagnick/mygtest                                        [dprint.cpp]
//   [2021-06-08][15:00:00] 003 Kartonagnick
//   [2021-06-05][12:10:00] 002 Kartonagnick
//==============================================================================
//==============================================================================

#ifndef dDISABLE_DPRINT

#include "features.hpp"

#ifdef dMYGTEST_HAS_ATOMIC                                    // [msvc2012: new]
    #include <mutex>
    static ::std::recursive_mutex& get_mygtest_mutex() noexcept
    {
        static ::std::recursive_mutex mut;
        return mut;
    }

#else                                                         // [old: msvc2010]
    #include "synch.hpp"
    static ::mygtest::synch& get_mygtest_mutex() noexcept
    {
        static ::mygtest::synch mut;
        return mut;
    }
#endif

struct mygtest_mutex
{
    mygtest_mutex();
   ~mygtest_mutex();
};

mygtest_mutex::mygtest_mutex()
{
    get_mygtest_mutex().lock();
}

mygtest_mutex::~mygtest_mutex()
{
    get_mygtest_mutex().unlock();
}

//==============================================================================
//==============================================================================
#endif // dDISABLE_DPRINT

