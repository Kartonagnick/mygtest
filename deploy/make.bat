@echo off & call :checkParent
if errorlevel 1 (exit /b 1)
rem ============================================================================
rem ============================================================================
:main
  setlocal
  call "%~dp0ver.bat"
  @echo [MAKE] run... v%eMAKE_VERSION%
  rem set "eTRACE=ON"
  rem set "eDEBUG=ON"

  set "VC08=msvc2008:32:release:static"
  set "VC10=msvc2010:32:debug:static"
  set "VC12=msvc2012:32:release:static"
  set "VC13=msvc2013:32:debug:static"
  set "VC15=msvc2015:32:release:static"
  set "VC17=msvc2017:32:debug:static"
  set "VC19=msvc2019:64:release:static"
  set "VC=%VC08%;%VC10%;%VC12%;%VC13%;%VC15%;%VC17%;%VC19%"

  set "MG81=mingw810:64:release:static"
  set "MG73=mingw730:64:release:static"
  set "MG72=mingw720:64:release:static"
  set "MG=%MG72%;%MG73%;%MG81%;"

  rem set "order=mingw494:32:debug:static" bug!!!
  rem set "order=%VC%"
  rem set "order=%MG%"
  rem set "order=%VC%;%MG%"
  set "order=%VC19%"
::set "order=all"
  set "order=msvc2015:64:debug:static"

  rem for development
  (call :generate) && (goto :success) || (goto :failed)

::(call :clean)     || (goto :failed)
::(call :build)     || (goto :failed)
::(call :runTests)  || (goto :failed)
::(call :runStress) || (goto :failed)
::(call :install)   || (goto :failed)
:success
  @echo [MAKE] completed successfully
exit /b 0

:failed
  @echo [MAKE] finished with erros
exit /b 1

rem ............................................................................

:clean
  call "%eDIR_BAT_ENGINE%\run.bat" ^
    "--clean: all" 
exit /b

:generate
  call "%eDIR_BAT_ENGINE%\run.bat" ^
    "--generate: cmake-makefiles"  ^
    "--configurations: %order%"    ^
    "--defines: STABLE_RELEASE"    ^
    "--defines: _USE_32BIT_TIME_T"
exit /b

:build
  call "%eDIR_BAT_ENGINE%\run.bat" ^
    "--build: cmake-makefiles"     ^
    "--configurations: %order%"    ^
    "--defines: STABLE_RELEASE"    ^
    "--defines: _USE_32BIT_TIME_T"
exit /b

:runTests
  call "%eDIR_BAT_ENGINE%\run.bat" ^
    "--runTests: test*.exe"        ^
    "--exclude: mingw*-dynamic; stress-*" ^
    "--configurations: %order%"
exit /b

:runStress
  call "%eDIR_BAT_ENGINE%\run.bat" ^
    "--runTests: test*.exe"        ^
    "--exclude: mingw*-dynamic"    ^
    "--args: stress"               ^
    "--configurations: %order%"
exit /b

:install
  call "%eDIR_BAT_ENGINE%\run.bat" ^
    "--custom: finalize"           ^
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
