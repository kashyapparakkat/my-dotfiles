# fzy is faster than fzf

# map C:\cbn_gits to linux also
# sublime $(convert_path path)
#convert_path(){
# if windows: convert to C:\ from cygdrive&/mnt/c
# if linux:
#	
#}
# C:\cygwin64\bin\mintty.exe --dir "%1" /bin/bash
# C:\cygwin64\bin\mintty.exe --dir "%1" /bin/env CHERE_INVOKING=1 /bin/bash -l

# C:\cygwin\bin\mintty.exe -h always -e /bin/sh -c '/cygdrive/c/cygwin64/mysql2sqlite.sh| /bin/sqlite3 database.sqlite'

#grep "/.*" -E -o ~/.viminfo |sort |uniq -i|fzf|sed 's/"//g'
#echo "$(grep "/.*" -E -o ~/.viminfo |sed 's/"//g'|sort|uniq -i|fzf)"

###TODO

function network() {
	# ping abc,nslookup abc,traceroute,host,host -t CNAME www.redhat.com
	ping "$1"
	echo -e "\n\nnslookup\n"
	nslookup "$1"
	echo -e "\n\nhost -t CNAME"
	host -t CNAME "$1"
	echo -e "\n\ntraceroute\n"
	echo -e "\n\ndig\n"
	dig "$1"
	traceroute "$1"
}

function smart_recent(){
	pwd
	# call re
	# case $1 in
	# npp: npp choice 
}




function cbn(){
echo "
alias sf='searchfiles'

alias st='searchtext'
# search is recursive by default
alias sth='searchhere'

# alias stf='searchtext .'

alias sn='searchnotes'
alias snf='searchnotes .|fzs' # sn fuzzy

alias sa='searchall'
alias saf='searchall .'


# TODO
alias srf='searchInRecentfiles .'


alias ex='exit'

alias ff='pcfind common_fuzzy fuzzy_db'
alias f='pcfind common db'
alias fa='pcfind all db'
alias ffa='pcfind all_fuzzy fuzzy_db'
alias faf='pcfind all_fuzzy fuzzy_db'
"|fzy -l 22
}

#set PATH $PATH=/usr/local/bin
export PATH=/usr/local/bin:$PATH
export PATH=~/anaconda3/bin:$PATH
export PATH=$PATH:/mnt/c/Windows/System32
# copy file path to clipboard
  #newline must be stripped http://stackoverflow.com/questions/12524308/bash-strip-trailing-linebreak-from-output
  mpf() {
    FILE=$(mdfind -name . 2> /dev/null | fzf) \
      && echo "${FILE}" | tr -d '\n' | pbcopy
  }

function recent_files(){
	# recent

	# linux ~/.config/sublime-text-2/Settings/Session.sublime_session, so look for such a file in the Settings folder in your user directory.
	# In Mac OS X this list is stored in a file called Session.sublime_session under ~/Library/Application Support/Sublime Text 2/Settings, 
	sublime_file=C:/Users/"$USERNAME"/AppData/Roaming/Sublime\ Text\ 3/Local/Session.sublime_session
	notepadpp_file=/cygdrive/c/Users/"$USERNAME"/AppData/Roaming/Notepad++/session.xml
	notepadpp_file2=/cygdrive/c/Users/"$USERNAME"/AppData/Roaming/Notepad++/session.xml
	if [ -f ~/.viminfo ]; then
	grep "~?/.*" -E -o ~/.viminfo |sed 's/"//g'>~/cbn_history.txt
	fi
	if [ -f "$sublime_file" ]; then
		# TODO  below json parsing is not proper when multiple entries in the array ['windows'][0]
	cat "$sublime_file"|python -c "import sys, json; print('\n'.join(json.load(sys.stdin)['windows'][0]['file_history']))"|convert_forwardslash_windows_to_cygdrive
	# grep "~?/.*\"" -E -o "$sublime_file" |sed 's/"//g'>>~/cbn_history.txt
	fi
	[ -f "$notepadpp_file" ] && grep "\\w:\\\[^\"]*\" " -E -o "$notepadpp_file">>~/cbn_history.txt
	[ -f "$notepadpp_file2" ] && grep "\\w:\\\[^\"]*\" " -E -o "$notepadpp_file2">>~/cbn_history.txt
	# if [ -f "$notepadpp_file" ]; then  
	# 	grep "\\w:\\\[^\"]*\" " -E -o "$notepadpp_file">>~/cbn_history.txt
	# fi
	#remove ", trailing spaces
	echo  "$(cat ~/cbn_history.txt|convert_to_cygdrive|clean_filepaths|lsort|uniq -i)"
	#C:\Users\cibin\AppData\Roaming\Notepad++\session.xml
}
function clean_filepaths(){
	# remove quotes|remove trailing spaces
	sed 's/"//g'|sed 's/ *$//'| sed '/^ *$/d'

}
function escape_spaces(){
	sed 's/ /\\ /g'

}
function re() {
	file="$(recent_files|fzf|sed 's/ /\\ /g')"
	if [ -f "$file" ]; then		
	    vim "$file"
	else
		echo "file:$file not found"
	fi
}

function red(){
	# recent d
	cd "$(recent_dirs|fzf|sed 's/ /\\ /g')"

}


function recent_dirs(){

	#remove ", trailing spaces
	# TODO get dires of recent_files in vim,ranger,sublime

	# echo  "$(cat ~/cbn_history.txt|convert_to_cygdrive|clean_filepaths|lsort|uniq -i)"	
	cd_history=$(cat ~/.z|cut -d'|' -f1|convert_to_cygdrive)
	all_recent_files=$(recent_files|sed 's|/[^/]*$||')
	# all_dirs=$all_recent_files$cd_history	

	# TODO \n not working
	all_dirs="${all_recent_files}zzzzzz${cd_history}"
	echo "$all_dirs" |sed 's=/[^\\/]*$=='|clean_filepaths| lsort|uniq -i

}

function convert_to_cygdrive(){
	#also converts slashes
	sed -e "s/\\(.\\):/\\/cygdrive\\/\\1/"  -- "$@"|sed 's/\\/\//g'

}

function convert_forwardslash_windows_to_cygdrive(){
	#with/without colon
	#also converts slashes
	# /c/xyz or /c:/xyz -> /cygdrive.c/xyz
	sed -e "s/\\/\\(.\\):\?\\//\\/cygdrive\\/\\1\\//"  -- "$@"|sed 's/\\/\//g'

}

#www.cibinmathew.com
#github.com/cibinmathew




# Go back to previous folder
# cd -

# for most of the regex lookaround searches defined here like
# cmd abc xyz$ can be used to search for .xyz extension 


# credits:
# http://rejeep.github.io/bash/2009/06/03/bash-tips.html

# initial configuration
# to make startup faster; http://stackoverflow.com/questions/28410852/startup-is-really-slow-for-all-cygwin-applications

# for case insensitive autocompletion, in  /etc/inputrc or ~/.inputrc uncomment
# set completion-ignore-case on 



# don't put duplicate lines or empty spaces in the history
export HISTCONTROL=ignoreboth

# merge session histories
shopt -s histappend



source $HOME/misc_lib.sh
source $HOME/lib.sh
#source $HOME/myalias.sh
function op() {
echo "$#"
echo "$2"
echo "$2" | head -"$1" | tail -1
# echo "$1"

}
alias mkcd='_(){ mkdir $1; cd $1; }; _'



# ls after cd
# I always, no matter what, want to list the current folders contents when I enter it. So after a while when gotten tired of typing ls all the time. I wrote a little function to do the job:
# Does ls after cd.
function cd()
{
  builtin cd ${1:-$HOME} && ls
}

# Fast ls
# As you might figure out from the previous tip, I like to know what I have in the current folder, all the time. The above only helps if I move around between different folders. So I needed something when changing a lot in the current folder.
function lss(){
#ls stats
ls
lfind . -type f | sed 's/.*\.//' | sort | uniq -c
ls|wc -l
#du
}
alias ls='_(){ ls --color=auto -p "$@" ; lfind . ! -name . -prune -print | grep -c /; }; _'


bind -x '"\C-o"':"ls -lh"
# Put this in your ~/.bashrc file and then source it with source ~/.bashrc and try it out by pressing C-o (Ctrl and o).





#switch case example
	#case $# in
	#2)  grep -PrIi "(?=.*$1[^/]*$)(?=.*$2[^/]*$)" --color=auto $Universal_home/Downloads/all_files.db |  sed -e "s/\\/cygdrive\\///";;
	#3)  grep -PrIi "(?=.*$1[^/]*$)(?=.*$2[^/]*$)(?=.*$3[^/]*$)" --color=auto $Universal_home/Downloads/all_files.db |  sed -e "s/\\/cygdrive\\///";;
	#4)  grep -PrIi "(?=.*$1[^/]*$)(?=.*$2[^/]*$)(?=.*$3[^/]*$)(?=.*$4[^/]*$)" --color=auto $Universal_home/Downloads/all_files.db |  sed -e "s/\\/cygdrive\\///";;
	#*)  echo "too many arguments"  ;; 
	#esac

## RANGER	
# Preventing nested ranger instances
# You can start a shell in the current directory with S, when you exit the shell you get back to your ranger instance.
# When you however forget that you already are in a ranger shell and start ranger again you end up with ranger running a shell running ranger.
# To prevent this you can create the following function in your shell's startup file:
# ranger() {
    # if [ -z "$RANGER_LEVEL" ]; then
				#####/usr/bin/ranger "$@"
        # ranger "$@"
    # else
        # exit
    # fi
# }

# alias ranger='/usr/bin/python3.6m.exe /cygdrive/c/cygwin64/bin/ranger --choosedir=$HOME/rangerdir; LASTDIR=`cat $HOME/rangerdir`; cd "$LASTDIR"'
alias ranger='/usr/bin/python3.6m.exe /cygdrive/c/cygwin64/bin/ranger' #; LASTDIR=`cat $(cd)`; cd "$LASTDIR"'

alias r='ranger'

#[ -f ~/.fzf.bash ] && source ~/.fzf.bash


# https://stackoverflow.com/questions/12870928/mac-bash-git-ps1-command-not-found
source ~/.git-prompt.sh
#PS1=$PS1'$(__git_ps1 "(%s) ")'
PS1='\# \[\e[0;31m\]$(r=$?; [[ $r == "0" ]] || echo "[$r] ")\[\e[0m\]\[\e[0;36m\]\u\[\e[0m\] \w\[\e[0;33m\]$(__git_branch)\[\e[0m\]> '

__git_branch() {
    git branch 2>/dev/null | grep -e '^*' | sed -E 's/^\* (.+)$/(\1)/'
}

#Sometimes you have multiple terminal windows open at the same time. By default, the window that closes last, will overwrite the bash history file, loosing the history of all the other terminal windows and ssh sessions in the process. This can be avoided by this little setting:

# merge session histories
shopt -s histappend

#colorize my man pages (and all less output in general):
# colorful man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m' # end the info box
export LESS_TERMCAP_so=$'\E[01;42;30m' # begin the info box
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'


# use colordiff instead of diff if available
command -v colordiff >/dev/null 2>&1 && alias diff="colordiff -u"
 
# use htop instead of top if installed
command -v htop >/dev/null 2>&1 && alias top=htop
#The command -v bit checks if the app in question is installed, and creates the alias only if it is found. I’m redirecting the output so that I don’t get error messages scrolling on the screen when I log in.

# corrects typos (eg: cd /ect becomes cd /etc)
shopt -s cdspell

export PAGER="/usr/bin/less -isM"
export LESS="/usr/bin/less -isM"


#z fuzzy cd completion
source ~/my-scripts/z/z.sh


source ~/my.keybindings.sh
# Rename command prompt
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'
if [[ "$unamestr" == 'Darwin' ]]; then
  export PROMPT_COMMAND='echo -ne "\033]0;🍎${PWD##*/}\007"'
elif [[ "$unamestr" == 'Linux' ]]; then
  export PROMPT_COMMAND='echo -ne "\033]0;🐧${PWD##*/}\007"'
fi

# Set the PS1 prompt (with colors).
# Based on http://www-128.ibm.com/developerworks/linux/library/l-tip-prompt/
# And http://networking.ringofsaturn.com/Unix/Bash-prompts.php .
# http://ezprompt.net/
if [[ "$unamestr" == 'Darwin' ]]; then
  export PS1="\[\e[00;33m\]\u\[\e[0m\]\[\e[00;37m\]@\h:\[\e[0m\]\[\e[00;36m\]\w\[\e[0m\]\[\e[00;37m\] \[\e[0m\] \D{%T} \n$ "
elif [[ "$unamestr" == 'Linux' ]]; then
  #extremely different colors for linux so I don't confuse myself when SSH'ing
  export PS1="\[\e[00;32m\] 🐧 \u\[\e[0m\]\[\e[00;45m\]@\h:\[\e[0m\]\[\e[00;36m\]\w\[\e[0m\]\[\e[00;37m\] \[\e[0m\] \D{%T} \n$ "
fi



# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss

PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"
# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login

if [[ "$unamestr" == 'Darwin' ]]; then
  export HISTFILE=$HOME/Dropbox/dev/bash_eternal_history_mac.txt
elif [[ "$unamestr" == 'Linux' ]]; then
  export HISTFILE=$HOME/dev/bash_eternal_history_linux.txt
fi





function xpl() {
	#alias vl='vim $(fc -s)' # will open the output of last command in vi
	file ="$(fc -s|head -$1 | tail -1)"
	echo "$file"
	# ff=$(echo /cygdrive/f/july\ 2/ |  sed -r "s/\\/cygdrive\\/(.)\\//\1:\\\\\\\/" | sed -e "s/\\//\\\\\\\/g" | sed -r "s/(.*)\\\\\\\/\"\1\"/")
	# echo "$ff"
	# explorer.exe "$ff"
	# if [ ! -f "$file" ]; then
		# echo "File exist"
    # else
		# echo "File not found!"
	# fi
}

function open() { 

# http://robertmarkbramprogrammer.blogspot.in/2007/06/cygwin-bash-script-open-windows.html
if [ $# -eq 0 -o  -n "$1" ]; then	
        if [ -n "$1" ];  then	
		# normal argument
			filepath="$1"
		else	
		# capture the piped input as an argument             
			read filepath; 		
		fi
		echo "file is $filepath"
		filepath=$(echo "$filepath" | head -1)
	 #if [ -z "$1" ]; then
		   
	   	 
	# location=.
	# case "$1" in
	 # ""                 ) location=.;;
	 # "-help"            ) usage; exit 0;;
	 # *                  ) location="${1}";;
	# esac
	 
	# if [ -e "$location" ]
	# then
	   # WIN_PATH=`cygpath -w -a "${location}"`
	   # cmd /C start "" "$WIN_PATH"
	# else
	 # echo ${location} does not exist!
	 # exit 2
	# fi

	b=$(echo $filepath | sed 's/\(.\)/\1:/' | sed -e "s/\\//\\\\/g")
	echo opening "$b"
	cmd /C start "" "$b"
	 
 
 else
 {
        echo "else $*"
	 echo "Open Windows Explorer"
	 echo "Usage: $0 [-help] [path]"
	 echo "          [path]: folder at which to open Windows Explorer, will"
	 echo "              default to current dir if not supplied."
	 echo "          [-help] Display help (this message)."
	
	}
    fi
 }
 
#delete
# grep "~?/.*" -E -o ~/.viminfo |sed 's/"//g'>~/cbn_history.txt
# grep "~?/.*\"" -E -o "$sublime_file" |sed 's/"//g'>>~/cbn_history.txt
# grep "\\w:\\\[^\"]*\" " -E -o /cygdrive/c/Users/"$USERNAME"/AppData/Roaming/Notepad++/session.xml>>~/cbn_history.txt
# #remove ", trailing spaces
# echo  "$(cat ~/cbn_history.txt|convert_to_cygdrive|sed 's/"//g'|sed 's/ *$//'|sort|uniq)"
#delete


# fzf|escape_spaces|recent_in_app

function remove_color_code() {
# https://unix.stackexchange.com/questions/55546/removing-color-codes-from-output
	sed 's/\x1B\[[0-9;]*[JKmsu]//g' -- "$@"
}
function extract_filepath_linenum(){
# TODO extract linenum
# echo "/cygdrive/c/cygwin64/home/cibin/my.bashrc:23:342:adf"
read arg
echo -e "$arg"|remove_color_code|  sed -e 's/\x1b\[[0-9;]*m//g'|sed -e "s/\\([^:]*\\):\?\\([[:digit:]]\+\\)\\(.*\\)/\\1:\\2/"
# sed -e 's/\x1b\[[0-9;]*m//g'|sed -e "s/\\([^:]*\\):\?\\([[:digit:]]\+\\)\\(.*\\)/\\1:\\2/" -- "$@"

}

function recent_in_app(){
	# file="$(recent_files|escape_spaces|fzf|open_in_app)"
	recent_files|remove_color_code|escape_spaces|fzf|open_in_app
	# echo "$file"
}


function prompt_for_s(){

	read -n 1 -p "a/f/n/r/t " pressedkey < /dev/tty;
	case $pressedkey in
		 n ) echo " searching...";snf|extract_filepath_linenum|open_in_app;;
		 t ) st|extract_filepath_linenum|open_in_app;;
		 r ) srf|extract_filepath_linenum|open_in_app;;
		 a ) saf|extract_filepath_linenum|open_in_app;;
		 f ) sf|open_in_app;;
		 d ) echo "HHHHHHHHHHHHHHH $filepath"|clip;;
	esac
}

function smart_open(){

cr=`echo $'\n.'`
cr=${cr%.}

 read -n 1 -p "s/z$cr" pressedkey </dev/tty
	case $pressedkey in

	    s ) echo; prompt_for_s;;
	    r ) echo "$filepath";open_in_ranger $(echo "$filepath");;
	    v ) echo "$filepath";open_in_vim $(echo "$filepath");;
	    e ) open_in_explorer $(echo "$filepath");;
	esac


}


# echo "/cygdrive/c/cbn_gits/delete.py"|open_in_app
function open_in_app(){

	 # if (( $# == 0 )) ; then
  #       echo < /dev/stdin
  #       echo
  #   else
  #       echo  <<< "$1"
  #       echo
  #   fi
read filepath #</dev/tty

textreset=$(tput sgr0) # reset the foreground colour
red=$(tput setaf 1)
yellow=$(tput setaf 2) 

echo "!!${yellow} file: ${textreset} ${red} $filepath ${textreset}."
 	

# echo
# filepath=$(</dev/stdin)

# # sublime notepadpp explorer ranger cdbash vim emacs clipb
# Get a carriage return into `cr` -- there *has* to be a better way to do this
cr=`echo $'\n.'`
cr=${cr%.}


while true; do
    read -n 1 -s -p "Open in [sublime/notepad++/explorer/vim/emacs /less $cr e explorer/d desktop/r ranger] $cr cc clipb1 cd cygdrive 2 windows $cr cd   q=quit  f=foldersearch r=recent again d=directory search] $cr" pressedkey </dev/tty
	# if [ "$pressedkey" = $'\e' ]; then
	#         echo -e "\n [ESC] Pressed"
	        
	# elif [ "$pressedkey" == $'\x0a' ] ;then
	#         echo -e "\n [Enter] Pressed"
	        
	# fi	
	escaped_filepath=$(echo "$filepath"|escape_spaces)
	echo -e "escaped_filepath=$escaped_filepath\n"
    case $pressedkey in
	    # [Yy]* ) rm ~/cron/beeb.txt; /usr/bin/get-iplayer --type tv>>~/cron/beeb.txt; break;;
	    l ) less "$filepath"; break;;
	    r ) echo "$filepath"|open_in_ranger ; break;;
	    v ) echo "$escaped_filepath"|open_in_vim; break;;
	    e ) open_in_explorer $(echo "$filepath"); break;;
	   
	    b ) cd_to_directory $(echo "$filepath"); break;;

	    c ) echo "$filepath"|clip; 
				read -n 1 -s -p "1/2" pressedkey < /dev/tty;
				case $pressedkey in
					 c ) echo "$filepath"|clip; break;;
					 d ) echo "HHHHHHHHHHHHHHH $filepath"|clip; break;;
				esac
			
	     break;;
	    o ) default_run $(echo "$filepath"); break;;
	    [Nn]* ) open_in_npp $(echo "$filepath"); break;;
	    [Ss]* ) open_in_sublime_text $(echo "$filepath"); exit;break;;
	    [Qq]* ) exit; break;;
	        * ) echo "adfasf";echo "$filepath";open_in_vim $(echo "$filepath"); break;;
    esac    	
	echo "try again" #;break;
done


}

function cd_to_directory() {
	arg=$*
if [[ -d $arg ]]; then
	echo "$arg is a directory"
	cd "$arg"
elif [[ -f $arg ]]; then
	parentdir="$(dirname "$arg")"
	cd "${parentdir}"
	# pwd

else
echo "$arg is not valid"
# exit 1
fi


}
function aaa(){
	c=$(return_arg_or_piped_input $*)
	echo "aaa=$c"
}

function return_arg_or_piped_input(){
	if [ -t 0 ]; then
	    echo "$1"
	else
	    read a
	    echo "$a"
	fi
}

# ls working colorful on all OS'es
#linux
if [[ `uname` == Linux ]]; then
    export LS1='--color=always'
#mac
elif [[ `uname` == Darwin* ]]; then
    export LS1='-G'
#win/cygwin/other
else
    export LS1='--color=auto'
fi

export LS2='-hF --time-style=long-iso'
alias l='ls $LS1 $LS2 -AB'




function open_in_emacs(){	
	~/my-scripts/emacs.sh "$(~/my-scripts/convert_path_to_windows.sh $*)"
}
function open_in_explorer(){	
	~/my-scripts/open_explorer.sh "$(~/my-scripts/convert_path_to_windows.sh $*)"
}
function open_in_npp(){	
	~/my-scripts/npp.sh "$(~/my-scripts/convert_path_to_windows.sh $*)"
}
function open_in_sublime_text(){
	~/my-scripts/sublime_text.sh "$(~/my-scripts/convert_path_to_windows.sh $*)"
}
function default_run(){	
	~/my-scripts/default_run.sh "$(~/my-scripts/convert_path_to_windows.sh $*)"

}



