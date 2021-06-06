[![logo](docs/logo.png)](docs/home.md "for developers")  

Google test framework extension  
Расширение для фреймворка Google Test  
=====================================  

Проект представляет собой расширение для [gtest](https://github.com/google/googletest).  
Повзляет задавать тестам сложные имена в стиле "модерн".  
Стиль "модерн" похож на файловый путь.  
Имя теста состоит из нескольких слов, разделенных слэшом.  

Классика:  

```
#include <mygtest/test-list.hpp>
#ifdef TEST_CLASSIC

#define TEST_CASE_NAME Class
#define TEST_NUMBER(n) Method_##n

#icnlude <cassert>

void foo()
{
    assert(false);
}

TEST_COMPONENT(000)
{
    ASSERT_DEATH_DEBUG(foo());
}

#endif TEST_CLASSIC
```

Вывод в консоль:  

```
[==========] Running 1 test from 1 test suite.
[----------] Global test environment set-up.
[----------] 1 test from tools
[ RUN      ] Class.Method_000
[       OK ] Class.Method_000 (22 ms)
```

В классической схеме имя теста складывается из двух компонентов:  
  - имя тестового набора  
  - идентификатор тестируемой ситуации  

В примере выше итоговое имя теста получилось: `Class.Method_000`  

Но на практике двух компонентов часто бываает недостаточно.  
Например, у нас есть несколько классов с одинаковыми именами, но с различными `namespace`.  
И вот, чтобы было понятно к какому именно классу относится тот или иной тест,  
хочется включить `namespace` класса в название теста.  
Для этой цели и было разработанно расширение `mygtest`.  
Расширение позволяет использовать стиль `модерн`  

Модерн:  

```
#include <mygtest/modern.hpp>
#ifdef TEST_MODERN

#define dTEST_COMPONENT Namespace, Class
#define dTEST_METHOD Method
#define dTEST_TAG tdd

#icnlude <cassert>

void foo()
{
    assert(false);
}

TEST_COMPONENT(000)
{
    ASSERT_DEATH_DEBUG(foo());
}

#endif TEST_MODERN
```

Вывод в консоль:  

```
[==========] Running 1 test from 1 test suite.
[----------] Global test environment set-up.
[----------] 1 test from example\additional
[ RUN      ] Namespace\Class.Method_000(tdd)
[       OK ] Namespace\Class.Method_000(tdd) (0 ms)
[----------] 1 test from Namespace\Class (0 ms total)
```

Данное расширение позволяет:  
  - через запятую указать до пяти (включительно) имен.  
  - указатель тестируемый метод.  
  - указать тэг (аспект тестируемой ситуации).  


Модуль build_info
-----------------
В своём составе `mygtest` имеет субмодуль `build_info`  
`build_info` печатает в лог компиляции информацию о сборке.  


Пример использования:  

```
// pch.hpp
#define dPCH_USED 1                      
#include <mygtest/build_info/view.hpp>
#include <mygtest/mygtest.ver>
dVIEW_BUILD("[mygtest]", dMYGTEST)
```

Вывод в консоль:  

```
2>__cplusplus: 201703L
2>c++11: enabled
2>c++14: enabled
2>c++17: enabled
2>_MSC_FULL_VER ..... 192829915
2>_MSVC_LANG ........ 201703L
2>_MSC_EXTENSIONS ... enabled
2>msvc2019: 16.9.5 (6)
2>[mygtest] enabled -> pch
2>[mygtest] UNSTABLE-DEBUG
2>[mygtest] MTd (debug-static runtime c++)
2>[mygtest] 2.0.6, x64-debug-MTd, unstable
```

----------------------------------------------

1) [Документация](docs/table.md)  
2) [История](docs/history.md)  


