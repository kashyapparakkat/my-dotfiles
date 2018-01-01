# TODO check windows/cygwin/linux

if [ "$OS" == "Windows_NT" ]; then
    echo "TODO"
    # call convert path to windows.sh
else # if windows + ubuntu; add ubuntu only; add VM
    # convert if starting with /cygdrive
    # convert cygdrive|convert slashes|remove single and double quotes
    file=$(echo "$*"|sed -e "s/\\/cygdrive\\/\\(.\\)\\//\\1:\\\/"|sed 's/\\/\//g'|sed "s/'//g")
    # file=$(echo "$file"|sed 's/~/C:\\Users/'|sed 's/\//\\/g'|sed "s/'//g")
    echo "$file"
fi
