// --- local/mygtest                                                  [main.cpp]
// [2023-08-05][19:00:00] 001 Kartonagnick    
// [2023-07-23][17:50:00] birthday of the project  
//==============================================================================
//==============================================================================

#include <mygtest/main.hpp>

GTEST_API_ int main(int argc, char** argv)
{
    // example settings:
    //   test.ext --gtest_filter=tools.stopwatch* --stress
    //   testing::GTEST_FLAG(filter) = "tools.stopwatch_*";
    return ::testing::run(argc, argv);
}

//==============================================================================
//==============================================================================
