if [ -z "$1" ]; then
    echo "Usage: empty arg"
else 
download-all
fi
		
function download-all() {

# sudo apt install git

git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

}