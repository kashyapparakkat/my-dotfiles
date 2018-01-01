echo "$1"

file=$(~/my-scripts/convert_path_to_OS_format.sh "$*")

echo "$file"
# open explorer.bat "$file"


if [ "$OS" == "Windows_NT" ]; then
    # cygwin works for below
    explorer.exe /Select, "$file"
elif [ "$OS" == "Darvin" ]; then
    # open .
    echo "open ."
else
    #The following works in all desktop environments by using the default file manager:
    echo "$file"

    if ! [ -x "$(command -v nautilus)" ]; then # default
        xdg-open .   # specifying file runs iT
        # xdg-open "$file" # You can also open files from the terminal as if you had double clicked them in the file manager:
    else
        nautilus "$file"
        # exit 1
    fi
fi
