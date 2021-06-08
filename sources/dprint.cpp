// [2021y-06m-08d][15:00:00] Idrisov Denis R. 001
// [2021y-06m-05d][12:10:00] Idrisov Denis R. 001 PRE
//==============================================================================
//==============================================================================

#ifndef dDISABLE_DPRINT

#include <mygtest\private\features.hpp>

struct mygtest_mutex
{
    mygtest_mutex();
   ~mygtest_mutex();
};

#ifdef dHAS_ATOMIC

    #include <mutex>

    static ::std::recursive_mutex& get_mygtest_mutex()
    {
        static ::std::recursive_mutex mut;
        return mut;
    }

    mygtest_mutex::mygtest_mutex()
    {
        get_mygtest_mutex().lock();
    }

    mygtest_mutex::~mygtest_mutex()
    {
        get_mygtest_mutex().unlock();
    }

#else

//==============================================================================
//==============================================================================

    #include "synch.hpp"

    static ::mygtest::synch& get_mygtest_mutex()
    {
        static ::mygtest::synch mut;
        return mut;
    }

    mygtest_mutex::mygtest_mutex()
    {
        get_mygtest_mutex().lock();
    }

    mygtest_mutex::~mygtest_mutex()
    {
        get_mygtest_mutex().unlock();
    }

#endif // !dHAS_ATOMIC

//==============================================================================
//==============================================================================

#endif // !dDISABLE_DPRINT

