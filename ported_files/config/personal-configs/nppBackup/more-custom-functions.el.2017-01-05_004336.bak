;;; more-custom-functions.el
; http://www.cibinmathew.com
; github.com/cibinmathew
(defvar search_list_count 0)
(defun mp-add-python-keys ()
  (interactive)
  (setq search_list_count 0)
       (message "%s" search_list_count)
       (add-hook 'ido-setup-hook  (lambda ()
                                    (define-key ido-completion-map (kbd "\C-c q") 'set-default-compiler-python )))
       (set-default-compiler-python )

       )
  (message "asfa")
  (global-set-key (kbd "C-x t") 'mp-add-python-keys)

(defun set-default-compiler-python ()
    "Find a recent file using ido."
    (interactive)
    (setq search_list_count (+ 1 search_list_count))
    (message "%s" search_list_count)
    (if (eq 1 search_list_count)
        (message "first call")
      (progn
                                        ;(exit-minibuffer)
                                        ;(ido-exit-minibuffa )
        (message "exiting old")
        (minibuffer-keyboard-quit)
        (setq ido-exit nil)
        (message "exited old minibuffer")
        ))
    (message "opening ido prompt")
  (let ((file 
  (ido-completing-read "choose? " (list "C:/Program Files (x86)/Python35-32/python.exe"
  (format "C:/Users/%s/AppData/Local/Programs/Python/Python35-32/python.exe" user-login-name)
  (format "C:/Users/%s/AppData/Local/Continuum/Anaconda3_32/python.exe" user-login-name)
  (format "C:/Users/%s/AppData/Local/Continuum/Anaconda3_1/python.exe" user-login-name)
  "C:/Python27/python.exe" 
  (format "C:/Users/%s/AppData/Local/Continuum/Anaconda2/python.exe" user-login-name)
  ))))
    (when file
(setq python-shell-interpreter  file)
(message "%s" python-shell-interpreter)))
)

(defun open-common-executable ()
" all python.exe, pips paths"
(interactive)
)

(defun get-related-files ()

	"Like `directory-files' with MATCH hard-coded to exclude \".\" and \"..\"." 
	(setq regex-filter "^\\(\\(.*\\.txt\\)\\|\\(.*\\.py\\)\\|\\(.*\\.el\\)\\|\\(.*\\.java\\)\\|\\(.*\\.ahk\\)\\|\\(.*\\.ini\\)\\|\\(.*\\.sh\\)\\)$")
	(setq foldercontent-of-this-file nil)
	(setq foldercontent-of-parent-of-this-file nil)
	; if buffer is not a special buffer
	(when  buffer-file-name
		(setq parent-directory-this-file (directory-file-name (file-name-directory buffer-file-name)))
		(setq parent-of-parent-directory-this-file (directory-file-name (file-name-directory parent-directory-this-file)))
		(setq foldercontent-of-this-file (directory-files (directory-file-name (file-name-directory buffer-file-name)) t "^\\([^.]\\|\\.[^.]\\|\\.\\..\\)"))
		(setq foldercontent-of-parent-of-this-file (directory-files  parent-of-parent-directory-this-file t regex-filter))
	)
	(setq recent-dirs nil)
	(setq recent-dirs 
	(delete-dups
          (mapcar (lambda (file)
                    (if (file-directory-p file) file (file-name-directory file)))
                  recentf-list))
				  )
	; FIXME
	; index contents of first level subfolders of this file also
	
	; get first n items only
	(setq recent-dirs (append foldercontent-of-this-file (last (reverse recent-dirs) 5) ))
    (setq all-recent-dirs-foldercontent nil)
	(dolist (dir recent-dirs) 
	   ; (message "exist %s" (file-exists-p dir))
		(when (file-exists-p dir)		
		; "^\\([^.]\\|\\.[^.]\\|\\.\\..\\)"
			(setq foldercontent (directory-files dir t regex-filter))
			(setq all-recent-dirs-foldercontent (append all-recent-dirs-foldercontent foldercontent))
		)
	)
	(setq all-files (append foldercontent-of-this-file recentf-list foldercontent-of-parent-of-this-file all-recent-dirs-foldercontent ))
  (message "%s" (safe-length all-files))
  (setq all-files (sort all-files  (lambda (a b) 
        (time-less-p 
                     (nth 5 (file-attributes b))
		(nth 5 (file-attributes a))
					 ))))	
; (setq all-files
        ; (mapcar #'car
                ; (sort all-files
                      ; #'(lambda (x y) 
					  ; (time-less-p (nth 6 (file-attributes y)) (nth 6 (file-attributes x)))))))
					 
  (setq all-files (delete-dups all-files))
  
	
)

; http://stackoverflow.com/questions/17164767/emacs-lisp-directory-files  
(defun cibin-find-related-files ()
	"Find a recent file using ido."
	(interactive)
	
	
	(setq all-files (get-related-files))
	(let ((file (ido-completing-read "related files: " 
                               (mapcar #'abbreviate-file-name all-files)
                               nil t)))
    (when file
      (find-file file))))

	  
(defun cibin-search-in-text-files-related-bash()
	(interactive)
	
	(setq prompt "grepcmd all/common/downs/ahk/notes/here/hhere   common/code/txt   searchTerm: ")
	(setq default (format "grepfilelist_related.sh "))
	(search-handler prompt default)
	
)  
	  
(defun cibin-search-in-common-files-bash()
	(interactive)
	
	(setq prompt "grepcmd all/common/downs/ahk/notes/here/hhere   common/code/txt   searchTerm: ")
	(setq default (format "grepfilelist_common.sh "))
	(search-handler prompt default)
	
  )
(defun extract ()

  (interactive)

  (setq cmd-str "extract.sh C:/Users/cibin/Downloads/New folder/generate.zip")
	(shell-command cmd-str "*extract*")
  )
(defun cibin-search-in-files-advgrep-here ()
	(interactive)
	
	(setq prompt "grepcmd all/common/downs/ahk/notes/here/hhere   common/code/txt   searchTerm: ")
	; TODO add the current file extension to this
	(setq file-ext (file-name-extension (buffer-file-name)))
	(setq default (format "advgrep.sh here %s " file-ext))
	(search-handler prompt default)
)
(defun search-handler (prompt default) 	
	
	(setq file "~/.emacs.d/my-files/emacs-tmp/filelist.txt")
	(when (file-exists-p file)
		(delete-file file))
	(setq filelist (format "%s" (mapconcat 'identity (get-related-files) "\n")))
 	(append-to-file filelist nil file ) 
	(setq cmd-str (read-from-minibuffer prompt default))
	(shell-command cmd-str "*grep*")
	 (switch-to-buffer "*grep*" t)  ; t: don't add it to the recent buffer list 
)
	  
; http://stackoverflow.com/questions/17164767/emacs-lisp-directory-files  
(defun cibin-search-in-freq-small-notes ()
	"Find a recent file using ido."
	(interactive)

	(setq all-files (get-related-files))
  (setq all-files (last (reverse all-files) 1500))
	(let ((file (ido-completing-read "related files: " 
                               all-files
                               nil t)))
    (when file
      (find-file file))))
	  
	  ; reformat XML code adding the following code in your .emacs:
(require 'sgml-mode)

(defun reformat-xml ()
"Reformat XML on Emacs "
  (interactive)
  (save-excursion
    (sgml-pretty-print (point-min) (point-max))
    (indent-region (point-min) (point-max))))

	
(defun cibin/launcher ()
    "easy launcher"
    (interactive)

	  (let ((file 
		  (ido-completing-read "choose? " (list "C:/Users/cibin/AppData/Roaming/BitTorrent/BitTorrent.exe" "D:/music/Pathirayo Pakalai.BACHELOR PARTY.mp3")
		)))
		(when file
		(cibin/spacemacs//open-in-external-app file)))
)	
(defun cibin/music ()
    "music launcher"
    (interactive)
	(let ((file 
	; (ido-completing-read "choose? " (list "D:/music/Nee Manimukil.mp3" "D:/music/Party-On-My-Mind-(Race-2)-KK-n-Honey-Singh-(Pagalworld.Com).mp3" "D:/music/Pathirayo Pakalai.BACHELOR PARTY.mp3"
	(ido-completing-read "choose? " 

	(delete-dups
	   (mapcar 'abbreviate-file-name  
				(read-file-into-lines "~/music.db")
				))
	  )))
		(when file
	(cibin/spacemacs//open-in-external-app file)))
)
(defun read-file-into-lines (filename)
  "Read file, split into lines, return a list"
  (with-temp-buffer
    (insert-file-contents filename)
    (split-string (buffer-substring-no-properties (point-min) (point-max)) "\n" t)))
	
(defun cibin/spacemacs//open-in-external-app (file-path)
  "Open `file-path' in external application."
  (cond
   ((spacemacs/system-is-mswindows) (w32-shell-execute "open" (replace-regexp-in-string "/" "\\\\" file-path)))
   ((spacemacs/system-is-mac) (shell-command (format "open \"%s\"" file-path)))
   ((spacemacs/system-is-linux) (let ((process-connection-type nil))
                                  (start-process "" nil "xdg-open" file-path)))))
								  

; delete till non whitespace
(global-set-key (kbd "M-SPC") 'fc/delete-space)
; (global-set-key (kbd "<M-Spc>") 'fixup-whitespace)
(global-set-key (kbd "C-c M-d") 'fc/delete-space)

(defun fc/delete-space ()
  "Remove all space around point.
Calling this repeatedly will clean more and more whitespace.
First, it will clear all whitespace until the end of the line, if
any. Then it will clear whitespace to the beginning of the line.
Then it will clear all following whitespace over any number of
lines. And then it will clear all preceding whitespace."
  (interactive)
  (cond
   ((looking-at "[ \t]+")
    (replace-match ""))
   ((looking-back "[ \t]")
    (let ((start (point)))
      (skip-chars-backward " \t")
      (delete-region (point) start)))
   ((looking-at "[ \t\n]+")
    (replace-match ""))
   ((looking-back "[ \t\n]")
    (let ((start (point)))
      (skip-chars-backward " \t\n")
      (delete-region (point) start)))))

	  
 (global-set-key (kbd "C-c C-u") 'fc/kill-to-beginning-of-line)
(defun fc/kill-to-beginning-of-line ()
  "Kill from the beginning of the line to point."
  (interactive)
  (kill-region (point-at-bol)
               (point)))		

; Popwin is a popup window manager for Emacs which makes you free from 
; the hell of annoying buffers such like Help, Completions, compilation, and etc.

(use-package popwin
  :ensure t
  :config
  (popwin-mode 1)
  (setq popwin:popup-window-height 35
        popwin:special-display-config
        '(("*Miniedit Help*" :noselect t)
          (help-mode :noselect nil)
          (completion-list-mode :noselect t)
          (compilation-mode :noselect nil)
          (grep-mode :noselect t)
          (occur-mode :noselect t)
          ("*Pp Macroexpand Output*" :noselect t)
          ("*Shell Command Output*")
          ("*Async Shell Command*")
          ("*vc-diff*")
          ("*vc-change-log*")
          (" *undo-tree*" :width 60 :position right)
          ("^\\*anything.*\\*$" :regexp t)
          ("*slime-apropos*")
          ("*slime-macroexpansion*")
          ("*slime-description*")
          ("*slime-compilation*" :noselect t)
          ("*slime-xref*")
          ("*Flycheck errors*")
          ("*Warnings*")
          ("*Error*")
          ("*Process List*")
          ("*Smex: Unbound Commands*")
          ("*Paradox Report*" :noselect nil)
          ("*Package Commit List*" :noselect nil)
          ("*Diff*" :noselect nil)
          ("*Messages*" :noselect nil)
          ("*Google Maps*" :noselect nil)
          ("*ag search*" :noselect nil)
          ("*PDF-Occur*" :noselect nil)
          ("*PDF-Metadata*" :noselect nil)
          ("^\\*Outline .*\\.pdf\\*$" :regexp t :noselect nil)
          ("*MULTI-TERM-DEDICATED*" :noselect nil :stick t)
          (sldb-mode :stick t)
          (slime-repl-mode)
          (slime-connection-list-mode)))

  (add-hook 'popwin:after-popup-hook 'turn-off-evil-mode)
  (bind-keys :map popwin:window-map
             ((kbd "<escape>") . popwin:close-popup-window)))




(defun joe-diff-buffer-with-file ()
  "Compare the current modified buffer with the saved version."
  (interactive)
  (let ((diff-switches "-u"))
    (diff-buffer-with-file (current-buffer))))

; vlf (view large files)
; VLF lets me handle things like 2gb files gracefully.
(use-package vlf-setup)


; https://writequit.org/org/settings.html
	(use-package eww
  :defer t
  :init
  (progn
    (define-prefix-command 'my/eww-map)
    (define-key ctl-x-map "w" 'my/eww-map)

    (define-key my/eww-map "t" 'eww)
    (define-key my/eww-map "o" 'eww)
    (define-key my/eww-map "w" 'my/eww-wiki)
    (define-key my/eww-map "e" 'my/search-es-docs)

    (defun my/eww-wiki (text)
      "Function used to search wikipedia for the given text."
      (interactive (list (read-string "Wiki for: ")))
      (eww (format "https://en.m.wikipedia.org/wiki/Special:Search?search=%s"
                   (url-encode-url text)))))
  :config
  (progn
    (define-key eww-mode-map "o" 'eww)
    (define-key eww-mode-map "O" 'eww-browse-with-external-browser)
    (use-package eww-lnum
      :init
      (eval-after-load "eww"
        '(progn (define-key eww-mode-map "f" 'eww-lnum-follow)
                (define-key eww-mode-map "F" 'eww-lnum-universal))))))


;; ==== Window switching ====
(defun my/other-window-backwards ()
  (interactive)
  (other-window -1))

(global-set-key (kbd "M-'") 'other-window)
(global-set-key (kbd "M-\"") 'my/other-window-backwards)

;; ==== transpose buffers ====
(defun transpose-buffers (arg)
  "Transpose the buffers shown in two windows."
  (interactive "p")
  (let ((selector (if (>= arg 0) 'next-window 'previous-window)))
    (while (/= arg 0)
      (let ((this-win (window-buffer))
            (next-win (window-buffer (funcall selector))))
        (set-window-buffer (selected-window) next-win)
        (set-window-buffer (funcall selector) this-win)
        (select-window (funcall selector)))
      (setq arg (if (plusp arg) (1- arg) (1+ arg))))))

(global-set-key (kbd "C-x 4 t") 'transpose-buffers)				


; Format JSON more beautifully
; I work with a ton of JSON, so I need to be able to format it nicely. Fortunately this is really easy with Python:

(defun beautify-json ()
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e
                             "python -mjson.tool" (current-buffer) t)))

							 
; Recompile startup elisp files
; Byte-compile startup stuff.
(defun byte-recompile-init-files ()
  "Recompile all of the startup files"
  (interactive)
  (byte-recompile-directory "~/.emacs.d" 0))


(defun duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated. However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))

(global-set-key (kbd "C-c d") 'duplicate-current-line-or-region)


 
(defun my-backward-kill-word ()
  (interactive)
  (setq word-delimiter-regexp "[-\s\"\(\):\;'=]")
  (setq word-delimiter-regexp-negated "[^-\s\"\(\):\;'=]+")

  (if (looking-at word-delimiter-regexp)

	(let ((p (point)))
		(if (looking-at "\\(.\\)\\1+")
			
			; select all repeated characters
			(progn
				(re-search-forward "\\(.\\)\\1+" nil :no-error)
			 ; (backward-char)
			 
		   )

		   ; delete adjacent special chars one by one
		   (setq p (+ (point) 1))

		   )
			(kill-region (point) p )
		   )

		; delete till next special char if at starting of an alphabet
		(let ((p (point)))
			;    (re-search-forward "[\w]+" nil :no-error)
			; TODO subwords are not considered here
			(re-search-forward word-delimiter-regexp-negated nil :no-error)
			;(backward-char)
			(kill-region p (point))
     )

	; delete the word
	   ; (kill-word 1)
	   ; (forward-word)
	   ;(re-search-forward "\\w+")
   )
)
(global-set-key (kbd "M-d") 'my-backward-kill-word) 
; ----(global-set-key (kbd "M-d") 'my-backward-kill-word) 

(provide 'more-custom-functions)

