
great and good https://github.com/kaushalmodi/.emacs.d/tree/master/setup-files

C-x z; repeat then z  z z z z z z
helm-decsb
(defun repeat-complex-command-no-confirm ()
  "..."
  (interactive)
  (let* ((hist  command-history)
         newcmd)
    (while (eq 'repeat-complex-command-no-confirm (caar hist))
      (setq hist  (cdr hist)))
    (setq newcmd  (car hist))
    (if newcmd
        (apply #'funcall-interactively (car newcmd)
               (mapcar (lambda (ee) (eval ee t)) (cdr newcmd)))
      (error "There are no previous complex commands to repeat"))))
(car command-history)


; A complex command is one that uses the minibuffer. That's different from the repeat command that is usually bound to 【Ctrl+x z】
(global-set-key (kbd "M-H") 'repeat-complex-command)
(global-set-key (kbd "M-G") 'repeat)


hk:: to use right arrow in helm buffer
ma and 'a surfingkeys
org-reeveal
make C-w delete to back even in normal mode;
try C-w delete backward C-e delete forward if prev is C-w; C-r delete till punctuation

https://github.com/kaushalmodi/.emacs.d/blob/master/setup-files/setup-ag.el
(defun ag/jump-to-result-if-only-one-match ()
      "Jump to the first ag result if that ag search came up with just one match."
.....
	  
	  
(global-set-key (kbd "<M-F8>") 'eval-buffer)
(global-set-key (kbd "<C-F8>") 'eval-region)

;; hk:: eval buffer/region
;; hk:: ediff with saved 
;; hk:: revert


; (setq ag-project-root-function         (lambda (d) (let ((default-directory d)) )))
(setq ag-project-root-function         (lambda (d) (message default-directory)))
(message (format "%s"  default-directory))

(defun aaaaa(d)
(interactive)
 (let ((default-directory d)) (projectile-project-root))
)
(setq-default default-directory "C:/cbn_gits/AHK/LIB/")
        ; (default-directory "c:/")
        ; (default-directory)
        (projectile-project-root)

(setq exec-path (append exec-path '("c:/cygwin64/bin")))
(setq find-program "C:\\cygwin64\\bin\\find.exe")

remove org hydra



;; http://pragmaticemacs.com/emacs/regions-marks-and-visual-mark/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; visible mark - show where mark is                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defface visible-mark-active ;; put this before (require 'visible-mark)
  '((((type tty) (class mono)))
    (t (:background "magenta"))) "")
(require 'visible-mark)
(global-visible-mark-mode 1) ;; or add (visible-mark-mode) to specific hooks
(setq visible-mark-max 2)
(setq visible-mark-faces `(visible-mark-face1 visible-mark-face2))

(use-package anzu
  :init (global-anzu-mode)
  :bind (
    ("M-%" . anzu-query-replace)
    ("C-M-%" . anzu-query-replace-regexp)
  )
)


(defun my/anzu-update-func (here total)
  (when anzu--state
    (let ((status (cl-case anzu--state
                    (search (format "<%d/%d>" here total))
                    (replace-query (format "(%d Replaces)" total))
                    (replace (format "<%d/%d>" here total)))))
      (propertize status 'face 'anzu-mode-line))))

(custom-set-variables
 '(anzu-mode-line-update-function #'my/anzu-update-func))
(require 'anzu)
(global-anzu-mode +1)

(set-face-attribute 'anzu-mode-line nil
                    :foreground "yellow" :weight 'bold)

(custom-set-variables
 '(anzu-mode-lighter "")
 '(anzu-deactivate-region t)
 '(anzu-search-threshold 1000)
 '(anzu-replace-threshold 50)
 '(anzu-replace-to-string-separator " => "))

(define-key isearch-mode-map [remap isearch-query-replace]  #'anzu-isearch-query-replace)
(define-key isearch-mode-map [remap isearch-query-replace-regexp] #'anzu-isearch-query-replace-regexp)
