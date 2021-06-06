[M]: #main  "головной файл модуля"
[P]: ../icons/progress.png
[S]: ../icons/success.png
[F]: ../icons/failed.png
[D]: ../icons/danger.png
[E]: ../icons/empty.png
[B]: ../icons/bug.png
[N]: ../icons/na.png

<a name="main"></a>
[![P]][M] dprint v0.0.1
=======================
Служит для потоко-безопасного вывода данных в `std::cout`
Пример:  

```
#include <mygtest/modern.hpp>

#define dTEST_COMPONENT example, additional
#define dTEST_METHOD method
#define dTEST_TAG tdd

TEST_COMPONENT(000)
{
    dprint(std::cout << "sample\n");
}
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





