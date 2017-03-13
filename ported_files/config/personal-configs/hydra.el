;; it modifies the existing hk's

;; more available at https://github.com/abo-abo/hydra/blob/master/hydra-examples.el

(defhydra cibin/hydra-ibuffer-main (:color pink :hint nil)
; https://github.com/abo-abo/hydra/wiki/Ibuffer
  "
 ^Navigation^ | ^Mark^        | ^Actions^        | ^View^
-^----------^-+-^----^--------+-^-------^--------+-^----^-------
  _k_:    ʌ   | _m_: mark     | _D_: delete      | _g_: refresh
 _RET_: visit | _u_: unmark   | _S_: save        | _s_: sort
  _j_:    v   | _*_: specific | _a_: all actions | _/_: filter
              | _*_: specific | _=_: diff        | _/_: filter
-^----------^-+-^----^--------+-^-------^--------+-^----^-------
"
  ("=" ibuffer-forward-line)
  ("j" ibuffer-forward-line)
  ("RET" ibuffer-visit-buffer :color blue)
  ("k" ibuffer-backward-line)

  ("m" ibuffer-mark-forward)
  ("u" ibuffer-unmark-forward)
  ("*" hydra-ibuffer-mark/body :color blue)

  ("D" ibuffer-do-delete)
  ("S" ibuffer-do-save)
  ("a" hydra-ibuffer-action/body :color blue)

  ("g" ibuffer-update)
  ("s" hydra-ibuffer-sort/body :color blue)
  ("/" hydra-ibuffer-filter/body :color blue)

  ("o" ibuffer-visit-buffer-other-window "other window" :color blue)
  ; ("q" ibuffer-quit "quit ibuffer" :color blue)
  ("q" quit-window "quit ibuffer" :color blue)
  ("." nil "toggle hydra" :color blue))
  
(defhydra hydra-ibuffer-mark (:color teal :columns 5
                              :after-exit (hydra-ibuffer-main/body))
  "Mark"
  ("*" ibuffer-unmark-all "unmark all")
  ("M" ibuffer-mark-by-mode "mode")
  ("m" ibuffer-mark-modified-buffers "modified")
  ("u" ibuffer-mark-unsaved-buffers "unsaved")
  ("s" ibuffer-mark-special-buffers "special")
  ("r" ibuffer-mark-read-only-buffers "read-only")
  ("/" ibuffer-mark-dired-buffers "dired")
  ("e" ibuffer-mark-dissociated-buffers "dissociated")
  ("h" ibuffer-mark-help-buffers "help")
  ("z" ibuffer-mark-compressed-file-buffers "compressed")
  ("b" hydra-ibuffer-main/body "back" :color blue))

(defhydra hydra-ibuffer-action (:color teal :columns 4
                                :after-exit
                                (if (eq major-mode 'ibuffer-mode)
                                    (hydra-ibuffer-main/body)))
  "Action"
  ("A" ibuffer-do-view "view")
  ("E" ibuffer-do-eval "eval")
  ("F" ibuffer-do-shell-command-file "shell-command-file")
  ("I" ibuffer-do-query-replace-regexp "query-replace-regexp")
  ("H" ibuffer-do-view-other-frame "view-other-frame")
  ("N" ibuffer-do-shell-command-pipe-replace "shell-cmd-pipe-replace")
  ("M" ibuffer-do-toggle-modified "toggle-modified")
  ("O" ibuffer-do-occur "occur")
  ("P" ibuffer-do-print "print")
  ("Q" ibuffer-do-query-replace "query-replace")
  ("R" ibuffer-do-rename-uniquely "rename-uniquely")
  ("T" ibuffer-do-toggle-read-only "toggle-read-only")
  ("U" ibuffer-do-replace-regexp "replace-regexp")
  ("V" ibuffer-do-revert "revert")
  ("W" ibuffer-do-view-and-eval "view-and-eval")
  ("X" ibuffer-do-shell-command-pipe "shell-command-pipe")
  ("b" nil "back"))

(defhydra hydra-ibuffer-sort (:color amaranth :columns 3)
  "Sort"
  ("i" ibuffer-invert-sorting "invert")
  ("a" ibuffer-do-sort-by-alphabetic "alphabetic")
  ("v" ibuffer-do-sort-by-recency "recently used")
  ("s" ibuffer-do-sort-by-size "size")
  ("f" ibuffer-do-sort-by-filename/process "filename")
  ("m" ibuffer-do-sort-by-major-mode "mode")
  ("b" hydra-ibuffer-main/body "back" :color blue))

(defhydra hydra-ibuffer-filter (:color amaranth :columns 4)
  "Filter"
  ("m" ibuffer-filter-by-used-mode "mode")
  ("M" ibuffer-filter-by-derived-mode "derived mode")
  ("n" ibuffer-filter-by-name "name")
  ("c" ibuffer-filter-by-content "content")
  ("e" ibuffer-filter-by-predicate "predicate")
  ("f" ibuffer-filter-by-filename "filename")
  (">" ibuffer-filter-by-size-gt "size")
  ("<" ibuffer-filter-by-size-lt "size")
  ("/" ibuffer-filter-disable "disable")
  ("b" cibin/hydra-ibuffer-main/body "back" :color blue))
(require 'cc-mode)
(require 'ibuffer)
; (eval-after-load 'ibuffer

; Key binding:
; (define-key ibuffer-mode-map (kbd "s p") 'ibuffer-do-sort-by-pathname)
; (define-key ibuffer-mode-map (kbd ".") 'cibin/hydra-ibuffer-main/body)
; Automatically open the hydra with Ibuffer.
; (add-hook 'ibuffer-mode-hooks #'cibin/hydra-ibuffer-main/body) 

; )
; Key binding:

(define-key ibuffer-mode-map "." 'cibin/hydra-ibuffer-main/body)
; Optional:

; Automatically open the hydra with Ibuffer.

(add-hook 'ibuffer-hook #'cibin/hydra-ibuffer-main/body)



;;** Example 4: toggle rarely used modes
(when (bound-and-true-p hydra-examples-verbatim)
  (defvar whitespace-mode nil)
  (global-set-key
   (kbd "C-c C-v")
   (defhydra hydra-toggle-simple (:color blue)
     "toggle"
     ("a" abbrev-mode "abbrev")
     ("d" toggle-debug-on-error "debug")
     ("f" auto-fill-mode "fill")
     ("t" toggle-truncate-lines "truncate")
     ("w" whitespace-mode "whitespace")
     ("q" nil "cancel"))))
	 
	 
	 
;; TODO integrate quickrun
  (defhydra hydra-quickrun (:color blue :columns 2)
    "Quickrun"
    ("h" helm-quickrun "helm")
    ("q" quickrun "run")
    ("r" quickrun-region "region")
    ("w" quickrun-with-arg "with-arg")
    ("s" quickrun-shell "shell")
    ("c" quickrun-compile-only "compile")
    ("p" quickrun-replace-region "replace"))
  (global-set-key (kbd "C-c q") 'hydra-quickrun/body)


  ;;TODO
  (defhydra hydra-cleanups (:color blue :columns 4)
  "Command"
  ;; remove blanks
  ;; remove dupes
  ;; remove trailings
  ("w" whitespace-cleanup "whitespace")
  ("g" helm-git-grep "git-grep")
  ("l" helm-ls-git-ls "git-ls")
  ("k" keyword-search "keyword-search")
  ("L" lively "lively")
  ("S" lively-stop "lively-stop")
  ("r" revert-buffer "revert-buffer")
  ("R" restart-emacs "restart")
  ("v" visit-tags-table "visit-tags")
  ("b" bongo "bongo")
  ("t" find-temp-file "temp"))
;(global-set-key (kbd "C-c x") 'hydra-cleanups/body)	 



(defhydra hydra-marked-items (dired-mode-map "")
  "
marked items: %(length (dired-get-marked-files)) Size: %(cdrw-get-size))
Directory size: %s(shell-command-to-string \"du -hs\")
"
  ("j" dired-next-line "down")
  ("m" dired-mark "mark")
	("k" dired-previous-line "up" )
	("." nil "toggle hydra" :color blue)

  )
  (define-key dired-mode-map "." 'hydra-marked-items/body)

  
; undo-tree-visualizer-mode-map
(defhydra hydra-undo-tree (undo-tree-visualizer-mode-map "")
  "
  undo-tree
"
  ("d" 'undo-tree-visualizer-toggle-diff "DIFF")
	("." nil "toggle hydra" :color blue)

  )


(defun dired-get-size ()
  (interactive)
  (let ((files (dired-get-marked-files)))
    (with-temp-buffer
      (apply 'call-process "/usr/bin/du" nil t nil "-sch" files)
      (message
       "Size of all marked files: %s"
       (progn
         (re-search-backward "\\(^[ 0-9.,]+[A-Za-z]+\\).*total$")
         (match-string 1))))))

 (defun cdrw-get-size ()
  (interactive)
  (let ((sum 0)
        (files (dired-get-marked-files)))
   (dolist (file files (format "%.1fM" sum))
    (incf sum (/ (nth 8 (car 
      (directory-files-and-attributes (file-name-directory file) nil 
        (regexp-quote (file-name-nondirectory file))))) 1048576.0)))))
		
		

; (defhydra cibinn/hydra-dired-main (:color pink :hint nil)
  ; "
 ; ^Navigation^ | ^Mark^        | ^Actions^        | ^View^
; -^----------^-+-^----^--------+-^-------^--------+-^----^-------
  ; _g_:    ʌ   | _l_: mark     | ^ ^              | ^ ^
; -^----------^-+-^----^--------+-^-------^--------+-^----^-------
; "
; ("g" text-scale-increase "in" :color blue)
; ("l" text-scale-decrease "out")
; )
; (add-hook 'dired-mode-hook #'cibinn/hydra-dired-main/body)




      (defhydra hydra-cibin-misc (:color blue :columns 4 :post (redraw-display))
        "hydra-toggle-mode"
        ("RET" redraw-display "<quit>")
        ("c" csv-mode "csv-mode")
        ("j" jinja2-mode "jinja2-mode")
        ("k" markdown-mode "markdown-mode")
        ("l" lineum-mode "lineum-mode")
		("a" cibin-apply-major-mode "cibin-apply-major-mode")
           
        ("m" moinmoin-mode "moinmoin-mode")
        ("o" org-mode "org-mode")
        ("p" python-mode "python-mode")
        ("r" R-mode "R-mode")
        ("s" sql-mode "sql-mode")
        ("t" text-mode "text-mode")
        ("v" visual-line-mode "visual-line-mode")
        ("y" yaml-mode "yaml-mode")
        )
     (global-set-key (kbd "C-x l") 'hydra-cibin-misc/body)  
  (if (require 'hydra nil 'noerror)
    (progn
      (defhydra hydra-search (:color blue :columns 4)
        "hydra-search"
        ("RET" helm-swoop "helm-swoop")
        ("b" helm-swoop-back-to-last-point "helm-swoop-back-to-last-point")
        ("f" file-file-in-project "find-file-in-project")
        ("m" helm-multi-swoop "helm-multi-swoop")
        ("M" helm-multi-swoop-all "helm-multi-swoop-all")
        ("o" occur "occur-dwim")
        ("O" occur-dwim "occur")
        ("r" vr/isearch-backward "vr/isearch-backward")
        ("s" vr/isearch-forward "vr/isearch-forward"))
      (global-set-key (kbd "C-c s") 'hydra-search/body))
  (message "** hydra is not installed"))
  
  (if (require 'hydra nil 'noerror)
    (progn (defhydra hydra-replace (:color blue)
             "hydra-replace"
             ("RET" replace-string "replace-string")
             ("r" vr/replace "vr/replace")
             ("q" query-replace "query-replace")
             ("Q" vr/query-replace "vr/query-replace"))

           (global-set-key (kbd "C-c r") 'hydra-replace/body))
  (message "** hydra is not installed"))
  
;; http://bnbeckwith.com/bnb-emacs/
  (defmacro toggle-setting-string (setting)
  `(if (and (boundp ',setting) ,setting) '[x] '[_]))
(bind-key
 "C-x t"
(defhydra hydra-toggle (:color amaranth)
   "
_c_ column-number : %(toggle-setting-string column-number-mode)  _b_ orgtbl-mode    : %(toggle-setting-string orgtbl-mode)  
_e_ debug-on-error: %(toggle-setting-string debug-on-error)  _s_ orgstruct-mode : %(toggle-setting-string orgstruct-mode)  _m_   hide mode-line : %(toggle-setting-string bnb/hide-mode-line-mode)  
_u_ debug-on-quit : %(toggle-setting-string debug-on-quit)  _h_ diff-hl-mode   : %(toggle-setting-string diff-hl-mode)
_f_ auto-fill     : %(toggle-setting-string auto-fill-function)  _B_ battery-mode   : %(toggle-setting-string display-battery-mode)
_t_ truncate-lines: %(toggle-setting-string truncate-lines)  _l_ highlight-line : %(toggle-setting-string hl-line-mode)
_r_ read-only     : %(toggle-setting-string buffer-read-only)  _n_ line-numbers   : %(toggle-setting-string linum-mode)
_w_ whitespace    : %(toggle-setting-string whitespace-mode)  _N_ relative lines : %(if (eq linum-format 'linum-relative) '[x] '[_])
"
   ("c" column-number-mode nil)
   ("e" toggle-debug-on-error nil)
   ("u" toggle-debug-on-quit nil)
   ("f" auto-fill-mode nil)
   ("t" toggle-truncate-lines nil)
   ("r" dired-toggle-read-only nil)
   ("w" whitespace-mode nil)
   ("b" orgtbl-mode nil)
   ("s" orgstruct-mode nil)
   ("x" bnb/transparency-next nil)
   ("B" display-battery-mode nil)
   ("X" bnb/transparency-previous nil)
   ("h" diff-hl-mode nil)
   ("l" hl-line-mode nil)
   ("n" linum-mode nil)
   ("N" linum-relative-toggle nil)
   ("m" bnb/hide-mode-line-mode nil)
   ("q" nil)))

        
   
   (defhydra sk/hydra-expand (:pre (er/mark-word)
                           :color red
                           :hint nil)
  "
 _a_: add    _r_: reduce   _q_: quit
 "
  ("a" er/expand-region :color blue)
  ("r" er/contract-region :color blue)
  ("q" nil :color blue))
  
  (defhydra hydra-org (:color red :hint nil)
    "
  Navigation^
  ---------------------------------------------------------
  _j_ next heading
  _k_ prev heading
  _h_ next heading (same level)
  _l_ prev heading (same level)
  _u_p higher heading
  _g_o to
  "
    ("j" outline-next-visible-heading)
    ("k" outline-previous-visible-heading)
    ("h" org-forward-heading-same-level)
    ("l" org-backward-heading-same-level)
    ("u" outline-up-heading)
    ("g" org-goto :exit t))
  
  (defhydra hydra-global-org (:color blue
                            :hint nil)
  "
Timer^^        ^Clock^         ^Capture^
--------------------------------------------------
s_t_art        _w_ clock in    _c_apture
 _s_top        _o_ clock out   _l_ast capture
_r_eset        _j_ clock goto
"
  ("t" org-timer-start)
  ("s" org-timer-stop)
  ;; Need to be at timer
  ("r" org-timer-set-timer)
  ("w" (org-clock-in '(4)))
  ("o" org-clock-out)
  ;; Visit the clocked task from any buffer
  ("j" org-clock-goto)
  ("c" org-capture)
  ("l" org-capture-goto-last-stored))



(with-eval-after-load 'org
    
(define-key org-mode-map (kbd "?") 'hydra-org/body)
(add-hook 'org-mode-hook #'hydra-org/body)
)


; Flycheck
; Flycheck is an amazing syntax-checking package for Emacs, and I’m a fan of helm-flycheck for navigation. Here’s the hydra I use for quickly navigating between warnings and errors which Flycheck reports, with quick access to helm-flycheck:

;; (use-package helm-flycheck
  ;; :config
  ;; (define-key flycheck-mode-map (kbd "C-c ! h") 'helm-flycheck)
  ;; (key-chord-define-global "QF"
   ;; (defhydra flycheck-hydra ()
     ;; "errors"
     ;; ("n" flycheck-next-error "next")
     ;; ("p" flycheck-previous-error "previous")
     ;; ("h" helm-flycheck "helm" :color blue)
     ;; ("q" nil "quit"))))
	 (defhydra hydra-help (:color blue :columns 8)
  "Help"
  ("f" describe-function "function")
  ("F" Info-goto-emacs-command-node "goto command")
  ("v" describe-variable "variable")
  ("m" describe-mode "mode")
  ("@" describe-face "face")
  ("k" describe-key "key")
  ("t" describe-theme "theme")
  ("b" describe-bindings "bindings")
  ("p" describe-package "package")
  ("d" helm-dash "dash")
  ("." helm-dash-at-point "dash at point"))
  
  ; mix with quickrun
  (defhydra hydra-eval (:color blue :columns 8)
  "Eval"
  ("e" eval-expression "expression")
  ("d" eval-defun "defun")
  ("b" eval-buffer "buffer")
  ("l" eval-last-sexp "last sexp")
  ("1" async-shell-command "shell-command"))
  
  
(defhydra hydra-magit (:color blue :columns 8)
  "Magit"
  ("c" magit-status "status")
  ("C" magit-checkout "checkout")
  ("v" magit-branch-manager "branch manager")
  ("m" magit-merge "merge")
  ("l" magit-log "log")
  ("!" magit-git-command "command")
  ("$" magit-process "process"))	 
	 
(use-package avy
  :config
  (use-package link-hint)
  (global-set-key (kbd "M-g g") #'avy-goto-line)
  (defhydra hydra-avy (global-map "M-g" :color blue)
    "avy-goto"
    ("c" avy-goto-char "char")
    ("C" avy-goto-char-2 "char-2")
    ("w" avy-goto-word-1 "word")
    ("s" avy-goto-subword-1 "subword")
    ("u" link-hint-open-link "open-URI")
    ("U" link-hint-copy-link "copy-URI")))
; https://github.com/nivekuil/corral