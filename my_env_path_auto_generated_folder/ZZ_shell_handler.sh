#!/usr/bin/sh
echo ==sh handler==
echo "$(pwd)"
filename=${0###*/}
filename=$(basename "$filename") # remove windows path

# remove trailing .sh
func=$(echo $filename | sed -e "s/.sh//")
# echo "/home/$USERNAME/lib.sh"
# ls -l "/home/$USERNAME/lib.sh"
echo "$*"
source /home/$USERNAME/lib.sh && $func $@