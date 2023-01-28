@echo off & call :checkParent
if errorlevel 1 (exit /b 1)
rem ============================================================================
rem ============================================================================

:main
  setlocal
  @echo [WORK DIRECTORY]
  @echo   '%CD%'
  call :viewDiskSpace "%DISK%"
  call :viewMemory
:success
  rem @echo [INFO] completed successfully
exit /b 0

:failed
  @echo [INFO] finished with erros
exit /b 1

rem ============================================================================
rem ============================================================================

rem :use-fsutil-deprecated
  rem see v0.0.9
  rem set "command=fsutil volume diskfree %disk%"
  rem for /f "tokens=2 delims=:" %%a in ('%command%') do (
  rem   call :setElementData "%%a"
  rem )
rem exit /b

:getTotalDiskSpace
  set command=wmic LogicalDisk Where "Name='%disk%'" Get Size /value
  for /f "usebackq" %%x in (`%command%`) do (
    for /f "tokens=2 delims==" %%a in ("%%x") do (
      set "%~1=%%~a"
    )
  )
exit /b

:getFreeDiskSpace
  set command=wmic LogicalDisk Where "Name='%disk%'" Get FreeSpace /value
  for /f "usebackq" %%x in (`%command%`) do (
    for /f "tokens=2 delims==" %%a in ("%%x") do (
      set "%~1=%%~a"
    )
  )
exit /b

:viewDiskSpace
  setlocal
  set "dis_=%CD%"
  set "disk=%~1"
  if defined disk (goto :viewDiskSpaceNext)
  set "disk=%CD%"
  set "disk=%disk:~0,2%"
:viewDiskSpaceNext
  call :getTotalDiskSpace "totalSize"          || goto :viewDiskSpace-error-1
  call :getFreeDiskSpace  "freeSize"           || goto :viewDiskSpace-error-2
  call :diskSize "totalSize" "%totalSize%" "b" || goto :viewDiskSpace-error-3
  call :diskSize "freeSize" "%freeSize%"  "b"  || goto :viewDiskSpace-error-4
  @echo [disk] total: %totalSize%
  @echo [disk] free : %freeSize%
exit /b  
:viewDiskSpace-error-1
  @echo [ERROR] failed: getTotalDiskSpace
exit /b 1
:viewDiskSpace-error-2
  @echo [ERROR] failed: getFreeDiskSpace
exit /b 1
:viewDiskSpace-error-3
  @echo [ERROR] failed: 'diskSize "info" "%totalSize%" "b"'
exit /b 1
:viewDiskSpace-error-4
  @echo [ERROR] failed: 'diskSize "info" "%freeSize%" "b"'
exit /b 1

:diskSize
  setlocal
  rem %~1 name of result variable
  rem %~2 total source bytes
  rem %~3 b or mb
  set command=cscript.exe /nologo "%~dp0vbs\size.vbs" "%~2" "%~3"
  for /f "usebackq tokens=1-3" %%a in (`%command%`) do (
    set "gb=%%~a"
    set "mb=%%~b"
    set "kb=%%~c"
  )

  call :checkNumeric "%gb%" || exit /b 1
  call :checkNumeric "%mb%" || exit /b 1
  call :checkNumeric "%kb%" || exit /b 1

  if %gb% GTR 0 (
    if %mb% GTR 0 (set "info=%gb%.%mb% gb") else (set "info=%gb% gb")
  ) else (
    if %kb% GTR 0 (set "info=%mb%.%kb% mb") else (set "info=0 kb")
  )
  endlocal & set "%~1=%info%"
exit /b

:checkNumeric
  setlocal
  if 1%~1 EQU +1%~1 (exit /b)

  set "number=%~1"
  set "positive=%number:-=%"

  if %~1==-%positive% (
    @echo [ERROR] expected positive value: %~1 
  ) else (
    @echo [ERROR] expected value: %~1 
  )
exit /b 1

rem ============================================================================
rem ============================================================================

:memTotal
  setlocal
  set "command=wmic OS get TotalVisibleMemorySize /value"
  for /F "tokens=2 delims==" %%a in ('%command%^|find "="') do (
    set "bytes=%%~a"
  )
  endlocal & set "%~1=%bytes%"
exit /b

:memFree
  setlocal
  set "command=wmic OS get FreePhysicalMemory /value"
  for /F "tokens=2 delims==" %%a in ('%command%^|find "="') do (
    set "bytes=%%~a"
  )
  endlocal & set "%~1=%bytes%"
exit /b

:viewMemory
  setlocal
  call :memTotal "total"
  call :memFree  "free"
  call :diskSize "info" "%total%" "kb" || exit /b 1
  @echo [memory] total: %info%
  
  call :diskSize "info" "%free%" "kb" || exit /b 1
  @echo [memory] free : %info%
exit /b

rem ============================================================================
rem ============================================================================

rem :bytesToMegabytes
rem   see: old deprecated versions...
rem   setlocal
rem   rem %~1 result of megabytes
rem   rem %~2 result of bytes
rem   rem %~3 total source bytes
rem   for /f "usebackq tokens=1-4" %%a in (`cscript.exe /nologo "%~dp0size.vbs" "%~3"`) do (
rem     @echo [%%a GB][%%b MB][%%c KB][%%d B]
rem     set gb=%%~a
rem     set mb=%%~b
rem     set gb=%%~a
rem   )
rem   endlocal & set "%~1=%SizeMb%"
rem exit /b

rem ============================================================================
rem ============================================================================

:trim
  set "from=%* %trimArgs%"
  for /F "tokens=1,*" %%a in ("%from%") do (call set "%%a=%%b")
exit /b

:normalizeD
  set "%~1=%~dpfn2"
exit /b

:setOwnerD
  if defined eDIR_OWNER (exit /b)
  rem  chcp 1251 >nul
  @echo off & cls & echo. & echo.
  call :normalizeD eDIR_OWNER "%~dp0."
exit /b

:checkParent
  if errorlevel 1 (@echo [ERROR] was broken at launch & exit /b 1)
  call :setOwnerD
exit /b

rem ============================================================================
rem ============================================================================
