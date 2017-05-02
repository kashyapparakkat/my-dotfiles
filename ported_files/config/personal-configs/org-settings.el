;; http://ergoemacs.org/emacs/emacs_org_babel_literate_programing.html


(setq org-agenda-files (list (format "C:/Users/%s/Downloads/todo.org" user-login-name)                            
                        (format "C:/Users/%s/Downloads/todo.txt" user-login-name)                           
                             "~/.emacs.d/my-files/org/work.org"))
							 
							 ;; set maximum indentation for description lists
(setq org-list-description-max-indent 5)


(with-eval-after-load 'org
;; prevent demoting heading also shifting text inside sections
(setq org-adapt-indentation nil)
(setq org-startup-idented t)

	(define-key org-mode-map (kbd "M-r") 'org-toggle-heading)
(define-key org-mode-map (kbd "M-e") 'other-window) ;; bring back this key
	(define-key org-mode-map [C-return] 'cibin/org-insert-heading-respect-content)
	(evil-define-key 'normal org-mode-map [C-return] 'cibin/org-insert-heading-respect-content)
) 
(use-package org-bullets
  :init
  (setq org-bullets-bullet-list '("●" "•" "▪" "►" "♦" "■" "○" ))
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
)

(defun cibin/org-insert-heading-respect-content()
  (interactive)
 (org-insert-heading-respect-content nil)
 (evil-insert-state)
  )

(global-set-key (kbd "C-c o") 
                (lambda () (interactive) (find-file "~/organizer.org")))
				
	   ; The pipe is optional, but if it is present, the task states following it will all be considered by Org to mean “complete
				(setq org-todo-keywords
      '((sequence "TODO" "INFO" "IN-PROGRESS" "WAITING" "|" "DONE" "LATER")))
	  
	  
; TODO evil-org.el
;; normal state shortcuts
(evil-define-key 'normal org-mode-map
  "gh" 'outline-up-heading
  "gj" (if (fboundp 'org-forward-same-level) ;to be backward compatible with older org version
	   'org-forward-same-level  'org-forward-heading-same-level)
  "gk" (if (fboundp 'org-backward-same-level)
	   'org-backward-same-level 'org-backward-heading-same-level)

  "go" 'outline-previous-heading
  "gl" 'outline-next-visible-heading
  "t" 'org-todo
  "T" '(lambda () (interactive) (evil-org-eol-call (lambda() (org-insert-todo-heading nil))))
  "H" 'org-shiftleft
  ; "J" 'org-shiftdown
  "J" 'outline-next-visible-heading
  ; "K" 'org-shiftup
  "K" 'outline-previous-visible-heading
  "L" 'org-shiftright
  ;; "o" '(lambda () (interactive) (evil-org-eol-call 'clever-insert-item))
  "O" '(lambda () (interactive) (evil-org-eol-call 'org-insert-heading))
  "$" 'org-end-of-line
  "^" 'org-beginning-of-line
  "<" 'org-metaleft
  ">" 'org-metaright
  "-" 'org-cycle-list-bullet
  (kbd "<tab>") 'org-cycle)
	  
(global-set-key (kbd "<f2>") (lambda () (interactive)  (my/org-toggle-heading-and-todo "DONE")))
(global-set-key (kbd "<S-f2>") (lambda () (interactive)  (my/org-toggle-heading-and-todo "TODO")))

(defun my/org-toggle-heading-and-todo (arg)
  "Toggles the current line between a non-heading and TODO heading."
  (interactive)

(let ((is-heading))
    (save-excursion
      (forward-line 0)
      (when (looking-at "^\\*") 
        (setq is-heading t)))
    (if is-heading 
        (progn
          (org-todo 'none) ; remove TODO
          (org-toggle-heading) ; remove heading
        (forward-line))
      (progn
        (org-toggle-heading) ; convert to heading
        (org-todo arg) ; add TODO
(org-metaleft)
        (forward-line)
        ; (forward-line)
       ; (next-line)
       )
        )))
        ; (org-todo 'nextset)))) ; add TODO

;; Minimal outline
;; If you have read how headlines are written in org, you can notice that it is by the number of “*” before it. To make it look better, let’s indent every heading and remove all the “*” but the last one.

(setq org-startup-indented t
      org-hide-leading-stars t)
;; Images
;; The GUI Emacs has the ability to display images. But if the image is pretty large, it displays the whole thing. Let’s restrict it from doing that.

(setq org-image-actual-width '(300))

;; make org mode allow eval of some langs
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (clojure . t)
 (C . t)
 (css . t)
 (sh . t)
 (awk . t)
 (R . t)
 (shell . t)
 (http . t)
   (python . t)
 (restclient . t)
   (ruby . t)))

;; stop emacs asking for confirmation
(setq org-confirm-babel-evaluate nil)
(setq org-src-fontify-natively t)


;; org-babel result to a separate buffer
;; There is a way to open org-babel outpupt in a separate buffer with C-o - org-open-at-point is fancy like that. The problem is, the result block is created. But there is also a command org-babel-remove-result. Combining the two, I made a little dirty hack
;; https://emacs.stackexchange.com/questions/23870/org-babel-result-to-a-separate-buffer
(defun my-babel-to-buffer ()
  "A function to efficiently feed babel code block result to a separate buffer"
  (interactive)
  (org-open-at-point)
  (org-babel-remove-result)
)

(defun my-org-mode-config ()
  "To use with `org-mode-hook'"
  (local-set-key (kbd "C-`") 'my-babel-to-buffer)
)

(add-hook 'org-mode-hook 'my-org-mode-config)
