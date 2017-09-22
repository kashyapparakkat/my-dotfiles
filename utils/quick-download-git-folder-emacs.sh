read -p "Are you sure to overwrite? " -n 1 -r
echo    # (optional) move to a new line
if [[  $REPLY =~ ^[Yy]$ ]]
then
	echo "yes"
    # [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
	
	
	# cd ~/.emacs.d/my-files/config
	# uncomment to run
	# rm -r ~/.emacs.d/my-files/config
	# svn checkout https://github.com/cibinmathew/cbn_gits/trunk/ported_files/cibin/.emacs.d/my-files/config/personal-configs
	# wget --no-check-certificate https://github.com/cibinmathew/cbn_gits/raw/master/ported_files/cibin/.spacemacs -O ~/.spacemacs
fi
