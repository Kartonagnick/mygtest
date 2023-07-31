// --- local/mygtest                                               [mygtest.cpp]
// [2023-08-05][19:00:00] 003 Kartonagnick PRE
//   --- Katonagnick/mygtest                                       [mygtest.cpp]
//   [2021-06-08][15:00:00] 003 Kartonagnick
//   [2021-06-05][12:10:00] 002 Kartonagnick
//   [2021-0m-15][00:42:36] 001 Kartonagnick
//==============================================================================
//==============================================================================

#include <cassert>
#include <cstring>
#include "features.hpp"

//==============================================================================
//==============================================================================

namespace testing
{
    bool stress   = false;
    bool generate = false;

    void SetGlobalVariable(int argi, char** argv) noexcept
    {
        assert(argv);
        assert(argi >= 0);
        const size_t argc = static_cast<size_t>(argi);

        for(size_t i = 0; i != argc; ++i)
        {
            size_t x = 0;
            const char* const arg = argv[i];

            if(!arg)
                goto next;

            while(arg[x] == ' ' || arg[x] == '-')
                if(arg[++x] == 0)
                    goto next;

            if(::strcmp(arg + x, "stress") == 0)
                ::testing::stress = true;

            if(::strcmp(arg + x, "generate") == 0)
                ::testing::generate = true;
        next:
            void();
        }
    }

} // namespace testing

//==============================================================================
//==============================================================================
