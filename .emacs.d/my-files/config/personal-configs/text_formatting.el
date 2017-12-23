(message "loading text_formatting")

(defun toggle-camel-case ()
  "Toggles the symbol at point between underscore style and camel case,
   e.g. hello_world_string and HelloWorldString.

  From https://www.bunkus.org/blog/2009/12/switching-identifier-naming-style-between-camel-case-and-c-style-in-emacs/"
  (interactive)
  (let* ((symbol-pos (bounds-of-thing-at-point 'symbol))
         case-fold-search symbol-at-point cstyle regexp func)
    (unless symbol-pos
      (error "No symbol at point"))
    (save-excursion
      (narrow-to-region (car symbol-pos) (cdr symbol-pos))
      (setq cstyle (string-match-p "_" (buffer-string))
            regexp (if cstyle "\\(?:\\_<\\|_\\)\\(\\w\\)" "\\([A-Z]\\)")
            func (if cstyle
                     'capitalize
                   (lambda (s)
                     (concat (if (= (match-beginning 1)
                                    (car symbol-pos))
                                 ""
                               "_")
                             (downcase s)))))
      (goto-char (+ (point-min) 1))
      (while (re-search-forward regexp nil t)
        (replace-match (funcall func (match-string 1))
                       t nil))
      (widen))))


(cibin/global-set-key '("M-C" . toggle-camel-case))
(cibin/global-set-key '("C-M-c" . xah-cycle-hyphen-underscore-space))

(defun align-to-colon (begin end)
  "Align region to colon (:) signs"
  (interactive "r")
  (align-regexp begin end
                (rx (group (zero-or-more (syntax whitespace))) ":") 1 1 ))

(defun align-to-comma (begin end)
  "Align region to comma  signs"
  (interactive "r")
  (align-regexp begin end
                (rx "," (group (zero-or-more (syntax whitespace))) ) 1 1 ))


(defun align-to-equals (begin end)
  "Align region to equal signs"
  (interactive "r")
  (align-regexp begin end
                (rx (group (zero-or-more (syntax whitespace))) "=") 1 1 ))

(defun align-to-hash (begin end)
  "Align region to hash ( => ) signs"
  (interactive "r")
  (align-regexp begin end
                (rx (group (zero-or-more (syntax whitespace))) "=>") 1 1 ))

;; work with this
(defun align-to-comma-before (begin end)
  "Align region to equal signs"
  (interactive "r")
  (align-regexp begin end
                (rx (group (zero-or-more (syntax whitespace))) ",") 1 1 ))

(defun cibin/align-repeat-prompt (start end)
;; http://pragmaticemacs.com/emacs/aligning-text/
  ;; https://stackoverflow.com/questions/20119064/align-to-columns-in-emacs
  (interactive "r")
  (setq string (read-string "enter regexp : " ))
  (align-regexp start end
                (format "\\(\\s-*\\)%s" string) 1 0 t))

(defun bjm/align-repeat-whitespace (start end)
  "Align columns by whitespace"
  (interactive "r")
  (align-regexp start end
                "\\(\\s-*\\)\\s-" 1 0 t))

(defun bjm/align-& (start end)
  "Align columns by ampersand"
  (interactive "r")
  (align-regexp ;; "\\(\\s-*\\):" 1 1 t))
                "\\(\\s-*\\)&" 1 1 t))

(spacemacs/set-leader-keys "x a s" 'bjm/align-repeat-whitespace)
(spacemacs/set-leader-keys "x a p" 'cibin/align-repeat-prompt)
