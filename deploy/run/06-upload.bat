@echo off & call :checkParent
if errorlevel 1 (exit /b 1)
rem =========================================================================
rem =========================================================================

:main
  ::CI_PIPELINE_ID
  setlocal
  @echo.
  @echo [UPLOAD] to sftp...
  @echo [DIR_ARTIFACT] ....... %eDIR_ARTIFACT%
  @echo [DIR_SOURCE] ......... %eDIR_SOURCE%
  @echo [GIT_BRANCH] ......... %eGIT_BRANCH%
  @echo [GIT_COMMIT] ......... %eGIT_COMMIT%
  @echo [GIT_COMMENT] ........ %eGIT_COMMENT%
  @echo [CI_PIPELINE_ID] ..... %CI_PIPELINE_ID%
  @echo.
  @echo [eDIR_DESTINATION] ... %eDIR_DESTINATION%
  @echo.

  if defined eGIT_RELEASE_COMMIT (
    @echo [RELEASE] ......... YES
  ) else (
    @echo [RELEASE] ......... NO
  )
  @echo.

  if defined eCANCEL_UPLOAD (
    @echo [CANCEL] specified: eCANCEL_UPLOAD 
    goto :success       
  )

  if not defined eGIT_BRANCH ( 
    @echo [ERROR] npt specified: eGIT_BRANCH 
    goto :failed
  )

  if "%eGIT_BRANCH%" == "master" (
    if defined eGIT_RELEASE_COMMIT (goto :saveData)
  )
  if defined eUPLOAD_NON_MASTER (goto :saveData)

  if "%eGIT_BRANCH%" == "master" (
    @echo [CANCEL] comment: %GIT_COMMENT%
    @echo [CANCEL] the operation is only available for the release-commit
  )  else (
    @echo [CANCEL] branch: %eGIT_BRANCH%
    @echo [CANCEL] the operation is only available for the master branch
  )
  goto :success       

:saveData
  sh.exe "--login" "%CI_TOOLS%\upload_sftp.sh" 
  if errorlevel 1 (
    @echo [ERROR] sh.exe finished with error
    goto :failed
  )
:success
  @echo [UPLOAD] completed successfully
exit /b 0

:failed
  @echo [UPLOAD] finished with erros
exit /b 1 

rem =========================================================================
rem =========================================================================

:checkParent
  if errorlevel 1 (@echo [ERROR] was broken at launch & exit /b 1)
  if defined eDIR_OWNER (exit /b)
  @echo off
  @echo [ERROR] should be run from under the parent batch file
exit /b 1

rem =========================================================================
rem =========================================================================
