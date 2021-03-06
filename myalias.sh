# ; http://www.cibinmathew.com
# ; github.com/cibinmathew

#########
# Aliases
#########
# some are from https://www.cyberciti.biz/tips/bash-aliases-mac-centos-linux-unix.html
# explore more for better ones

# add this to windows also if possible
# emacs send signal to emacs to turn on debug on quit
alias emacsd='pkill -SIGUSR2 emacs'
# my custom functions
# add these to initialise.sh also

function l() {
  less -isNm *.$1
}

# fzf cant take input interactively, fzy can take
# if WINDOWS
# duplicate find.exe as lfind.exe, lsort.exe, ...

alias find='find' # initialisation to prevent error
  alias find='/usr/bin/find'
  alias sort='/usr/bin/sort'
if [ "$machine" == "Windows" ]; then

	# alias ranger='/usr/bin/python3.6m.exe /cygdrive/c/cygwin64/bin/ranger --choosedir=$HOME/rangerdir; LASTDIR=`cat $HOME/rangerdir`; cd "$LASTDIR"'

	alias ranger='/usr/bin/python3.6m.exe /cygdrive/c/cygwin64/bin/ranger' #; LASTDIR=`cat $(cd)`; cd "$LASTDIR"'

else  # else if linux/Mac *nix
	alias lfind='find'
	alias lsort='sort'
fi

if [ "$machine" == "Windows" ]; then
alias clip='clip'
elif [ "$machine" == "Linux" ]; then
alias clip='xclip -selection c'

elif [ "$machine" == "Mac" ]; then
alias clip='pbcopy'

fi


# s file/text-ext/all-text/common-text/notes [=recurse/here/recent/allfileslist] [fuzzy]

alias r='ranger'

alias crons='source ~/cron-job.sh'




alias fzft='fzf --preview "'"echo {} | cut -f1 -d":" | xargs cat {};"'"'
# fzf --preview "head -100 {}"'


alias s='prompt_for_s'

alias sa='searchall'
alias saf='searchall .|fzy -l 25'
alias searchfiles='searchfilesraw|fzy -l 20'
alias searchfolders='cat ~/all_folders2.db|fzy -l 20'

alias sf='searchfiles|open_in_app'
alias sf='searchfilesraw|fzft'

alias scf='a=$(searchcommands);echo "$a";echo "$a"|clip'
alias sn='searchnotes'
alias sNf='searchnotes -m 5 .|fzy -l 25|open_in_app' # sn fuzzy
alias snf='searchnotes .|fzy -l 25|open_in_app' # sn fuzzy

alias snf='searchnotes .|fzft'




alias spf='searchproject .|fzy -l 25' # sp fuzzy
alias sp='searchproject'


alias srf='searchInRecentfiles .|fzft'
alias sr='searchInRecentfiles'

alias st='searchtext'
alias stf='searchtext|fzy -l 25|extract_filepath_linenum|open_in_app'
# search is recursive by default
alias searchhere='searchtext -n'
alias sth='searchhere .|fzft|extract_filepath_linenum|open_in_app'
# alias stf='searchtext .'

alias vi='vim'
if [ -e /usr/bin/vimx ]; then alias vim='/usr/bin/vimx'; fi
if [ -e /usr/bin/vim.gtk ]; then alias vim='/usr/bin/vim.gtk'; fi

# vim without plugins for faster and large file navigation
alias vimu='vim -u NONE'
alias vimu='vim -u ~/basic-settings-no-plugins.vimrc'
alias ex='exit'

# GIT
# TODO
# best one:
alias glog="git log --graph --pretty='format:%C(red)%d%C(reset) %C(yellow)%h%C(reset) %ar %C(green)%aN%C(reset) %s' && git log --stat"
# git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
# git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative
# alias gl='git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative && git log --name-status'
#alias git='tig'
alias gdf='git diff --stat && git log --stat && git diff'
# alias gcm='git commit -a -m'
#git commit message
function gcm(){
  echo "git diff --stat && git commit   && git push"
  git diff --stat && git commit -am "$*" && git log --stat
}
         # git commit push
function gcp(){
  echo "git diff --stat && git commit   && git push"
  git diff --stat && git commit -am "$*" && git push && git log --stat
}
function gls()
{
git_del=$(git ls-files --deleted)
git_mod=$(git ls-files --modified)
#git diff --name-only --diff-filter=A --cached # All new files in the index
#git diff --name-only --diff-filter=A          # All files that are not staged
git_added=$(git diff --name-only --diff-filter=A HEAD)     # All new files not yet committed


echo "DEL: $git_del \n $cr $cr MOD:$git_mod \n ADD: $git_added"
}

alias ff='pcfind common_fuzzy fuzzy_db'
alias f='pcfind common db'
alias fa='pcfind all db'
alias ffa='pcfind all_fuzzy fuzzy_db'
alias faf='pcfind all_fuzzy fuzzy_db'

alias fr='pcfind rhere live' # recurse here
alias frr='pcfind rrhere live' # recurse here
alias fh='pcfind h live' # recurse here only 2 levels
alias fhh='pcfind hh live' # recurse here only 2 levels
alias fhhh='pcfind hhh live' # recurse here only 2 levels
alias fhhhh='pcfind hhhh live' # recurse here only 2 levels

alias g='advgrep'
alias gn='advgrep notes'
alias gnc='advgrep notes common'
alias gat='advgrep all txt'

## LINUX AND WINDOWS COMMON ALIASES

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias cgrep='cgrep --color=auto -C 1'

## get rid of command not found ##
alias cd..='cd ..'

## a quick way to get out of current directory ##

alias cd~='cd ~'
alias cdmisc='cd $cbn_git_path/cbn_gits/misc'
alias cdahk='cd $cbn_git_path/cbn_gits/AHK'
alias cdd='cd $Universal_home/Downloads'
alias cdh='cd ~'
alias cdp='cd $Universal_home/Downloads/Projects'
# alias cdd='cd ~/Downloads'

alias cd.='cd ..'
alias cd..='cd ../..'
alias cd...='cd ../../..'

alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'




# Show me the size (sorted) of only the folders in this directory
alias folders="lfind . -maxdepth 1 -type d -print | xargs du -sk | sort -rn"

# This will keep you sane when you're about to smash the keyboard again.
alias frak="fortune"

# This is where you put your hand rolled scripts (remember to chmod them)
PATH="$HOME/bin:$PATH"


# cd into the old directory
alias bd='cd "$OLDPWD"'

alias emacsmode='set -o emacs'
alias vimode='set -o vi'

alias ins='sudo apt-get install'
#I use this about 20 times a day to cd into the last changed directory:

cl()
{
        last_dir="$(ls -Frt | grep '/$' | tail -n1)"
        if [ -d "$last_dir" ]; then
                cd "$last_dir"
        fi
}
# We can find files in our current directory easily by setting this alias
alias fhere="lfind . -iname "

## set some other defaults ##
alias du="du -ach | sort -h"
alias df='df -H'

# top is atop, just like vi is vim
alias top='atop'
#-p flag to make any necessary parent directories. We can make this the default:
alias mkdir="mkdir -p"
#Have you ever needed your public IP address from the command line when you're behind a router using NAT? Something like this could be useful:
alias myip="curl http://ipecho.net/plain; echo"

#If I then have to upload them to a server, I can use sftp to connect and automatically change to a specific directory:

alias upload="sftp username@server.com:/path/to/upload/directory"
alias ll='ls -lhA --color=auto'
alias ls='ls --color=auto -p'
## Show hidden files ##
alias l.='ls -d .* --color=auto'




# if user is not root, pass all commands via sudo #
if [ $UID -ne 0 ]; then
    alias reboot='sudo reboot'
    alias update='sudo apt-get upgrade'
fi

# os specific aliases

### Get os name via uname ###
_myos="$(uname)"

### add alias as per os using $_myos ###
case $_myos in
   Linux) alias foo='/path/to/linux/bin/foo';;
   FreeBSD|OpenBSD) alias foo='/path/to/bsd/bin/foo' ;;
   SunOS) alias foo='/path/to/sunos/bin/foo' ;;
   *) ;;
esac


#8: Command short cuts to save time

# handy short cuts #
alias h='history'
alias j='jobs -l'

#11: Control output of networking tool called ping

# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'
# Do not wait interval 1 second, go fast #
alias fastping='ping -c 100 -s.2'



#16: Add safety nets

# do not delete / or prompt if deleting more than 3 files at a time #
alias rm='rm -I --preserve-root'

# confirmation #
alias mv='mv -i -v'
alias cp='cp -i'
alias ln='ln -i'

# Parenting changing perms on / #
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'


#19: Tune sudo and su

# become root #
alias root='sudo -i'
alias su='sudo -i'

#20: Pass halt/reboot via sudo

# shutdown command bring the Linux / Unix system down:

# reboot / halt / poweroff
alias reboot='sudo /sbin/reboot'
alias poweroff='sudo /sbin/poweroff'
alias halt='sudo /sbin/halt'
alias shutdown='sudo /sbin/shutdown'

#21: Control web servers

# also pass it via sudo so whoever is admin can reload it without calling you #
alias nginxreload='sudo /usr/local/nginx/sbin/nginx -s reload'
alias nginxtest='sudo /usr/local/nginx/sbin/nginx -t'
alias lightyload='sudo /etc/init.d/lighttpd reload'
alias lightytest='sudo /usr/sbin/lighttpd -f /etc/lighttpd/lighttpd.conf -t'
alias httpdreload='sudo /usr/sbin/apachectl -k graceful'
alias httpdtest='sudo /usr/sbin/apachectl -t && /usr/sbin/apachectl -t -D DUMP_VHOSTS'



## this one saved by butt so many times ##
alias wget='wget -c'




# alias e='emacsclient -t'
# alias ec='emacsclient -c'
# alias vim='emacsclient -t'
# alias vi='emacsclient -t'






### FASD
# To get fasd working in a shell, some initialization code must be run. Put the line below in your shell rc.
# echo "fasd begin"
# eval "$(fasd --init auto)"
# Note that this method will slightly increase your shell start-up time, since calling binaries has overhead. You can cache fasd init code if you want minimal overhead. Example code for bash (to be put into .bashrc):

# fasd_cache="$HOME/.fasd-init-bash"
# if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  # fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
# fi
# source "$fasd_cache"
# unset fasd_cache
# echo "fasd ended"

# Fasd comes with some useful aliases by default:

alias a='fasd -a'        # any
# alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
# alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
# alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection

alias v='f -e vim' # quick opening files with vim

function emacs(){
# https://www.emacswiki.org/emacs/EmacsAsDaemon
    #!/bin/bash
USERID=`id -u`
if [ ! -e /tmp/emacs$USERID/server ]
then
	echo "Starting server."
	/etc/init.d/emacs start
        while [ ! -e "/tmp/emacs$USERID/server" ] ; do sleep 1 ; done
fi

emacsclient -c "$@"
}


# https://github.com/junegunn/fzf/wiki/Examples#git
PATH=$PATH:~/diff-so-fancy-master
alias glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
hhh="echo {} | grep -o '[a-f0-9]\{7\}' | head -1| xargs -I % sh -c 'git show --color=always % | diff-so-fancy'"


# fcoc_preview - checkout git commit with previews
fcoc_preview() {
  local commit
  commit=$( glNoGraph |
    fzf --no-sort --reverse --tiebreak=index --no-multi \
            --ansi --preview 'echo {} | grep -o "[a-f0-9]\{7\}" | head -1| xargs -I % sh -c "git show --color=always % |diff-so-fancy"')      &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}


# fshow_preview - git commit browser with previews
fshow_preview() {
    glNoGraph |
        fzf --no-sort --reverse --tiebreak=index --no-multi \
            --ansi --preview 'echo {} | grep -o "[a-f0-9]\{7\}" | head -1| xargs -I % sh -c "git show --color=always % |diff-so-fancy"'
                --header "enter to view, alt-y to copy hash" \
                --bind "enter:execute:$_viewGitLogLine   | less -R" \
                --bind "alt-y:execute:$_gitLogLineToHash | xclip"
}

#### diff highlight
# TODO sometimes it is needed per repo
git config pager.log 'diff-highlight | less -r'
git config pager.show 'diff-highlight | less -r'
git config pager.diff 'diff-highlight | less -r'
# That covers almost everything, but there's one spot missing: diffs shown by the interactive patch-staging tool (you are using interactive
# staging, right?). In Git 2.9, you can now ask it to filter the diffs it shows through any script you like:
git config interactive.diffFilter diff-highlight


# tmux
alias tmuxd='tmux new-session -s default'

if [ -d "~/anaconda2/bin/python" ]; then alias python2='~/anaconda2/bin/python'; fi
if [ -d "~/anaconda3/bin/python" ]; then alias python3='~/anaconda3/bin/python'; fi

# prefer python 3 over 2
if [ -d "~/anaconda2/bin/python" ]; then alias python='~/anaconda2/bin/python'; fi
if [ -d "~/anaconda3/bin/python" ]; then alias python='~/anaconda3/bin/python'; fi
