;; it modifies the existing hk's

;; many hydra's taken from https://sriramkswamy.github.io/dotemacs/
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
"
;; -^----------^-+-^----^--------+-^-------^--------+-^----^-------
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

; todo move this hook to some other file
(add-hook 'ibuffer-hook (lambda () (setq truncate-lines t)))


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

	 ;; Quickrun

;; This is for Quickrun functionality.

(defhydra sk/hydra-quickrun (:color blue
                             :hint nil)
  "
 _s_: quickrun     _a_: with arg    _c_: compile only       _q_: quit
 _r_: run region   _S_: shell       _R_: replace region
"
  ("s" quickrun)
  ("r" quickrun-region)
  ("a" quickrun-with-arg)
  ("S" quickrun-shell)
  ("c" quickrun-compile-only)
  ("R" quickrun-replace-region)
  ("q" nil :color blue))

;; TODO integrate quickrun, edebug, python
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

;; Debugging
;; Emacs has a built-in debugger in edebug and, apparently, it’s pretty good. Let’s make a small hydra for that.
;; A small hydra to start appropriate debuggers

(defhydra sk/hydra-debug (;; :pre (load-library "realgud")
                          :color blue
                          :hint nil)
  "
 _g_: c-gdb         _p_: py-pdb        _i_: py-ipdb        _q_: quit
 _G_: realgud-gdb   _P_: realgud-pdb   _I_: realgud-ipdb
"
  ("g" gdb)
  ("G" realgud:gdb)
  ("p" pdb)
  ("P" realgud:pdb)
  ("i" ipdb)
  ("I" realgud:ipdb)
  ("q" nil :color blue))


;;TODO
  (defhydra hydra-cleanups (:color blue :columns 4)
  "Command"
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
(global-set-key (kbd "C-x c") 'hydra-cleanups/body)



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
        ("a" cibin-apply-major-mode "cibin-apply-major-mode")
        ("c" csv-mode "csv-mode")
        ("h" html-mode "html-mode")
        ("j" jinja2-mode "jinja2-mode")
        ("k" markdown-mode "markdown-mode")
        ("l" lineum-mode "lineum-mode")
        ("m" moinmoin-mode "moinmoin-mode")
        ("o" org-mode "org-mode")
        ("p" python-mode "python-mode")
        ("r" R-mode "R-mode")
        ("s" sql-mode "sql-mode")
        ("t" text-mode "text-mode")
        ("v" visual-line-mode "visual-line-mode")
        ("w" web-mode "web-mode")
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
_u_ debug-on-quit : %(toggle-setting-string debug-on-quit)  _d_ diff-hl-mode   : %(toggle-setting-string diff-hl-mode)
_f_ auto-fill     : %(toggle-setting-string auto-fill-function)  _B_ battery-mode   : %(toggle-setting-string display-battery-mode)
_t_ truncate-lines(long line wrap): %(toggle-setting-string truncate-lines)  _l_ highlight-line : %(toggle-setting-string hl-line-mode)
_r_ read-only     : %(toggle-setting-string buffer-read-only)  _n_ line-numbers   : %(toggle-setting-string linum-mode)
_w_ whitespace    : %(toggle-setting-string whitespace-mode)  _N_ relative lines : %(if (eq linum-format 'linum-relative) '[x] '[_])
_j_ next-line      _k_ previous-line
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
   ("d" diff-hl-mode nil)
   ("j" next-line nil)
   ("k" previous-line nil)
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

  (defhydra hydra-org (:color blue :hint nil)
  ;; Navigation^
  ;; ---------------------------------------------------------
    "
  _j_ next heading        _h_ next heading (same level)
  _k_ prev heading        _l_ prev heading (same level)
  _u_p higher heading     _g_o to
  ----------
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

  ; (define-key org-mode-map (kbd "?") 'hydra-org/body)
  	(evil-define-key 'normal org-mode-map  (kbd "?")'hydra-org/body)
;; TODO disabling for now
;; (add-hook 'org-mode-hook #'hydra-org/body)
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



(defhydra sk/hydra-rectangle (:pre (rectangle-mark-mode 1)
                              :color pink
                              :hint nil)
  "
 _p_: paste   _r_: replace  _I_: insert
 _y_: copy    _o_: open     _V_: reset
 _d_: kill    _n_: number   _q_: quit
"
  ("h" backward-char nil)
  ("l" forward-char nil)
  ("k" previous-line nil)
  ("j" next-line nil)
  ("y" copy-rectangle-as-kill)
  ("d" kill-rectangle)
  ("x" clear-rectangle)
  ("o" open-rectangle)
  ("p" yank-rectangle)
  ("r" string-rectangle)
  ("n" rectangle-number-lines)
  ("I" string-insert-rectangle)
  ("V" (if (region-active-p)
           (deactivate-mark)
         (rectangle-mark-mode 1)) nil)
  ("q" keyboard-quit :color blue))
;; Key binding
(bind-keys*
  ("M-m V" . sk/hydra-rectangle/body))


;; Multiple cursors hydra

(defhydra sk/hydra-multiple-cursors (:color red
                                     :hint nil)
  "
  _k_: prev         _j_: next         _a_: all     _b_: beg of lines   _q_: quit
  _K_: skip prev    _J_: skip next    _d_: defun   _e_: end of lines
  _p_: unmark prev  _n_: unmark next  _r_: regexp  _l_: lines
"
  ("j" mc/mark-next-like-this)
  ("J" mc/skip-to-next-like-this)
  ("n" mc/unmark-next-like-this)
  ("k" mc/mark-previous-like-this)
  ("K" mc/skip-to-previous-like-this)
  ("p" mc/unmark-previous-like-this)
  ("a" mc/mark-all-like-this :color blue)
  ("d" mc/mark-all-like-this-in-defun :color blue)
  ("r" mc/mark-all-in-region-regexp :color blue)
  ("b" mc/edit-beginnings-of-lines)
  ("e" mc/edit-ends-of-lines)
  ("l" mc/edit-lines :color blue)
  ("q" nil :color blue))
;; Key binding
;; (bind-keys*
  ;; ("C-t" . sk/hydra-multiple-cursors/body))


;; TODO make it work for all languages
(defhydra sk/hydra-for-py (:color blue
                           :hint nil)
  "
 ^Send^                     ^Navigate^                    ^Virtualenv^      ^Testing^                                        ^Format^
^^^^^^^^^^--------------------------------------------------------------------------------------------------------------------------------
 _r_: region    _s_: start    _d_: definition    _F_: file    _V_: pyenv        _ta_: test all    _tm_: test mod    _pd_: pdb dir    _c_: create-doc
 _b_: buffer    _S_: switch   _a_: assignment    _B_: back    _u_: pyenv set    _td_: test dir    _to_: test one    _pm_: pdb mod    _y_: yapf
 _f_: func                  _v_: reference     _D_: doc     _U_: pyenv unset  _tf_: test fail   _pa_: pdb all     _po_: pdb one    _q_: quit
"
  ("r" python-shell-send-region)
  ("b" python-shell-send-buffer)
  ("f" python-shell-send-defun)
  ("s" run-python)
  ("S" python-shell-switch-to-shell)
  ("d" anaconda-mode-find-definitions :color red)
  ("D" anaconda-mode-show-doc :color red)
  ("a" anaconda-mode-find-assignments :color red)
  ("v" anaconda-mode-find-references :color red)
  ("F" anaconda-mode-find-file :color red)
  ("B" anaconda-mode-go-back :color red)
  ("V" pyenv-mode :color red)
  ("u" pyenv-mode-set)
  ("U" pyenv-mode-unset)
  ("ta" pytest-all)
  ("td" pytest-directory)
  ("tf" pytest-failed)
  ("tm" pytest-module)
  ("to" pytest-one)
  ("pa" pytest-pdb-all)
  ("pd" pytest-pdb-directory)
  ("pm" pytest-pdb-module)
  ("po" pytest-pdb-one)
  ("c" sphinx-doc)
  ("y" py-yapf-buffer)
  ("q" nil :color blue))
;; Key binding
(bind-keys*
  ("M-m s p" . sk/hydra-for-py/body))
;; Modal binding
;; (modalka-define-kbd "s p" "M-m s p")
;; Which key modal explanation

(which-key-add-key-based-replacements
  "s p" "python code")

;;; Web

; There are two hydras we use for Web editing - one for JavaScript specifically and one for web mode.

(defhydra sk/hydra-for-js (:color blue
                           :hint nil)
  "
 ^Node^                                ^Tern^                                  ^Json^
^^^^^^^^^^-----------------------------------------------------------------------------------------
 _r_: region    _s_: start    _l_: load    _d_: definition    _h_: highlight refs    _j_: path
 _b_: buffer    _S_: switch              _n_: def by name   _u_: use-server        _q_: quit
 _x_: sexp      _e_: exec                _t_: type          _D_: doc
"
  ("r" nodejs-repl-send-region)
  ("b" nodejs-repl-send-buffer)
  ("x" nodejs-repl-send-last-sexp)
  ("s" nodejs-repl)
  ("S" nodejs-repl-switch-to-repl)
  ("e" nodejs-repl-execute)
  ("l" nodejs-repl-load-file :color red)
  ("d" tern-find-definition :color red)
  ("n" tern-find-definition-by-name :color red)
  ("t" tern-get-type :color red)
  ("D" tern-get-docs :color red)
  ("u" tern-use-server :color red)
  ("h" tern-highlight-refs)
  ("R" tern-rename-variable)
  ("j" jsons-print-path)
  ("q" nil :color blue))
(defhydra sk/hydra-for-web (:color red
                            :hint nil)
  "
 ^Server^           ^HTML^                ^Skewer^
^^^^^^^^^^------------------------------------------------------------------------------------------------------------------------------
 _w_: httpd start   _i_: html real-time   _j_: js eval     _r_: run            _f_: eval func              _l_: load buffer      _p_: phantomjs
 _W_: httpd stop                        _h_: html eval   _s_: start          _e_: eval last exp          _b_: bower load       _P_: phantomjs kill
                                      _c_: css eval    _S_: list clients   _E_: eval print last exp    _B_: bower refresh    _q_: quit
"
  ("w" httpd-start :color blue)
  ("W" httpd-stop :color blue)
  ("i" impatient-mode :color blue)
  ("j" skewer-mode)
  ("h" skewer-html-mode)
  ("c" skewer-css-mode)
  ("r" run-skewer)
  ("s" skewer-repl :color blue)
  ("S" list-skewer-clients :color blue)
  ("f" skewer-eval-defun :color blue)
  ("e" skewer-eval-last-expression :color blue)
  ("E" skewer-eval-print-last-expression :color blue)
  ("l" skewer-load-buffer :color blue)
  ("b" skewer-bower-load :color blue)
  ("B" skewer-bower-refresh)
  ("p" skewer-run-phantomjs :color blue)
  ("P" skewer-phantomjs-kill)
  ("q" nil :color blue))

(defun flush-blank-lines (start end) (interactive "r") (flush-lines "^\\s-*$" start end nil))

;;; https://www.masteringemacs.org/article/removing-blank-lines-buffer
(defun collapse-blank-lines (start end) (interactive "r") (replace-regexp "^\n\\{2,\\}" "\n" nil start end))
(defun my-delete-leading-whitespace (start end)
          "Delete whitespace at the beginning of each line in region."
          (interactive "*r")
          (save-excursion
            (if (not (bolp)) (forward-line 1))
            (delete-whitespace-rectangle (point) end nil)))
(defhydra cibin/hydra-for-format (:color red
                               :hint nil)


 ;; ^Beautify^
  "
 ^^^-blanks ---------------  ------whitespace----------------- ------dupes----------------------------   ---actions
 _r_: collapse-blank-lines   _t_: delete-trailing-whitespace    _d_: delete-duplicate-lines(incl blank   _a_: select All 
 _f_: flush-blank-lines      _l_: my-delete-leading-whitespace  _h_: hlt-highlight-line-dups-region      _w_: toggle whitespace indicators
 _b_: delete-blank-lines     _k_: keep-lines     _k_: leading, blanks,                                   _t_: truncate toggle
                             _x_: flush-lines                                                            _t_: stats                 _q_: quit
 _i_: indent                                                                                             _n_: json or quickurun hydra to & back
"

  ("r" collapse-blank-lines)
  ("c" nil)
  ("i" nil)
  ("x" flush-lines)
  ("h" hlt-highlight-line-dups-region)
  ("j" nil)
  ("n" nil)
  ("k" keep-lines)
  ("b" delete-blank-lines)
  ("a" mark-whole-buffer)
  ("d" delete-duplicate-lines)
  ("f" flush-blank-lines)
  ("t" delete-trailing-whitespace)
  ("l" my-delete-leading-whitespace)
  ("w" whitespace-mode)
  ("q" nil :color blue))
(bind-keys*
  ("C-x f" . cibin/hydra-for-format/body))

;;REMOVE after cibin/hydra.... is ready
(defhydra sk/hydra-for-format (:color red
                               :hint nil)
  "
 ^Beautify^
^^^^^^^^^^--------------------------------------
 _h_: html        _c_: css       _j_: js        _q_: quit
 _H_: html buf    _C_: css buf   _J_: js buf
"
  ("h" web-beautify-html)
  ("H" web-beautify-html-buffer)
  ("c" web-beautify-css)
  ("C" web-beautify-css-buffer)
  ("j" web-beautify-js)
  ("J" web-beautify-js-buffer)
  ("q" nil :color blue))
; Key binding
(bind-keys*
  ("M-m s j" . sk/hydra-for-js/body)
  ("M-m s w" . sk/hydra-for-web/body)
  ("M-m s f" . sk/hydra-for-format/body))
; Modal binding
; (modalka-define-kbd "s j" "M-m s j")
; (modalka-define-kbd "s w" "M-m s w")
; (modalka-define-kbd "s f" "M-m s f")
; Which key modal explanation

(which-key-add-key-based-replacements
  "s j" "javscript code"
  "s w" "web code"
  "s f" "format code")
