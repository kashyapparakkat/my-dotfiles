(defun aaa ()

(interactive)
(realgud:pdb "pdb c:/Users/cibin/Downloads/delete.py")
(message "switched to py file")
(sleep-for 5)
;; (switch-to-buffer old-buffer)
(isend-associate  "*pdb delete.py shell*")
;; (switch-to-buffer old-buffer)
 
)

(global-set-key (kbd "<C-f8>") 'cibin/eval-this-line)
(defun cibin/eval-this-line () (interactive)
       (end-of-line)
       (call-interactively 'eval-last-sexp)
       (next-line)
)


;; (require 'isend)
 (setq isend-skip-empty-lines nil)
  (setq isend-strip-empty-lines nil)
  (setq isend-delete-indentation t)
  (setq isend-end-with-empty-line t)

(defun cbn-debug ()
  (interactive)
(require 'realgud) ; lazy loading
;; (menu-bar-mode 1)
;; (tool-bar-mode 1)
(setq old-buffer buffer-file-name)
(message "running real")
    (realgud:run-process "pdb" "pdb" '("pdb" "C:/Users/cibin/Downloads/delete.py") realgud:pdb-minibuffer-history)
    ;; (realgud:run-process "pdb" "C:/Python27/Lib/pdb.py" '("pdb" "C:/Users/cibin/Downloads/delete.py") realgud:pdb-minibuffer-history)
    ;; (sleep-for 3)
(switch-to-buffer old-buffer)
(message "switched to py file")
(sleep-for 3)
(switch-to-buffer old-buffer)
(isend-associate  "*pdb pdb shell*")
(switch-to-buffer old-buffer)
 ;; (isend)
)


;; (realgud:run-process "pdb" "C:/Users/cibin/Downloads/delete.py" '("python -m pdb" "") realgud:pdb-minibuffer-history)
;; (realgud:run-process "python -m C:/Python27/Lib/pdb.py" "C:/Users/cibin/Downloads/delete.py" '("pdb" "") realgud:pdb-minibuffer-history)
;; PDB command line


(defun user-python-debug-buffer ()
  "Run default python debugger on current buffer."
  (interactive)
  (setq command (format "python -u -m pdb %s " (file-name-nondirectory buffer-file-name)))
  (let ((command-with-args (read-string "Debug command: " command nil nil nil)))
    (pdb command-with-args)))
