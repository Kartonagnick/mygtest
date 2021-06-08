// [2021y-06m-08d][15:00:00] Idrisov Denis R. 001
// [2021y-06m-05d][12:10:00] Idrisov Denis R. 001 PRE
#pragma once
#ifndef dMYGTEST_SYNCH_USED_ 
#define dMYGTEST_SYNCH_USED_ 001
//==============================================================================
//==============================================================================

#include <mygtest/private/features.hpp>

#ifdef dHAS_ATOMIC

#include <mutex>

namespace mygtest
{
    class synch
    {
        ::std::recursive_mutex m_mutex;
    public:
        dNOCOPYABLE(synch);

        synch() dNOEXCEPT : m_mutex() {}

        void lock() dNOEXCEPT
        {
            this->m_mutex.lock();
        }
        void unlock() dNOEXCEPT
        {
            this->m_mutex.unlock();
        }
    };

} // namespace mygtest

#else

// --- old compiler
namespace mygtest
{
    class synch
    {
        typedef char arr_t[40];
        union storage
        {
            void* ptr;
            arr_t arr;
        };
        storage m_storage;
    public:
        dNOCOPYABLE(synch);

        ~synch();
        synch() dNOEXCEPT;

        void lock()   dNOEXCEPT;
        void unlock() dNOEXCEPT;
    };

} // namespace mygtest

#endif

//==============================================================================
//==============================================================================

namespace mygtest
{
    class synch_guard
    {
        synch& ref;
    public:
        dNOCOPYABLE(synch_guard);

        synch_guard(synch& s) dNOEXCEPT 
            : ref(s)
        {
            ref.lock();
        }
        ~synch_guard() dNOEXCEPT
        {
            ref.unlock();
        }
    };

} // namespace mygtest

//==============================================================================
//==============================================================================
#endif // !dMYGTEST_SYNCH_USED_