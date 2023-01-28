@echo off & call :checkParent
if errorlevel 1 (exit /b 1)
rem ============================================================================
rem ============================================================================
:main
  setlocal
  @echo [GITLAB] run...
  rem set "eDEBUG=ON"

  call :develop && goto :success || goto :failed

  (call "%~dp003-clean.bat"   "artifact") || (goto :failed)
  (call "%~dp003-clean.bat"   "msvc2019") || (goto :failed)
  (call "%~dp003-clean.bat"   "msvc2017") || (goto :failed)

  (call "%~dp004-build.bat"   "msvc2019:32:debug"  ) || (goto :failed)
  (call "%~dp004-build.bat"   "msvc2019:32:release") || (goto :failed)
  (call "%~dp004-build.bat"   "msvc2019:64:debug"  ) || (goto :failed)
  (call "%~dp004-build.bat"   "msvc2019:64:release") || (goto :failed)

  (call "%~dp004-build.bat"   "msvc2017:32:debug"  ) || (goto :failed)
  (call "%~dp004-build.bat"   "msvc2017:32:release") || (goto :failed)
  (call "%~dp004-build.bat"   "msvc2017:64:debug"  ) || (goto :failed)
  (call "%~dp004-build.bat"   "msvc2017:64:release") || (goto :failed)

  (call "%~dp005-test.bat"    "msvc2019") || (goto :failed)
  (call "%~dp005-test.bat"    "msvc2017") || (goto :failed)

  (call "%~dp006-upload.bat") || (goto :failed)

  (call "%~dp003-clean.bat"   "msvc2019") || (goto :failed)
  (call "%~dp003-clean.bat"   "msvc2017") || (goto :failed)
:success
  @echo [GITLAB] completed successfully
exit /b 0

:failed
  @echo [GITLAB] finished with erros
exit /b 1

:develop
  set "GITLAB_CI=ON"
  set "config=all"
  (call "%~dp002-init.bat")               || (goto :failed)
::(call "%~dp003-clean.bat"   "artifact") || (goto :failed)
  (call "%~dp004-build.bat"   "%config%") || (goto :failed)
  (call "%~dp005-test.bat"    "%config%") || (goto :failed)
::(call "%~dp006-upload.bat")             || (goto :failed)
::(call "%~dp003-clean.bat"   "msvc2019") || (goto :failed)
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
