;; Ensure ibuffer opens with point at the current buffer's entry.
(defadvice ibuffer
  (around ibuffer-point-to-most-recent) ()
  "Open ibuffer with cursor pointed to most recent buffer name."
  (let ((recent-buffer-name (buffer-name)))
    ad-do-it
    (ibuffer-jump-to-buffer recent-buffer-name)))
(ad-activate 'ibuffer)


(defun kill-all-other-buffers-if-not-modified ()
  "Kill all other buffers."
  (interactive)
    (setq buffers-to-kill (delq (current-buffer) (buffer-list)))
  (mapc 'kill-buffer-if-not-modified buffers-to-kill))
  
(defun kill-this-buffer-if-not-modified ()
  (interactive)
  ; taken from menu-bar.el
  (if (menu-bar-non-minibuffer-window-p)
      (kill-buffer-if-not-modified (current-buffer))
    (abort-recursive-edit)))


;; TODO make this run not just for current buffer
;; http://amitp.blogspot.in/2007/03/emacs-dont-kill-unsaved-buffers.html
(defun ask-before-killing-buffer-if-running-or-modified ()
  (let ((buffer (current-buffer)))
    (cond
     ((equal (buffer-name) "*scratch*")
      ;; Never kill *scratch*
      nil)
     ((and buffer-file-name (buffer-modified-p))
      ;; If there's a file associated with the buffer, 
      ;; make sure it's saved
      (y-or-n-p (format "Buffer %s modified; kill anyway? " 
                    (buffer-name))))
     ((get-buffer-process buffer)
      ;; If there's a process associated with the buffer, 
      ;; make sure it's dead
      (y-or-n-p (format "Process %s active; kill anyway? "
                    (process-name (get-buffer-process buffer)))))
     (t t))))
;; (add-to-list 'kill-buffer-query-functions 'ask-before-killing-buffer)





;; (message "%s" 
     ;; (delete (current-buffer) (seq-filter #'buffer-file-name (buffer-list))))

(defun cibin-next-modified-buffer ()
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (< i 20)
      (if (not (and buffer-file-name (buffer-modified-p)))
          (progn (next-buffer)
                 (setq i (1+ i)))
        (progn (setq i 100))))))

(defun cibin-previous-modified-buffer ()
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (< i 20)
      (if (not (and buffer-file-name (buffer-modified-p)))
          (progn (previous-buffer)
                 (setq i (1+ i)))
        (progn (setq i 100))))))
(global-set-key (kbd "<f11>") 'cibin-next-modified-buffer)
(global-set-key (kbd "S-<f11>") 'cibin-previous-modified-buffer)


