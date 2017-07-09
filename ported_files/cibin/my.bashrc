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

# This makes it unnecessary to press Tab twice when there is more than one match.
# set show-all-if-ambiguous on

bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"
bind "TAB: menu-complete"
bind "set blink-matching-paren on"
bind "set colored-completion-prefix on"
bind "set completion-map-case on"
bind "set mark-directories on"
# bind "set show-all-if-unmodified on"
# bind "set show-mode-in-prompt on"

#bind -x '"|C-i": cd -\n"'
#bind -x '"|C-i"\C-asudo \C-e"'
#bind -x '"|C-u":"cd ..\n"'
bind '"\C-p":history-search-backward'
bind '"\C-q":"exit\r"'
bind '"\C-i":"cd -\r"'
bind '"\C-i":"\C-asudo \C-e"'
bind '"\C-u":"cd ..\r"'
#bind -x '"|C-q":"exit\n"'
bind -x '"|C-l": clear:echo "cleared"'
# for f12
bind '"\e[24~":"pwd\n"'
# binds Alt 0
bind -x '"\e0":ranger'



# C-u=kill till beginning
# emacs bindings
# reverse-search-history (C-r)
# Search backward starting at the current line and moving `up' through the history as necessary.  This is an incremental search.
# man bash | grep -A294 'Commands for' 
# Set Vi Mode in bash:
# set -o vi 

# Set Emacs Mode in bash:
# set -o emacs 

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
ranger() {
    if [ -z "$RANGER_LEVEL" ]; then
        # /usr/bin/ranger "$@"
        ranger "$@"
    else
        exit
    fi
}

alias r='ranger'
# alias ranger='ranger --choosedir=$HOME/rangerdir; LASTDIR=`cat $HOME/rangerdir`; cd "$LASTDIR"'
# alias ranger='ranger; LASTDIR=`cat $HOME/rangerdir`; cd "$LASTDIR"'


#[ -f ~/.fzf.bash ] && source ~/.fzf.bash


# https://stackoverflow.com/questions/12870928/mac-bash-git-ps1-command-not-found
source ~/.git-prompt.sh
#PS1=$PS1'$(__git_ps1 "(%s) ")'
PS1='\# \[\e[0;31m\]$(r=$?; [[ $r == "0" ]] || echo "[$r] ")\[\e[0m\]\[\e[0;36m\]\u\[\e[0m\] \W\[\e[0;33m\]$(__git_branch)\[\e[0m\]> '

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