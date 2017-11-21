# | variable		|linux|windows|
# | Universal_home | ~ | /cygdrive/c/Users/username|
# | cbn_git_path| ~/cbn_gits| /cygdrive/c/cbn_gits|
# | ~| ~|/cygdrive/c/cygwin64/home/username|
#

# function set_home_directory() {

	if [ "$OS" == "Windows_NT" ]; then
		Universal_home=$(cygpath -H)  # /cygdrive/c/users
		cbn_git_path="/cygdrive/c"
		Universal_home="$Universal_home/$USERNAME"
	else
		cbn_git_path="~"
		Universal_home=$HOME
		# echo "linux machine"
	fi

	export Universal_home
	# echo "$Universal_home"




unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Windows;;
    MINGW*)     machine=Windows;;
    *)          machine="UNKNOWN:${unameOut}"
esac
export machine
echo ${machine}




# }
