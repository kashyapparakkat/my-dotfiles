;;good ;;https://github.com/oleg-pavliv/emacs/blob/master/dired-custom.el

(defun op:dired-find-file-literally ()
  (let* ((file (dired-get-file-for-visit)) (buf (get-buffer-create (concat file ".literal"))))
    (with-current-buffer buf
      (delete-region (point-min) (point-max))
      (insert-file-contents-literally file))
    (switch-to-buffer buf)))

	
	; show env var named path
(getenv "PATH")

; example of setting env var named “path”
; by prepending new paths to existing paths
(setenv "PATH"
  (concat
   "C:/cygwin/usr/local/bin" ";"
   "C:/cygwin/usr/bin" ";"
   "C:/cygwin/bin" ";"
   (getenv "PATH") ; inherited from OS
  )
)




(defun my-find-file-check-make-large-file-read-only-hook ()
  "If a file is over a given size, make the buffer read only."
  (when (> (buffer-size) (* 1024 1024))
    (setq buffer-read-only t)
    (buffer-disable-undo)
    (fundamental-mode)
	(linum-mode -1) 
	(font-lock-mode -1)
	
	"(set (make-variable-buffer-local 'global-hl-line-mode) nil)
  (set (make-variable-buffer-local 'line-number-mode) nil)
  (set (make-variable-buffer-local 'column-number-mode) nil) )
  "
	
	))

(add-hook 'find-file-hook 'my-find-file-check-make-large-file-read-only-hook)




(defun json-format ()
(interactive)
(save-excursion
(shell-command "python "  (buffer-name) t)
)
)
