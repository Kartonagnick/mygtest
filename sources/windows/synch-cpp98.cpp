// [2021y-06m-05d][12:10:00] Idrisov Denis R. 001 PRE
// --------------------------------------------------
// [2021y-05m-15d][00:42:36] Idrisov Denis R.
// [2021y-02m-24d] Idrisov Denis R.
// [2021y-02m-23d] Idrisov Denis R.

#include <mygtest/private/features.hpp>

#ifndef dHAS_ATOMIC
// #pragma message("build for msvc2012 (or newer) or other compiler")

//==============================================================================
//=== windows ==================================================================

#ifndef _WIN32_WINNT
    #define _WIN32_WINNT 0x0502
#endif

#ifdef _WIN32
    #define NOMINMAX 1
    #define WIN32_LEAN_AND_MEAN
    #include <windows.h> 
#else
     #error: only windows supported
#endif

//==============================================================================
//=== assert ===================================================================

#ifdef NDEBUG
    #define dASSERT(...)
#else
    #include <cassert>
    #define dASSERT(...) assert((__VA_ARGS__))
#endif

//==============================================================================
//==============================================================================

#include "../synch.hpp"
#include <new>

//==============================================================================
//==============================================================================

namespace
{
    ::CRITICAL_SECTION* cast(char* storage)
    {
        dASSERT(storage);
        return reinterpret_cast<::CRITICAL_SECTION*>(storage);
    }

} // namespace

//==============================================================================
//==============================================================================

namespace mygtest
{
    synch::synch() dNOEXCEPT
    {
        dSTATIC_CHECK(
            INVALID_SIZE_OF_STORAGE,
            sizeof(::CRITICAL_SECTION) <= 40
        );

        new (this->m_storage.arr) ::CRITICAL_SECTION;
        ::CRITICAL_SECTION* ptr = cast(this->m_storage.arr);
        dASSERT(ptr);

        ZeroMemory(ptr, sizeof(::CRITICAL_SECTION)); 
        ::InitializeCriticalSection(ptr);
    }

    synch::~synch() 
    {
        ::CRITICAL_SECTION* ptr = cast(this->m_storage.arr);
        dASSERT(ptr);
        ::DeleteCriticalSection(ptr);
    }

    void synch::lock() dNOEXCEPT
    {
        ::CRITICAL_SECTION* ptr = cast(this->m_storage.arr);
        dASSERT(ptr);
        ::EnterCriticalSection(ptr);
    }

    void synch::unlock() dNOEXCEPT 
    {
        ::CRITICAL_SECTION* ptr = cast(this->m_storage.arr);
        dASSERT(ptr);
        ::LeaveCriticalSection(ptr);
    }

} // namespace mygtest

//==============================================================================
//==============================================================================
#endif // dHAS_ATOMIC