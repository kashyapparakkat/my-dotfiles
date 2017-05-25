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



(defun diff-files-lines ()
(interactive)
(setq cmd-string (format "comm -2 -3 <(sort %s) <(sort  %s)" (return-filepath) (buffer-file-name-other)))
(message "%s" cmd-string)
(save-excursion
(shell-command  cmd-string "*diff_shell_output*")
;; (switch-to-buffer "*diff_shell_output*")
;; (vdiff-3way-layout-function-default buffer-a buffer-b "*diff_shell_output*")
(set-window-buffer (split-window-horizontally) "*diff_shell_output*")
)

(defun vdiff-3way-layout-function-default (buffer-a buffer-b buffer-c)
  "https://github.com/justbur/emacs-vdiff/blob/4a6f27b83ef0240c56587354277ba685d9834bc9/vdiff.el"

  (delete-other-windows)
  (switch-to-buffer buffer-a)
  (set-window-buffer (split-window-vertically) buffer-c)
  (set-window-buffer (split-window-horizontally) buffer-b))
)
