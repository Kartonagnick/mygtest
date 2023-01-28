@echo off & call :checkParent
if errorlevel 1 (exit /b 1)
rem ============================================================================
rem ============================================================================
:main
  setlocal

  set "order=%~1"
  if not defined order (set order=all)

  @echo.
  @echo [TEST-STAGE] ----------------------------------------[%order%]---

  call "%eDIR_BAT_ENGINE%\run.bat" ^
    "--runTests: test*.exe"        ^
    "--exclude: mingw*-dynamic"    ^
    "--configurations: %order%"

  if errorlevel 1 (goto :failed)
:success
  @echo [TEST-STAGE] completed successfully
exit /b 0

:failed
  @echo [TEST-STAGE] finished with erros
exit /b 1

rem ============================================================================
rem ============================================================================

:checkParent
  if errorlevel 1 (@echo [ERROR] was broken at launch & exit /b 1)
  if defined eDIR_OWNER (exit /b)
  call "%~dp002-init.bat"
exit /b

rem ============================================================================
rem ============================================================================
