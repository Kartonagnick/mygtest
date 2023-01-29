// [2021y-06m-08d][15:00:00] Idrisov Denis R. 001
// [2021y-06m-05d][12:10:00] Idrisov Denis R. 001    
//------------------------------------------------------------------------------
// [2021y-05m-15d][00:42:36] Idrisov Denis R.

#include <cassert>
#include <cstring>
#include <mygtest/private/features.hpp>
//==============================================================================
//==============================================================================

namespace testing
{
    bool stress   = false;
    bool generate = false;

    void SetGlobalVariable(int argi, char** argv) dNOEXCEPT
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
