@echo off
REM Wrapper til GnuCOBOL på Windows
REM Sætter include- og lib-stier automatisk

set COBINC=C:\Users\SPAC-18\AppData\Local\GnuCOBOL\include
set COBLIB=C:\Users\SPAC-18\AppData\Local\GnuCOBOL\lib

set PATH=C:\Users\SPAC-18\AppData\Local\GnuCOBOL;%PATH%



REM Kald cobc med de rigtige flags
cobc -I"%COBINC%" -L"%COBLIB%" -x %*.cbl -o %*.exe -lcob

REM Check if compilation was successful before trying to run
IF EXIST %*.exe (
    REM Set console code page to UTF-8 (65001) for proper display of national characters
    chcp 65001 > NUL

    REM Run the compiled COBOL program
    %*.exe

    REM Optional: Reset console code page if you have other tools expecting a different one
    REM chcp 850 > NUL
) ELSE (
    echo.
    echo ERROR: COBOL compilation failed for %*.cbl
    echo.
)

REM Pause to keep the console window open after execution
pause