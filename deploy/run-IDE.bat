@echo off & call :checkParent
if errorlevel 1 (exit /b 1)

rem ============================================================================
rem ============================================================================

:main
  setlocal
  call "%~dp0ver.bat"
  @echo [RUN-MSVC] run... v%eMAKE_VERSION%

::set "eDEBUG=ON"
::set "eTRACE=ON"

  set "IDE=VisualStudio"
::set "IDE=QtCreator"

  set "order=msvc2022:64:release:static"
::set "order=msvc2019:64:release:static"
::set "order=msvc2017:64:release:static"
::set "order=msvc2008:64:release:static"
::set "order=msvc2015:64:release:static"

  call "%eDIR_BAT_ENGINE%\run.bat" ^
    "--generate: cmake-makefiles"  ^
    "--configurations: %order%"    ^
    "--defines: UNSTABLE_RELEASE"  ^
    "--defines: _USE_32BIT_TIME_T"

  call "%eDIR_BAT_ENGINE%\run.bat" ^
    "--runIDE: %IDE%"              ^
    "--configurations: %order%"
exit /b

rem ============================================================================
rem ============================================================================

:findWorkspace
  if defined eDIR_WORKSPACE (exit /b)
  if not defined eWORKSPACE_SYMPTOMS (
      set "eWORKSPACE_SYMPTOMS=3rd_party;programs"
  ) 
  setlocal
  set "dir_start=%~1"
  if not defined dir_start (set "dir_start=%CD%")
  if not exist "%dir_start%" (goto :findWorkspaceFailed)
  set "DRIVE=%dir_start:~0,3%"
  pushd "%dir_start%" 
:loopFindWorkspace
  call :checkWorkspaceSymptoms
  if not errorlevel 1    (goto :findWorkspaceSuccess)
  if "%DRIVE%" == "%CD%" (goto :findWorkspaceFailed )
  cd ..
  goto :loopFindWorkspace
exit /b

:findWorkspaceSuccess
  endlocal & set "eDIR_WORKSPACE=%CD%"
  popd
exit /b 0

:findWorkspaceFailed
  popd
exit /b 1

rem ............................................................................

:checkWorkspaceSymptoms
  set "enumerator=%eWORKSPACE_SYMPTOMS%"
:loopWorkspaceSymptoms
  for /F "tokens=1* delims=;" %%a in ("%enumerator%") do (
    for /F "tokens=*" %%a in ("%%a") do (
      if not exist "%CD%\%%a" exit /b 1
    )
    set "enumerator=%%b"
  )
  if defined enumerator goto :loopWorkspaceSymptoms
exit /b 

rem ============================================================================
rem ============================================================================

:normalizeD
  set "%~1=%~dpfn2"
exit /b

:setOwnerD
  if defined eDIR_OWNER (exit /b)
  @echo off & cls & echo. & echo.
  call :normalizeD eDIR_OWNER "%~dp0."
exit /b

:setWorkspaceD
  call :findWorkspace || call :findWorkspace "C:\workspace"
  if errorlevel 1 (@echo [ERROR] 'WorkSpace' not found)
exit /b

:setBatScriptsD
  if defined eDIR_BAT_SCRIPTS   (exit /b)
  if not defined eDIR_WORKSPACE (exit /b)
  set "eDIR_BAT_SCRIPTS=%eDIR_WORKSPACE%\scripts\bat"
exit /b

:setBatEngineD
  if defined eDIR_BAT_ENGINE      (exit /b)
  if not defined eDIR_BAT_SCRIPTS (exit /b)
  set "eDIR_BAT_ENGINE=%eDIR_BAT_SCRIPTS%\engine"
exit /b

:checkParent
  if errorlevel 1 (@echo [ERROR] was broken at launch & exit /b 1)
  call :setOwnerD      || exit /b
  call :setWorkspaceD  || exit /b
  call :setBatScriptsD || exit /b
  call :setBatEngineD  || exit /b
exit /b 0

rem ============================================================================
rem ============================================================================
