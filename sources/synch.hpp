// --- local/mygtest                                                 [synch.hpp]
// [2023-08-05][19:00:00] 002 Kartonagnick    
//   --- Katonagnick/mygtest                                         [synch.hpp]
//   [2021-06-08][15:00:00] 002 Kartonagnick
//   [2021-06-05][12:10:00] 001 Kartonagnick
//==============================================================================
//==============================================================================

#pragma once
#ifndef dMYGTEST_SYNCH_USED_ 
#define dMYGTEST_SYNCH_USED_ 2

#include "features.hpp"

#ifdef dHAS_ATOMIC                                            // [msvc2012: new]

#include <mutex>
namespace mygtest
{
    class synch
    {
        ::std::recursive_mutex m_mutex;
    public:
        synch() noexcept : m_mutex() {}
        void lock()   { this->m_mutex.lock();   }
        void unlock() { this->m_mutex.unlock(); }
    };

} // namespace mygtest

#else                                                         // [old: msvc2010]

namespace mygtest
{
    class synch
    {
        typedef char arr_t[40];
        union storage { void* ptr; arr_t arr; };
        storage m_storage;
    public:
       ~synch();
        synch() noexcept;
        void lock()   noexcept;
        void unlock() noexcept;
    };

} // namespace mygtest

#endif 

//==============================================================================
//==============================================================================
#endif // dMYGTEST_SYNCH_USED_
