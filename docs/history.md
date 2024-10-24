[H]: ../README.md  "на главную"
[R]: icons/release.png
[V]: icons/version.png
[P]: icons/progress.png
[S]: icons/success.png
[B]: icons/bug.png

[![S]][H] **История изменений**  
--------------------------------------------------------------------------------

23 июля 2023, 20:00:00. Регистрация в [локальном хранилище][LO]  
23 июля 2023, 17:50:00. Создание второй реинкарнации `mygtest`  
   - проект переезжает в [local]  
   - рефактор дизайна репозитория  
   - зеркало для [Github]

4 июня 2021, 23:05:00. Проект был зарегистрированн на [Github]  
4 июня 2021, 22:59:48. [Картонажник] основал проект `mygtest`  
  - разработка методологии работы с юнит-тестами  
    с использованием [GTest]  

|    дата    |  время   |        событие        |  
|:----------:|:--------:|:---------------------:|  
| 2023-07-23 | 20:00:00 | регистрации git-local |  
| 2023-07-23 | 17:50:00 | вторая реинкарнация   |  
| 2021-06-04 | 23:05:00 | регистрация на github |  
| 2021-06-04 | 22:59:48 | дата рождения проекта |  

[GTest]: https://github.com/google/googletest
[Картонажник]: https://github.com/Kartonagnick
[Github]:      https://github.com/Kartonagnick/mygtest
[local]:       D:/local/mygtest/README.md
[LO]:          D:/local/mygtest/README.md


[![S]][H] **v0.0.2 (dev)**
--------------------------------------------------------------------------------
[![V]][VE002] [![2023-08-05 19:00:00]][VE002]  

[2023-07-23 21:50:00]: https://img.shields.io/static/v1?label=2024-07-23&message=21:50:00&color=yellowgreen
[VE002]: changelog.md#-v002-dev

|    дата    |  время   |     ветка      | статус |  
|:----------:|:--------:|:--------------:|:------:|  
| 2023-07-31 | 18:50:00 | [#2-dev-frame] | DONE   |  
| 2023-07-31 | 11:00:00 | [#2-dev-frame] | BEGIN  |  

1. upd: `docs`  
   - upd: `logo.png`          002  
   - upd: `changelog.md`      002  
   - upd: `history.md`        002  
   - upd: `chrono.md`         002  
   - upd: `docs.md`           002  
2. add: `docs/yed`  
   - add: `design.graphml`  
   - add: `design.jpg`  
   - add: `screen.jpg`  
3. add: `deploy`  
   - add: `ver.bat`           001  
   - add: `make-debug.bat`    001  
   - add: `make.bat`          001  
   - add: `run-IDE.bat`       001  
   - add: `compilers.bat`     001  
4. add: `deploy/cmake`  
   - add: `setup.cmake`       007  
   - add: `CMakeLists.txt`    001  
5. add: `include/mygtest`  
   - add: `mygtest.ver`       004  
   - add: `mygtest.hpp`       002  
   - add: `modern.hpp`        002  
   - add: `main.hpp`          003  
   - add: `test-list.hpp`     003  
6. add: `include/mygtest/private`  
   - add: `component.hpp`     002  
   - add: `extension.hpp`     003  
   - add: `noexcept.hpp`      001  
   - add: `macro7.hpp`        004  
   - add: `reg10.hpp`         003  
   - add: `reg08.hpp`         003  
   - add: `dprint.hpp`        002  
7. add: `sources`  
   - add: `features.hpp`      002  
   - add: `mygtest.cpp`       003  
   - add: `dprint.cpp`        003  
   - add: `synch.hpp`         002  
   - add: `synch.cpp`         006  
   - add: `pch.hpp`           005  
8. add: `test/include`  
   - add: `test-develop.hpp`  003  
   - add: `test-stable.hpp`   003  
9. add: `test/sources`  
   - add: `test-origin.cpp`   001  
   - add: `test-classic.cpp`  003  
   - add: `test-modern.cpp`   003  
   - add: `main.cpp`          001  
   - add: `pch.hpp`           001  
10. upd: `project.root`       002  
11. fix: `README.md`  

[#2-dev-frame]: tasks/2023-07-31-0002-dev-frame.md
<div/>


[![S]][H] **v0.0.1 (rep)**
--------------------------------------------------------------------------------
[![V]][VE001] [![2023-07-23 21:50]][VE001]  

[2023-07-23 21:50]: https://img.shields.io/static/v1?label=2024-07-23&message=21:50&color=yellowgreen
[VE001]: changelog.md#-v001-rep

|    дата    | время |     ветка      | статус |  
|:----------:|:-----:|:--------------:|:------:|  
| 2023-07-23 | 21:40 | [#1-rep-first] | DONE   |  
| 2023-07-23 | 21:20 | [#1-rep-first] | BEGIN  |  

1. add: `docs`  
   - add: `logo.png`       001  
   - add: `changelog.md`   001  
   - add: `chrono.md`      001  
   - add: `history.md`     001  
   - add: `docs.md`        001  
   - add: `icons` ...      002  
2. add: `docs/other`  
   - add: `calendar.md`  
3. add: `.gitignore`       001  
4. add: `project.root`     001  
5. fix: `README.md`  

[#1-rep-first]: tasks/2023-07-23-0001-rep-first.md
<div/>
