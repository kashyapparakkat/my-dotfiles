(message "loading cbn-helm-config")
;load master first
;; (require 'helm-ag)
(with-eval-after-load  'helm-ag
  (require 'helm-do-ag-fork-modified)
  )
;helm-mini is better than helm-buffers-list
 ;; (define-key evil-normal-state-map (kbd "b") 'helm-buffers-list)
(global-set-key (kbd "C-x b") 'cibin/helm-mini)
(define-key evil-normal-state-map (kbd "b") 'cibin/helm-mini)
(evil-define-key 'normal dired-mode-map (kbd "b") 'cibin/helm-mini)

(defun cibin/helm-mini()
(interactive)
(setq all-func '(dummy cibin/find-related-files-helm-saved-input cibin/helm-find-files ) )
(helm-mini))

(defun cibin/helm-do-ag-Extension-here-cwd-switchable()
  (interactive)
  (setq all-func '(dummy cibin/helm-do-ag-Extension-recurse-cwd-with-saved-input ) )
(cibin/helm-do-ag-Extension-recurse-cwd nil)
)

(with-eval-after-load 'helm
(setq
        ;; move to end or beginning of source when reaching top or bottom
        ;; of source
helm-move-to-line-cycle-in-source nil
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

(with-eval-after-load 'helm-ag
;; TODO 
;; (define-key helm-ag-map (kbd "C-l") 'helm-ag--up-one-level)
    (define-key helm-ag-map (kbd "C-l") 'try-next-function)
)
(defun bind-ido-keys()

(define-key ido-common-completion-map (kbd "C-l") 'try-next-function)
(define-key ido-completion-map (kbd "C-l") 'try-next-function)
(define-key ido-file-completion-map (kbd "C-l") 'try-next-function)
(define-key ido-buffer-completion-map (kbd "C-l") 'try-next-function)
;; (define-key ido-mode-map  "\C-l" 'try-next-function)
(define-key minibuffer-local-completion-map  "\C-l" 'try-next-function)
(define-key  ivy-minibuffer-map "\C-l" 'try-next-function)
(define-key ivy-minibuffer-map (kbd "C-l") 'try-next-function)

)
(add-hook 'ido-setup-completion-map #'bind-ido-keys)
(add-hook 'ido-setup-hook #'bind-ido-keys)
(add-hook 'ido-define-mode-map-hook #'bind-ido-keys)
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
  ;; (helm-find-files-1 saved-helm-input)
  ;; (helm-find-files-1 ido-text)
  (helm-find-files-1 ivy--old-text)
  )

(defun cibin/helm-do-ag-Extension-here-cwd-with-saved-input()
  (cibin/helm-do-ag-Extension-here-cwd saved-helm-input)
)

;; (defun cibin/find-related-files-helm-saved-input()
(defun cibin/helm-do-ag-Extension-recurse-cwd-with-saved-input()
(cibin/helm-do-ag-Extension-here-cwd saved-helm-input)
  )

(defun cibin/find-related-files-helm-saved-input()
  ;; (set-pattern)
  ;; (helm-find-files-1)
  ;; (helm-find-files-1 saved-helm-input)
  (cibin-find-related-files saved-helm-input)
)

(setq saved-helm-input "")

(defun try-next-function()
  (interactive)
(message "hii")
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
(fset 'this-func (car all-func))
(message (format "trying.. %s %s"  saved-helm-input (car all-func)))
(if (helm-alive-p)
    (helm-run-after-exit (car all-func))
  (progn
(message "ivy is quit")
    ;; (ivy-immediate-done)
;; (keyboard-escape-quit)
;; (minibuffer-keyboard-quit)
(message "ivy is quit2")
; (message this-func)
(this-func)
;; (ivy-quit-and-run this-func)
))
;; (helm-run-after-exit (helm-find-files "C:/"))

;; (helm-run-after-exit (this-func))
;; (helm-run-after-exit (intern (format "%s" (car all-func))))
;; (helm-exit-and-execute-action
   ;; (lambda (_candidate)
     ;; (apply (car all-func) )))
 ;; (this-func)
(helm-exit-minibuffer)
(message (format "all: %s" all-func))
)

(defun set-pattern()
  ;; (setq mssg helm-input)
  (helm-set-pattern saved-helm-input 'update)
)


























(provide 'cbn-helm-config)
