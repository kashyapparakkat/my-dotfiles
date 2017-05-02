(defun my-move-end-of-line-before-whitespace ()
  "Move to the last non-whitespace character in the current line.
  http://stackoverflow.com/questions/9597391/emacs-move-point-to-last-non-whitespace-character "
  
  (move-end-of-line nil)
  (re-search-backward "^\\|[^[:space:]]")
  (forward-char)
  )
  
  (defun my-move-end-of-line-before-punctuation ()
 (interactive)
  (move-end-of-line nil)
  (re-search-backward "^\\|[\"\)#]")
                                        ; # asdsadf
  ; hellow")

(backward-char)
  ;; (forward-char)
  )
;; (define-key evil-normal-state-map (kbd "C-f") 'my-move-end-of-line-before-comment)
  
  (defun my-move-end-of-line-before-comment()
 (interactive)
  (move-end-of-line nil)
  (re-search-backward "^\\|[#]")
                                        ; # asdsadf
  ; hellow")

(backward-char)
  ;; (forward-char)
  )
;; (define-key evil-normal-state-map (kbd "C-f") 'my-move-end-of-line-before-punctuation )
  
  
(defun smart-end-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.

Move point to the last non-whitespace character on this line.
If point was already at that position, move point to end of line."
  (interactive)
  (let ((oldpos (point)))
(my-move-end-of-line-before-whitespace)
;; (my-move-end-of-line-before-punctuation)
    (and (= oldpos (point))
         (end-of-line)
		 )))  




; (global-set-key (kbd "C-e") 'evil-end-of-line)
; (define-key evil-normal-state-map (kbd "C-e") 'evil-end-of-line)
; (define-key evil-normal-state-map (kbd "C-a") 'smart-line-beginning)

(global-set-key (kbd "C-e") 'smart-end-of-line)
(global-set-key (kbd "<end>") 'smart-end-of-line)
(define-key evil-normal-state-map (kbd "C-e") 'smart-end-of-line)
(define-key evil-normal-state-map (kbd "ge") 'smart-end-of-line)

(define-key evil-normal-state-map (kbd "C-a") 'x4-smarter-beginning-of-line)
(define-key evil-normal-state-map (kbd "gh") 'x4-smarter-beginning-of-line)
(global-set-key (kbd "C-a") 'x4-smarter-beginning-of-line)
(global-set-key [home] 'x4-smarter-beginning-of-line)

; (global-set-key (kbd "C-a") 'smart-line-beginning)
; (global-set-key [home] 'smart-line-beginning)

(global-set-key (kbd "C-x 2") 'window-toggle-split-direction)

; TODO		 
; (global-set-key (kbd "C-<home>") 'x4-smarter-beginning-of-line)
; (global-set-key (kbd "S-<home>") 'x4-smarter-beginning-of-line)

(global-set-key [(control \8)] 'fc/kill-to-beginning-of-line)
(global-set-key [(control x) (\8)] 'fc/kill-to-beginning-of-line)
;; (global-set-key [(meta \8)] 'kill-line)

(global-set-key (kbd "C-9") 'kill-line)

(global-set-key (kbd "M-8") 'kill-whole-line)

(global-set-key (kbd "M-,") 'beginning-of-buffer)
(global-set-key (kbd "M-.") 'end-of-buffer)
(define-key evil-normal-state-map (kbd "M-,") 'beginning-of-buffer)
(define-key evil-normal-state-map (kbd "M-.") 'end-of-buffer)

 ; TODO explore elisp-slime-nav
(global-set-key (kbd "M->") 'elisp-slime-nav-find-elisp-thing-at-point)

; TODO make these into something more useful
; (global-set-key (kbd "M-<") 'beginning-of-buffer)


		 
		 ;; Smart beginning of the line
(defun x4-smarter-beginning-of-line ()
"""Move point to beginning-of-line or first non-whitespace character or first non-whitespace after a comment sign.
https://gist.github.com/X4lldux/5649195 
"""
"(interactive ""^"")"
(interactive)
(let (
(oldpos (point))
(indentpos (progn
(back-to-indentation)
(point)
)
)
(textpos (progn
(beginning-of-line-text)
(point)
)
)
)
(cond
((> oldpos textpos) (beginning-of-line-text))
((and (<= oldpos textpos) (> oldpos indentpos)) (back-to-indentation))
((and (<= oldpos indentpos) (> oldpos (line-beginning-position))) (beginning-of-line))
(t (beginning-of-line-text))
)
)
)

(defun window-toggle-split-direction ()
  "Switch window split from horizontally to vertically, or vice versa.

i.e. change right window to bottom, or change bottom window to right."
; https://www.emacswiki.org/emacs/ToggleWindowSplit
  (interactive)
  (require 'windmove)
  (let ((done))
    (dolist (dirs '((right . down) (down . right)))
      (unless done
        (let* ((win (selected-window))
               (nextdir (car dirs))
               (neighbour-dir (cdr dirs))
               (next-win (windmove-find-other-window nextdir win))
               (neighbour1 (windmove-find-other-window neighbour-dir win))
               (neighbour2 (if next-win (with-selected-window next-win
                                          (windmove-find-other-window neighbour-dir next-win)))))
          ;;(message "win: %s\nnext-win: %s\nneighbour1: %s\nneighbour2:%s" win next-win neighbour1 neighbour2)
          (setq done (and (eq neighbour1 neighbour2)
                          (not (eq (minibuffer-window) next-win))))
          (if done
              (let* ((other-buf (window-buffer next-win)))
                (delete-window next-win)
                (if (eq nextdir 'right)
                    (split-window-vertically)
                  (split-window-horizontally))
                (set-window-buffer (windmove-find-other-window neighbour-dir) other-buf))))))))
				




(defun cibin/goto-func-definition()
(interactive)
  (if (equal major-mode 'python-mode)
(elpy-goto-definition)
(message "searching definition")
(dumb-jump-go)
))



; TODO diff-mode-map debugger-mode-map message-buffer-mode-map fundamental-mode-map 

; (dolist (m (list  help-mode-map evil-normal-state-map spacemacs-buffer-mode-map)
  ; (bind-keys :map m
             ;;;;;;; :prefix-map f14-prefix-map
             ;;;;;;; :prefix "<f14>"
             ; ("l" . forward-char)
             ; ("h" . backward-char)
             ; ("j" . next-line)
             ; ("k" . previous-line)
             ; )))
			 
  (defun move-line-to-ends (n)
  "Move the current line up or down by N lines."
  ;; modified from https://www.emacswiki.org/emacs/MoveLine
  ;; (interactive "p")

  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line)
  (forward-char)
  (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    ; (forward-line n)
      (if (eq -1 n)
(beginning-of-buffer)
      (progn (end-of-buffer)(open-line 1)(next-line 1)))
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
(forward-char col)
))

(defun move-line-to-top (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line-to-ends (if (null n) -1 (- n))))

(defun move-line-to-bottom (n)
  "Move the current line down by N lines."
  (interactive "p")
(move-line-to-ends (if (null n) 1 n)))

(global-set-key (kbd "M-P") 'move-line-to-top)

(global-set-key (kbd "M-N") 'move-line-to-bottom)

;;TODO see if this works
;;ensure that M-v always undoes C-v, so you can go back exactly.
(setq scroll-preserve-screen-position 'always)

(define-key evil-normal-state-map   (kbd "f") 'avy-goto-char-timer)

(define-key evil-normal-state-map   (kbd "J") 'xah-forward-block)
(define-key evil-visual-state-map   (kbd "J") 'xah-forward-block)
(define-key evil-normal-state-map   (kbd "K") 'xah-backward-block)
(define-key evil-visual-state-map   (kbd "K") 'xah-backward-block)

;;Make the cursor stop at the last character of a line instead of the newline character
(setq evil-move-cursor-back t)
