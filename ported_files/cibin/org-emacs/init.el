; move to diff file
;;https://stackoverflow.com/a/17149070


(require 'package)
; (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
; (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
; (add-to-list 'package-archives '("org"         . "http://orgmode.org/elpa/") t)
; (add-to-list 'package-archives '("gnu"         . "http://elpa.gnu.org/packages/") t)

 (setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
							 
							 
							 (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t) ; Org-mode's repository
							 
(setq user-emacs-directory "~/org-emacs/")
							  ; (setq load-path '("~/org-emacs"))
; (let* ((user-init-dir-default
    ; (file-name-as-directory (concat "~" init-file-user "/org-emacs")))
       ; (user-init-dir
    ; (file-name-as-directory (or (getenv "EMACS_USER_DIRECTORY")
                    ; user-init-dir-default)))
       ; (user-init-file-1
    ; (expand-file-name "init" user-init-dir))))
  ; (setq user-emacs-directory user-init-dir)
  ; (message "user-emacs-directory" )
  ; (message user-emacs-directory )
  
  
  ;; reuse existing package-user-dir
  (setq package-user-dir "~/../.emacs.d/elpa")
(package-initialize)
(evil-mode 1)  ;; enable evil-mode
(which-key-mode 1)


(load-file "~/../.emacs.d/my-files/config/personal-configs/basic-settings.el")
(load-file "~/../.emacs.d/my-files/config/personal-configs/starter-kit-bindings.el")
(load-file "~/../.emacs.d/my-files/config/personal-configs/org-settings.el")

;; todo cbn-navigation contains unnecessary advanced fun; move it to diff file
(load-file "~/../.emacs.d/my-files/config/personal-configs/cbn-navigation.el")

(set gc-cons-threshold 200000000)
