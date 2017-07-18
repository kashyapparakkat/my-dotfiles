echo "$1"
# convert cygdrive|convert slashes|remove single and double quotes
file=$(echo "$1"|sed -e "s/\\/cygdrive\\/\\(.\\)\\//\\1:\\\/"|sed 's/\//\\/g'|sed "s/'//g")

echo "$file"
explorer.exe /Select, "$file"