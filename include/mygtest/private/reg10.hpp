// [2021y-06m-05d][12:10:00] Idrisov Denis R. 001 PRE
#pragma once
#ifndef dMYGTEST_REG10_USED_ 
#define dMYGTEST_REG10_USED_ 001 PRE

#include <mygtest/private/features.hpp>

//==============================================================================
//=== dREGISTER_UNIT_TEST ======================================================
#define dGTEST_IN  ::testing::internal
#define dRESOLVER  dGTEST_IN::SuiteApiResolver<::testing::Test>

#define dREGISTER_UNIT_TEST(Class, TestName, SubtestName)      \
    struct Class : public ::testing::Test                      \
    {                                                          \
        Class() {}                                             \
    private:                                                   \
        virtual void TestBody();                               \
        static ::testing::TestInfo* const test_info_;          \
        dNOCOPYABLE(Class);                                    \
    };                                                         \
    ::testing::TestInfo* const Class::test_info_ =             \
    ::testing::internal::MakeAndRegisterTestInfo(              \
        #TestName,                                             \
        #SubtestName,                                          \
        nullptr,                                               \
        nullptr,                                               \
        dGTEST_IN::CodeLocation(__FILE__, __LINE__),           \
        dGTEST_IN::GetTestTypeId(),                            \
        dRESOLVER::GetSetUpCaseOrSuite(__FILE__, __LINE__),    \
        dRESOLVER::GetTearDownCaseOrSuite(__FILE__, __LINE__), \
        new dGTEST_IN::TestFactoryImpl<Class>                  \
    );                                                         \
    void Class::TestBody()

#define dREGISTER_DISABLED_UNIT_TEST(Class, TestName, SubtestName) \
    struct Class         \
    {                    \
        void TestBody(); \
    };                   \
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
#endif // !dMYGTEST_REG10_USED_