if [ -z "$1" ]; then
    echo "Usage: empty arg"
else 
download-all
fi
		
function download-all() {


echo "downloading ..."
wget --no-check-certificate https://github.com/cibinmathew/cbn_gits/raw/master/ported_files/cibin/.bashrc -O ~/.bashrc
wget --no-check-certificate https://github.com/cibinmathew/cbn_gits/raw/master/ported_files/cibin/.vimrc -O ~/.vimrc
wget --no-check-certificate https://github.com/cibinmathew/cbn_gits/raw/master/ported_files/cibin/lib.sh -O ~/lib.sh
wget --no-check-certificate https://github.com/cibinmathew/cbn_gits/raw/master/ported_files/cibin/misc_lib.sh -O ~/misc_lib.sh
wget --no-check-certificate https://github.com/cibinmathew/cbn_gits/raw/master/ported_files/cibin/set_defaults.sh -O ~/set_defaults.sh
wget --no-check-certificate https://github.com/cibinmathew/cbn_gits/raw/master/ported_files/cibin/myalias.sh -O ~/myalias.sh

# wget --no-check-certificate https://github.com/cibinmathew/cbn_gits/raw/master/ported_files/cibin/rc.conf -O ~/.config/ranger/rc.conf.sh


## TODO cd to tmp directory
mkdir ~/tmp-installers
cd ~/tmp-installers


## ranger
# We will also install some other applications that allow ranger to preview various file formats effectively.
# sudo apt-get update

#if debian
# sudo apt-get install ranger caca-utils highlight atool w3m poppler-utils mediainfo


# or
git clone https://github.com/hut/ranger.git
cd ranger
sudo make install 
sudo make install 


## for windows 
## works only with cygwing python
## make install This translates roughly to: 
## python setup.py install --optimize=1 --record=install_log.txt # specify python path here


wget --no-check-certificate https://github.com/cibinmathew/cbn_gits/raw/master/ported_files/cibin/.config/ranger/rc.conf -O ~/.config/ranger/rc.conf
wget --no-check-certificate https://github.com/cibinmathew/cbn_gits/raw/master/ported_files/cibin/.config/ranger/commands.py -O ~/.config/ranger/commands.py

# git clone git://git.savannah.nongnu.org/ranger.git
# or
# tar xvf ranger-stable.tar.gz
# cd ranger-stable
# cd ranger


cd ~/tmp-installers

### FASD
git clone https://github.com/clvv/fasd.git
cd fasd
sudo make install

### z fuzzy cd completion
git clone https://github.com/rupa/z.git ~/my-scripts/z

# http://seanbowman.me/blog/fzf-fasd-and-bash-aliases/
cd ~/tmp-installers

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
sudo ~/.fzf/install


####################
##				  ##
##   FOR WINDOWS  ##
##				  ##
####################

# add cygwin utils here
# fasd, ranger

# cd ~/tmp-installers

### FASD
# git clone https://github.com/clvv/fasd.git
# cd fasd
# sudo make install


# https://stackoverflow.com/questions/12870928/mac-bash-git-ps1-command-not-found
curl -o ~/.git-prompt.sh \
    https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
	
	
	}

# Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# ack
curl https://beyondgrep.com/ack-2.18-single-file > ~/bin/ack && chmod 0755 ~/bin/ack

git clone https://github.com/jhawthorn/fzy.git  ~/my-scripts/fzy

cd ~/my-scripts/fzy
make install
