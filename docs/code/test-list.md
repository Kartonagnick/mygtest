[M]: #main  "головной файл модуля"
[P]: ../icons/progress.png
[S]: ../icons/success.png
[F]: ../icons/failed.png
[D]: ../icons/danger.png
[E]: ../icons/empty.png
[B]: ../icons/bug.png
[N]: ../icons/na.png

<a name="main"></a>
[![P]][M] test-list v0.0.1
==========================
Классический стиль: итоговое имя юнит-теста состоит из двух компонентов:  
  - имя тестового набора  
  - имя тестового кейса  

Пример:  

```
#include <mygtest/test-list.hpp>

#define TEST_CASE_NAME tools
#define TEST_NUMBER(n) classic_##n

TEST(TEST_CASE_NAME, TEST_NUMBER(000))
{
    ASSERT_DEATH_DEBUG(foo());
}
```

Вывод в консоль:  
```
[==========] Running 10 tests from 4 test suites.
[----------] Global test environment set-up.
[----------] 4 tests from tools
[ RUN      ] tools.classic_000
[       OK ] tools.classic_000 (8 ms)
[----------] 4 tests from tools (29 ms total)
```

<br/>

--------------------------------------------------------------------------------

История изменений 
-----------------

| **ID** | версия          |     дата      |  время   |   ветка    | status  |  
|:------:|:---------------:|:-------------:|:--------:|:----------:|:-------:|  
|  0003  | 0.0.1 [![S]][M] | 2021y-06m-06d | 21:50:00 | [#5-table] | DONE    |  
|  0002  | 0.0.1 [![E]][M] | 2021y-06m-06d | 12:00:00 | [#5-table] | BEGIN   |  
|  0001  | 0.0.1 [![S]][M] | 2021y-06m-05d | 20:40:00 | [#3-impl]  | DONE    |  
|  0000  | 0.0.1 [![E]][M] | 2021y-06m-05d | 12:10:00 | [#3-impl]  | BEGIN   |  

--------------------------------------------------------------------------------
[#5-table]: ../history.md/#v001
[#3-impl]:  ../history.md/#v001





