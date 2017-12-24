echo "$1"

file=$(~/my-scripts/convert_path_to_windows.sh "$*")

echo "$file"
# open explorer.bat "$file"


	if [ "$OS" == "Windows_NT" ]; then
# cygwin works for below
explorer.exe /Select, "$file"
else 


#The following works in all desktop environments by using the default file manager:

xdg-open .
# OR nautilus .
#You can also open files from the terminal as if you had double clicked them in the file manager:

#xdg-open file
fi
