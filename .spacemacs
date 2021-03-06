
;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.
(setq-default dotspacemacs-configuration-layers '(
                                                  python
))


( defun dotspacemacs/layers ()
	"Configuration Layers declaration.
	You should not put any user code in this function besides modifying the variable
	values."

	(setq-default
 ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'all
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()


;; List of configuration layers to load. If it is the symbol `all' instead
;; of a list then all discovered layers will be installed.
dotspacemacs-configuration-layers
'(
;; ----------------------------------------------------------------
;; Example of useful layers you may want to use right away.
;; Uncomment some layer names and press <SPC f e R> (Vim style) or
;; <M-m f e R> (Emacs style) to install them.
;; ----------------------------------------------------------------
(auto-completion :variables
	auto-completion-return-key-behavior 'complete
	auto-completion-tab-key-behavior 'cycle
	auto-completion-complete-with-key-sequence nil
	auto-completion-complete-with-key-sequence-delay 0.1
	auto-completion-private-snippets-directory nil)

;; better-defaults
emacs-lisp
;; git
;; markdown
;; org
;; (shell :variables
;;        shell-default-height 30
;;        shell-default-position 'bottom)
;; spell-checking
;; syntax-checking
;; version-control
)
;; List of additional packages that will be installed without being
;; wrapped in a layer. If you need some configuration for these
;; packages, then consider creating a layer. You can also put the
;; configuration in `dotspacemacs/user-config'.
dotspacemacs-additional-packages '(
ob-ipython
	anaconda-mode
	flymake-cursor
	jedi
	epc
	visual-regexp-steroids
	visual-regexp
	company-flx
	flycheck
peep-dired
indent-tools
loccur
sphinx-doc
hide-lines
dired-narrow
	dired-subtree
	git-gutter+
	shrink-whitespace
	dired+
	golden-ratio
	elpy
cycle-quotes
	fuzzy
	ranger
	ob-http
	company-restclient
	free-keys
	magit
	highlight-thing
	mic-paren
	scratch
	company-jedi
ag
flex-isearch
flx-isearch
git-timemachine
	yascroll
	swiper
region-bindings-mode
helm-flyspell
	isend-mode
	menu-bar+
	realgud
	flyspell-popup
	keyfreq
	drag-stuff
	ob-restclient
vdiff
mc-extras
	quick-preview
	visible-mark
	corral
	ivy-hydra
vlf
	restclient
	solarized-theme
	counsel
	auctex
	ido-sort-mtime
	shell-pop
	shell-here
	buffer-flip
	quickrun
	multiple-cursors
	rainbow-mode
	isearch-dabbrev
	dired-k
	dired-filter
	eww-lnum
	dired-quick-sort
	key-chord
	goto-chg
	smex
	color-identifiers-mode

	tabbar
	beacon
	nlinum
	markdown-mode
	)
;; A list of packages and/or extensions that will not be install and loaded.
dotspacemacs-excluded-packages '(
	window-numbering
	)

	    ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
	"Initialization function.
	This function is called at the very startup of Spacemacs initialization
	before layers configuration.
	You should not put any user code in there besides modifying the variable
	values."
;; This setq-default sexp is an exhaustive list of all the supported
;; spacemacs settings.
(setq-default
;; If non nil ELPA repositories are contacted via HTTPS whenever it's
;; possible. Set it to nil if you have no way to use HTTPS in your
;; environment, otherwise it is strongly recommended to let it set to t.
;; This variable has no effect if Emacs is launched with the parameter
;; `--insecure' which forces the value of this variable to nil.
;; (default t)
dotspacemacs-elpa-https t
;; Maximum allowed time in seconds to contact an ELPA repository.
dotspacemacs-elpa-timeout 5
;; If non nil then spacemacs will check for updates at startup
;; when the current branch is not `develop'. (default t)
dotspacemacs-check-for-update nil
;; One of `vim', `emacs' or `hybrid'. Evil is always enabled but if the
;; variable is `emacs' then the `holy-mode' is enabled at startup. `hybrid'
;; uses emacs key bindings for vim's insert mode, but otherwise leaves evil
;; unchanged. (default 'vim)
dotspacemacs-editing-style 'hybrid
;; If non nil output loading progress in `*Messages*' buffer. (default nil)
dotspacemacs-verbose-loading nil
;; Specify the startup banner. Default value is `official', it displays
;; the official spacemacs logo. An integer value is the index of text
;; banner, `random' chooses a random text banner in `core/banners'
;; directory. A string value must be a path to an image format supported
;; by your Emacs build.
;; If the value is nil then no banner is displayed. (default 'official)
dotspacemacs-startup-banner 'official
;; List of items to show in the startup buffer. If nil it is disabled.
;; Possible values are: `recents' `bookmarks' `projects'.
;; (default '(recents projects))
dotspacemacs-startup-lists '(recents projects)
;; Number of recent files to show in the startup buffer. Ignored if
;; `dotspacemacs-startup-lists' doesn't include `recents'. (default 5)
dotspacemacs-startup-recent-list-size 10
;; Default major mode of the scratch buffer (default `text-mode')
dotspacemacs-scratch-mode 'text-mode
;; List of themes, the first of the list is loaded when spacemacs starts.
;; Press <SPC> T n to cycle to the next theme in the list (works great
;; with 2 themes variants, one dark and one light)
dotspacemacs-themes '(spacemacs-dark
	spacemacs-light
	solarized-light
	solarized-dark
	monokai
	zenburn)
;; If non nil the cursor color matches the state color in GUI Emacs.
dotspacemacs-colorize-cursor-according-to-state t
;; Default font. `powerline-scale' allows to quickly tweak the mode-line
;; size to make separators look not too crappy.
dotspacemacs-default-font '("Source Code Pro"
	:size 15
	:weight normal
	:width normal
	:powerline-scale 1)
;; The leader key
dotspacemacs-leader-key "SPC"
;; The leader key accessible in `emacs state' and `insert state'
;; (default "M-m")
dotspacemacs-emacs-leader-key "M-m"
;; Major mode leader key is a shortcut key which is the equivalent of
;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
dotspacemacs-major-mode-leader-key ","
;; Major mode leader key accessible in `emacs state' and `insert state'.
;; (default "C-M-m)
dotspacemacs-major-mode-emacs-leader-key "C-M-m"
;; These variables control whether separate commands are bound in the GUI to
;; the key pairs C-i, TAB and C-m, RET.
;; Setting it to a non-nil value, allows for separate commands under <C-i>
;; and TAB or <C-m> and RET.
;; In the terminal, these pairs are generally indistinguishable, so this only
;; works in the GUI. (default nil)
dotspacemacs-distinguish-gui-tab nil
;; (Not implemented) dotspacemacs-distinguish-gui-ret nil
;; The command key used for Evil commands (ex-commands) and
;; Emacs commands (M-x).
;; By default the command key is `:' so ex-commands are executed like in Vim
;; with `:' and Emacs commands are executed with `<leader> :'.
dotspacemacs-command-key ":"
;; If non nil `Y' is remapped to `y$'. (default t)
dotspacemacs-remap-Y-to-y$ t
;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")

;; Name of the default layout (default "Default")
dotspacemacs-default-layout-name "Default"
;; If non nil the default layout name is displayed in the mode-line.
;; (default nil)
dotspacemacs-display-default-layout nil
;; If non nil then the last auto saved layouts are resume automatically upon
;; start. (default nil)
dotspacemacs-auto-resume-layouts t
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
;; Location where to auto-save files. Possible values are `original' to
;; auto-save the file in-place, `cache' to auto-save the file to another
;; file stored in the cache directory and `nil' to disable auto-saving.
;; (default 'cache)
dotspacemacs-auto-save-file-location 'cache
;; Maximum number of rollback slots to keep in the cache. (default 5)
dotspacemacs-max-rollback-slots 5
;; If non nil then `ido' replaces `helm' for some commands. For now only
;; `find-files' (SPC f f), `find-spacemacs-file' (SPC f e s), and
;; `find-contrib-file' (SPC f e c) are replaced. (default nil)
dotspacemacs-use-ido nil
;; If non nil, `helm' will try to minimize the space it uses. (default nil)
dotspacemacs-helm-resize nil
;; if non nil, the helm header is hidden when there is only one source.
;; (default nil)
dotspacemacs-helm-no-header nil
;; define the position to display `helm', options are `bottom', `top',
;; `left', or `right'. (default 'bottom)
dotspacemacs-helm-position 'bottom
;; If non nil the paste micro-state is enabled. When enabled pressing `p`
;; several times cycle between the kill ring content. (default nil)
dotspacemacs-enable-paste-micro-state nil
;; Which-key delay in seconds. The which-key buffer is the popup listing
;; the commands bound to the current keystroke sequence. (default 0.4)
dotspacemacs-which-key-delay 0.4
;; Which-key frame position. Possible values are `right', `bottom' and
;; `right-then-bottom'. right-then-bottom tries to display the frame to the
;; right; if there is insufficient space it displays it at the bottom.
;; (default 'bottom)
dotspacemacs-which-key-position 'bottom
;; If non nil a progress bar is displayed when spacemacs is loading. This
;; may increase the boot time on some systems and emacs builds, set it to
;; nil to boost the loading time. (default t)
dotspacemacs-loading-progress-bar t
;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
;; (Emacs 24.4+ only)
dotspacemacs-fullscreen-at-startup nil

;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
;; Use to disable fullscreen animations in OSX. (default nil)
dotspacemacs-fullscreen-use-non-native nil
;; If non nil the frame is maximized when Emacs starts up.
;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
;; (default nil) (Emacs 24.4+ only)
dotspacemacs-maximized-at-startup t
;; A value from the range (0..100), in increasing opacity, which describes
;; the transparency level of a frame when it's active or selected.
;; Transparency can be toggled through `toggle-transparency'. (default 90)
dotspacemacs-active-transparency 90
;; A value from the range (0..100), in increasing opacity, which describes
;; the transparency level of a frame when it's inactive or deselected.
;; Transparency can be toggled through `toggle-transparency'. (default 90)
dotspacemacs-inactive-transparency 90
;; If non nil unicode symbols are displayed in the mode line. (default t)
dotspacemacs-mode-line-unicode-symbols t
;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
;; scrolling overrides the default behavior of Emacs which recenters the
;; point when it reaches the top or bottom of the screen. (default t)
dotspacemacs-smooth-scrolling t
;; If non nil line numbers are turned on in all `prog-mode' and `text-mode'
;; derivatives. If set to `relative', also turns on relative line numbers.
;; (default nil)
dotspacemacs-line-numbers nil
;; If non-nil smartparens-strict-mode will be enabled in programming modes.
;; (default nil)
dotspacemacs-smartparens-strict-mode nil
;; Select a scope to highlight delimiters. Possible values are `any',
;; `current', `all' or `nil'. Default is `all' (highlight any scope and
;; emphasis the current one). (default 'all)
dotspacemacs-highlight-delimiters 'all
;; If non nil advises quit functions to keep server open when quitting.
;; (default nil)
dotspacemacs-persistent-server nil
;; List of search tool executable names. Spacemacs uses the first installed
;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
;; (default '("ag" "pt" "ack" "grep"))
dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
;; The default package repository used if no explicit repository has been
;; specified with an installed package.
;; Not used for now. (default nil)
dotspacemacs-default-package-repository nil
;; Delete whitespace while saving buffer. Possible values are `all'
;; to aggressively delete empty line and long sequences of whitespace,
;; `trailing' to delete only the whitespace at end of lines, `changed'to
;; delete only whitespace for changed lines or `nil' to disable cleanup.
;; (default nil)
dotspacemacs-whitespace-cleanup nil
))

(defun dotspacemacs/user-init ()
	"Initialization function for user code.
	It is called immediately after `dotspacemacs/init', before layer configuration
	executes.
	This function is mostly useful for variables that need to be set
	before packages are loaded. If you are unsure, you should try in setting them in
	`dotspacemacs/user-config' first."
	(setq-default evil-escape-key-sequence "jf")

	(setq spacemacs-evil-cursors '(("normal" "#ff00ff" box)
		("insert" "chartreuse3" (bar . 2))
		("emacs" "SkyBlue2" box)
		("hybrid" "red" (bar . 2))
		("replace" "chocolate" (hbar . 2))
		("evilified" "LightGoldenrod3" box)
		("visual" "gray" (hbar . 2))
		("motion" "plum3" box)
		("lisp" "green" box)
		("iedit" "green" box)
		("iedit-insert" "green" (bar . 2))))


	)



(defun dotspacemacs/user-config ()
	"Configuration function for user code.
	This function is called at the very end of Spacemacs initialization after
	layers configuration.
	This is the place where most of your configurations should be done. Unless it is
	explicitly specified that a variable should be set before a package is loaded,
	you should place you code here."



(load-file "~/.emacs.d/my-files/config/personal-configs/cibin-load-all.el")
(load-file "~/.emacs.d/my-files/config/personal-configs/others.el")



(message "checkpoint 61")

(message "reached end of user-config()")

) ; end of user-config()


;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-show-menu 0.2)
 '(ac-auto-start 3)
 '(ac-candidate-limit 30)
 '(ac-delay 0.2)
 '(ac-dwim t)
 '(ac-fuzzy-complete t)
 '(ac-fuzzy-enable t t)
 '(ac-ignore-case (quote smart))
 '(ac-menu-height 20)
 '(ac-show-menu-immediately-on-auto-complete t)
 '(ac-source-filename nil t)
 '(ac-source-files-in-current-dir nil t)
 '(ac-source-words-in-same-mode-buffers nil t)
 '(ac-source-yasnippet nil t)
 '(ac-use-fuzzy t)
 '(ac-use-menu-map t)
 '(ac-use-quick-help t)
 '(blink-cursor-delay 0.3)
 '(blink-cursor-mode t)
 '(clean-buffer-list-delay-general 2)
 '(comint-completion-addsuffix t)
 '(comint-completion-autolist t)
 '(comint-get-old-input (lambda nil "") t)
 '(comint-input-ignoredups t)
 '(comint-move-point-for-output nil)
 '(comint-prompt-read-only nil)
 '(comint-scroll-show-maximum-output t)
 '(comint-scroll-to-bottom-on-input t)
 '(cua-mode nil nil (cua-base))
 '(cursor-type (quote (hbar . 4)))
 '(custom-enabled-themes (quote (whiteboard)))
 '(custom-safe-themes
   (quote
    ("a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "f81a9aabc6a70441e4a742dfd6d10b2bae1088830dc7aba9c9922f4b1bd2ba50" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(diff-default-read-only nil)
 '(diff-switches "-u --ignore-all-space")
 '(evil-want-Y-yank-to-eol t)
 '(golden-ratio-mode t)
 '(helm-locate-command "locate %s %s")
 '(hybrid-mode t)
 '(kill-read-only-ok t)
 '(line-spacing 0.2)
 '(package-selected-packages
   (quote
    (ewmctrl hide-region project-explorer smartscan mc-extras ghub let-alist manage-minor-mode hide-lines sphinx-doc pydoc loccur dash-functional yafolding evil-unimpaired indent-tools git-timemachine flx-isearch flex-isearch helm-dired-recent-dirs helm-github-stars helm-chrome helm-cider-history ein ob-ipython change-inner vlf cycle-quotes scratch test-simple loc-changes load-relative mic-paren highlight-thing know-your-http-well winum vdiff helm-gtags discover ggtags keyfreq vkill company-restclient ob-http quick-preview visible-mark corral ivy-hydra ob-restclient restclient free-keys js2-mode visual-regexp-steroids visual-regexp auctex auto-dim-other-buffers selected region-bindings-mode comment-dwim-2 flyspell-popup realgud helm-flyspell isend-mode menu-bar+ color-theme-solarized web-mode ag ess-R-data-view ess jedi-core python-environment ctable concurrent deferred pythonic anaconda-mode flymake-cursor jedi epc company-flx uuidgen toc-org request org-plus-contrib org-bullets magit-popup link-hint hide-comnt eyebrowse evil-visual-mark-mode evil-ediff goto-chg undo-tree dumb-jump f dired-hacks-utils diminish column-enforce-mode seq company-jedi magit shell-pop shell-here highlight-indent-guides buffer-flip quickrun ido-sort-mtime drag-stuff eww-lnum fixmee auto-install counsel helm-google ranger multiple-cursors dionysos bookmark+ emms isearch-dabbrev sublimity google-maps rainbow-mode dired-k minimap imenu-anywhere tabbar color-identifiers-mode window-numbering dired-subtree yascroll dired-filter key-chord dired-quick-sort swiper fuzzy elpy pyvenv find-file-in-project ivy dired-narrow peep-dired goto-last-change shrink-whitespace git-gutter+ git-commit with-editor markdown-mode nlinum flycheck dired+ beacon smex menu-bar+ s powerline hydra spinner parent-mode projectile pkg-info epl flx smartparens iedit anzu highlight pos-tip company yasnippet packed dash helm avy helm-core async auto-complete popup package-build bind-key bind-map evil cygwin-mount persp-mode ws-butler which-key volatile-highlights vi-tilde-fringe use-package spacemacs-theme spaceline solarized-theme smooth-scrolling restart-emacs rainbow-delimiters quelpa popwin pcre2el paradox page-break-lines open-junk-file neotree move-text macrostep lorem-ipsum linum-relative leuven-theme info+ indent-guide ido-vertical-mode hungry-delete hl-todo highlight-parentheses highlight-numbers highlight-indentation help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make helm-flx helm-descbinds helm-company helm-c-yasnippet helm-ag google-translate golden-ratio flx-ido fill-column-indicator fancy-battery expand-region exec-path-from-shell evil-visualstar evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-args evil-anzu eval-sexp-fu elisp-slime-nav define-word company-statistics company-quickhelp clean-aindent-mode buffer-move bracketed-paste auto-yasnippet auto-highlight-symbol auto-compile aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell)))
 '(python-shell-interpreter "C:/Users/cibin/Anaconda3/python.exe")
 '(read-file-name-completion-ignore-case t)
 '(realgud:pdb-command-name "python -m pdb")
 '(safe-local-variable-values
   (quote
    ((ffip-project-root . "c:/Users/cibin/AppData/Roaming/.emacs.d/my-files/config/personal-configs/nppBackup/")
     (eval progn
           (pp-buffer)
           (indent-buffer)))))
 '(scroll-bar-mode nil)
 '(send-mail-function (quote mailclient-send-it))
 '(solarized-termcolors 256)
 '(tabbar-separator (quote (0.5)))
 '(undo-limit 1000000)
 '(undo-outer-limit 2000000)
 '(undo-strong-limit 1500000))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil))))
 '(mode-line ((t (:background "SpringGreen4" :foreground "#ffffff" :box (:line-width 1 :color "#5d4d7a")))))
 '(msearch-level-1 ((t (:background "orange" :foreground "gray8")))))
