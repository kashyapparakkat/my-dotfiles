(message "loading cbn-dired-settings2")
;  https://www.reddit.com/r/emacs/comments/4agkye/how_do_you_customize_dired/

;; work like two-panelled file manager if two dired buffers opened. Very cool!
(setq dired-dwim-target t)


;;----------------------------------------
;;Open file by C-return in external application
(defun ergoemacs-open-in-external-app ()
  "Open the current file or dired marked files in external app."
  (interactive)
  (let ( doIt
         (myFileList
          (cond
           ((string-equal major-mode "dired-mode") (dired-get-marked-files))
           (t (list (buffer-file-name))) ) ) )

    (setq doIt (if (<= (length myFileList) 5)
                   t
                 (y-or-n-p "Open more than 5 files?") ) )

    (when doIt
      (cond
       ((string-equal system-type "windows-nt")
        (mapc (lambda (fPath) (w32-shell-execute "open" (replace-regexp-in-string "/" "\\" fPath t t)) ) myFileList)
        )
       ((string-equal system-type "darwin")
        (mapc (lambda (fPath) (shell-command (format "open \"%s\"" fPath)) )  myFileList) )
       ((string-equal system-type "gnu/linux")
        (mapc (lambda (fPath) (let ((process-connection-type nil)) (start-process "" nil "xdg-open" fPath)) ) myFileList) ) ) ) ) )

(define-key dired-mode-map (kbd "<C-return>") 'ergoemacs-open-in-external-app)

;;----------------------------------------
;;Sort settings
;(require 'dired-sort-menu+)

    (use-package dired-sort-menu+
  :defer t)
(add-hook 'dired-load-hook
          (lambda () (require 'dired-sort-menu)))

(if (eq system-type 'windows-nt) ;OR gnu/linux
    (setq dired-listing-switches "-lah")
  (setq dired-listing-switches "-lah --group-directories-first"))

;; windows settings See (customize-group 'ls-lisp)
(setq ls-lisp-dirs-first t)
(setq ls-lisp-ignore-case t)
; hide the link count, user, and group columns - default is '(links uid gid)
(setq ls-lisp-verbosity '(links))
; use ISO dates (the first is for recent dates, second for old dates)
(setq ls-lisp-format-time-list '("%Y-%m-%d %H:%M" "%Y-%m-%d      "))
(setq ls-lisp-use-localized-time-format t)

;; Always copy/delete recursively
(setq dired-recursive-copies (quote always))
(setq dired-recursive-deletes (quote top))

;; Auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

;; включаем omit-mode по-умолчанию, т.е. скрываем по-умолчанию файлы .bashrc и т.д.
;; отключается в меню или по C-x M-o
;; http://www.emacswiki.org/emacs/DiredOmitMode
;;(setq dired-omit-files "^\\.?#\\|^\\.$\\|^\\.\\.$") ;;default

;(require 'dired-x)

    (use-package dired-x
  :defer t)
(setq-default dired-omit-files-p t) ; Buffer-local variable
(setq dired-omit-files "^\\.?#\\|^\\.$\\|^\\.[^.].+$")
(add-hook 'dired-mode-hook (lambda () (dired-omit-mode)))

;; (require 'dired-details)
;; (dired-details-install)
;; ;;(setq dired-details-hidden-string " [\u25bc] ")
;; (setq dired-details-hidden-string "[…] ")

;; Allow to switch from current user to sudo when browsind `dired' buffers.
;; To activate and swit with "C-c C-s" just put in your .emacs:
; (require 'dired-toggle-sudo)
; (define-key dired-mode-map (kbd "C-c C-s") 'dired-toggle-sudo)



;; (eval-after-load 'tramp
;;  '(progn
;;     ;; Allow to use: /sudo:user@host:/path/to/file
;;     (add-to-list 'tramp-default-proxies-alist
;;        '(".*" "\\`.+\\'" "/ssh:%h:"))))

;;http://www.emacswiki.org/emacs/DiredPlus
;; (require 'dired+)

;;------------------------------
;; Create new file via "N" key with full path creation if subdirectories missing (foo/bar/filename.txt as example). "+" key create only directory.

(eval-after-load 'dired
  '(progn
     (defun my-dired-create-file (file)
       "Create a file called FILE. If FILE already exists, signal an error."
       (interactive
        (list (read-file-name "Create file: " (dired-current-directory))))
       (let* ((expanded (expand-file-name file))
              (try expanded)
              (dir (directory-file-name (file-name-directory expanded)))
              new)
         (if (file-exists-p expanded)
             (error "Cannot create file %s: file exists" expanded))
         ;; Find the topmost nonexistent parent dir (variable `new')
         (while (and try (not (file-exists-p try)) (not (equal new try)))
           (setq new try
                 try (directory-file-name (file-name-directory try))))
         (when (not (file-exists-p dir))
           (make-directory dir t))
         (write-region "" nil expanded t)
         (when new
           (dired-add-file new)
           (dired-move-to-filename))))
     (define-key dired-mode-map (kbd "N") 'my-dired-create-file)))
	 
(defun shell-instead-dired ()
  (interactive)
  (let ((dired-buffer (current-buffer)))
    (shell (concat default-directory "-shell"))
    ;; (kill-buffer dired-buffer) ;; remove this line if you don't want to kill the dired buffer
    ;; (delete-other-windows)
    ))

(define-key dired-mode-map (kbd "<M-return>") 'shell-instead-dired)


;;----------------------------------------
;; http://stackoverflow.com/questions/10226836/how-to-tar-and-compress-marked-files-in-emacs
;; You can also archive files just by marking and copying them to an archive file.
;; For example, mark several files in dired, and select m-x dired-do-copy.
;; When prompted for destination, type test.zip. The files will be added to the zip archive automatically.
;; You can also uncompress files by selecting them in dired and running the command dired-do-extract
;; To set this up, look at the following variables: dired-to-archive-copy-alist dired-extract-alist
;; Here's my setup, which has served me for many years...
;; ;; dired-a provides support functions, including archiving, for dired
;; (load "dired-a")

;; Alist with information how to add files to an archive (from dired-a)
;; Each element has the form (REGEXP ADD-CMD NEW-CMD). If REGEXP matches
;; the file name of a target, that target is an archive and ADD-CMD is a command
;; that adds to an existing archive and NEW-CMD is a command that makes a new
;; archive (overwriting an old one if it exists). ADD-CMD and NEW-CMD are:
;; 1. Nil (meaning we cannot do this for this type of archive) (one of
;;    ADD-CMD and NEW-CMD must be non-nil).
;; 2. A symbol that must be a function e.g. dired-do-archive-op.
;; 3. A format string with two arguments, the source files concatenated into
;;    a space separated string and the target archive.
;; 4. A list of strings, the command and its flags, to which the target and
;;    the source-files are concatenated."
(setq dired-to-archive-copy-alist
      '(("\\.sh\\(ar\\|[0-9]\\)*$" nil "shar %s > %s")
    ("\\.jar$" ("jar" "uvf") ("jar" "cvf"))
    ("\\.tar$" ("tar" "-uf") ("tar" "-cf"))
    ("\\.tgz$\\|\\.tar\\.g?[zZ]$" ("tar" "-uf %s" "|" "gzip > %s") ("tar" "-czvf"))
    ("\\.ear$" ("zip" "-qr") ("zip" "-qr"))
;   ("\\.rar$" ("rar" "a")   ("rar" "a"))
    ("\\.war$" ("zip" "-qr") ("zip" "-qr"))
    ("\\.zip$" ("zip" "-qr") ("zip" "-qr"))
    ("\\.wmz$" ("zip" "-qr") ("zip" "-qr")) ;; for media player skins
    ("\\.arc$" ("arc" "a") nil)
    ("\\.zoo$" ("zoo" "aP") nil)
    ))

;; use pkzip with manipulating zip files (t) from within dired (use zip
;; and unzip otherwise)
(setq archive-zip-use-pkzip nil)

;; add these file types to archive mode to allow viewing and changing
;; their contents
(add-to-list 'auto-mode-alist '("\\.[ejrw]ar$\\'" . archive-mode))

;; modify the dired-extract switches to use the directory
;; ~/download/tryout as the default extract directory for zip files
(defconst MY_TRYOUT_DIR "~/downloads/tryout"
  "Directory for extracting files")

(setq dired-extract-alist
      `(
    ("\\.u\\(ue\\|aa\\)$" . dired-uud)
    ("\\.jar$" . "jar -xvf %s")
    ("\\.tar$" . ,(concat "tar -xf %s -C " MY_TRYOUT_DIR))
    ("\\.tgz$\\|\\.tar\\.g?[zZ]$" . ,(concat "tar -xzf %s -C " MY_TRYOUT_DIR))
    ("\\.arc$" . "arc x %s ")
    ("\\.bz2$" . ,(concat "bunzip2 -q %s"))
    ("\\.rar$" . ,(concat "unrar x %s " MY_TRYOUT_DIR "\\"))
    ("\\.zip$" . ,(concat "unzip -qq -Ux %s -d " MY_TRYOUT_DIR))
    ("\\.ear$" . ,(concat "unzip -qq -Ux %s -d " MY_TRYOUT_DIR))
    ("\\.war$" . ,(concat "unzip -qq -Ux %s -d " MY_TRYOUT_DIR))
    ("\\.zoo$" . "zoo x. %s ")
    ("\\.lzh$" . "lha x %s ")
    ("\\.7z$"  . "7z e %s ")
    ("\\.g?[zZ]$" . "gzip -d %s")   ; There is only one file
    ))


; ----------------------------------------
;; dired ediff selected files by = key
; ----------------------------------------
;; http://stackoverflow.com/questions/18121808/emacs-ediff-marked-files-in-different-dired-buffers
;; works for files marked in the same dired buffer and also for files in different buffers. In
;; addition to working on 2 marked files potentially across dired buffers, it handles the case when
;; there are 0 or 1 marked files. 0 marked files will use the file under the cursor as file A, and
;; prompt for a file to compare with. 1 marked files will use the marked file as file A, and prompt
;; for a file to compare with. The file under the point is used as the default in the prompt. I
;; bound this to =

;;ediff-split-window-function ;; http://www.gnu.org/software/emacs/manual/html_node/ediff/Miscellaneous.html

(defun mkm/ediff-marked-pair ()
   "Run ediff-files on a pair of files marked in dired buffer"
   (interactive)
   (let* ((marked-files (dired-get-marked-files nil nil))
          (other-win (get-window-with-predicate
                      (lambda (window)
                        (with-current-buffer (window-buffer window)
                          (and (not (eq window (selected-window)))
                               (eq major-mode 'dired-mode))))))
          (other-marked-files (and other-win
                                   (with-current-buffer (window-buffer other-win)
                                     (dired-get-marked-files nil)))))
     (cond ((= (length marked-files) 2)
            (ediff-files (nth 0 marked-files)
                         (nth 1 marked-files)))
           ((and (= (length marked-files) 1)
                 (= (length other-marked-files) 1))
            (ediff-files (nth 0 marked-files)
                         (nth 0 other-marked-files)))
           ((= (length marked-files) 1)
            (let ((single-file (nth 0 marked-files)))
              (ediff-files single-file
                           (read-file-name
                            (format "Diff %s with: " single-file)
                            nil (m (if (string= single-file (dired-get-filename))
                                       nil
                                     (dired-get-filename))) t))))
           (t (error "mark no more than 2 files")))))

(define-key dired-mode-map "=" 'mkm/ediff-marked-pair)


;;--------------------------------------------------------------------------------

(provide 'cbn-dired-settings2)