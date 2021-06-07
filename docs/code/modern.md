[M]: #main  "головной файл модуля"
[P]: ../icons/progress.png
[S]: ../icons/success.png
[F]: ../icons/failed.png
[D]: ../icons/danger.png
[E]: ../icons/empty.png
[B]: ../icons/bug.png
[N]: ../icons/na.png

<a name="main"></a>
[![P]][M] modern v0.0.1
==========================
Стиль "модерн" похож на файловый путь.  
Имя теста состоит из нескольких слов, разделенных слэшом.  

Пример:  

```
#include <mygtest/modern.hpp>

#define dTEST_COMPONENT example, additional
#define dTEST_METHOD method
#define dTEST_TAG tdd

TEST_COMPONENT(000)
{
    ASSERT_DEATH_DEBUG(foo());
}
```

Вывод в консоль:  
```
[==========] Running 10 tests from 4 test suites.
[----------] Global test environment set-up.
[----------] 4 tests from tools
[----------] 3 tests from example/additional
[ RUN      ] example/additional.method_000(tdd)
[       OK ] example/additional.method_000(tdd) (7 ms)
```


dTEST_COMPONENT
--------------- 
Через запятаю указываем до пяти (включительно) имен.  
Имена будут отображены в виде файлого пути.  


dTEST_METHOD
------------
Указываем имя метода, который нужно протестировать.


dTEST_TAG
---------

Тэг, который нужно указать в скобках.  
Как правило здесь указывается `char` или `wchar_t`,  
и тп. аспекты тестируемой ситуации.  

<br/>

--------------------------------------------------------------------------------

История изменений 
-----------------

| **ID** | версия          |     дата      |  время   |   ветка    | status  |  
|:------:|:---------------:|:-------------:|:--------:|:----------:|:-------:|  
|  0005  | 0.0.1 [![S]][M] | 2021y-06m-07d | 21:50:00 | [#7-table] | DONE    |  
|  0004  | 0.0.1 [![E]][M] | 2021y-06m-07d | 12:00:00 | [#7-table] | BEGIN   |  
|  0003  | 0.0.1 [![S]][M] | 2021y-06m-06d | 21:50:00 | [#5-table] | DONE    |  
|  0002  | 0.0.1 [![E]][M] | 2021y-06m-06d | 12:00:00 | [#5-table] | BEGIN   |  
|  0001  | 0.0.1 [![S]][M] | 2021y-06m-05d | 20:40:00 | [#3-impl]  | DONE    |  
|  0000  | 0.0.1 [![E]][M] | 2021y-06m-05d | 12:10:00 | [#3-impl]  | BEGIN   |  

--------------------------------------------------------------------------------
[#5-table]: ../history.md/#v001
[#3-impl]:  ../history.md/#v001





