@echo off 
call :checkParent
if errorlevel 1 (exit /b 1)
rem ============================================================================
rem ============================================================================
:main
    setlocal
    @echo [MAKE] run...

    rem set "eDEBUG=ON"

    set "VC08=msvc2008:64:debug:static"
    set "VC10=msvc2010:32:release:static"
    set "VC12=msvc2012:64:debug:static"
    set "VC13=msvc2013:32:release:static"
    set "VC15=msvc2015:64:debug:static"
    set "VC17=msvc2017:32:release:static"
    set "VC19=msvc2019:64:debug:static"
    set "VC=%VC08%;%VC10%;%VC12%;%VC13%;%VC15%;%VC17%;%VC19%"

    set "MG81=mingw810:64:release:static"
    set "MG73=mingw730:32:release:static"
    set "MG72=mingw720:64:release:static"
    set "MG71=mingw710:32:release:static"

    set "MG64=mingw640:64:release:static"
    set "MG63=mingw630:32:release:static"
    set "MG62=mingw620:64:release:static"
    set "MG61=mingw610:32:release:static"
    
    set "MG54=mingw540:64:release:static"
    set "MG53=mingw530:32:release:static"
    set "MG52=mingw520:64:release:static"
    set "MG51=mingw510:32:release:static"

    set "M494=mingw494:64:release:static"
    set "M493=mingw493:32:release:static"
    set "M492=mingw492:64:release:static"
    set "M491=mingw491:32:release:static"
    set "M490=mingw490:64:release:static"

    set "M485=mingw485:64:release:static"
    set "M484=mingw484:32:release:static"
    set "M483=mingw483:64:release:static"
    set "M482=mingw482:32:release:static"
    set "M481=mingw481:64:release:static"

    set "MG7=%MG72%;%MG73%;%MG81%;"
    set "MG6=%MG61%;%MG62%;%MG63%;%MG64%;"
    set "MG5=%MG51%;%MG53%;%MG54%;"
    set "MG49=%M490%;%M491%;%M492%;%M493%;%M494%;"    
    set "MG48=%M481%;%M482%;%M483%;%M484%;%M485%;"        
    
    set "MG=%MG48%;%MG49%;%MG5%;%MG6%;%MG7%"

    set "order=%VC19%"
    set "order=%MG81%"
    set "order=%MG%"
    set "order=%VC%; %MG%"
    set "order=%VC19%; %MG81%"
    set "order=all"

    rem for development
    rem (call :generate) && (goto :success) || (goto :failed)
    rem (call :build) && (goto :success) || (goto :failed)

    (call :clean)    || (goto :failed)
    (call :build)    || (goto :failed)
    (call :runTests) || (goto :failed)
    (call :install)  || (goto :failed)
:success
    @echo [MAKE] completed successfully
exit /b 0

:failed
    @echo [MAKE] finished with erros
exit /b 1

rem ............................................................................

:clean
    call "%eDIR_BAT_ENGINE%\run.bat"  ^
        "--clean: all" 
exit /b

:generate
    call "%eDIR_BAT_ENGINE%\run.bat"  ^
        "--generate: cmake-makefiles" ^
        "--configurations: %order%"   ^
        "--defines: STABLE_RELEASE"
exit /b

:build
    call "%eDIR_BAT_ENGINE%\run.bat"  ^
        "--build: cmake-makefiles"    ^
        "--configurations: %order%"   ^
        "--defines: STABLE_RELEASE"
exit /b

:runTests
    call "%eDIR_BAT_ENGINE%\run.bat"  ^
        "--runTests: test*.exe"       ^
        "--exclude: *mingw*-dynamic"  ^
        "--configurations: %order%"
exit /b

:install
    call "%eDIR_BAT_ENGINE%\run.bat"  ^
        "--custom: finalize"          ^
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

:normalize
    set "%~1=%~dpfn2"
exit /b

:checkParent
    if errorlevel 1 (
        @echo [ERROR] was broken at launch
        exit /b 1
    )
    if not defined eDIR_OWNER (
        @echo off & cls & @echo. & @echo.
        call :normalize eDIR_OWNER "%~dp0."
    )
    (call :findWorkspace) || (call :findWorkspace "C:\workspace")
    if errorlevel 1 (
        @echo [ERROR] 'WorkSpace' not found
        exit /b 1
    )
    if not defined eDIR_BAT_SCRIPTS (
        set "eDIR_BAT_SCRIPTS=%eDIR_WORKSPACE%\scripts\bat"
    )
    if not defined eDIR_BAT_ENGINE (
        set "eDIR_BAT_ENGINE=%eDIR_BAT_SCRIPTS%\engine"
    )
exit /b 0

rem ============================================================================
rem ============================================================================
