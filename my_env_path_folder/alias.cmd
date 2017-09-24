REM @echo off

REM http://winaero.com/blog/how-to-set-aliases-for-the-command-prompt-in-windows/
doskey cd.=cd ..
doskey cd..=cd ..\..
doskey cd...=cd ..\..\..
doskey ..=cd ..
doskey ...=cd ..\..

doskey cdmisc=cd C:\cbn_gits\misc
doskey cdahk=cd C:\cbn_gits\AHK
doskey cd~=cd %USERPROFILE%
doskey cdh=cd %USERPROFILE%
doskey cdd=cd %USERPROFILE%\Downloads
doskey ex=exit
doskey r=C:\cygwin64\bin\python3.6m.exe C:\cygwin64\bin\ranger
doskey ranger=C:\cygwin64\bin\python3.6m.exe C:\cygwin64\bin\ranger

doskey gdf=git diff --name-only


doskey cd = cd /d $* ^&^& "C:\cbn_gits\my_env_path_folder\cmd-set-title.bat"
doskey cd=@echo off$Tcd /d $*$T@title ^%cd^%$Techo on
title %cd%
