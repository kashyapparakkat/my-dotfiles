rem argument : filepath

C:\cygwin64\bin\bash.exe --login -i -c "source ~/essential_functions.sh;filepath=$(echo \"%*\"|convert_to_cygdrive|escape_spaces);echo "$filepath"|open_in_app;bash" 