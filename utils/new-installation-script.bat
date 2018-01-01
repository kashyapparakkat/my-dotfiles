REM windows only

REM https://superuser.com/questions/302194/automatically-executing-commands-when-a-command-prompt-is-opened/302553
REM reg add "HKCU\Software\Microsoft\Command Processor" /v AutoRun ^  /t REG_EXPAND_SZ /d "%"USERPROFILE"%\init.cmd" /f

reg add "HKCU\Software\Microsoft\Command Processor" /v AutoRun ^  /t REG_EXPAND_SZ /d "C:\cbn_gits\my_env_path_folder\alias.cmd" /f

REM To remove these changes, delete the registry key:
REM reg delete "HKCU\Software\Microsoft\Command Processor" /v AutoRun