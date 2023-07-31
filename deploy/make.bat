@echo off & call :checkParent || exit /b

rem --- local/mygtest                                          [deploy/make.bat]
rem [2023-08-05][19:00:00] 001 Kartonagnick    
rem ============================================================================
rem ============================================================================

:main
  setlocal
  chcp 65001 >nul
  call :setDepth
::set "eDEBUG=ON"
  call "%~dp0ver.bat"
  call :echo0 [MAKE] run... v%eMAKE_VERSION%

  call "%~dp0compilers.bat"

::set "stable=UNSTABLE_RELEASE"
  set "stable=STABLE_RELEASE"

  set "order=all"
  set "order=msvc2019:64:release:static"
  set "order=%VERY_FAST_MODERN%"
  set "order=%VC_MODERN%"
  set "order=%VERY_FAST%"

  rem for development
::call :generate && goto :success || goto :failed

::call :clean     || goto :failed
  call :build     || goto :failed
  call :runTests  || goto :failed
::call :runStress || goto :failed
:success
  call :echo0 [MAKE] completed successfully
  exit /b 0
:failed
  call :echo0 [MAKE] finished with erros
exit /b 1

:clean
  call "%eDIR_BAT_ENGINE%\run.bat" ^
    "--clean: all" 
  exit /b
:generate
  call "%eDIR_BAT_ENGINE%\run.bat" ^
    "--generate: cmake-makefiles"  ^
    "--configurations: %order%"    ^
    "--defines: %stable%"          ^
    "--defines: _USE_32BIT_TIME_T"
  exit /b
:build
  call "%eDIR_BAT_ENGINE%\run.bat" ^
    "--build: cmake-makefiles"     ^
    "--configurations: %order%"    ^
    "--defines: %stable%"          ^
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

rem ============================================================================
rem ============================================================================

:findWorkspace
  setlocal
  call :makeSearchList
  call :normalizeD enumWorkspace "."
  set "enumWorkspace=%enumWorkspace%;%eDISKS%"
:loopWorkspace
  for /F "tokens=1* delims=;" %%a in ("%enumWorkspace%") do (
    call :findWorkspaceD "%%~a" && goto :loopWorkspaceSuccess
    set "enumWorkspace=%%~b"
  )
  if defined enumWorkspace goto :loopWorkspace
  call :echo2 [ERROR] 'WorkSpace' not found
  exit /b 1
:loopWorkspaceSuccess
  call :debug2 found: %eDIR_WORKSPACE%
  endlocal & (set "eDIR_WORKSPACE=%eDIR_WORKSPACE%") 
  exit /b 0
:makeSearchList
  set "eDISKS="
  rem enumerate list of disks
  set "cmd=WMIC LogicalDisk Get Name"
  set "run=%cmd% /value 2^> nul ^| find "=""
  for /f "usebackq tokens=*" %%a in (`%run%`) do (call :makeDiskList-add "%%~a")
  exit /b
:makeDiskList-add
  set "%~1"
  call :normalizeD "dir" "%Name%\workspace"
  set "eDISKS=%eDISKS%;%dir%"
  if not defined eTRACE exit /b
  call :echo2 find in: %dir%
exit /b

:findWorkspaceD
  if defined eDIR_WORKSPACE (exit /b)
  if not defined eWORKSPACE_SYMPTOMS (
    set "eWORKSPACE_SYMPTOMS=3rd_party;programs;scripts"
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

:setDepth
  set "eDEEP0="
  if defined eINDENT (set /a "eINDENT+=1") else (set "eINDENT=0")
  for /l %%i in (1, 1, %eINDENT%) do (call set "eDEEP0=  %%eDEEP0%%")
  set "eDEEP1=  %eDEEP0%"
  set "eDEEP2=  %eDEEP1%"
  set "eDEEP3=  %eDEEP2%"
  exit /b
:echo0
  echo %eDEEP0%%* & exit /b
:echo1
  echo %eDEEP1%%* & exit /b
:echo2
  echo %eDEEP2%%* & exit /b
:echo3
  echo %eDEEP3%%* & exit /b
:debug1
  if not defined eDEBUG (exit /b)
  echo %eDEEP1%%* & exit /b
:debug2
  if not defined eDEBUG (exit /b)
  echo %eDEEP2%%* & exit /b
:debug3
  if not defined eDEBUG (exit /b)
  echo %eDEEP3%%*
exit /b

rem ............................................................................

:toUpper 
  setlocal
  set "name="
  set "value="
  for /F "tokens=1,*" %%a in ("%*") do (
    set "name=%%~a"
    set "value=%%~b"
  )
  if not defined name  (goto :toUpper.failed )
  if not defined value (goto :toUpper.success)
  
  for %%j in ("a=A" "b=B" "c=C" "d=D" "e=E" "f=F" "g=G" "h=H" "i=I"
              "j=J" "k=K" "l=L" "m=M" "n=N" "o=O" "p=P" "q=Q" "r=R"
              "s=S" "t=T" "u=U" "v=V" "w=W" "x=X" "y=Y" "z=Z") do (
      call set "value=%%value:%%~j%%"
  )
:toUpper.success
  endlocal & (set "%name%=%value%")
  exit /b 0
:toUpper.failed
  echo [ERROR] 'variable name' not defined
  endlocal
exit /b 1

:trim
  for /F "tokens=1,*" %%a in ("%*") do (call set "%%a=%%b")
  exit /b
:normalizeD
  set "%~1=%~dpfn2"
  exit /b
:setName
  set "%~1=%~n2"
  exit /b
:setNameExt
  set "%~1=%~n2%~x2"
  exit /b
:setValue
  if defined %~1 (exit /b)
  set "%~1=%~2"
exit /b

rem ............................................................................

:checkParent
  if errorlevel 1 (echo [ERROR] was broken at launch &  exit /b 1)
  call :setOwnerD      || exit /b 1
  call :findWorkspace  || exit /b 1
  call :setBatScriptsD || exit /b 1
  call :setBatEngineD  || exit /b 1
  exit /b
:setOwnerD
  if defined eDIR_OWNER (exit /b)
  echo off & cls & echo. & echo.
  call :normalizeD eDIR_OWNER "%~dp0."
  exit /b
:setBatScriptsD
  if defined eDIR_BAT_SCRIPTS (exit /b)
  set "eDIR_BAT_SCRIPTS=%eDIR_WORKSPACE%\scripts\bat"
  exit /b
:setBatEngineD
  if defined eDIR_BAT_ENGINE (exit /b)
  set "eDIR_BAT_ENGINE=%eDIR_BAT_SCRIPTS%\engine"
exit /b
