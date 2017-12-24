echo "path=$1"
# !~/my-scripts/sublime_text $(convert_path path)
if [ "$OS" == "Windows_NT" ]; then 
C:/Program\ Files/Sublime\ Text\ 3/sublime_text.exe "$1"
# C:/Program\ Files/Sublime\ Text\ 3/sublime_text.exe "C:\cygwin64\home\cibin\my-scripts\sublime_text.sh"

else 
subl "$1"
fi
