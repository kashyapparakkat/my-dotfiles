echo "$1"

file=$(~/my-scripts/convert_path_to_windows.sh "$*")

echo "$file" 

# cygwin works for below
#explorer.exe  "$file"



	if [ "$OS" == "Windows_NT" ]; then
# cygwin works for below
explorer.exe "$file"
else 
#You can also open files from the terminal as if you had double clicked them in the file manager:

xdg-open "$file"
fi
