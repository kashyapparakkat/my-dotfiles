rem set "var=%cd%"
rem convert to double slashes 
set "var=%cd:\=\\%" 
rem set var=%variable:\=\\%

rem TODO /cygdrive/d/Local\ Disk\ D_732016210/ doesnot work
C:\cygwin64\bin\bash.exe --login -i -c "source \"$HOME\"/.bashrc;dir=$(echo \"%var%\"|convert_to_cygdrive|escape_spaces);echo "d=$dir";command cd $dir;pwd;smart_open;bash" 
