


(advice-add 'helm-ff-filter-candidate-one-by-one
        :around (lambda (fcn file)
                  (unless (string-match "\\(?:/\\|\\`\\)\\.\\{1,2\\}\\'" file)
                    (funcall fcn file))))
; http://stackoverflow.com/questions/19907939/how-can-one-quickly-browse-through-lots-of-files-in-emacs


;; little modification to dired-mode that let's you browse through lots of files
(add-hook 'dired-mode-hook
  (lambda()
    (define-key dired-mode-map (kbd "C-o") 'dired-view-current)     ; was dired-display-file
    (define-key dired-mode-map (kbd "n")   'dired-view-next)           ; was dired-next-line
    (define-key dired-mode-map (kbd "p")   'dired-view-previous))) ; was dired-previous-line

(defun dired-view-next ()
  "Move down one line and view the current file in another window."
  (interactive)
  (dired-next-line)
  (dired-display-file)
  ;; (dired-view-current)
  )

(defun dired-view-previous ()
  "Move up one line and view the current file in another window."
  (interactive)
  (dired-previous-line)
  (dired-view-current))

(defun dired-view-current ()
  "View the current file in another window (possibly newly created)."
  (interactive)
  (if (not (window-parent))
      (split-window))                                   ; create a new window if necessary
  (let ((file (dired-get-file-for-visit))
        (dbuffer (current-buffer)))
    (other-window 1)                                          ; switch to the other window
    (unless (equal dbuffer (current-buffer))                 ; don't kill the dired buffer
      (if (or view-mode (equal major-mode 'dired-mode))   ; only if in view- or dired-mode
          (kill-buffer)))                                                    ; ... kill it
    (let ((filebuffer (get-file-buffer file)))
      (if filebuffer                              ; does a buffer already look at the file
          (switch-to-buffer filebuffer)                                    ; simply switch 
        (view-file file))                                                    ; ... view it
      (other-window -1))))                   ; give the attention back to the dired buffer




(defun my-dired-view-file ()
  (interactive)
  (dired-view-file)
  (local-set-key (kbd "<f5>") 'View-quit))

(define-key dired-mode-map (kbd "<f5>") 'my-dired-view-file)




;; http://jaderholm.com/blog/programothesis-16-emacs-dired-view-file-nextprevious
;; View-mode (v in Dired) is nice for reading files. It allows you to press SPC to scroll through the file. By default you have to press q C-n v to go to the next file. This adds n and p bindings to view-mode to navigate between files without going back to Dired buffer.

(defun dired-view-file ()
  "In Dired, examine a file in view mode, returning to Dired when done.
When file is a directory, show it in this buffer if it is inserted.
Otherwise, display it in another buffer."
  (interactive)
  (local-set-key (kbd "n") 'dired-view-file-next)

  (let ((file (dired-get-file-for-visit)))
    (if (file-directory-p file)
        (or (and (cdr dired-subdir-alist)
                 (dired-goto-subdir file))
            (dired file))
      (view-file-other-window file))))

(defun dired-view-file-next (&optional reverse)
  (interactive)
  (View-quit)
  (if reverse (previous-line)
    (next-line))
  (dired-view-file))

(defun dired-view-file-previous ()
  (interactive)
  (dired-view-file-next 1))

(add-hook 'view-mode-hook
          (lambda ()
(define-key 'evil-normal-state-map "n" nil)
(evil-define-key 'normal dired-mode-map "n" nil)
(evil-define-key 'normal dired-mode-map "n" nil)
(define-key evil-motion-state-map "n" nil)
(define-key evil-motion-state-map "n" 'dired-view-file-next)
            (define-key view-mode-map (kbd "n") 'dired-view-file-next)
            (define-key view-mode-map (kbd "p") 'dired-view-file-previous)

(evil-define-key 'normal dired-mode-map "n" 'dired-view-file-next)
(evil-define-key 'normal view-mode-map "n" 'dired-view-file-next)
            (message "sdfasd")
            )
          )
; quick-preview

; Not dired-specific per-se, but quick-preview is great for files that Emacs might not be able to open, but your regular X11 (or OSX's quick preview) can show well, like moves are things. Works great when you're in a dired buffer to preview a file.

; I like to bind it globally to C-c q and in dired to Q

(use-package quick-preview
  :ensure t
  :init
  (global-set-key (kbd "C-c q") 'quick-preview-at-point)
  ;; TODO remove Q
  (define-key dired-mode-map (kbd "Q") 'quick-preview-at-point))
