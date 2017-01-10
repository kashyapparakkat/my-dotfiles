; http://www.cibinmathew.com
; github.com/cibinmathew

; https://writequit.org/org/settings.html
; https://sriramkswamy.github.io/dotemacs/
; http://www.wilkesley.org/~ian/xah/emacs/elisp_next_prev_user_buffer.html
; http://www.wilkesley.org/~ian/xah/emacs/emacs_stop_cursor_enter_prompt.html

; TO DO
; ========
; http://ergoemacs.org/emacs/elisp_close_buffer_open_last_closed.html
; http://www.wilkesley.org/~ian/xah/misc/ergoemacs_vi_mode.html
; use single key for switching bufffer use xah function for switch

; lots of good tips


; https://github.com/thunderboltsid/vim-configuration/blob/master/vimrc
; https://github.com/magnars/.emacs.d


; thanks
; https://sriramkswamy.github.io/dotemacs/
; http://aaronbedra.com/emacs.d/
;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.
(setq-default dotspacemacs-configuration-layers '(
                                                  
                                                  
                                                  csv
                                                  
                                                  
                                                  autohotkeythemes-megapack))


( defun dotspacemacs/layers ()
		"Configuration Layers declaration.
		You should not put any user code in this function besides modifying the variable
		values."

		(setq-default
				;; Base distribution to use. This is a layer contained in the directory
				;; `+distribution'. For now available distributions are `spacemacs-base'
				;; or `spacemacs'. (default 'spacemacs)
				dotspacemacs-distribution 'spacemacs
				;; List of additional paths where to look for configuration layers.
				;; Paths must have a trailing slash (i.
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
				flycheck
				peep-dired
				dired-narrow
				dired-subtree
				git-gutter+
				shrink-whitespace
				dired+ 
				golden-ratio
				elpy
				yascroll
				swiper
				drag-stuff
				ido-sort-mtime
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
				;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
				;; are declared in a layer which is not a member of
				;; the list `dotspacemacs-configuration-layers'. (default t)
				dotspacemacs-delete-orphan-packages t))

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
							 leuven
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
		;; Name of the default layout (default "Default")
		dotspacemacs-default-layout-name "Default"
		;; If non nil the default layout name is displayed in the mode-line.
		;; (default nil)
		dotspacemacs-display-default-layout nil
		;; If non nil then the last auto saved layouts are resume automatically upon
		;; start. (default nil)
		dotspacemacs-auto-resume-layouts t
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
		
		(load "server")
		(server-start)
		; TODO
		; (unless (server-running-p) (server-start))
		
		
		(setq load-prefer-newer t)
(auto-compile-on-load-mode)		  
(global-hl-line-mode 1) ; Disable current line highlight
(global-linum-mode) ; Show line numbers by default
(setq custom-enabled-themes '(whiteboard))
(setq cursor-type '(bar . 4))
; set to t for debug trace		
(setq debug-on-error t)		
(message "user-config")
(recentf-mode 1) ; keep a list of recently opened files
(setq initial-major-mode (quote text-mode)) ; default mode
(defalias 'list-buffers 'ibuffer) ; always use ibuffer,  (a replacement for the default buffer-list).
;; make frequently used commands short
(defalias 'qrr 'query-replace-regexp)
(defalias 'lml 'list-matching-lines)
(defalias 'dml 'delete-matching-lines)
(defalias 'dnml 'delete-non-matching-lines)
(defalias 'dtw 'delete-trailing-whitespace)
(defalias 'sl 'sort-lines)
(defalias 'rr 'reverse-region)
(defalias 'rs 'replace-string)

(defalias 'g 'grep)
(defalias 'gf 'grep-find)
(defalias 'fd 'find-dired)
(defalias 'rb 'revert-buffer)
(defalias 'sh 'shell)
(defalias 'fb 'flyspell-buffer)
(defalias 'sbc 'set-background-color)
(defalias 'rof 'recentf-open-files)
(defalias 'lcd 'list-colors-display)
(defalias 'cc 'calc)
; elisp
(defalias 'eb 'eval-buffer)
(defalias 'er 'eval-region)
(defalias 'ed 'eval-defun)
(defalias 'eis 'elisp-index-search)
(defalias 'lf 'load-file)
; major modes
(defalias 'hm 'html-mode)
(defalias 'tm 'text-mode)
(defalias 'elm 'emacs-lisp-mode)
(defalias 'om 'org-mode)
(defalias 'ssm 'shell-script-mode)
; minor modes
(defalias 'wsm 'whitespace-mode)
(defalias 'gwsm 'global-whitespace-mode)
(defalias 'vlm 'visual-line-mode)
(defalias 'glm 'global-linum-mode)
; Save the above in file and name it my-alias.el, then put it in your ~/.emacs.d/ directory. Then, in your emacs init file, add:
; (load "my-alias")
;; Tell emacs where is your personal elisp lib dir


; If a line is wrapped, pressing j or <down> should move to the next part of the same line.
(define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)

; Make horizontal movement cross lines
; if the cursor is at the end of a line, pressing l or <right> should move to the next line.
(setq-default evil-cross-lines t)

; save the place in files
; Navigates back to where you were editing a file next time you open it

(use-package saveplace
  :defer t
  :init
  (setq-default save-place t)
  (setq save-place-file (expand-file-name ".places" user-emacs-directory)))

(global-set-key [f1] 'shell-other-window) ; shell


(global-set-key (kbd "<f8>") 'cibin/xah-run-current-file)

;; Automatically reload files was modified by external program
(global-auto-revert-mode 1)
;; and display "half modal" warning about it
;(require 'w32-msgbox)
(setq revert-buffer-function 'inform-revert-modified-file)

(global-set-key (kbd "<mouse-3>") 'nil)
(fset 'evil-visual-update-x-selection 'ignore)
(setq mouse-drag-copy-region nil)
(setq x-select-enable-primary nil)
(setq visible-bell 1)

(add-to-list 'load-path "C:/cygwin64/bin")
;; we use yascroll for the scrollbar instead
; (require 'yascroll)
(scroll-bar-mode 1)
; (global-yascroll-bar-mode 1)
; (setq yascroll:delay-to-hide nil)


 ; Emulate Evil's * command with Swiper.
(global-set-key (kbd "C-M-s")
                (lambda ()
                  (interactive)
                  (swiper (word-at-point))))


; Shift click to extend marked region
(define-key global-map (kbd "<S-down-mouse-1>") 'mouse-save-then-kill)

(cd (format "C:/Users/%s/AppData/Roaming/.emacs.d/my-files/config/others/el-qrencode-master" user-login-name))
(load-file "~/.emacs.d/my-files/config/others/el-qrencode-master/load.el")
; (load-file "~/.emacs.d/my-files/config/others/fic-ext-mode.el")
(load-file "~/.emacs.d/my-files/config/others/zzz-to-char.el")
(load-file "~/.emacs.d/my-files/config/others/vlfi-master/vlf-setup.el")

(load-file "~/.emacs.d/my-files/config/others/dired-sort-menu.el")
(load-file "~/.emacs.d/my-files/config/others/dired-sort-menu+.el")

(load-file "~/.emacs.d/my-files/config/others/bm.el")
; (autoload 'bm-toggle   "bm" "Toggle bookmark in current buffer." t)
; (autoload 'bm-next     "bm" "Goto bookmark."                     t)
; (autoload 'bm-previous "bm" "Goto previous bookmark."            t)
(global-set-key (kbd "<C-f2>") 'bm-toggle)
(global-set-key (kbd "<M-f2>") (lambda () (interactive)
								(setq bm-cycle-all-buffers t)
								(bm-next)
								(setq bm-cycle-all-buffers nil)))

(global-set-key (kbd "<f2>")   'bm-next)
(global-set-key (kbd "<S-f2>") 'bm-previous)

; Click on fringe to toggle bookmarks, and use mouse wheel to move between them.

(global-set-key (kbd "<left-fringe> <wheel-down>") 'bm-next-mouse)
(global-set-key (kbd "<left-fringe> <wheel-up>") 'bm-previous-mouse)
(global-set-key (kbd "<left-fringe> <mouse-1>") 'bm-toggle-mouse)

; If you would like to cycle through bookmarks in all open buffers, add the following line:
(setq bm-cycle-all-buffers nil)
; cycle
(setq bm-wrap-search t)
;; save bookmarks
         (setq-default bm-buffer-persistence t)

         ;; Restoring bookmarks when on file find.
         (add-hook 'find-file-hooks 'bm-buffer-restore)


         (add-hook 'after-save-hook #'bm-buffer-save)

         ;; Restoring bookmarks
         (add-hook 'find-file-hooks   #'bm-buffer-restore)
         (add-hook 'after-revert-hook #'bm-buffer-restore)


; configures Emacs so that files deleted via Emacs are moved to the Recycle.
(setq delete-by-moving-to-trash t)

;; Load up starter kit customizations

; (require 'starter-kit-defuns)
; (require 'starter-kit-bindings)

(message "checkpoint 55")

; (add-to-list 'load-path "~/.emacs.d/my-files/config/personal-configs/")
(load-file "~/.emacs.d/my-files/config/others/popwin-el-master/popwin.el")

(load-file "~/.emacs.d/my-files/config/personal-configs/create-filecache.el")
; to save memory, make it read only when hotkey is fired
(file-cache-read-cache-from-file)

(load-file "~/.emacs.d/my-files/config/personal-configs/shell.el")
(load-file "~/.emacs.d/my-files/config/personal-configs/move-copy.el")
(load-file "~/.emacs.d/my-files/config/personal-configs/search-bindings.el")
(load-file "~/.emacs.d/my-files/config/personal-configs/starter-kit-bindings.el")
(load-file "~/.emacs.d/my-files/config/personal-configs/dired-settings.el")
(load-file "~/.emacs.d/my-files/config/personal-configs/dired-settings2.el")
(load-file "~/.emacs.d/my-files/config/personal-configs/more-custom-functions.el")
(load-file "~/.emacs.d/my-files/config/personal-configs/auto-complete.el")
(load-file "~/.emacs.d/my-files/config/personal-configs/org-settings.el")
(load-file "~/.emacs.d/my-files/config/personal-configs/other-settings.el")
; (load-file "~/.emacs.d/my-files/config/personal-configs/appearance.el")
(load-file "~/.emacs.d/my-files/config/personal-configs/cbn-mode-line.el")

(load-file "~/.emacs.d/my-files/config/personal-configs/xah-fly-keys-functions.el")
; (load-file "~/.emacs.d/my-files/config/personal-configs/cbn-xah-fly-keys.el")



; ===========

;https://github.com/mcandre/dotfiles/blob/master/.emacs
;; Open project file by fuzzy name C-]

(use-package fiplr
  :bind ("C-]" . fiplr-find-file)
  :defines fipl-ignored-globs
  :config
  (setq fiplr-ignored-globs
        '((directories
           ;; Version control
           (".git"
            ".svn"
            ".hg"
            ".bzr"
            ;; NPM
            "node_modules"
            ;; Bower
            "bower_components"
            ;; Maven
            "target"
            ;; Gradle
            "build"
            ".gradle"
            ;; Python
            "__pycache__"
            ;; IntelliJ
            ".idea"
            ;; Infer
            "infer-out"))
          (files
           ;; Emacs
           (".#*"
            ;; Vim
            "*~"
            ;; Objects
            "*.so"
            "*.o"
            "*.obj"
            "*.hi"
            ;; Media
            "*.jpg"
            "*.png"
            "*.gif"
            "*.pdf"
            ;; Archives
            "*.gz"
            "*.zip"))))
			
 ;; Better TAB handling
  (define-key *fiplr-keymap* (kbd "TAB")
    (lambda ()
(interactive))))
  (use-package markdown-mode
    :mode ("\\.md$" . gfm-mode)
    :init
    ;; Use markdown-mode for *scratch*
    (setq initial-scratch-message nil
          initial-major-mode 'gfm-mode)
    :config
    ;; Block indent for Markdown
    (add-hook 'markdown-mode-hook
              (lambda ()

                (setq indent-tabs-mode nil
                      tab-width 4)
                (define-key markdown-mode-map (kbd "TAB") 'traditional-indent)
                (define-key markdown-mode-map (kbd "<backtab>") 'traditional-outdent)
                (define-key markdown-mode-map (kbd "M-<left>") nil)
                (define-key markdown-mode-map (kbd "M-<right>") nil)
                ;; Remove triple backtick 'features'
                (define-key gfm-mode-map (kbd "`") nil))))


; ====
(message "checkpoint 59")

;; Typing text replaces marked regions
(delete-selection-mode 1)


(setq enable-recursive-minibuffers t) ;; allow recursive editing in minibuffer

(follow-mode t)                       ;; follow-mode allows easier editing of long files

; (global-set-key [f5]          '(lambda () (interactive) (kill-buffer (current-buffer))))

; to have the name of the file as the name of the window:
(setq frame-title-format '(buffer-file-name "Emacs: (%f)" "Emacs: %b"))

; Don't move back the cursor one position when exiting insert mode
(setq evil-move-cursor-back nil)

(cd (format "C:/Users/%s/Downloads" user-login-name)) 






 ; whitespace mode configured to show lines longer than 120 characters.
(setq whitespace-line-column 120) 

; https://pawelbx.github.io/emacs-theme-gallery/
; color themes, deftheme style (added in emacs 24).
; M-x package-install monokai-theme
; (load-theme 'monokai)


(setq echo-keystrokes 0.1
      use-dialog-box nil
      visible-bell t)
; load menu-bar+
; (eval-after-load "menu-bar" '(require 'menu-bar+))
; ======

; flyspell

; The built-in Emacs spell checker. Turn off the welcome flag because it is annoying and breaks on quite a few systems. Specify the location of the spell check program so it loads properly.

(setq flyspell-issue-welcome-flag nil)
(if (eq system-type 'darwin)
    (setq-default ispell-program-name "/usr/local/bin/aspell")
  (setq-default ispell-program-name "/usr/bin/aspell"))
(setq-default ispell-list-command "list")



; (require 'sublimity)
;; (require 'sublimity-scroll)
;; (require 'sublimity-map)
;; (require 'sublimity-attractive)
; then call command “M-x sublimity-mode” (or put the following expression in your init file).

; (sublimity-mode 1)

; smex is an amazing program that helps order the M-x commands based on usage and recent items. Let’s install it.

(use-package smex
  :ensure t
  :config
  (smex-initialize))

(message "checkpoint 41")

; Beacon is just a tiny utility that indicates the cursor position when the cursor moves suddenly. You can also manually invoke it by calling the function beacon-blink and it is bound by default.
(use-package beacon
  :ensure t
  :demand t
  :diminish beacon-mode
  :bind* (("M-m g z" . beacon-blink))
  :config
  (beacon-mode 1))

(message "checkpoint 43")

(use-package avy
  :ensure t
  :init
  (setq avy-keys-alist
        `((avy-goto-char-timer . (?j ?k ?l ?f ?s ?d ?e ?r ?u ?i))
          (avy-goto-line . (?j ?k ?l ?f ?s ?d ?e ?r ?u ?i))))
  (setq avy-style 'pre)
  :bind* (("M-m f" . avy-goto-char-timer)
          ("M-m F" . avy-goto-line)
		  ("C-'" . avy-goto-char)
          ("C-," . avy-goto-char-2)))


; dumb-jump
; Use it to jump to function definitions. Requires no external depedencies.

(use-package dumb-jump
  :diminish dumb-jump-mode
  :bind (("C-M-g" . dumb-jump-go)
         ("C-M-p" . dumb-jump-back)
         ("C-M-q" . dumb-jump-quick-look)))


; disabling just for now
;; Fast line numbers
(use-package nlinum
  :config
  ;; Line number gutter in ncurses mode
  (unless window-system
    (setq nlinum-format "%d "))
  ;; :idle
  (global-nlinum-mode))

(message "checkpoint 63")




; Shrink white space
; This package helps to reduce the number of blank lines/whitespace between words easily. Useful when deleting chunks of text and just want to make it neat.
(use-package shrink-whitespace
  :ensure t
  :bind* (("M-m g SPC" . shrink-whitespace)))


; highlight git changes in buffers in a git repository:

(use-package git-gutter+
  :config
  (global-git-gutter+-mode)
)


(message "loading not installed/untested packages")


(message "checkpoint 44")

; Color Identifiers Mode and Color Delimiters
; The plugin colors-identifiers-mode colorize every variable in a different color. I've mixed feelings about it because the code looks like a fruit salad, but it makes really easy to visually identify where variables are used. I'm using it for now. Setup is:
(use-package color-identifiers-mode)
; (global-color-identifiers-mode 1)
(add-hook 'after-init-hook 'global-color-identifiers-mode)

; color-identifiers-mode is better than rainbow-delimiters

; Another firm step into the total fruitsalarization of your Emacs is the Rainbow Delimiters package that will color nested delimiters on a different color so you can check easily which of them are pairs without having to move the cursor over them. When you have lots of nested parenthesis this helps a lot to see the pairs without having to move the cursor over them.
; (use-package rainbow-delimiters)
; (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

; go to the last change
(use-package goto-chg)

(global-set-key [(control .)] 'goto-last-change)
(global-set-key (kbd "C-.") 'goto-last-change)
; M-. can conflict with etags tag search. But C-. can get overwritten
; by flyspell-auto-correct-word. And goto-last-change needs a really
; fast key.
(global-set-key [(meta .)] 'goto-last-change)
; ensure that even in worst case some goto-last-change is available
(global-set-key [(control meta .)] 'goto-last-change)

(message "checkpoint 66")
;; Highlight TODO and FIXME in comments 
; (use-package fic-ext-mode)
; (require fic-ext-mode)
; (add-something-to-mode-hooks '(c++ tcl emacs-lisp python text markdown latex) 'fic-ext-mode)



(defun add-something-to-mode-hooks (mode-list something)
  "helper function to add a callback to multiple hooks"
  (dolist (mode mode-list)
    (add-hook (intern (concat (symbol-name mode) "-mode-hook")) something)))


  
; extra major modes!
; (use-package markdown-mode)
; Enable Markdown mode and setup additional file extensions. Use pandoc to generate HTML previews from within the mode, and use a custom css file to make it a little prettier.
; (add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
; (add-to-list 'auto-mode-alist '("\\.mdown$" . markdown-mode))
; (add-hook 'markdown-mode-hook
          ; (lambda ()
            ; (visual-line-mode t)
            ; (writegood-mode t)
            ; (flyspell-mode t)))
; (setq markdown-command "pandoc --smart -f markdown -t html")
; (setq markdown-css-paths `(,(expand-file-name "markdown.css" abedra/vendor-dir)))


(message "checkpoint 61")

(message "reached end of user-config()")

) ; end of user-config() 





; (defvar cibin/packages '(flycheck                          
                          ; markdown-mode
                          ; )
  ; "Default packages")
; Install default packages, When Emacs boots, check to make sure all of the packages defined in cibin/packages are installed. If not, have ELPA take care of it.

; (defun cibin/packages-installed-p ()
  ; (loop for pkg in cibin/packages
        ; when (not (package-installed-p pkg)) do (return nil)
        ; finally (return t)))

; (unless (cibin/packages-installed-p)
  ; (message "%s" "Refreshing package database...")
  ; (package-refresh-contents)
  ; (dolist (pkg cibin/packages)
    ; (when (not (package-installed-p pkg))
      ; (package-install pkg))))

; https://github.com/bbatsov/crux/blob/master/crux.el
(defun crux-open-with (arg)
  "Open visited file in default external program.
When in dired mode, open file under the cursor.

With a prefix ARG always prompt for command to use."
  (interactive "P")
  (let* ((current-file-name
          (if (eq major-mode 'dired-mode)
              (dired-get-file-for-visit)
            buffer-file-name))
         (open (pcase system-type
                 (`darwin "open")
                 ((or `gnu `gnu/linux `gnu/kfreebsd) "xdg-open")))
         (program (if (or arg (not open))
                      (read-shell-command "Open current file with: ")
                    open)))
    (start-process "crux-open-with-process" nil program current-file-name)))

(defun crux-duplicate-and-comment-current-line-or-region (arg)
  "Duplicates and comments the current line or region ARG times.
   If there's no region, the current line will be duplicated.  However, if
   there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (pcase-let* ((origin (point))
               (`(,beg . ,end) (crux-get-positions-of-line-or-region))
               (region (buffer-substring-no-properties beg end)))
    (comment-or-uncomment-region beg end)
    (setq end (line-end-position))
    (dotimes (_ arg)
      (goto-char end)
      (newline)
      (insert region)
      (setq end (point)))
    (goto-char (+ origin (* (length region) arg) arg))))



(defun forward-word-to-beginning (&optional n)
  "Move point forward n words and place cursor at the beginning of the word rather than at the end of a word."
  (interactive "p")
  (let (myword)
    (setq myword
      (if (and transient-mark-mode mark-active)
        (buffer-substring-no-properties (region-beginning) (region-end))
        (thing-at-point 'symbol)))
    (if (not (eq myword nil))
      (forward-word n))
    (forward-word n)
    (backward-word n)))


; search all buffers
(require 'cl)
(defcustom search-all-buffers-ignored-files (list (rx-to-string '(and bos (or ".bash_history" "TAGS") eos)))
  "Files to ignore when searching buffers via \\[search-all-buffers]."
  :type 'editable-list)

(require 'grep)
(defun search-all-buffers (regexp prefix)
  "Searches file-visiting buffers for occurence of REGEXP.  With
prefix > 1 (i.e., if you type C-u \\[search-all-buffers]),
searches all buffers."
  (interactive (list (grep-read-regexp)
                     current-prefix-arg))
  (message "Regexp is %s; prefix is %s" regexp prefix)
  (multi-occur
   (if (member prefix '(4 (4)))
       (buffer-list)
     (remove-if
      (lambda (b) (some (lambda (rx) (string-match rx  (file-name-nondirectory (buffer-file-name b)))) search-all-buffers-ignored-files))
      (remove-if-not 'buffer-file-name (buffer-list))))

   regexp))
	
	
(defun smart-line-beginning ()
  "Move point to the beginning of text on the current line; if that is already
the current position of point, then move it to the beginning of the line."
  (interactive)
  (let ((pt (point)))
    (beginning-of-line-text)
    (when (eq pt (point))
      (beginning-of-line))))


	  
(defun pull-next-line() 
"pull the next line onto the end of the current line, compressing whitespace."
  (interactive) 
  (move-end-of-line 1) 
  (kill-line)
  (just-one-space))


(defun toolbar-button ()
 "another nonce menu function"
 (interactive)
 (message "hotel, motel, holiday inn"))

    (tool-bar-add-item "spell" 'toolbar-button               'toolbar-button
               :help   "Run fonction toolbar-button")
			   
			   
			   
(defun minibuffer-keyboard-quit ()
  "http://stackoverflow.com/a/10166400 
  Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))

(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

; http://pragmaticemacs.com/emacs/aligning-text/
(defun bjm/align-whitespace (start end)
  "Align columns by whitespace"
  (interactive "r")
  (align-regexp start end
                "\\(\\s-*\\)\\s-" 1 0 t))

(defun bjm/align-& (start end)
  "Align columns by ampersand"
  (interactive "r")
  (align-regexp start end
                "\\(\\s-*\\)&" 1 1 t))

;; Align command !!!

;; from http://stackoverflow.com/questions/3633120/emacs-hotkey-to-align-equal-signs
;; another information: https://gist.github.com/700416
;; use rx function http://www.emacswiki.org/emacs/rx


(defun align-to-colon (begin end)
  "Align region to colon (:) signs"
  (interactive "r")
  (align-regexp begin end
                (rx (group (zero-or-more (syntax whitespace))) ":") 1 1 ))

(defun align-to-comma (begin end)
  "Align region to comma  signs"
  (interactive "r")
  (align-regexp begin end
                (rx "," (group (zero-or-more (syntax whitespace))) ) 1 1 ))


(defun align-to-equals (begin end)
  "Align region to equal signs"
  (interactive "r")
  (align-regexp begin end
                (rx (group (zero-or-more (syntax whitespace))) "=") 1 1 ))

(defun align-to-hash (begin end)
  "Align region to hash ( => ) signs"
  (interactive "r")
  (align-regexp begin end
                (rx (group (zero-or-more (syntax whitespace))) "=>") 1 1 ))

;; work with this
(defun align-to-comma-before (begin end)
  "Align region to equal signs"
  (interactive "r")
  (align-regexp begin end
                (rx (group (zero-or-more (syntax whitespace))) ",") 1 1 ))
				
				
(defun kill-whole-line nil
  "http://everything2.com/title/useful+emacs+lisp+functions
kills the entire line on which the cursor is located, and places the
cursor as close to its previous position as possible."
  (interactive)
  (progn
    (let ((y (current-column))
  (a (progn (beginning-of-line) (point)))
  (b (progn (forward-line 1) (point))))
      (kill-region a b)
      (move-to-column y))))
	  


;; from ; https://snarfed.org/dotfiles/.emacs
(defun switch-to-scratch ()
  (interactive) (bury-then-switch-to-buffer "*scratch*"))
(defun bury-then-switch-to-buffer (buffer)
  "Bury buffer in all windows, then switch to it in the current window."
  (replace-buffer-in-windows buffer)
  (switch-to-buffer buffer t))  ; t: don't add it to the recent buffer list 
  

(defun rename-this-file (new-file-name)
  "Renames this file and switches the buffer to point to the new file."
  (interactive "FRename to: ")
  (let ((orig-buffer (current-buffer)))
    (rename-file buffer-file-name new-file-name)
    (find-file new-file-name)
    (kill-buffer orig-buffer)))







; https://www.emacswiki.org/emacs/OpenNextLine
    ;; Behave like vi's o command
    (defun open-next-line (arg)
      "Move to the next line and then opens a line.
    See also `newline-and-indent'."
      (interactive "p")
      (end-of-line)
      (open-line arg)
      (next-line 1)
      (when newline-and-indent
        (indent-according-to-mode)))


    ;; Behave like vi's O command
    (defun open-previous-line (arg)
      "Open a new line before the current one. 
     See also `newline-and-indent'."
      (interactive "p")
      (beginning-of-line)
      (open-line arg)
      (when newline-and-indent
        (indent-according-to-mode)))

    ;; Autoindent open-*-lines
    (defvar newline-and-indent t
      "Modify the behavior of the open-*-line functions to cause them to autoindent.")
	  

; bubble-buffer

(defvar LIMIT 1)
(defvar time 0)
(defvar mylist nil)

(defun time-now ()
   (car (cdr (current-time))))

(defun bubble-buffer ()
   (interactive)
   (if (or (> (- (time-now) time) LIMIT) (null mylist))
       (progn (setq mylist (copy-alist (buffer-list)))
          (delq (get-buffer " *Minibuf-0*") mylist)
          (delq (get-buffer " *Minibuf-1*") mylist)))
   (bury-buffer (car mylist))
   (setq mylist (cdr mylist))
   (setq newtop (car mylist))
   (switch-to-buffer (car mylist))
   (setq rest (cdr (copy-alist mylist)))
   (while rest
     (bury-buffer (car rest))
     (setq rest (cdr rest)))
   (setq time (time-now)))


; shell functions
(defun shell-region (start end)
  "execute region in an inferior shell"
  (interactive "r")
  (shell-command  (buffer-substring-no-properties start end)))
  
  ;;;;
  ; http://stackoverflow.com/questions/6286579/emacs-shell-mode-how-to-send-region-to-shell
(defun sh-send-line-or-region (&optional step)
  (interactive ())
  (let ((proc (get-process "shell"))
        pbuf min max command)
    (unless proc
      (let ((currbuff (current-buffer)))
        (shell)
        (switch-to-buffer currbuff)
        (setq proc (get-process "shell"))
        ))
    (setq pbuff (process-buffer proc))
    (if (use-region-p)
        (setq min (region-beginning)
              max (region-end))
      (setq min (point-at-bol)
            max (point-at-eol)))
    (setq command (concat (buffer-substring min max) "\n"))
    (with-current-buffer pbuff
      (goto-char (process-mark proc))
      (insert command)
      (move-marker (process-mark proc) (point))
      ) ;;pop-to-buffer does not work with save-current-buffer -- bug?
    (process-send-string  proc command)
    (display-buffer (process-buffer proc) t)
    (when step 
      (goto-char max)
      (next-line))
    ))

(defun sh-send-line-or-region-and-step ()
  (interactive)
  (sh-send-line-or-region t))
  
;;;;;
  
(defun sh-switch-to-process-buffer ()
  (interactive)
  (pop-to-buffer (process-buffer (get-process "shell")) t))

(defun shell-run-command-line-or-region()  
	(interactive)
	(if (use-region-p)
		(shell-command  (buffer-substring-no-properties start end))
		(.....)
	)
	)
  
  
  
  

; http://geosoft.no/development/emacs.html
 ; For fast navigation within an Emacs buffer it is necessary to be able to move swiftly between words. The functions below change the default Emacs behavour on this point slightly, to make them a lot more usable.
; Note the way that the underscore character is treated. This is convinient behaviour in programming. Other domains may have different requirements, and these functions should be easy to modify in this respect.

(defun geosoft-forward-word ()
   ;; Move one word forward. Leave the pointer at start of word
   ;; instead of emacs default end of word. Treat _ as part of word
   (interactive)
   (forward-char 1)
   (backward-word 1)
   (forward-word 2)
   (backward-word 1)
   (backward-char 1)
   (cond ((looking-at "_") (forward-char 1) (geosoft-forward-word))
         (t (forward-char 1))))

(defun geosoft-backward-word ()
   ;; Move one word backward. Leave the pointer at start of word
   ;; Treat _ as part of word
   (interactive)
   (backward-word 1)
   (backward-char 1)
   (cond ((looking-at "_") (geosoft-backward-word))
         (t (forward-char 1))))
		 
		 


(defun xah-python-2to3-current-file ()
  "Convert current buffer from python 2 to python 3.
This command calls python3's script 「2to3」.
URL `http://ergoemacs.org/emacs/elisp_python_2to3.html'
Version 2016-02-16"
  (interactive)
  (let* (
         (fName (buffer-file-name))
         (fSuffix (file-name-extension fName)))
    (when (buffer-modified-p)
      (save-buffer))
    (if (or (string-equal fSuffix "py") (string-equal fSuffix "py3"))
        (progn
          (shell-command (format "2to3 -w %s" fName))
          (revert-buffer  "IGNORE-AUTO" "NOCONFIRM" "PRESERVE-MODES"))
      (error "file 「%s」 doesn't end in “.py” or “.py3”." fName))))
	  
(defun xah-open-file-fast ()
"Prompt to open a file from `xah-filelist'.
URL `http://ergoemacs.org/emacs/emacs_hotkey_open_file_fast.html'
Version 2015-04-23"
; Call xah-open-file-fast, then it will prompt with real-time name completion as you type.
; You should assign it a key. For example, 【F8】, so you can open a file by 【F8 1】, 【F8 2】, etc.
  (interactive)
  ; (let ((-abbrevCode
         ; (ido-completing-read "Open:" (mapcar (lambda (-x) (car -x)) xah-filelist))))
    ; (find-file (cdr (assoc -abbrevCode xah-filelist))))
	; OR
	(let ((j 1) (file (car xah-filelist)))
(while file
(let ((name (intern (format "Open:%s" (car file)))))
(fset name `(lambda () (interactive) (find-file ,(cdr file))))
(setq file (nth j xah-filelist))
(or (< j 10) (setq file nil j 0))
(global-set-key (kbd (format "<f2> %d" j)) name)
(setq j (1+ j)))))
	)
(defun xah-new-empty-buffer ()
  "Open a new empty buffer.
URL `http://ergoemacs.org/emacs/emacs_new_empty_buffer.html'
Version 2016-08-11"
  (interactive)
  (let ((-buf (generate-new-buffer "untitled")))
    (switch-to-buffer -buf)
    (funcall initial-major-mode)
    (setq buffer-offer-save t)))

(defun shell-other-window ()
  "Open a `shell' in a new window."
  (interactive)
  (let ((buf (shell)))
    (switch-to-buffer (other-buffer buf))
    (switch-to-buffer-other-window buf)))
	
	
(defun inform-revert-modified-file (&optional p1 p2)
      "bdimych custom function"
      (let ((revert-buffer-function nil))
			 (message "File modified. Reloaded." ) ; %s: %s" title body)
            (revert-buffer p1 p2)
        ;(w32-msgbox (buffer-file-name) "Emacs: Modified file automatically reverted" 'vb-ok-only 'vb-information nil t)
      )
    )
	
	



(defun reload-settings ()
;These little helper functions let me access and reload my configuration whenever I want to make any changes. 
		  (interactive)
		  (org-babel-load-file "~/.emacs.d/settings.org"))
		  
  





(defconst +win-path+ "C:/" "Windows root path.")
;;; Cygwin
(let ((cygwin-dir (concat +win-path+ "cygwin64/bin")))
		(when (file-exists-p cygwin-dir)
		(setq shell-file-name "bash"
		explicit-shell-file-name "bash")
		(setenv "SHELL" shell-file-name)
		(setenv "CYGWIN" "nodosfilewarning")

		(when (require 'cygwin-mount nil t)
		(cygwin-mount-activate)
		(setq w32shell-cygwin-bin cygwin-dir))))
		
(defun cygwin-shell ()
  "Run cygwin bash in shell mode."
  (interactive)
  (let ((explicit-shell-file-name "C:/cygwin64/bin/bash"))
    (call-interactively 'shell)))
(defun xah-copy-file-path (&optional *dir-path-only-p)
  "Copy the current buffer's file path or dired path to `kill-ring'.
Result is full path.
If `universal-argument' is called first, copy only the dir path.
URL `http://ergoemacs.org/emacs/emacs_copy_file_path.html'
Version 2016-07-17"
  (interactive "P")
  (let ((-fpath
         (if (equal major-mode 'dired-mode)
             (expand-file-name default-directory)
           (if (null (buffer-file-name))
               (user-error "Current buffer is not associated with a file.")
             (buffer-file-name)))))
    (kill-new
     (if (null *dir-path-only-p)
         (progn
           (message "File path copied: 「%s」" -fpath)
           -fpath
           )
       (progn
         (message "Directory path copied: 「%s」" (file-name-directory -fpath))
         (file-name-directory -fpath))))))
	
	
	(defun cibin/xah-open-file-at-cursor ()
  "Open the file path under cursor.
If there is text selection, uses the text selection for path.
If the path starts with “http://”, open the URL in browser.
Input path can be {relative, full path, URL}.
Path may have a trailing “:‹n›” that indicates line number. If so, jump to that line number.
If path does not have a file extension, automatically try with “.el” for elisp files.
This command is similar to `find-file-at-point' but without prompting for confirmation.

URL `http://ergoemacs.org/emacs/emacs_open_file_path_fast.html'"
  (interactive)
  (
  ; let ((-path (if (use-region-p)
                   ; (buffer-substring-no-properties (region-beginning) (region-end))
                 ; (let (p0 p1 p2)
                   ; (setq p0 (point))
                   ; ; chars that are likely to be delimiters of full path, e.g. space, tabs, brakets.
                   ; (skip-chars-backward "^  \"\t\n`'|()[]{}<>〔〕“”〈〉《》【】〖〗«»‹›·。\\`")
                   ; (setq p1 (point))
                   ; (goto-char p0)
                   ; (skip-chars-forward "^  \"\t\n`'|()[]{}<>〔〕“”〈〉《》【】〖〗«»‹›·。\\'")
                   ; (setq p2 (point))
                   ; (goto-char p0)
                   ; (buffer-substring-no-properties p1 p2)))))
	let ((-path  (setq -path
      (buffer-substring-no-properties
       (line-beginning-position)
       (line-end-position)))
       )	)	 
				   
			(message "path is")
			(message -path)
	; if text is a url		
    ; (if (string-match-p "\\`https?://" -path)
        ; (browse-url -path)
	; (pcase "yyy" 		
		; ("nill" (message "hi" ))
		; ("noo" (message "no" ))
		; ("yyy" (message "hellllll" ))
	; )





(setq -path (replace-regexp-in-string "/cygdrive/\\(.\\)" "\\1:" -path))
		
		(message "path without /cygdrive is")
			(message -path)
			(if (file-exists-p -path)
                (find-file -path)
      (progn ; not starting “http://”
	  
	  ; input is like C:/abc/adsf/.../adfa.txt:343
	  ; skip the first colon if it is the second character
        (if (string-match "^\\`\\(..[^:]+?\\):\\([0-9]*\\)\\(.*\\)\\'" -path)
            (progn
              (let (
                    (-fpath (match-string 1 -path))
                    (-line-num (string-to-number (match-string 2 -path))))
					(message "line no present\nfpath is")
					(message -fpath)
					(message "line is ")
					
					(message (number-to-string -line-num))
                (if (file-exists-p -fpath)
                    (progn
                      (find-file -fpath)
                      (goto-char 1)
                      (forward-line (1- -line-num)))
                  (progn
                    (when (y-or-n-p (format "file doesn't exist: 「%s」. Create?" -fpath))
                      (find-file -fpath))))))
          (progn
		  
			(message "No line # pathhh is")
			(message -path)
            (if (file-exists-p -path)
                (find-file -path)
              (if (file-exists-p (concat -path ".el"))
                  (find-file (concat -path ".el"))
                (when (y-or-n-p (format "file doesn't exist: 「%s」. Create?" -path))
                  (find-file -path ))))))
				  
				  
				  ))))
	
	
	

(defun say-word (word)
; copies current word to variable.
; instead of showing default text showing up, empty arg is sent as the argument
  (interactive (list
                (read-string (format "word (%s): " (thing-at-point 'word))
                             nil nil (thing-at-point 'word))))
  (message "The word is %s" word))
  
(defun paste-from-x-clipboard()
; execute in minibuffer
  (interactive)
  (let ((value
       (read-from-minibuffer prompt initial nil nil
                             history default inherit)))
  (if (and (equal value "") default)
      (if (consp default) (car default) default)
    value))
  ; (shell-command "ls-l")
  (shell-command value)
								 
  )
  
(defun ff (arg)
  "Prompt user to enter a string, with input history support."
  (interactive
   (list
    (read-string "Enter (use up/down for history) :" "grep")
		))
  ; (message "String is %s." arg)
  (shell-command arg))
  
  

(defun sm-minibuffer-insert-val2 (exp)
; http://stackoverflow.com/questions/10121944/passing-emacs-variables-to-minibuffer-shell-commands
  (interactive
   (list (let ((enable-recursive-minibuffers t))
           (read-from-minibuffer "Insert: "
                                 nil read-expression-map t
                                 'read-expression-history))))
    (let ((val (with-selected-window (minibuffer-selected-window)
                 (eval exp)))
          (standard-output (current-buffer)))
      (prin1 val)))
  
(defun sm-minibuffer-insert-val (exp)
; http://stackoverflow.com/questions/10121944/passing-emacs-variables-to-minibuffer-shell-commands
  (interactive
   (list (let ((enable-recursive-minibuffers t))
           (read-from-minibuffer "Insert: "
                                 nil read-expression-map t
                                 'read-expression-history))))
    (let ((val (with-selected-window (minibuffer-selected-window)
                 (eval exp)))
          (standard-output (current-buffer)))
      (prin1 val)))
  
(defun cibin/xah-run-current-file ()
		"Execute the current file.
		For example, if the current buffer is the file x.py, then it'll call 「python x.py」 in a shell.
		The file can be Emacs Lisp, PHP, Perl, Python, Ruby, JavaScript, Bash, Ocaml, Visual Basic, TeX, Java, Clojure.
		File suffix is used to determine what program to run.

	-	If the file is modified or not saved, save it automatically before run.

		URL `http://ergoemacs.org/emacs/elisp_run_current_file.html'
		version 2016-01-28"
		(interactive)
		(let (
			 (-suffix-map
			  ;; (‹extension› . ‹shell program name›)
			  `(
				("php" . "php")
				("pl" . "perl")
				("py" . ,(format "%s" python-shell-interpreter))
				("ahk" . ,(if (string-equal system-type "windows-nt") "C:/Program Files/AutoHotkey/AutoHotkey.exe" "C:/Program Files/AutoHotkey/AutoHotkey.exe"))
				("py3" . ,(if (string-equal system-type "windows-nt") "c:/Python32/python.exe" "python3"))
				("rb" . "ruby")
				("go" . "go run")
				("js" . "node") ; node.js
				("sh" . "bash")
				("clj" . "java -cp /home/xah/apps/clojure-1.6.0/clojure-1.6.0.jar clojure.main")
				("rkt" . "racket")
				("ml" . "ocaml")
				("vbs" . "cscript")
				("tex" . "pdflatex")
				("latex" . "pdflatex")
				("java" . "javac")
				;; ("pov" . "/usr/local/bin/povray +R2 +A0.1 +J1.2 +Am2 +Q9 +H480 +W640")
				))

         -fname
         -fSuffix
         -prog-name
         -cmd-str)





		(when (null (buffer-file-name)) (save-buffer))
		(when (buffer-modified-p) (save-buffer))

		(setq -fname (buffer-file-name))
		(setq -fSuffix (file-name-extension -fname))
		(setq -prog-name (cdr (assoc -fSuffix -suffix-map)))
		; (setq -cmd-str (concat -prog-name " \""   -fname "\""))
		(setq -cmd-str (concat (shell-quote-argument -prog-name) " " (shell-quote-argument -fname)))

		(cond
		 ((string-equal -fSuffix "el") (load -fname))
		 ((string-equal -fSuffix "java")
		  (progn
			(shell-command -cmd-str "*xah-run-current-file output*" )
			(shell-command
			 (format "java %s" (file-name-sans-extension (file-name-nondirectory -fname))))))
		 (t (if -prog-name
				(progn
				  (message "Running… %s" -cmd-str)
					; freezes emacs on directly running
					; (shell-command -cmd-str "*xah-run-current-file output*" ))

					; TODO: works with windows only
					; https://lists.gnu.org/archive/html/bug-gnu-emacs/2015-06/msg00205.html
          (let ((proc (start-process "cmd" nil "cmd.exe" "/C" "start" -cmd-str)))
			; The set-process-query-on-exit-flag to nil is so it won't bother on closing emacs (we can't kill it anyway).
            (set-process-query-on-exit-flag proc nil)
			)
			)
			  (message "No recognized program file suffix for this file."))))))
(defun xah-make-backup ()
  "Make a backup copy of current file or dired marked files.
If in dired, backup current file or marked files.
The backup file name is
 ‹name›~‹timestamp›~
example:
 file.html~20150721T014457~
in the same dir. If such a file already exist, it's overwritten.
If the current buffer is not associated with a file, nothing's done.
URL `http://ergoemacs.org/emacs/elisp_make-backup.html'
Version 2015-10-14"
  (interactive)
  (let ((-fname (buffer-file-name)))
    (if -fname
        (let ((-backup-name
               (concat -fname "~" (format-time-string "%Y%m%dT%H%M%S") "~")))
          (copy-file -fname -backup-name t)
          (message (concat "Backup saved at: " -backup-name)))
      (if (string-equal major-mode "dired-mode")
          (progn
            (mapc (lambda (-x)
                    (let ((-backup-name
                           (concat -x "~" (format-time-string "%Y%m%dT%H%M%S") "~")))
                      (copy-file -x -backup-name t)))
                  (dired-get-marked-files))
            (message "marked files backed up"))
        (user-error "buffer not file nor dired")))))		  




		  
		  
;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-delay 0.3)
 '(blink-cursor-mode t)
 '(comint-completion-addsuffix t)
 '(comint-completion-autolist t)
 '(comint-get-old-input (lambda nil "") t)
 '(comint-input-ignoredups t)
 '(comint-move-point-for-output nil)
 '(comint-prompt-read-only nil)
 '(comint-scroll-show-maximum-output t)
 '(comint-scroll-to-bottom-on-input t)
 '(cursor-type (quote (hbar . 4)))
 '(custom-enabled-themes (quote (whiteboard)))
 '(custom-safe-themes
   (quote
    ("f81a9aabc6a70441e4a742dfd6d10b2bae1088830dc7aba9c9922f4b1bd2ba50" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(evil-want-Y-yank-to-eol t)
 '(helm-locate-command "locate %s %s")
 '(hybrid-mode t)
 '(line-spacing 0.2)
 '(package-selected-packages
   (quote
    (ido-sort-mtime drag-stuff eww-lnum fixmee auto-install counsel helm-google ranger multiple-cursors dionysos bookmark+ emms isearch-dabbrev sublimity google-maps rainbow-mode dired-k minimap imenu-anywhere tabbar color-identifiers-mode window-numbering dired-subtree yascroll dired-filter key-chord dired-quick-sort swiper fuzzy elpy pyvenv find-file-in-project ivy dired-narrow peep-dired goto-last-change shrink-whitespace git-gutter+ git-commit with-editor markdown-mode nlinum flycheck dired+ beacon smex menu-bar+ s powerline hydra spinner parent-mode projectile pkg-info epl flx smartparens iedit anzu highlight pos-tip company yasnippet packed dash helm avy helm-core async auto-complete popup package-build bind-key bind-map evil cygwin-mount persp-mode ws-butler which-key volatile-highlights vi-tilde-fringe use-package spacemacs-theme spaceline solarized-theme smooth-scrolling restart-emacs rainbow-delimiters quelpa popwin pcre2el paradox page-break-lines open-junk-file neotree move-text macrostep lorem-ipsum linum-relative leuven-theme info+ indent-guide ido-vertical-mode hungry-delete hl-todo highlight-parentheses highlight-numbers highlight-indentation help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make helm-flx helm-descbinds helm-company helm-c-yasnippet helm-ag google-translate golden-ratio flx-ido fill-column-indicator fancy-battery expand-region exec-path-from-shell evil-visualstar evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-args evil-anzu eval-sexp-fu elisp-slime-nav define-word company-statistics company-quickhelp clean-aindent-mode buffer-move bracketed-paste auto-yasnippet auto-highlight-symbol auto-compile aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell)))
 '(send-mail-function (quote mailclient-send-it)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil))))
 '(mode-line ((t (:background "SpringGreen4" :foreground "#ffffff" :box (:line-width 1 :color "#5d4d7a"))))))
