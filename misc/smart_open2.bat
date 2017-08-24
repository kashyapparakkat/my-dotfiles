rem set "var=%cd%"
rem convert to double slashes 
set "var=%cd:\=\\%" 
rem set var=%variable:\=\\%

rem TODO /cygdrive/d/Local\ Disk\ D_732016210/ doesnot work
C:\cygwin64\bin\bash.exe --login -i -c "source /home/\"$USERNAME\"/.bashrc;filepath=$(echo \"%*\"|convert_to_cygdrive|escape_spaces);pwd;smart_open \"$filepath\";bash" 
