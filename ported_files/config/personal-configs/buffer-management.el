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

;; in helm-mini, to enable fuzzy matching, add the following settings: 
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)

(defun kill-buffers-from-same-folder-recursively()
                                        ; http://stackoverflow.com/questions/32822036/how-to-kill-all-buffers-with-buffer-file-in-a-certain-location

  (interactive)
(setq this (file-name-directory buffer-file-name))
(mapc (lambda (buffer)
(setq file-name (buffer-file-name buffer))
                                        ; todo to handle dired
                                        ; (let ((file-name
               ;(or (buffer-file-name buffer)
                   ;; In dired-mode we need `dired-directory' which
                   ;; might be a list and may not be fully expanded.
                ;   (with-current-buffer buffer
                 ;    (and (eq major-mode 'dired-mode)
                  ;        (expand-file-name
                   ;        (if (consp dired-directory)
                    ;           (car dired-directory)
                     ;        dired-directory)))))
                 ;    ))

          (when (and file-name
           (string-prefix-p (file-name-directory (buffer-file-name buffer)) file-name t))
            ; todo kill buffer ; (kill-this-buffer-if-not-modified)
            ;(kill-buffer buffer)
            (kill-buffer-if-not-modified buffer)
            ) 
            )      (buffer-list))
      )


(defun cibin/helm-find-files ()
  (interactive)
  (helm :sources '(
 helm-source-findutils
 helm-source-files-in-current-dir
                   helm-source-buffers-list
                   helm-source-recentf
                   helm-source-buffers-list
                   helm-source-locate

 ;; helm-source-buffer-not-found
                   ;helm-source-google-suggest
    helm-source-bookmarks
    helm-source-file-cache
                   )
        :buffer "*helm all the things*")
        )

(setq helm-mini-default-sources '(helm-source-buffers-list
 helm-source-files-in-current-dir
                                  helm-source-recentf
                                  helm-source-bookmarks
                                  helm-source-buffer-not-found))
;; helm-for-files
;; http://pragmaticemacs.com/emacs/find-and-open-files-from-anywhere-with-helm-for-files/
;; limit max number of matches displayed for speed
    (setq helm-candidate-number-limit 100)
    ;; ignore boring files like .o and .a
    (setq helm-ff-skip-boring-files t)

;; Update: On helm version >=2.4.0 this is now the default.
;; (setq helm-locate-command "locate %s -e -A --regex %s")

;; replace locate with spotlight on Mac
    ;; (setq helm-locate-command "mdfind -name %s %s"))
    ;; (setq helm-locate-command "locate-with-mdfind %.0s %s")

;; http://amitp.blogspot.in/2012/10/emacs-helm-for-finding-files.html
(setq helm-idle-delay 0.1)
(setq helm-input-idle-delay 0.1)
(loop for ext in '("\\.swf$" "\\.elc$" "\\.pyc$")
      do (add-to-list 'helm-boring-file-regexp-list ext))

                                        ; or only in evil’s normal state:
;todo helm-buffers-list or helm-mini

;; (define-key evil-normal-state-map (kbd "b") 'helm-buffers-list)
(global-set-key (kbd "C-x b") 'helm-mini)
(define-key evil-normal-state-map (kbd "b") 'helm-mini)
 


;; File finding
; https://github.com/emacs-helm/helm/blob/master/helm-files.el


;;; helm-for-files > helm-multi-files > helm-find-files
(global-set-key (kbd "C-x C-f") 'cibin/helm-find-files)
(global-set-key (kbd "M-o") 'cibin/helm-find-files)

