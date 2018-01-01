(message "loading seamless-integration")
(defun open-ranger()
(interactive)
(shell-command (format "open-tmux-ranger %s" (buffer-file-name)))
)

(defun open-bash()
(interactive)
(shell-command (format "open-tmux-bash %s" (file-name-directory (buffer-file-name))))
)

(defun open-in-vim()
(interactive)
(shell-command (format "open-tmux-vim %s" (buffer-file-name)))
)

(defun open-in-tig()
(interactive)
(shell-command (format "open-tmux-tig %s" (buffer-file-name)))
)

(provide 'seamless-integration)
