// --- local/mygtest                                                 [synch.cpp]
// [2023-08-05][19:00:00] 006 Kartonagnick PRE
//   --- Katonagnick/mygtest                           [windows/synch-cpp98.cpp]
//   [2021-06-08][15:00:00] 005 Kartonagnick
//   [2021-06-05][12:10:00] 004 Kartonagnick
//   [2021-05-15][00:42:36] 003 Kartonagnick
//   [2021-02-24][??:??:??] 002 Kartonagnick
//   [2021-02-23][??:??:??] 001 Kartonagnick
//==============================================================================
//==============================================================================

#include "features.hpp"

#ifndef dMYGTEST_HAS_ATOMIC                                   // [msvc2012: new]

#ifdef _WIN32
    #define NOMINMAX 1
    #define WIN32_LEAN_AND_MEAN
    #include <windows.h> 
#else
     #error: only windows supported
#endif

#include "synch.hpp"
#include <cassert>
#include <new>

//==============================================================================
//==============================================================================

static ::CRITICAL_SECTION* cast(char* storage) noexcept
{
    assert(storage);
    return reinterpret_cast<::CRITICAL_SECTION*>(storage);
}

//==============================================================================
//==============================================================================

namespace mygtest
{
    synch::synch() noexcept
    {
        dMYGTEST_STATIC_CHECK(
            INVALID_SIZE_OF_STORAGE, sizeof(::CRITICAL_SECTION) <= 40
        );

        ::CRITICAL_SECTION* ptr = new (this->m_storage.arr) ::CRITICAL_SECTION;
        assert(ptr);
        ::ZeroMemory(ptr, sizeof(::CRITICAL_SECTION)); 
        ::InitializeCriticalSection(ptr);
    }

    synch::~synch() 
    {
        ::CRITICAL_SECTION* ptr = cast(this->m_storage.arr);
        assert(ptr);
        ::DeleteCriticalSection(ptr);
    }

    void synch::lock() noexcept
    {
        ::CRITICAL_SECTION* ptr = cast(this->m_storage.arr);
        assert(ptr);
        ::EnterCriticalSection(ptr);
    }

    void synch::unlock() noexcept 
    {
        ::CRITICAL_SECTION* ptr = cast(this->m_storage.arr);
        assert(ptr);
        ::LeaveCriticalSection(ptr);
    }

} // namespace mygtest

//==============================================================================
//==============================================================================
#endif // dHAS_ATOMIC
