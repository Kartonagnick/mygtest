@echo off & call :checkParent
if errorlevel 1 (exit /b 1)
rem ============================================================================
rem ============================================================================
:main
  setlocal

  set "order=%~1"
  if not defined order (set "order=all")

  @echo.
  @echo [CLEAN-STAGE] -----------------------------------[%order%]---
  if "%order%" == "artifact" (goto :cleanArtifact)

  call "%eDIR_BAT_ENGINE%\run.bat" ^
    "--clean"                      ^
    "--configurations: %order%" 
  if errorlevel 1 (goto :failed)

:success
  @echo [CLEAN-STAGE] completed successfully
exit /b 0

:failed
  @echo [CLEAN-STAGE] finished with erros
exit /b 1

:cleanArtifact
  if not exist "%eDIR_ARTIFACT%" (exit /b)
  @echo   clean: artifacts...
  rmdir /s /q "%eDIR_ARTIFACT%" >nul 2>nul
exit /b

rem ============================================================================
rem ============================================================================

:checkParent
  if errorlevel 1 (@echo [ERROR] was broken at launch & exit /b 1)
  if defined eDIR_OWNER (exit /b)
  call "%~dp002-init.bat"
exit /b

rem ============================================================================
rem ============================================================================
