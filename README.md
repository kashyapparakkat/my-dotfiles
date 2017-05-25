# cbn_gits

TODO
##Automated

You can install Emacs Prelude via the command line with either curl or wget. Naturally git is also required.

###Via Curl

If you're using curl type the following command:

curl -L https://github.com/cibinmathew/cbn_gits/raw/master/utils/installer.sh | sh
###Via Wget

If you're using wget type:

wget --no-check-certificate https://github.com/cibinmathew/cbn_gits/raw/master/utils/installer.sh -O - | sh
###Manual

git clone git://github.com/bbatsov/prelude.git path/to/local/repo
ln -s path/to/local/repo ~/.emacs.d
cd ~/.emacs.d
If you are using Windows, you should check what Emacs thinks the ~ directory is by running Emacs and typing C-x d ~/<RET>, and then adjust the command appropriately.
