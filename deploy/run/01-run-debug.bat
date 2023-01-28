@echo off & cls & @echo. & @echo.
@chcp 1251 > nul
@echo [START] please wait...
set "eDEBUG=ON"
set "eTRACE=ON"
call "%~dp001-run.bat" > "%~dp0log.txt" 2>&1
@echo [DONE]

rem ============================================================================
rem ============================================================================
