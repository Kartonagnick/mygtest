[M]: #main  "перегрузка макросов"
[P]: ../../../icons/progress.png
[S]: ../../../icons/success.png
[F]: ../../../icons/failed.png
[D]: ../../../icons/danger.png
[E]: ../../../icons/empty.png
[B]: ../../../icons/bug.png
[N]: ../../../icons/na.png

<a name="main"></a>
[![S]][M] overload-7 v0.0.1
===========================
Умеет определять кол-во аргументов, которое было переданно в макрос.  
И позволяет перегружать макрос под разное кол-во аргументов:  

```cpp
#include <tools/macro/overload-7.hpp>
    
// usage: 
#define dPRINT_0() \
    std::cout <<"empty\n"

#define dPRINT_1(a1) \
    std::cout << a1 << '\n'

#define dPRINT_2(a1, a2) \
    std::cout << a1 << ", " << a2 << '\n'

#define dPRINT_3(a1, a2, a3) \
    std::cout << a1 << ", " << a2 << ", " << a3 << '\n'

#define dPRINT_4(a1, a2, a3, a4) \
    std::cout << a1 << ", " << a2 << ", " << a3 << ", " << a4 << '\n'

#define dPRINT_5(a1, a2, a3, a4, a5) \
    std::cout << a1 << ", " << a2 << ", "<< a3 << ", " << a4 << ", " << a5 << '\n'

#define dPRINT_6(a1, a2, a3, a4, a5, a6) \
    std::cout << a1 << ", " << a2 << ", "<< a3 << ", " << a4 << ", " << a5 << ", " << a6 << '\n'

#define dPRINT_7(a1, a2, a3, a4, a5, a6, a7) \
    std::cout << a1 << ", " << a2 << ", "<< a3 << ", " << a4 << ", " << a5 << ", " << a6 << ", " << a7 << '\n'


#define dPRINT(...) \
    dMACRO_CHOOSER_7(dPRINT, __VA_ARGS__)(__VA_ARGS__)

#define dIF_ARG_COUNT_0(element, delim, ...) \
    dPRINT(element, delim)

#define dIF_ARG_COUNT_N(element, delim, ...) \
    dPRINT(element, delim, __VA_ARGS__)

#define dCALL_ONE_OR_MORE(element, delim, ...) \
    dNULL_OR_MORE_7(dIF_ARG_COUNT, __VA_ARGS__)(element, delim, __VA_ARGS__)

#include <iostream>
    
int main()
{
    dPRINT();
    dPRINT(1);
    dPRINT(1,2);
    dPRINT(1,2,3);
    dPRINT(1,2,3,4);
    dPRINT(1,2,3,4,5);
    dPRINT(1,2,3,4,5,6);
    dPRINT(1,2,3,4,5,6,7);
    std::cout << dGET_ARGS_COUNT_MAX_7(1, 2, 3, 4, 5) << '\n';

    dCALL_ONE_OR_MORE(1,2);
    dCALL_ONE_OR_MORE(1,2,3);
}
```

--------------------------------------------------------------------------------

История изменений 
-----------------

| **ID** | версия          |     дата      |  время   |   ветка    | status  |  
|:------:|:---------------:|:-------------:|:--------:|:----------:|:-------:|  
|  0008  | 0.0.1 [![S]][M] | 2021y-06m-08d | 15:00:00 | [#9-pre]   | RELEASE |  
|  0007  | 0.0.1 [![S]][M] | 2021y-06m-08d | 14:50:00 | [#9-pre]   | DONE    |  
|  0006  | 0.0.1 [![E]][M] | 2021y-06m-08d | 12:00:00 | [#9-pre]   | BEGIN   |  
|  0003  | 0.0.1 [![S]][M] | 2021y-06m-06d | 21:50:00 | [#5-table] | DONE    |  
|  0002  | 0.0.1 [![E]][M] | 2021y-06m-06d | 12:00:00 | [#5-table] | BEGIN   |  
|  0001  | 0.0.1 [![S]][M] | 2021y-06m-05d | 20:40:00 | [#3-impl]  | DONE    |  
|  0000  | 0.0.1 [![E]][M] | 2021y-06m-05d | 12:10:00 | [#3-impl]  | BEGIN   |  

--------------------------------------------------------------------------------
[#7-table]: ../../../history.md/#v001
[#5-table]: ../../../history.md/#v001
[#3-impl]:  ../../../history.md/#v001
