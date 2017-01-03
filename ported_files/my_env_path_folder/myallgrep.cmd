@echo off
REM call ZZ_cmd_handler.cmd %*
REM call ZZ_cmd_handler.cmd %~n0 %*
set _CYGBIN=c:\cygwin64\bin
REM set _CYGBIN=/cygdrive/c/cygwin6/bin
set _CYGSCRIPT=/usr/bin/myallgrep.sh
set _CYGPATH="/usr/bin"

REM endlocal & bash --login && cd "/usr/bin" && pwd && "/usr/bin/myallgrep.sh" %*
REM endlocal & echo cd /cygdrive/c/cbn_gitsﾍｾ "%_CYGSCRIPT%" %* | bash --login -s
REM echo "/usr/bin/myallgrep.sh" %* |

REM endlocal & echo "%_CYGSCRIPT%" %*| %_CYGBIN%\bash --login -s
echo pwd; cd "/usr/bin/"; pwd ; "/usr/bin/myallgrep.sh" %*| "c:\cygwin64\bin\bash" --login -s
