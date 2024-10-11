@echo off
setlocal

echo.
choice /C AN /M "Activate Python VENV ?  A/N"
if errorlevel 2 goto:start

echo.
echo Activating VENV
call venv\Scripts\activate

:start
echo.
set python=venv\Scripts\pyinstaller.exe
echo Building with pyinstaller : %python%

set logFile=_build-win_monitor_log.txt
echo. > %logFile%

set targetDir=dist-win

set srcFile=monitor.py
call:buildFiles

set srcFile=winmonitor.py
call:buildFiles

title Finished building!
echo.
echo Finished.
echo Press any key ...
echo.
pause >nul
goto:eof

:buildFiles
echo.
echo Building:  %srcFile%
title Building:  %srcFile%

CALL %python% --log-level ERROR --onefile ^
              --distpath %targetDir% %srcFile% >> %logFile% 2>&1

echo. >> %logFile%
goto:eof

endlocal

