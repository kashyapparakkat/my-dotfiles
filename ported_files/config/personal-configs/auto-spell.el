;; https://www.emacswiki.org/emacs/FlySpell


;; TODO hk:: autocorrect previous word(if flyspell mode is not on, turn it on)


 ;;; https://www.emacswiki.org/emacs/AspellWindows
 (add-to-list 'exec-path "C:/Program Files (x86)/Aspell/bin/")
;We need tell emacs to use aspell, and where your custom dictionary is.

    (setq ispell-program-name "aspell")
    (setq ispell-personal-dictionary "C:/path/to/your/.ispell")
;Then, we need to turn it on.

    (require 'ispell)

;; If you’d like to use Flyspell’s menu selection in the terminal, or just prefer to use popup.el over the graphical menu, stick this somewhere in your load path:


  (defun flyspell-emacs-popup-textual (event poss word)
      "A textual flyspell popup menu."
      (require 'popup)
      (let* ((corrects (if flyspell-sort-corrections
                           (sort (car (cdr (cdr poss))) 'string<)
                         (car (cdr (cdr poss)))))
             (cor-menu (if (consp corrects)
                           (mapcar (lambda (correct)
                                     (list correct correct))
                                   corrects)
                         '()))
             (affix (car (cdr (cdr (cdr poss)))))
             show-affix-info
             (base-menu  (let ((save (if (and (consp affix) show-affix-info)
                                         (list
                                          (list (concat "Save affix: " (car affix))
                                                'save)
                                          '("Accept (session)" session)
                                          '("Accept (buffer)" buffer))
                                       '(("Save word" save)
                                         ("Accept (session)" session)
                                         ("Accept (buffer)" buffer)))))
                           (if (consp cor-menu)
                               (append cor-menu (cons "" save))
                             save)))
             (menu (mapcar
                    (lambda (arg) (if (consp arg) (car arg) arg))
                    base-menu)))
        (cadr (assoc (popup-menu* menu :scroll-bar t) base-menu))))
; and put this in your init file:

    (eval-after-load "flyspell"
      '(progn
         (fset 'flyspell-emacs-popup 'flyspell-emacs-popup-textual)))


;; Now calling “flyspell-correct-word-before-point” or middle-clicking a word will create a textual popup.


