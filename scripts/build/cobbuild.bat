@echo off
REM Build helper for compiling COBOL sources in src\cobol without running them

if "%~1"=="" (
	echo Usage: %~nx0 ProgramNameWithoutExtension
	exit /b 1
)

setlocal enabledelayedexpansion

set REPO_ROOT=%~dp0..\..
set COB_SRC=%REPO_ROOT%\src\cobol
set COB_COPY=%REPO_ROOT%\src\copybooks
set COB_BIN=%REPO_ROOT%\bin
set PROGRAM=%~1

set COBINC=C:\Users\SPAC-18\AppData\Local\GnuCOBOL\include
set COBLIB=C:\Users\SPAC-18\AppData\Local\GnuCOBOL\lib
set PATH=C:\Users\SPAC-18\AppData\Local\GnuCOBOL;%PATH%

if defined COBCPY (
	set COBCPY=%COB_COPY%;%COBCPY%
) else (
	set COBCPY=%COB_COPY%
)

set SOURCE=%COB_SRC%\%PROGRAM%.cbl
if not exist "!SOURCE!" (
	set SOURCE=%COB_SRC%\%PROGRAM%.cob
)

if not exist "!SOURCE!" (
	echo Could not find %PROGRAM%.cbl or %PROGRAM%.cob in %COB_SRC%
	exit /b 1
)

if not exist "%COB_BIN%" (
	mkdir "%COB_BIN%"
)

set TARGET=%COB_BIN%\%PROGRAM%.exe

echo Compiling !SOURCE! ^> !TARGET!
cobc -free -x "!SOURCE!" -I"%COBINC%" -I"%COB_COPY%" -L"%COBLIB%" -o "!TARGET!" -lcob

if errorlevel 1 (
	echo.
	echo ERROR: COBOL compilation failed for %PROGRAM%
	exit /b 1
)

echo Build finished: !TARGET!

endlocal