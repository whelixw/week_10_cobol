@echo off

set COBINC=C:\Users\SPAC-18\AppData\Local\GnuCOBOL\include
set COBLIB=C:\Users\SPAC-18\AppData\Local\GnuCOBOL\lib

set PATH=C:\Users\SPAC-18\AppData\Local\GnuCOBOL;%PATH%

cobc -I"%COBINC%" -L"%COBLIB%" %*
pause