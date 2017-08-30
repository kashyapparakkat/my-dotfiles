
(message "loading cbn-helm-config")
(with-eval-after-load 'helm
(setq
        ;; move to end or beginning of source when reaching top or bottom
        ;; of source
helm-move-to-line-cycle-in-source t
)
;; (define-key helm-map (kbd "C-h") 'delete-backward-char)

(define-key helm-map (kbd "<left>") 'backward-char)
(define-key helm-map (kbd "<right>") 'forward-char)



;; (define-key helm-map (kbd "<right>") 'forward-char)
;; (define-key global-map (kbd "M-y") 'helm-show-kill-ring)
;; (define-key helm-map (kbd "C-o") 'helm-recentf)
;; (define-key helm-map (kbd "C-o") 'helm-resume-select-buffer)
;; (define-key helm-map (kbd "C-o") 'helm-resume-list-buffers-after-quit)
;; (define-key global-map [remap find-file] 'helm-find-files)
;; (defvar hf-helm-resume-next-key (kbd "C-o"))
;; (defvar hf-helm-resume-prev-key (kbd "C-i"))

(define-key helm-map (kbd "C-l") 'try-next-function)
;; (define-key helm-map (kbd "C-k") 'set-pattern)
)

;; (helm-run-after-exit FUNCTION &rest ARGS)
;; helm-run-after-exit exits current helm session, and then runs FUNCTION, so this is what you want:


(defun es/helm-mini-or-projectile-find-file ()
  (interactive)
  (if (helm-alive-p)
      (helm-run-after-exit #'helm-for-files)
    (helm-mini)))
;; To call this command from a helm session, you need to bind a key to it since you can't use helm-M-x, e.g.,

(bind-key "C-c C-p" #'es/helm-mini-or-projectile-find-file)


(defun cbn-helm-next()
  (interactive)
  (message "%s" helm-pattern)
  (helm-run-after-exit #'helm-for-files)
  )

;(define-key helm-map (kbd "C-o") 'cbn-helm-next)

;; (helm-find-files "c:/Users")
;; (helm-find-files-l "c:/Users")
;; helm-set-pattern
;; helm-pattern

(defun cibin/helm-find-files()
  ;; (set-pattern)
  ;; (helm-find-files-1)
  (helm-find-files-1 saved-helm-input)
)
(defun cibin/find-related-files-helm-saved-input()
  ;; (set-pattern)
  ;; (helm-find-files-1)
  ;; (helm-find-files-1 saved-helm-input)
  (cibin-find-related-files saved-helm-input)
)

(setq all-func '(dummy cibin/find-related-files-helm-saved-input cibin/helm-find-files ) )
(setq saved-helm-input "")

(defun try-next-function()
  (interactive)
(fset 'this-func (car all-func))
;; (helm-run-after-exit (this-func))
;; (this-func)
;; (helm-run-after-exit (car all-func))

;; (helm-find-files)
;; (helm-run-after-exit (car all-func))
;; (exit-minibuffer)
;; (funcall (intern "my-func-name"))
;; (setq msg helm-pattern)
;; (setq msg helm-input)

;; (setq saved-helm-input helm-pattern)
(setq saved-helm-input helm-input)
;; (setq msg3 helm-input-local)
;; (message "%s" helm-pattern)
;; (message "%s" helm-input)
;; (message "%s" helm-input)
;; (message "%s" msg)
;; (message "%s" msg2)
;; (message "%s" msg3)
;; (helm-kill-async-processes)
;; (defvar my-function (car all-func))
;; (funcall my-function)
(setq all-func (cdr all-func))
(message (format "trying.. %s %s"  msg (car all-func)))
(helm-run-after-exit (car all-func))
;; (helm-run-after-exit (helm-find-files "C:/"))

;; (helm-run-after-exit (this-func))
;; (helm-run-after-exit (intern (format "%s" (car all-func))))
;; (helm-exit-and-execute-action
   ;; (lambda (_candidate)
     ;; (apply (car all-func) )))
 ;; (this-func)
;; (helm-exit-minibuffer)
(message (format "all: %s" all-func))
)

(defun set-pattern()
  ;; (setq mssg helm-input)
  (helm-set-pattern saved-helm-input 'update)
)


























(provide 'cbn-helm-config)
