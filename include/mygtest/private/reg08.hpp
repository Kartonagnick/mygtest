// --- local/mygtest                                                 [reg08.hpp]
// [2023-08-05][19:00:00] 003 Kartonagnick    
//   --- Katonagnick/mygtest                                         [reg08.hpp]
//   [2021-06-08][15:00:00] 002 Kartonagnick
//   [2021-06-05][12:10:00] 001 Kartonagnick
//==============================================================================
//==============================================================================

#pragma once
#ifndef dMYGTEST_REG08_USED_ 
#define dMYGTEST_REG08_USED_ 3

#define dMYGTEST_IN  ::testing::internal

#define dREGISTER_UNIT_TEST(Class, TestName, SubtestName) \
    struct Class : public ::testing::Test                 \
    {                                                     \
        Class() {}                                        \
    private:                                              \
        virtual void TestBody();                          \
        static ::testing::TestInfo* const test_info_;     \
    };                                                    \
    ::testing::TestInfo* const Class::test_info_ =        \
      ::testing::internal::MakeAndRegisterTestInfo(       \
          #TestName,                                      \
          #SubtestName,                                   \
          static_cast<const char*>(0),                    \
          static_cast<const char*>(0),                    \
          dMYGTEST_IN::CodeLocation(__FILE__, __LINE__),  \
          dMYGTEST_IN::GetTestTypeId(),                   \
          testing::Test::SetUpTestCase,                   \
          testing::Test::TearDownTestCase,                \
          new dMYGTEST_IN::TestFactoryImpl<Class>         \
    );                                                    \
    void Class::TestBody()


#define dREGISTER_DISABLED_UNIT_TEST(Class) \
    struct Class { void TestBody(); };      \
    void Class::TestBody()

    #if 0
    // example:
    dREGISTER_UNIT_TEST(SampleTest_Method, tools/ololo/SampleTest, Method)
    {
        std::cout << "ok\n";
        auto lambda = []{ assert(false); };
        ASSERT_DEATH(lambda(), ".*");
    }
    #endif

//==============================================================================
//==============================================================================
#endif // dMYGTEST_REG08_USED_
