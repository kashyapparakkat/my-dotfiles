

(defun cbn-debug ()
  (interactive)
(menu-bar-mode 1)
(tool-bar-mode 1)
 (realgud:run-process "pdb" "C:/Python27/Lib/pdb.py" '("pdb" "C:/Users/cibin/Downloads/delete.py") realgud:pdb-minibuffer-history)
 
 )
;; (realgud:run-process "pdb" "C:/Users/cibin/Downloads/delete.py" '("python -m pdb" "") realgud:pdb-minibuffer-history)
;; (realgud:run-process "python -m C:/Python27/Lib/pdb.py" "C:/Users/cibin/Downloads/delete.py" '("pdb" "") realgud:pdb-minibuffer-history)
;; PDB command line


(defun user-python-debug-buffer ()
  "Run python debugger on current buffer."
  (interactive)
  (setq command (format "python -u -m pdb %s " (file-name-nondirectory buffer-file-name)))
  (let ((command-with-args (read-string "Debug command: " command nil nil nil)))
    (pdb command-with-args)))
