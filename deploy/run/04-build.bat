@echo off & call :checkParent
if errorlevel 1 (exit /b 1)
rem ============================================================================
rem ============================================================================
:main
  setlocal

  set "order=%~1"
  if not defined order (set "order=msvc2019:64:debug:dynamic")

  @echo.
  @echo [BUILD-STAGE] -----------------------------------[%order%]---

  ::set "eDEBUG=ON"
  ::set "eTRACE=ON"

  call "%eDIR_BAT_ENGINE%\run.bat" ^
    "--build: cmake-makefiles"     ^
    "--configurations: %order%"    ^
    "--defines: STABLE_RELEASE"    ^
    "--defines: _USE_32BIT_TIME_T"

  if errorlevel 1 (goto :failed)

:success
  @echo [BUILD-STAGE] completed successfully
exit /b 0

:failed
  @echo [BUILD-STAGE] finished with erros
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
