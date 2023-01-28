@echo off & call :checkParent "%~1"
if errorlevel 1 (exit /b 1)
rem ============================================================================
rem ============================================================================
:main
  call "%~dp000-ver.bat"
  set "v=%eRUN_VERSION%"

  @echo.
  @echo [INITIAL-STAGE] -------------------------------------[run %v%]---
  @echo [DIR CURRENT] ........ %CD%
  @echo.

  call :initCI_TOOLS          || goto :failed
  call :initDirCource         || goto :failed
  call :initGIT               || goto :failed
  call :dateTime "eTIMESTAMP" || goto :failed
	
  rem set "eDEBUG=ON"
  rem set "eTRACE=ON"
  rem set "eUPLOAD_NON_MASTER=ON"
  rem set "eCANCEL_UPLOAD=ON"

  set "ePREFIX=external"

  call :setDestinationD

  @echo [eDIR_OWNER] ......... %eDIR_OWNER%
  @echo [eDIR_WORKSPACE] ..... %eDIR_WORKSPACE%

  if not defined eDEBUG (goto :next)
  @echo [eDIR_BAT_SCRIPTS] ... %eDIR_BAT_SCRIPTS%
  @echo [eDIR_BAT_ENGINE] .... %eDIR_BAT_ENGINE%
  @echo.
  @echo [eDIR_SOURCE] ........ %eDIR_SOURCE%
  @echo [eDIR_ARTIFACT] ...... %eDIR_ARTIFACT%
  @echo.
  @echo [eGIT_VERSION] ....... %eGIT_VERSION%
  @echo [eGIT_COMMIT_FULL] ... %eGIT_COMMIT_FULL%
  @echo [eGIT_COMMIT] ........ %eGIT_COMMIT%
  @echo [eGIT_BRANCH] ........ %eGIT_BRANCH%
  @echo [eGIT_COMMENT] ....... %eGIT_COMMENT%
  @echo.
  call "%~dp0show_ci.bat"
  @echo.

  @echo.
  @echo [eDIR_DESTINATION] ... %eDIR_DESTINATION%
  @echo.
:next
  call "%~dp0info.bat" || goto :failed
:success
  @echo [INITIAL-STAGE] completed successfully
exit /b 0

:failed
  @echo [INITIAL-STAGE] finished with erros
exit /b 1

:setWithPrefix
  set "ePREFIX_NAME=%ePREFIX%/%eNAME_PROJECT%"
exit /b

:setWithoutPrefix
  set "ePREFIX_NAME=%eNAME_PROJECT%"
exit /b

:setPipelineID-1
  set "eTOKEN_ID=#%CI_PIPELINE_ID%-%eGIT_COMMIT%"
exit /b

:setPipelineID-2
  set "eTOKEN_ID=%eGIT_COMMIT%"
exit /b

:setDestinationD

  if defined ePREFIX (
    call :setWithPrefix
  ) else (
    call :setWithoutPrefix
  )

  set "eDIR_DESTINATION=tt-distributives\%ePREFIX_NAME%\%eGIT_BRANCH%\%curDate%"
  if defined CI_PIPELINE_ID (
    rem example: tt-distributives\mt5-pamm2\master\2022y-12m-25d\#324-f9e7bb1
    call :setPipelineID-1
  ) else (
    rem example: tt-distributives\mt5-pamm2\#2-dev-frame\2022y-12m-25d\f9e7bb1
    call :setPipelineID-2
  )

  call :normalizeD eDIR_DESTINATION "%eDIR_DESTINATION%\%eTOKEN_ID%"
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

:initCI_TOOLS
  if defined CI_TOOLS (exit /b)
  if not exist "C:\ci-tools" (
    echo [ERROR] not specified: 'CI_TOOLS' 
    exit /b 1
  )
  set "CI_TOOLS=C:/ci-tools"
exit /b

rem ============================================================================
rem ============================================================================

:initGit64
  setlocal
  set "p1=%eDIR_WORKSPACE%\programs\x64\Git\bin"
  set "p2=%eDIR_WORKSPACE%\programs\x64\SmartGit\git\bin" 
  set "p3=C:\Program Files\Git\bin"
  set "p4=C:\Program Files\SmartGit\git\bin" 
  set "p5=%eDIR_WORKSPACE%\programs\x86\Git\bin" 
  set "p6=C:\Program Files (x86)\Git\bin" 
  set "p7=%eDIR_WORKSPACE%\programs\x86\SmartGit\git\bin" 
  set "p8=C:\Program Files (x86)\SmartGit\git\bin" 

  set "result=%p1%;%p2%;%p3%;%p4%;%p5%;%p6%;%p7%;%p8%" 
  set "PATH=%result%;%PATH%" 
  endlocal & set "PATH=%PATH%"
exit /b

:initGit32
  setlocal
  set "p1=%eDIR_WORKSPACE%\programs\x86\Git\bin" 
  set "p2=%eDIR_WORKSPACE%\programs\x86\SmartGit\git\bin" 
  set "p3=C:\Program Files\Git\bin" 
  set "p4=C:\Program Files\SmartGit\git\bin" 

  set "result=%p1%;%p2%;%p3%;%p4%" 
  set "PATH=%result%;%PATH%" 
  endlocal & set "PATH=%PATH%"
exit /b

:initGit
  if defined ProgramFiles(x86) (call :initGit64) else (call :initGit32)
  set "PATH=%eDIR_GIT%;%PATH%"
  where "git.exe" >nul 2>nul
  if errorlevel 1 (@echo [ERROR] 'git' not found & exit /b 1)

  where "sh.exe" >nul 2>nul
  if errorlevel 1 (@echo [ERROR] 'sh' not found & exit /b 1)

  set "eGIT_VERSION="
  for /f "tokens=3" %%a in ('git --version') do (set "eGIT_VERSION=%%a")

  set "eGIT_COMMIT_FULL="
  for /f %%a in ('git log -1 --pretty^=format:"%%H"') do (set "eGIT_COMMIT_FULL=%%a")

  set "eGIT_COMMIT="
  for /f %%a in ('git log -1 --pretty^=format:"%%h"') do (set "eGIT_COMMIT=%%a")

  if defined CI_COMMIT_REF_NAME (
    set "eGIT_BRANCH=%CI_COMMIT_REF_NAME%"
    goto :initGitNext
  )

  set "eGIT_BRANCH="
  for /f "delims=* tokens=*" %%a in ('git branch --contains %eGIT_COMMIT_FULL%') do (
    call :trim eGIT_BRANCH %%~a
  )
:initGitNext
  set "eGIT_COMMENT="
  for /f "delims=* tokens=*" %%a in ('git log --format^="%%s" -n 1 %eGIT_COMMIT_FULL%') do (
    call :trim eGIT_COMMENT %%~a
  )

  type nul > nul
  @echo %eGIT_COMMENT% | findstr /rc:"version .*\..*\..*" 1>nul

  if errorlevel 1 (
    set "eGIT_RELEASE_COMMIT="
  ) else (
    set "eGIT_RELEASE_COMMIT=ON"
  ) 
  type nul > nul
exit /b

rem ============================================================================
rem ============================================================================

:initDirCource
  if defined eDIR_SOURCE (exit /b)
  call "%eDIR_BAT_ENGINE%\run.bat" ^
    "--detect:"                    ^
    "--configurations: all"
  if errorlevel 1 (echo [ERROR] can not detect: eDIR_SOURCE)
exit /b

rem =========================================================================
rem =========================================================================

:dateTime
  rem %~1 variable name 
  for /f %%a in ('WMIC OS GET LocalDateTime ^| find "."') do (
      set "DTS=%%~a"  
  )

  if errorlevel 1 (echo [ERROR] 'WMIC' finished with error & exit /b 1)

  set "YY=%DTS:~0,4%"
  set "MM=%DTS:~4,2%"
  set "DD=%DTS:~6,2%"

  set "HH=%DTS:~8,2%"
  set "MIN=%DTS:~10,2%"
  set "SS=%DTS:~12,2%"
  rem set "MS=%DTS:~15,3%"

  set "curDateISO=%YY%-%MM%-%DD%"

  set "curDate=%YY%y-%MM%m-%DD%d"
  set "curTime=%HH%h-%MIN%min"
  set "curDateTime=%curDate%_%curTime%"

  set "%~1=%curDateTime%"
exit /b 

rem =========================================================================
rem =========================================================================

:trim
  for /F "tokens=1,*" %%a in ("%*") do (call set "%%a=%%b")
exit /b

:normalizeD
  set "%~1=%~dpfn2"
exit /b

:setOwnerD
  if defined eDIR_OWNER (exit /b)
  @echo off & cls & echo. & echo.
  call :normalizeD eDIR_OWNER "%~dp0."
exit /b

:setArtifactD
  set "eDIR_ARTIFACT=%~1"
  if defined eDIR_ARTIFACT (exit /b)
  call :normalizeD eDIR_ARTIFACT "%~dp0..\..\_artifacts"
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

rem ============================================================================
rem ============================================================================

:checkParent
  if errorlevel 1 (@echo [ERROR] was broken at launch & exit /b 1)
  if defined eRUN_INITIALIZED (exit /b)
  set "eRUN_INITIALIZED=ON"
  call :setOwnerD      || exit /b
  call :setWorkspaceD  || exit /b
  call :setBatScriptsD || exit /b
  call :setBatEngineD  || exit /b
  call :setArtifactD "%~1"
exit /b 0

rem ============================================================================
rem ============================================================================
