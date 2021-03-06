;;; xah-fly-keys.el --- A efficient modal keybinding set minor mode based on ergonomics.

;; Copyright Â© 2013-2015, by Xah Lee

;; Author: Xah Lee ( http://xahlee.info/ )
;; Version: 5.7.2
;; Created: 10 Sep 2013
;; Keywords: convenience, emulations, vim, ergoemacs
;; Homepage: http://ergoemacs.org/misc/ergoemacs_vi_mode.html

;; This file is not part of GNU Emacs.

;;; License:

;; You can redistribute this program and/or modify it under the terms of the GNU General Public License version 2.

;;; Commentary:

;; xah-fly-keys is a efficient keybinding for emacs. (more efficient than vim)

;; It is a modal mode like vi, but key choices are based on statistics of command call frequency.

;; --------------------------------------------------
;; MANUAL INSTALL

;; put the file xah-fly-keys.el in ~/.emacs.d/lisp/
;; create the dir if doesn't exist.

;; put the following in your emacs init file:

;; (add-to-list 'load-path "~/.emacs.d/lisp/")
;; (require 'xah-fly-keys)
;; (xah-fly-keys 1)

;; --------------------------------------------------
;; HOW TO USE

;; M-x xah-fly-keys to toggle the mode on/off.

;; Important command/insert mode switch keys:

;; xah-fly-command-mode-activate (press ã€<home>ã€‘ or ã€F8ã€‘ or ã€Alt+Spaceã€‘ or ã€menuã€‘)

;; xah-fly-insert-mode-activate  (when in command mode, press letter ã€uã€‘ key)

;; When in command mode:
;; ã€uã€‘ activates insertion mode
;; ã€Spaceã€‘ is a leader key. For example, ã€SPACE pã€‘ calls query-replace. Press ã€SPACE C-hã€‘ to see the full list.
;; ã€Space Spaceã€‘ also activates insertion mode.
;; ã€Space Enterã€‘ calls execute-extended-command or smex (if smex is installed).
;; ã€aã€‘ calls execute-extended-command or smex (if smex is installed).

;; The leader key sequence basically replace ALL emacs commands that starts with C-x key.

;; When using xah-fly-keys, you don't need to press Control or Meta, with the following exceptions:

;; C-c for major mode commands.
;; C-g for cancel.
;; C-q for quoted-insert.
;; C-h for getting a list of keys following a prefix/leader key.

;; Leader key

;; You NEVER need to press Ctrl+x

;; Any emacs commands that has a keybinding starting with C-x, has also a key sequence binding in xah-fly-keys. For example,
;; ã€C-x bã€‘ switch-to-buffer is ã€SPACE uã€‘
;; ã€C-x C-fã€‘ find-file is ã€SPACE c .ã€‘
;; ã€C-x n nã€‘ narrow-to-region is ã€SPACE n nã€‘
;; The first key we call it leader key. In the above examples, the SPACE is the leader key.

;; When in command mode, the ã€SPACEã€‘ is a leader key.

;; globally, the leader key is the ã€f9ã€‘ key.

;; the following stardard keys with Control are supported:

 ;; ã€Ctrl+tabã€‘ 'xah-next-user-buffer
 ;; ã€Ctrl+shift+tabã€‘ 'xah-previous-user-buffer
 ;; ã€Ctrl+vã€‘ paste
 ;; ã€Ctrl+wã€‘ close
 ;; ã€Ctrl+zã€‘ undo
 ;; ã€Ctrl+nã€‘ new
 ;; ã€Ctrl+oã€‘ open
 ;; ã€Ctrl+sã€‘ save
 ;; ã€Ctrl+shift+sã€‘ save as
 ;; ã€Ctrl+shift+tã€‘ open last clased
 ;; ã€Ctrl++ã€‘ 'text-scale-increase
 ;; ã€Ctrl+-ã€‘ 'text-scale-decrease
 ;; ã€Ctrl+0ã€‘ (lambda () (interactive) (text-scale-set 0))))

;; On the Mac, I highly recommend using a app called Sail to set your capslock to send Home. So that it acts as xah-fly-command-mode-activate. You can set capslock or one of the cmd key to Home. See http://xahlee.info/kbd/Mac_OS_X_keymapping_keybinding_tools.html

;; I recommend you clone xah-fly-keys.el, and modify it, and use your modified version. Don't worry about upgrade. The main point is use it for your own good. (I still make key tweaks every week, for the past 3 years.)

;; If you have a bug, post on github. If you have question, post on xah-fly-keys home page.

;; For detail about design and other info, see home page at
;; http://ergoemacs.org/misc/ergoemacs_vi_mode.html

;; If you like this project, Buy Xah Emacs Tutorial http://ergoemacs.org/emacs/buy_xah_emacs_tutorial.html or make a donation. Thanks.


;;; Code:


;(require 'dired) ; in emacs
;(require 'dired-x) ; in emacs
;(require 'ido) ; in emacs



(defcustom
  xah-fly-key-layout
  nil
  "The layout to use. Value is one of \"dvorak\" or \"qwerty\". If nil, dvorak is default."
  :group 'xah-fly-keys
  )

(setq xah-fly-key-layout "dvorak")

(defvar xah-fly-command-mode-activate-hook nil "Hook for `xah-fly-command-mode-activate'")
(defvar xah-fly-insert-mode-activate-hook nil "Hook for `xah-fly-insert-mode-activate'")

(defvar xah-fly-use-control-key nil "if true, define standard keys for open, close, paste, etc.")
(setq xah-fly-use-control-key t)


;; cursor movement

(defun xah-pop-local-mark-ring ()
  "Move cursor to last mark position of current buffer.
Call this repeatedly will cycle all positions in `mark-ring'.
URL `http://ergoemacs.org/emacs/emacs_jump_to_previous_position.html'
version 2016-04-04"
  (interactive)
  (set-mark-command t))

(defun xah-forward-block (&optional n)
  "Move cursor beginning of next text block.
A text block is separated by blank lines.
This command similar to `forward-paragraph', but this command's behavior is the same regardless of syntax table.
URL `http://ergoemacs.org/emacs/emacs_move_by_paragraph.html'
Version 2016-06-15"
  (interactive "p")
  (let ((n (if (null n) 1 n)))
    (search-forward-regexp "\n[\t\n ]*\n+" nil "NOERROR" n)))

(defun xah-backward-block (&optional n)
  "Move cursor to previous text block.
See: `xah-forward-block'
URL `http://ergoemacs.org/emacs/emacs_move_by_paragraph.html'
Version 2016-06-15"
  (interactive "p")
  (let ((n (if (null n) 1 n))
        (-i 1))
    (while (<= -i n)
      (if (search-backward-regexp "\n[\t\n ]*\n+" nil "NOERROR")
          (progn (skip-chars-backward "\n\t "))
        (progn (goto-char (point-min))
               (setq -i n)))
      (setq -i (1+ -i)))))

(defun xah-beginning-of-line-or-block (&optional n)
  "Move cursor to beginning of line, or beginning of current or previous text block.
 (a text block is separated by blank lines)
URL `http://ergoemacs.org/emacs/emacs_keybinding_design_beginning-of-line-or-block.html'
version 2016-06-15"
  (interactive "p")
  (let ((n (if (null n) 1 n)))
    (if (equal n 1)
        (if (or (equal (point) (line-beginning-position))
                (equal last-command this-command )
                ;; (equal last-command 'xah-end-of-line-or-block )
                )
            (xah-backward-block n)
          (beginning-of-line))
      (xah-backward-block n))))

(defun xah-end-of-line-or-block (&optional n)
  "Move cursor to end of line, or end of current or next text block.
 (a text block is separated by blank lines)
URL `http://ergoemacs.org/emacs/emacs_keybinding_design_beginning-of-line-or-block.html'
version 2016-06-15"
  (interactive "p")
  (let ((n (if (null n) 1 n)))
    (if (equal n 1)
        (if (or (equal (point) (line-end-position))
                (equal last-command this-command )
                ;; (equal last-command 'xah-beginning-of-line-or-block )
                )
            (xah-forward-block)
          (end-of-line))
      (progn (xah-forward-block n)))))

(defvar xah-brackets nil "string of left/right brackets pairs.")
(setq xah-brackets "()[]{}<>ï¼ˆï¼‰ï¼»ï¼½ï½›ï½â¦…â¦†ã€šã€›â¦ƒâ¦„â€œâ€â€˜â€™â€¹â€ºÂ«Â»ã€Œã€ã€ˆã€‰ã€Šã€‹ã€ã€‘ã€”ã€•â¦—â¦˜ã€Žã€ã€–ã€—ã€˜ã€™ï½¢ï½£âŸ¦âŸ§âŸ¨âŸ©âŸªâŸ«âŸ®âŸ¯âŸ¬âŸ­âŒˆâŒ‰âŒŠâŒ‹â¦‡â¦ˆâ¦‰â¦Šâ›âœââžâ¨â©âªâ«â´âµâ¬â­â®â¯â°â±â²â³âŒ©âŒªâ¦‘â¦’â§¼â§½ï¹™ï¹šï¹›ï¹œï¹ï¹žâ½â¾â‚â‚Žâ¦‹â¦Œâ¦â¦Žâ¦â¦â…â†â¸¢â¸£â¸¤â¸¥âŸ…âŸ†â¦“â¦”â¦•â¦–â¸¦â¸§â¸¨â¸©ï½Ÿï½ â§˜â§™â§šâ§›â¸œâ¸â¸Œâ¸â¸‚â¸ƒâ¸„â¸…â¸‰â¸Šáš›ášœà¼ºà¼»à¼¼à¼½âœââŽ´âŽµâžâŸâ â¡ï¹ï¹‚ï¹ƒï¹„ï¸¹ï¸ºï¸»ï¸¼ï¸—ï¸˜ï¸¿ï¹€ï¸½ï¸¾ï¹‡ï¹ˆï¸·ï¸¸")

(defvar xah-left-brackets '("(" "{" "[" "<" "ã€”" "ã€" "ã€–" "ã€ˆ" "ã€Š" "ã€Œ" "ã€Ž" "â€œ" "â€˜" "â€¹" "Â«" )
  "List of left bracket chars.")
(progn
;; make xah-left-brackets based on xah-brackets
  (setq xah-left-brackets '())
  (dotimes (-x (- (length xah-brackets) 1))
    (when (= (% -x 2) 0)
      (push (char-to-string (elt xah-brackets -x))
            xah-left-brackets)))
  (setq xah-left-brackets (reverse xah-left-brackets)))

(defvar xah-right-brackets '(")" "]" "}" ">" "ã€•" "ã€‘" "ã€—" "ã€‰" "ã€‹" "ã€" "ã€" "â€" "â€™" "â€º" "Â»")
  "list of right bracket chars.")
(progn
  (setq xah-right-brackets '())
  (dotimes (-x (- (length xah-brackets) 1))
    (when (= (% -x 2) 1)
      (push (char-to-string (elt xah-brackets -x))
            xah-right-brackets)))
  (setq xah-right-brackets (reverse xah-right-brackets)))

(defvar xah-punctuation-regex nil "a regex string for the purpose of jumping to punctuations in programing modes.")
(setq xah-punctuation-regex "[\\!\?\"'#$%&*+,/:;<=>@^`|~]+")

(defun xah-forward-punct (&optional n)
  "Move cursor to the next occurrence of punctuation.
The list of punctuations to jump to is defined by `xah-punctuation-regex'"
  (interactive "p")
  (search-forward-regexp xah-punctuation-regex nil t n))

(defun xah-backward-punct (&optional n)
  "Move cursor to the previous occurrence of punctuation.
See `xah-forward-punct'"
  (interactive "p")
  (search-backward-regexp xah-punctuation-regex nil t n))

(defun xah-backward-left-bracket ()
  "Move cursor to the previous occurrence of left bracket.
The list of brackets to jump to is defined by `xah-left-brackets'.
URL `http://ergoemacs.org/emacs/emacs_navigating_keys_for_brackets.html'
Version 2015-10-01"
  (interactive)
  (search-backward-regexp (regexp-opt xah-left-brackets) nil t))

(defun xah-forward-right-bracket ()
  "Move cursor to the next occurrence of right bracket.
The list of brackets to jump to is defined by `xah-right-brackets'.
URL `http://ergoemacs.org/emacs/emacs_navigating_keys_for_brackets.html'
Version 2015-10-01"
  (interactive)
  (search-forward-regexp (regexp-opt xah-right-brackets) nil t))

(defun xah-goto-matching-bracket ()
  "Move cursor to the matching bracket.
If cursor is not on a bracket, call `backward-up-list'.
The list of brackets to jump to is defined by `xah-left-brackets' and `xah-right-brackets'.
URL `http://ergoemacs.org/emacs/emacs_navigating_keys_for_brackets.html'
Version 2016-11-22"
  (interactive)
  (if (nth 3 (syntax-ppss))
      (backward-up-list 1 'ESCAPE-STRINGS 'NO-SYNTAX-CROSSING)
    (cond
     ((eq (char-after) ?\") (forward-sexp))
     ((eq (char-before) ?\") (backward-sexp ))
     ((looking-at (regexp-opt xah-left-brackets))
      (forward-sexp))
     ((looking-back (regexp-opt xah-right-brackets) (max (- (point) 1) 1))
      (backward-sexp))
     (t (backward-up-list 1 'ESCAPE-STRINGS 'NO-SYNTAX-CROSSING)))))

(defun xah-forward-equal-quote ()
  "Move cursor to the next occurrence of ã€Œ='ã€ or ã€Œ=\"ã€, with or without space.
URL `http://ergoemacs.org/emacs/emacs_navigating_keys_for_brackets.html'
Version 2015-05-05"
  (interactive)
  (search-forward-regexp "=[ \n]*\\('+\\|\\\"+\\)" nil t))

(defun xah-forward-equal-sign ()
  "Move cursor to the next occurrence of equal sign ã€Œ=ã€.
URL `http://ergoemacs.org/emacs/emacs_jump_to_punctuations.html'
Version 2015-06-15"
  (interactive)
  (search-forward-regexp "=+" nil t))

(defun xah-backward-equal-sign ()
  "Move cursor to previous occurrence of equal sign ã€Œ=ã€.
URL `http://ergoemacs.org/emacs/emacs_jump_to_punctuations.html'
Version 2015-06-15"
  (interactive)
  (when (search-backward-regexp "=+" nil t)
    (while (search-backward "=" (- (point) 1) t)
      (left-char))))

(defun xah-forward-comma-sign ()
  "Move cursor to the next occurrence of comma ã€Œ,ã€.
Version 2016-01-19"
  (interactive)
  (search-forward-regexp ",+" nil t))

(defun xah-backward-comma-sign ()
  "Move cursor to previous occurrence of comma sign ã€Œ,ã€.
Version 2016-01-19"
  (interactive)
  (when (search-backward-regexp ",+" nil t)
    (while (search-backward "," (- (point) 1) t)
      (left-char))))

(defun xah-forward-quote ()
  "Move cursor to the next occurrence of \".
If there are consecutive quotes of the same char, keep moving until none.
Returns `t' if found, else `nil'.
URL `http://ergoemacs.org/emacs/emacs_navigating_keys_for_brackets.html'
Version 2016-07-23"
  (interactive)
  (if (search-forward-regexp "\\\"+" nil t)
      t
    (progn
      (message "No more quotes after cursor..")
      nil)))

(defun xah-forward-quote-twice ()
  "Call `xah-forward-quote' twice.
Returns `t' if found, else `nil'.
URL `http://ergoemacs.org/emacs/emacs_navigating_keys_for_brackets.html'
Version 2016-07-23"
  (interactive)
  (when (xah-forward-quote)
    (xah-forward-quote)))

(defun xah-forward-quote-smart ()
  "Move cursor to the current or next string quote.
Place cursor at the position after the left quote.
Repeated call will find the next string.
URL `http://ergoemacs.org/emacs/emacs_navigating_keys_for_brackets.html'
Version 2016-11-22"
  (interactive)
  (let ((-pos (point)))
    (if (nth 3 (syntax-ppss))
        (progn
          (backward-up-list 1 'ESCAPE-STRINGS 'NO-SYNTAX-CROSSING)
          (forward-sexp)
          (search-forward-regexp "\\\"" nil t))
      (progn (search-forward-regexp "\\\"" nil t)))
    (when (<= (point) -pos)
      (progn (search-forward-regexp "\\\"" nil t)))))

(defun xah-backward-quote ()
  "Move cursor to the previous occurrence of \".
If there are consecutive quotes of the same char, keep moving until none.
Returns `t' if found, else `nil'.
URL `http://ergoemacs.org/emacs/emacs_navigating_keys_for_brackets.html'
Version 2016-07-23"
  (interactive)
  (if (search-backward-regexp "\\\"+" nil t)
      (when (char-before) ; isn't nil, at beginning of buffer
        (while (char-equal (char-before) (char-after))
          (left-char)
          t))
    (progn
      (message "No more quotes before cursor.")
      nil)))

(defun xah-forward-dot-comma ()
  "Move cursor to the next occurrence of ã€Œ.ã€ ã€Œ,ã€ ã€Œ;ã€.
URL `http://ergoemacs.org/emacs/emacs_jump_to_punctuations.html'
Version 2015-03-24"
  (interactive)
  (search-forward-regexp "\\.+\\|,+\\|;+" nil t))

(defun xah-backward-dot-comma ()
  "Move cursor to the previous occurrence of ã€Œ.ã€ ã€Œ,ã€ ã€Œ;ã€
URL `http://ergoemacs.org/emacs/emacs_jump_to_punctuations.html'
Version 2015-03-24"
  (interactive)
  (search-backward-regexp "\\.+\\|,+\\|;+" nil t))

;; (defun goto-point-min ()
;;   "Goto the beginning of buffer.
;; This is different from `beginning-of-buffer'
;; because that marks the previous position."
;;   (interactive)
;;   (goto-char (point-min))
;; )

;; (defun goto-point-max ()
;;   "Goto the end of buffer.
;; This is different from `end-of-buffer'
;; because that marks the previous position."
;;   (interactive)
;;   (goto-char (point-max))
;; )

;; (defun xah-forward-space ()
;;   "Move cursor to the next occurrence of white space."
;;   (interactive)
;;   (re-search-forward "[ \t\n]+" nil t))

;; (defun xah-backward-space ()
;;   "Move cursor to the next occurrence of white space."
;;   (interactive)
;;   ;; (skip-chars-backward "^ \t\n")
;;   ;; (re-search-backward "[ \t\n]+" nil t)
;;   (posix-search-backward "[ \t\n]+" nil t)
;;   )

; (defun xah-display-page-break-as-line ()
  ; "Display the formfeed ^L char as line.
; Version 2016-10-11"
  ; (interactive)
  ; 2016-10-11 thanks to Steve Purcell's page-break-lines.el
  ; (progn
    ; (when (null buffer-display-table)
      ; (setq buffer-display-table (make-display-table)))
    ; (aset buffer-display-table ?\^L
          ; (vconcat (make-list 70 (make-glyph-code ?â”€ 'font-lock-comment-face))))
    ; (redraw-frame)))


;; text selection

(defun xah-delete-current-line ()
  "Delete current line."
  (interactive)
  (delete-region (line-beginning-position) (line-end-position))
  (when (looking-at "\n")
    (delete-char 1)))

;; (defun xah-copy-line-or-region ()
;;   "Copy current line, or text selection.
;; When `universal-argument' is called first, copy whole buffer (respects `narrow-to-region').

;; URL `http://ergoemacs.org/emacs/emacs_copy_cut_current_line.html'
;; Version 2015-05-06"
;;   (interactive)
;;   (let (-p1 -p2)
;;     (if current-prefix-arg
;;         (progn (setq -p1 (point-min))
;;                (setq -p2 (point-max)))
;;       (progn (if (use-region-p)
;;                  (progn (setq -p1 (region-beginning))
;;                         (setq -p2 (region-end)))
;;                (progn (setq -p1 (line-beginning-position))
;;                       (setq -p2 (line-end-position))))))
;;     (kill-ring-save -p1 -p2)
;;     (if current-prefix-arg
;;         (message "buffer text copied")
;;       (message "text copied"))))

(defun xah-copy-line-or-region ()
  "Copy current line, or text selection.
When called repeatedly, append copy subsequent lines.
When `universal-argument' is called first, copy whole buffer (respects `narrow-to-region').

URL `http://ergoemacs.org/emacs/emacs_copy_cut_current_line.html'
Version 2016-06-18"
  (interactive)
  (let (-p1 -p2)
    (if current-prefix-arg
        (setq -p1 (point-min) -p2 (point-max))
      (if (use-region-p)
          (setq -p1 (region-beginning) -p2 (region-end))
        (setq -p1 (line-beginning-position) -p2 (line-end-position))))
    (if (eq last-command this-command)
        (progn
          (progn ; hack. exit if there's no more next line
            (end-of-line)
            (forward-char)
            (backward-char))
          ;; (push-mark (point) "NOMSG" "ACTIVATE")
          (kill-append "\n" nil)
          (kill-append (buffer-substring-no-properties (line-beginning-position) (line-end-position)) nil)
          (message "Line copy appended"))
      (progn
        (kill-ring-save -p1 -p2)
        (if current-prefix-arg
            (message "Buffer text copied")
          (message "Text copied"))))
    (end-of-line)
    (forward-char)
    ))

(defun xah-cut-line-or-region ()
  "Cut current line, or text selection.
When `universal-argument' is called first, cut whole buffer (respects `narrow-to-region').

URL `http://ergoemacs.org/emacs/emacs_copy_cut_current_line.html'
Version 2015-06-10"
  (interactive)
  (if current-prefix-arg
      (progn ; not using kill-region because we don't want to include previous kill
        (kill-new (buffer-string))
        (delete-region (point-min) (point-max)))
    (progn (if (use-region-p)
               (kill-region (region-beginning) (region-end) t)
             (kill-region (line-beginning-position) (line-beginning-position 2))))))

(defun xah-copy-all-or-region ()
  "Put the whole buffer content to `kill-ring', or text selection if there's one.
Respects `narrow-to-region'.
URL `http://ergoemacs.org/emacs/emacs_copy_cut_all_or_region.html'
Version 2015-08-22"
  (interactive)
  (if (use-region-p)
      (progn
        (kill-new (buffer-substring (region-beginning) (region-end)))
        (message "Text selection copied."))
    (progn
      (kill-new (buffer-string))
      (message "Buffer content copied."))))

(defun xah-cut-all-or-region ()
  "Cut the whole buffer content to `kill-ring', or text selection if there's one.
Respects `narrow-to-region'.
URL `http://ergoemacs.org/emacs/emacs_copy_cut_all_or_region.html'
Version 2015-08-22"
  (interactive)
  (if (use-region-p)
      (progn
        (kill-new (buffer-substring (region-beginning) (region-end)))
        (delete-region (region-beginning) (region-end)))
    (progn
      (kill-new (buffer-string))
      (delete-region (point-min) (point-max)))))

(defun xah-copy-all ()
  "Put the whole buffer content into the `kill-ring'.
(respects `narrow-to-region')
Version 2016-10-06"
  (interactive)
  (kill-new (buffer-string))
  (message "Buffer content copied."))

(defun xah-cut-all ()
  "Cut the whole buffer content into the `kill-ring'.
Respects `narrow-to-region'."
  (interactive)
  (kill-new (buffer-string))
  (delete-region (point-min) (point-max)))


;; editing commands


;; test case
;; test_case some
;; test-case
;; tesâ–®t-case

(defun xah-toggle-previous-letter-case ()
  "Toggle the letter case of the letter to the left of cursor.
URL `http://ergoemacs.org/emacs/modernization_upcase-word.html'
Version 2015-12-22"
  (interactive)
  (let ((case-fold-search nil))
    (left-char 1)
    (cond
     ((looking-at "[[:lower:]]") (upcase-region (point) (1+ (point))))
     ((looking-at "[[:upper:]]") (downcase-region (point) (1+ (point)))))
    (right-char)))

(defun xah-shrink-whitespaces ()
  "Remove whitespaces around cursor to just one or none.
Call this command again to shrink more. 3 calls will remove all whitespaces.
URL `http://ergoemacs.org/emacs/emacs_shrink_whitespace.html'
Version 2015-11-04"
  (interactive)
  (let ((-p0 (point))
        -line-has-char-p ; current line contains non-white space chars
        -has-space-tab-neighbor-p
        -whitespace-begin -whitespace-end
        -space-or-tab-begin -space-or-tab-end
        )
    (save-excursion
      (setq -has-space-tab-neighbor-p
            (if (or
                 (looking-at " \\|\t")
                 (looking-back " \\|\t" 1))
                t
              nil))
      (beginning-of-line)
      (setq -line-has-char-p (search-forward-regexp "[[:graph:]]" (line-end-position) t))

      (goto-char -p0)
      (skip-chars-backward "\t ")
      (setq -space-or-tab-begin (point))

      (skip-chars-backward "\t \n")
      (setq -whitespace-begin (point))

      (goto-char -p0)
      (skip-chars-forward "\t ")
      (setq -space-or-tab-end (point))
      (skip-chars-forward "\t \n")
      (setq -whitespace-end (point)))

    (if -line-has-char-p
        (if -has-space-tab-neighbor-p
            (let (-deleted-text)
              ;; remove all whitespaces in the range
              (setq -deleted-text
                    (delete-and-extract-region -space-or-tab-begin -space-or-tab-end))
              ;; insert a whitespace only if we have removed something different than a simple whitespace
              (when (not (string= -deleted-text " "))
                (insert " ")))

          (progn
            (when (equal (char-before) 10) (delete-char -1))
            (when (equal (char-after) 10) (delete-char 1))))
      (progn (delete-blank-lines)))))

(defun xah-fill-or-unfill ()
  "Reformat current paragraph or region to `fill-column', like `fill-paragraph' or â€œunfillâ€.
When there is a text selection, act on the the selection, else, act on a text block separated by blank lines.
URL `http://ergoemacs.org/emacs/modernization_fill-paragraph.html'
Version 2016-07-13"
  (interactive)
  ;; This command symbol has a property â€œ'compact-pâ€, the possible values are t and nil. This property is used to easily determine whether to compact or uncompact, when this command is called again
  (let ( (-compact-p
          (if (eq last-command this-command)
              (get this-command 'compact-p)
            (> (- (line-end-position) (line-beginning-position)) fill-column)))
         (deactivate-mark nil)
         (-blanks-regex "\n[ \t]*\n")
         -p1 -p2
         )
    (if (use-region-p)
        (progn (setq -p1 (region-beginning))
               (setq -p2 (region-end)))
      (save-excursion
        (if (re-search-backward -blanks-regex nil "NOERROR")
            (progn (re-search-forward -blanks-regex)
                   (setq -p1 (point)))
          (setq -p1 (point)))
        (if (re-search-forward -blanks-regex nil "NOERROR")
            (progn (re-search-backward -blanks-regex)
                   (setq -p2 (point)))
          (setq -p2 (point)))))
    (if -compact-p
        (fill-region -p1 -p2)
      (let ((fill-column most-positive-fixnum ))
        (fill-region -p1 -p2)))
    (put this-command 'compact-p (not -compact-p))))

(defun xah-reformat-lines ()
  "Reformat current text block into 1 long line or multiple short lines.
When there is a text selection, act on the the selection, else, act on a text block separated by blank lines.

When the command is called for the first time, it checks the current line's length to decide to go into 1 line or multiple lines. If current line is short, it'll reformat to 1 long lines. And vice versa.

Repeated call toggles between formatting to 1 long line and multiple lines.
URL `http://ergoemacs.org/emacs/emacs_reformat_lines.html'
Version 2016-10-19"
  (interactive)
  ;; This command symbol has a property â€œ'compact-pâ€, the possible values are t and nil. This property is used to easily determine whether to compact or uncompact, when this command is called again
  (let (
        (-compact-p
         (if (eq last-command this-command)
             (get this-command 'compact-p)
           (> (- (line-end-position) (line-beginning-position)) fill-column)))
        (deactivate-mark nil)
        (-blanks-regex "\n[ \t]*\n")
        -p1 -p2
        )
    (if (use-region-p)
        (progn (setq -p1 (region-beginning))
               (setq -p2 (region-end)))
      (save-excursion
        (if (re-search-backward -blanks-regex nil "NOERROR")
            (progn (re-search-forward -blanks-regex)
                   (setq -p1 (point)))
          (setq -p1 (point)))
        (if (re-search-forward -blanks-regex nil "NOERROR")
            (progn (re-search-backward -blanks-regex)
                   (setq -p2 (point)))
          (setq -p2 (point)))))
    (progn
      (if -compact-p
          (xah-reformat-to-multi-lines-region -p1 -p2)
        (xah-replace-whitespaces-to-1 -p1 -p2))
      (put this-command 'compact-p (not -compact-p)))))

(defun xah-reformat-to-single-line-region (*begin *end)
  "Replace whitespaces at end line by one space or 1 return.
Basically, collapse whitespaces. But 2 or more newline will collapse to 1.
URL `http://ergoemacs.org/emacs/emacs_reformat_lines.html'
Version 2016-10-30"
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region *begin *end)
      (goto-char (point-min))
      (while
          (search-forward-regexp "\n\n+" nil 'NOERROR)
        (replace-match ",,j0mxwz9jiv"))
      (goto-char (point-min))
      (while
          (search-forward "\t" nil 'NOERROR)
        (replace-match " "))
      (goto-char (point-min))
      (while
          (search-forward-regexp "\n" nil 'NOERROR)
        (replace-match " "))
      (goto-char (point-min))
      (while
          (search-forward-regexp "  +" nil 'NOERROR)
        (replace-match " "))
      (goto-char (point-min))
      (while
          (search-forward ",,j0mxwz9jiv" nil 'NOERROR)
        (replace-match "\n\n")))))

(defun xah-replace-whitespaces-to-1 (*begin *end)
  "Replace whitespaces by one space.
URL `http://ergoemacs.org/emacs/emacs_reformat_lines.html'
Version 2016-11-01"
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region *begin *end)
      (goto-char (point-min))
      (while
          (search-forward "\n" nil 'NOERROR)
        (replace-match " "))
      (goto-char (point-min))
      (while
          (search-forward "\t" nil 'NOERROR)
        (replace-match " "))
      (goto-char (point-min))
      (while
          (search-forward-regexp "  +" nil 'NOERROR)
        (replace-match " ")))))

(defun xah-reformat-to-multi-lines-region (*begin *end)
  "replace space by a newline char at places so lines are not long.
URL `http://ergoemacs.org/emacs/emacs_reformat_lines.html'
Version 2016-10-19"
  (interactive "r")
  (save-restriction
    (narrow-to-region *begin *end)
    (goto-char (point-min))
    (while
        (search-forward " " nil 'NOERROR)
      (when (> (- (point) (line-beginning-position)) fill-column)
        (replace-match "\n" )))))

(defun xah-unfill-paragraph ()
  "Replace newline chars in current paragraph by single spaces.
This command does the inverse of `fill-paragraph'.

URL `http://ergoemacs.org/emacs/emacs_unfill-paragraph.html'
Version 2016-07-13"
  (interactive)
  (let ((fill-column most-positive-fixnum))
    (fill-paragraph)))

(defun xah-unfill-region (*begin *end)
  "Replace newline chars in region by single spaces.
This command does the inverse of `fill-region'.

URL `http://ergoemacs.org/emacs/emacs_unfill-paragraph.html'
Version 2016-07-13"
  (interactive "r")
  (let ((fill-column most-positive-fixnum))
    (fill-region *begin *end)))

(defun xah-comment-dwim ()
  "Like `comment-dwim', but toggle comment if cursor is not at end of line.

URL `http://ergoemacs.org/emacs/emacs_toggle_comment_by_line.html'
Version 2016-10-25"
  (interactive)
  (if (region-active-p)
      (comment-dwim nil)
    (let ((-lbp (line-beginning-position))
          (-lep (line-end-position)))
      (if (eq -lbp -lep)
          (progn
            (comment-dwim nil))
        (if (eq (point) -lep)
            (progn
              (comment-dwim nil))
          (progn
            (comment-or-uncomment-region -lbp -lep)
            (forward-line )))))))

(defun xah-dired-rename-space-to-underscore ()
  "In dired, rename current or marked files by replacing space to underscore _.
If not in `dired', do nothing.

URL `http://ergoemacs.org/emacs/elisp_dired_rename_space_to_underscore.html'
Version 2016-11-09"
  (interactive)
  (if (equal major-mode 'dired-mode)
      (progn
        (mapc (lambda (fname)
                (when (string-match " " fname )
                  (rename-file fname (replace-regexp-in-string " " "_" fname))))
              (dired-get-marked-files ))
        (revert-buffer)
        (forward-line ))
    (user-error "Not in dired")))

(defun xah-dired-rename-space-to-hyphen ()
  "In dired, rename current or marked files by replacing space to hyphen -.
If not in `dired', do nothing.

URL `http://ergoemacs.org/emacs/elisp_dired_rename_space_to_underscore.html'
Version 2016-10-12"
  (interactive)
  (if (equal major-mode 'dired-mode)
      (progn
        (mapc (lambda (fname)
                (when (string-match " " fname )
                  (rename-file fname (replace-regexp-in-string " " "-" fname))))
              (dired-get-marked-files ))
        (revert-buffer))
    (user-error "Not in dired")))

(defun xah-cycle-hyphen-underscore-space ( &optional *begin *end )
  "Cycle {underscore, space, hypen} chars in selection or inside quote/bracket or line.
When called repeatedly, this command cycles the {â€œ_â€, â€œ-â€, â€œ â€} characters, in that order.

The region to work on is by this order:
â‘  if there's active region (text selection), use that.
â‘¡ If cursor is string quote or any type of bracket, and is within current line, work on that region.
â‘¢ else, work on current line.

URL `http://ergoemacs.org/emacs/elisp_change_space-hyphen_underscore.html'
Version 2016-11-11"
  (interactive)
  ;; this function sets a property ã€Œ'stateã€. Possible values are 0 to length of -charArray.
  (let (-p1 -p2)
    (if (and (not (null *begin)) (not (null *end)))
        (progn (setq -p1 *begin -p2 *end))
      (if (use-region-p)
          (setq -p1 (region-beginning) -p2 (region-end))
        (if (nth 3 (syntax-ppss))
            (save-excursion
              (skip-chars-backward "^\"")
              (setq -p1 (point))
              (skip-chars-forward "^\"")
              (setq -p2 (point)))
          (let (
                (-skipChars
                 (if (boundp 'xah-brackets)
                     (concat "^\"" xah-brackets)
                   "^\"<>(){}[]â€œâ€â€˜â€™â€¹â€ºÂ«Â»ã€Œã€ã€Žã€ã€ã€‘ã€–ã€—ã€Šã€‹ã€ˆã€‰ã€”ã€•ï¼ˆï¼‰")))
            (skip-chars-backward -skipChars (line-beginning-position))
            (setq -p1 (point))
            (skip-chars-forward -skipChars (line-end-position))
            (setq -p2 (point))
            (set-mark -p1)))))
    (let* ((-inputText (buffer-substring-no-properties -p1 -p2))
           (-charArray ["_" "-" " "])
           (-length (length -charArray))
           (-regionWasActive-p (region-active-p))
           (-nowState
            (if (equal last-command this-command )
                (get 'xah-cycle-hyphen-underscore-space 'state)
              0 ))
           (-changeTo (elt -charArray -nowState)))
      (save-excursion
        (save-restriction
          (narrow-to-region -p1 -p2)
          (goto-char (point-min))
          (while
              (search-forward-regexp
               (elt -charArray (% (+ -nowState 2) -length))
               ;; (concat
               ;;  (elt -charArray (% (+ -nowState 1) -length))
               ;;  "\\|"
               ;;  (elt -charArray (% (+ -nowState 2) -length)))
               (point-max)
               'NOERROR)
            (replace-match -changeTo 'FIXEDCASE 'LITERAL))))
      (when (or (string= -changeTo " ") -regionWasActive-p)
        (goto-char -p2)
        (set-mark -p1)
        (setq deactivate-mark nil))
      (put 'xah-cycle-hyphen-underscore-space 'state (% (+ -nowState 1) -length)))))

(defun xah-underscore-to-space-region (*begin *end)
  "Change underscore char to space.
URL `http://ergoemacs.org/emacs/elisp_change_space-hyphen_underscore.html'
Version 2015-08-18"
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region *begin *end)
      (goto-char (point-min))
      (while
          (search-forward-regexp "_" (point-max) 'NOERROR)
        (replace-match " " 'FIXEDCASE 'LITERAL)))))

(defun xah-copy-file-path (&optional *dir-path-only-p)
  "Copy the current buffer's file path or dired path to `kill-ring'.
Result is full path.
If `universal-argument' is called first, copy only the dir path.
URL `http://ergoemacs.org/emacs/emacs_copy_file_path.html'
Version 2016-07-17"
  (interactive "P")
  (let ((-fpath
         (if (equal major-mode 'dired-mode)
             (expand-file-name default-directory)
           (if (null (buffer-file-name))
               (user-error "Current buffer is not associated with a file.")
             (buffer-file-name)))))
    (kill-new
     (if (null *dir-path-only-p)
         (progn
           (message "File path copied: ã€Œ%sã€" -fpath)
           -fpath
           )
       (progn
         (message "Directory path copied: ã€Œ%sã€" (file-name-directory -fpath))
         (file-name-directory -fpath))))))

(defun xah-delete-text-block ()
  "Delete current/next text block or selection, and also copy to `kill-ring'.

A â€œblockâ€ is text between blank lines.
The â€œcurrent blockâ€ is the block the cursor is at.
If cursor is not on a block, deletes the next block.
If there's a text selection, just delete that region.

URL `http://ergoemacs.org/emacs/emacs_delete_block.html'
Version 2016-10-10"
  (interactive)
  (if (use-region-p)
      (kill-region (region-beginning) (region-end))
    (progn
      (beginning-of-line)
      (if (search-forward-regexp "[[:graph:]]" (line-end-position) 'NOERROR )
          (xah-delete-current-text-block)
        (when (search-forward-regexp "[[:graph:]]" )
          (xah-delete-current-text-block))))))

(defun xah-delete-current-text-block ()
  "Delete the current text block and also copy to `kill-ring'.

A â€œblockâ€ is text between blank lines.
The â€œcurrent blockâ€ is the block the cursor is at.
If cursor is not on a block nor on edge of a block, delete 2 empty lines.
If there's a text selection, ignore it.

URL `http://ergoemacs.org/emacs/emacs_delete_block.html'
Version 2016-10-10"
  (interactive)
  (let (-p1 -p2)
    (progn
      (if (re-search-backward "\n[ \t]*\n" nil "NOERROR")
          (progn (re-search-forward "\n[ \t]*\n")
                 (setq -p1 (point)))
        (setq -p1 (point)))
      (re-search-forward "\n[ \t]*\n" nil "NOERROR")
      (setq -p2 (point)))
    (kill-region -p1 -p2)))

(defun xah-copy-to-register-1 ()
  "Copy current line or text selection to register 1.
See also: `xah-paste-from-register-1', `copy-to-register'.

URL `http://ergoemacs.org/emacs/elisp_copy-paste_register_1.html'
Version 2015-12-08"
  (interactive)
  (let (-p1 -p2)
    (if (region-active-p)
        (progn (setq -p1 (region-beginning))
               (setq -p2 (region-end)))
      (progn (setq -p1 (line-beginning-position))
             (setq -p2 (line-end-position))))
    (copy-to-register ?1 -p1 -p2)
    (message "copied to register 1: ã€Œ%sã€." (buffer-substring-no-properties -p1 -p2))))

(defun xah-paste-from-register-1 ()
  "Paste text from register 1.
See also: `xah-copy-to-register-1', `insert-register'.
URL `http://ergoemacs.org/emacs/elisp_copy-paste_register_1.html'
Version 2015-12-08"
  (interactive)
  (when (use-region-p)
    (delete-region (region-beginning) (region-end)))
  (insert-register ?1 t))

  
  
  
    (use-package rect
  :defer t)
(defun xah-copy-rectangle-to-kill-ring (*begin *end)
  "Copy region as column (rectangle region) to `kill-ring'
See also: `kill-rectangle', `copy-to-register'.
URL `http://ergoemacs.org/emacs/emacs_copy_rectangle_text_to_clipboard.html'
version 2016-07-17"
  ;; extract-rectangle suggested by YoungFrog, 2012-07-25
  (interactive "r")
  ;(require 'rect)
  
  (kill-new (mapconcat 'identity (extract-rectangle *begin *end) "\n")))

(defun xah-upcase-sentence ()
  "Upcase sentence.
TODO 2014-09-30 command incomplete
"
  (interactive)
  (let (-p1 -p2)

    (if (region-active-p)
        (progn
          (setq -p1 (region-beginning))
          (setq -p2 (region-end)))
      (progn
        (save-excursion
          (progn
            (if (re-search-backward "\n[ \t]*\n" nil "move")
                (progn (re-search-forward "\n[ \t]*\n")
                       (setq -p1 (point)))
              (setq -p1 (point)))
            (if (re-search-forward "\n[ \t]*\n" nil "move")
                (progn (re-search-backward "\n[ \t]*\n")
                       (setq -p2 (point)))
              (setq -p2 (point)))))))

    (save-excursion
      (save-restriction
        (narrow-to-region -p1 -p2)

        (goto-char (point-min))
        (while (search-forward "\. \{1,2\}\\([a-z]\\)" nil t)
nil
;; (replace-match "myReplaceStr2")

)))))

(defun xah-escape-quotes (*begin *end)
  "Replace ã€Œ\"ã€ by ã€Œ\\\"ã€ in current line or text selection.
See also: `xah-unescape-quotes'
URL `http://ergoemacs.org/emacs/elisp_escape_quotes.html'
Version 2016-07-17"
  (interactive
   (if (use-region-p)
       (list (region-beginning) (region-end))
     (list (line-beginning-position) (line-end-position))))
  (save-excursion
      (save-restriction
        (narrow-to-region *begin *end)
        (goto-char (point-min))
        (while (search-forward "\"" nil t)
          (replace-match "\\\"" 'FIXEDCASE 'LITERAL)))))

(defun xah-unescape-quotes (*begin *end)
  "Replace  ã€Œ\\\"ã€ by ã€Œ\"ã€ in current line or text selection.
See also: `xah-escape-quotes'
URL `http://ergoemacs.org/emacs/elisp_escape_quotes.html'
Version 2016-07-17"
  (interactive
   (if (use-region-p)
       (list (region-beginning) (region-end))
     (list (line-beginning-position) (line-end-position))))
  (save-excursion
    (save-restriction
      (narrow-to-region *begin *end)
      (goto-char (point-min))
      (while (search-forward "\\\"" nil t)
        (replace-match "\"" 'FIXEDCASE 'LITERAL)))))

(defun xah-title-case-region-or-line (*begin *end)
  "Title case text between nearest brackets, or current line, or text selection.
Capitalize first letter of each word, except words like {to, of, the, a, in, or, and, â€¦}. If a word already contains cap letters such as HTTP, URL, they are left as is.

When called in a elisp program, *begin *end are region boundaries.
URL `http://ergoemacs.org/emacs/elisp_title_case_text.html'
Version 2015-05-07"
  (interactive
   (if (use-region-p)
       (list (region-beginning) (region-end))
     (let (
           -p1
           -p2
           (-skipChars "^\"<>(){}[]â€œâ€â€˜â€™â€¹â€ºÂ«Â»ã€Œã€ã€Žã€ã€ã€‘ã€–ã€—ã€Šã€‹ã€ˆã€‰ã€”ã€•"))
       (progn
         (skip-chars-backward -skipChars (line-beginning-position))
         (setq -p1 (point))
         (skip-chars-forward -skipChars (line-end-position))
         (setq -p2 (point)))
       (list -p1 -p2))))
  (let* (
         (-strPairs [
                     [" A " " a "]
                     [" And " " and "]
                     [" At " " at "]
                     [" As " " as "]
                     [" By " " by "]
                     [" Be " " be "]
                     [" Into " " into "]
                     [" In " " in "]
                     [" Is " " is "]
                     [" It " " it "]
                     [" For " " for "]
                     [" Of " " of "]
                     [" Or " " or "]
                     [" On " " on "]
                     [" Via " " via "]
                     [" The " " the "]
                     [" That " " that "]
                     [" To " " to "]
                     [" Vs " " vs "]
                     [" With " " with "]
                     [" From " " from "]
                     ["'S " "'s "]
                     ]))
    (save-excursion
      (save-restriction
        (narrow-to-region *begin *end)
        (upcase-initials-region (point-min) (point-max))
        (let ((case-fold-search nil))
          (mapc
           (lambda (-x)
             (goto-char (point-min))
             (while
                 (search-forward (aref -x 0) nil t)
               (replace-match (aref -x 1) 'FIXEDCASE 'LITERAL)))
           -strPairs))))))


;; insertion commands

(defun xah-insert-date ()
  "Insert current date and or time.
Insert date in this format: yyyy-mm-dd.
When called with `universal-argument', prompt for a format to use.
If there's text selection, delete it first.

Do not use this function in lisp code. Call `format-time-string' directly.

URL `http://ergoemacs.org/emacs/elisp_insert-date-time.html'
version 2016-10-11"
  (interactive)
  (when (use-region-p) (delete-region (region-beginning) (region-end)))
  (let ((-style
         (if current-prefix-arg
             (string-to-number
              (substring
               (ido-completing-read
                "Style:"
                '(
                  "1 â†’ 2016-10-10 Monday"
                  "2 â†’ 2016-10-10T19:39:47-07:00"
                  "3 â†’ 2016-10-10 19:39:58-07:00"
                  "4 â†’ Monday, October 10, 2016"
                  "5 â†’ Mon, Oct 10, 2016"
                  "6 â†’ October 10, 2016"
                  "7 â†’ Oct 10, 2016"
                  )) 0 1))
           0
           )))
    (insert
     (cond
      ((= -style 0)
       (format-time-string "%Y-%m-%d") ; "2016-10-10"
       )
      ((= -style 1)
       (format-time-string "%Y-%m-%d %A") ; "2016-10-10 Monday"
       )
      ((= -style 2)
       (concat
        (format-time-string "%Y-%m-%dT%T")
        ((lambda (-x) (format "%s:%s" (substring -x 0 3) (substring -x 3 5))) (format-time-string "%z")))
       ;; "2016-10-10T19:02:23-07:00"
       )
      ((= -style 3)
       (concat
        (format-time-string "%Y-%m-%d %T")
        ((lambda (-x) (format "%s:%s" (substring -x 0 3) (substring -x 3 5))) (format-time-string "%z")))
       ;; "2016-10-10 19:10:09-07:00"
       )
      ((= -style 4)
       (format-time-string "%A, %B %d, %Y")
       ;; "Monday, October 10, 2016"
       )
      ((= -style 5)
       (format-time-string "%a, %b %d, %Y")
       ;; "Mon, Oct 10, 2016"
       )
      ((= -style 6)
       (format-time-string "%B %d, %Y")
       ;; "October 10, 2016"
       )
      ((= -style 7)
       (format-time-string "%b %d, %Y")
       ;; "Oct 10, 2016"
       )
      (t
       (format-time-string "%Y-%m-%d"))))))

;; (defun xah-current-date-time-string ()
;;   "Returns current date-time string in full ISO 8601 format.
;; Example: ã€Œ2012-04-05T21:08:24-07:00ã€.

;; Note, for the time zone offset, both the formats ã€Œhhmmã€ and ã€Œhh:mmã€ are valid ISO 8601. However, Atom Webfeed spec seems to require ã€Œhh:mmã€."
;;   (concat
;;    (format-time-string "%Y-%m-%dT%T")
;;    ((lambda (-x) (format "%s:%s" (substring -x 0 3) (substring -x 3 5))) (format-time-string "%z"))))

(defun xah-insert-bracket-pair (*left-bracket *right-bracket &optional *wrap-method)
  "Insert brackets around selection, word, at point, and maybe move cursor in between.

If there's a text selection, wrap brackets around it.

If there's no text selection, and *wrap-method is non-nil,

 *wrap-method must be either 'line or 'block.
 'block means between empty lines.

 If *wrap-method is nil, then

 if cursor is inside a word, wrap brackets around it

 xyâ–®z â†’ (xyz)

If cursor is at end of a word, one of the following will happen:

 xyzâ–® â†’ xyz()
 xyzâ–® â†’ (xyz)       if in one of the lisp modes.

*left-bracket and *right-bracket are strings.

URL `http://ergoemacs.org/emacs/elisp_insert_brackets_by_pair.html'
Version 2016-11-19"
  (if (use-region-p)
      (progn ; there's active region
        (let (
              (-p1 (region-beginning))
              (-p2 (region-end)))
          (goto-char -p2)
          (insert *right-bracket)
          (goto-char -p1)
          (insert *left-bracket)
          (goto-char (+ -p2 2))))
    (progn ; no text selection
      (let (-p1 -p2)
        (cond
         ((eq *wrap-method 'line)
          (setq -p1 (line-beginning-position) -p2 (line-end-position))
          (goto-char -p2)
          (insert *right-bracket)
          (goto-char -p1)
          (insert *left-bracket)
          (goto-char (+ -p2 (length *left-bracket))))
         ((eq *wrap-method 'block)
          (save-excursion
            (progn
              (if (re-search-backward "\n[ \t]*\n" nil 'move)
                  (progn (re-search-forward "\n[ \t]*\n")
                         (setq -p1 (point)))
                (setq -p1 (point)))
              (if (re-search-forward "\n[ \t]*\n" nil 'move)
                  (progn (re-search-backward "\n[ \t]*\n")
                         (setq -p2 (point)))
                (setq -p2 (point))))
            (goto-char -p2)
            (insert *right-bracket)
            (goto-char -p1)
            (insert *left-bracket)
            (goto-char (+ -p2 (length *left-bracket)))))
         ((eq (point) (line-beginning-position))
          (insert *left-bracket )
          (end-of-line)
          (insert  *right-bracket))
         ((and
           (or ; cursor is at end of word or buffer. i.e. xyzâ–®
            (looking-at "[^-_[:alnum:]]")
            (eq (point) (point-max)))
           (not (or
                 (eq major-mode 'xah-elisp-mode)
                 (eq major-mode 'emacs-lisp-mode)
                 (eq major-mode 'lisp-mode)
                 (eq major-mode 'lisp-interaction-mode)
                 (eq major-mode 'common-lisp-mode)
                 (eq major-mode 'clojure-mode)
                 (eq major-mode 'xah-clojure-mode)
                 (eq major-mode 'scheme-mode))))
          (progn
            (setq -p1 (point) -p2 (point))
            (insert *left-bracket *right-bracket)
            (search-backward *right-bracket )))
         (t (progn
              ;; wrap around â€œwordâ€. basically, want all alphanumeric, plus hyphen and underscore, but don't want space or punctuations. Also want chinese chars
              ;; æˆ‘æœ‰ä¸€å¸˜å¹½æ¢¦ï¼Œä¸çŸ¥ä¸Žè°èƒ½å…±ã€‚å¤šå°‘ç§˜å¯†åœ¨å…¶ä¸­ï¼Œæ¬²è¯‰æ— äººèƒ½æ‡‚ã€‚
              (skip-chars-backward "-_[:alnum:]")
              (setq -p1 (point))
              (skip-chars-forward "-_[:alnum:]")
              (setq -p2 (point))
              (goto-char -p2)
              (insert *right-bracket)
              (goto-char -p1)
              (insert *left-bracket)
              (goto-char (+ -p2 (length *left-bracket))))))))))

(defun xah-insert-paren () (interactive) (xah-insert-bracket-pair "(" ")") )
(defun xah-insert-square-bracket () (interactive) (xah-insert-bracket-pair "[" "]") )
(defun xah-insert-brace () (interactive) (xah-insert-bracket-pair "{" "}") )

(defun xah-insert-double-curly-quoteâ€œâ€ () (interactive) (xah-insert-bracket-pair "â€œ" "â€") )
(defun xah-insert-curly-single-quoteâ€˜â€™ () (interactive) (xah-insert-bracket-pair "â€˜" "â€™") )
(defun xah-insert-single-angle-quoteâ€¹â€º () (interactive) (xah-insert-bracket-pair "â€¹" "â€º") )
(defun xah-insert-double-angle-quoteÂ«Â» () (interactive) (xah-insert-bracket-pair "Â«" "Â»") )
(defun xah-insert-ascii-double-quote () (interactive) (xah-insert-bracket-pair "\"" "\"") )
(defun xah-insert-ascii-single-quote () (interactive) (xah-insert-bracket-pair "'" "'") )
(defun xah-insert-emacs-quote () (interactive) (xah-insert-bracket-pair "`" "'") )
(defun xah-insert-corner-bracketã€Œã€ () (interactive) (xah-insert-bracket-pair "ã€Œ" "ã€" ) )
(defun xah-insert-white-corner-bracketã€Žã€ () (interactive) (xah-insert-bracket-pair "ã€Ž" "ã€") )
(defun xah-insert-angle-bracketã€ˆã€‰ () (interactive) (xah-insert-bracket-pair "ã€ˆ" "ã€‰") )
(defun xah-insert-double-angle-bracketã€Šã€‹ () (interactive) (xah-insert-bracket-pair "ã€Š" "ã€‹") )
(defun xah-insert-white-lenticular-bracketã€–ã€— () (interactive) (xah-insert-bracket-pair "ã€–" "ã€—") )
(defun xah-insert-black-lenticular-bracketã€ã€‘ () (interactive) (xah-insert-bracket-pair "ã€" "ã€‘") )
(defun xah-insert-tortoise-shell-bracketã€”ã€• () (interactive) (xah-insert-bracket-pair "ã€”" "ã€•" ) )

(defun xah-insert-hyphen ()
  "Insert a hyphen character."
  (interactive)
  (insert "-"))

(defun xah-insert-string-assignment ()
  "Insert space before cursor"
  (interactive)
  (progn (insert "=\"\"")
         (left-char)))

(defun xah-insert-space-before ()
  "Insert space before cursor"
  (interactive)
  (insert " "))

(defun xah-insert-space-after ()
  "Insert space after cursor"
  (interactive)
  (insert " ")
  (left-char))

(defun xah-insert-form-feed ()
  "insert a form feed char (ASCII 12)"
  (interactive)
  (insert ""))

(defun xah-insert-column-counter (*n)
  "Insert a sequence of numbers vertically.

 (this command is similar to emacs 24.x's `rectangle-number-lines'.)

For example, if your text is:

a b
c d
e f

and your cursor is after â€œaâ€, then calling this function with argument
3 will change it to become:

a1 b
c2 d
e3 f

If there are not enough existing lines after the cursor
when this function is called, it aborts at the last line.

This command is conveniently used together with `kill-rectangle' and `string-rectangle'."
  (interactive "nEnter the max integer: ")
  (let ((-i 1) -colpos )
    (setq -colpos (- (point) (line-beginning-position)))
    (while (<= -i *n)
      (insert (number-to-string -i))
      (forward-line) (beginning-of-line) (forward-char -colpos)
      (setq -i (1+ -i)))))

(defun xah-insert-alphabets-az (&optional *use-uppercase-p)
  "Insert letters a to z vertically.
If `universal-argument' is called first, use CAPITAL letters.

URL `http://ergoemacs.org/emacs/emacs_insert-alphabets.html'
Version 2015-11-06"
  (interactive "P")
  (let ((-startChar (if *use-uppercase-p 65 97 )))
    (dotimes (-i 26)
      (insert (format "%c\n" (+ -startChar -i))))))

(defvar xah-unicode-list nil "Associative list of Unicode symbols. First element is a Unicode character, second element is a string used as key shortcut in `ido-completing-read'")
(setq xah-unicode-list
      '(
        ("_" . "underscore" )
        ("â€¢" . ".bullet" )
        ("â†’" . "tn")
        ("â—‡" . "3" )
        ("â—†" . "4" )
        ("Â¤" . "2" )
        ("â€¦" . "...ellipsis" )
        ("Â " . "nbsp" )
        ("ã€" . "," )
        ("â­‘" . "9" )
        ("ðŸŽ¶" . "5" )
        ("â€”" . "-emdash" )
        ("ï¼†" . "7" )
        ("â†“" . "tt")
        ("â†" . "th")
        ("â†‘" . "tc")
        ("ðŸ‘" . "tu")
        ) )

(defun xah-insert-unicode ()
  "Insert a unicode"
  (interactive)
  (let (gotThis)
    (setq gotThis
          (ido-completing-read "insert:" (mapcar (lambda (x) (concat (car x) (cdr x))) xah-unicode-list)))
    (insert (car (assoc (substring gotThis 0 1) xah-unicode-list)))))


;; text selection

(defun xah-select-current-block ()
  "Select the current block of text between blank lines.

URL `http://ergoemacs.org/emacs/modernization_mark-word.html'
Version 2016-07-22"
  (interactive)
  (let (-p1)
    (progn
      (if (re-search-backward "\n[ \t]*\n" nil "move")
          (progn (re-search-forward "\n[ \t]*\n")
                 (setq -p1 (point)))
        (setq -p1 (point)))
      (re-search-forward "\n[ \t]*\n" nil "move"))
    (set-mark -p1)))

(defun xah-select-block ()
  "Select the current/next block of text between blank lines.
If region is active, extend selection downward by block.

URL `http://ergoemacs.org/emacs/modernization_mark-word.html'
Version 2016-07-22"
  (interactive)
  (if (region-active-p)
      (re-search-forward "\n[ \t]*\n" nil "move")
    (xah-select-current-block)))

(defun xah-select-current-line ()
  "Select current line.
URL `http://ergoemacs.org/emacs/modernization_mark-word.html'
Version 2016-07-22"
  (interactive)
  (end-of-line)
  (set-mark (line-beginning-position)))

(defun xah-select-line ()
  "Select current line. If region is active, extend selection downward by line.
URL `http://ergoemacs.org/emacs/modernization_mark-word.html'
Version 2016-07-22"
  (interactive)
  (if (region-active-p)
      (progn
        (forward-line 1)
        (end-of-line))
    (xah-select-current-line)))

(defun xah-semnav-up (arg)
"Called by `xah-extend-selection'.

URL `http://ergoemacs.org/emacs/modernization_mark-word.html'
Version 2015-11-13.
Written by Nikolaj Schumacher, 2008-10-20. Released under GPL 2"
  (interactive "p")
  (when (nth 3 (syntax-ppss))
    (if (> arg 0)
        (progn
          (skip-syntax-forward "^\"")
          (goto-char (1+ (point)))
          (setq arg (1- arg) ))
      (skip-syntax-backward "^\"")
      (goto-char (1- (point)))
      (setq arg (1+ arg) )))
  (up-list arg))

(defun xah-extend-selection (arg &optional incremental-p)
  "Select the current word.
Subsequent calls expands the selection to larger semantic unit.

This command works mostly in lisp syntax.
URL `http://ergoemacs.org/emacs/modernization_mark-word.html'
Version 2015-11-13.
Written by Nikolaj Schumacher, 2008-10-20. Released under GPL 2."
  (interactive
   (list (prefix-numeric-value current-prefix-arg)
         (or (use-region-p)
             (eq last-command this-command))))
  (if incremental-p
      (progn
        (xah-semnav-up (- arg))
        (forward-sexp)
        (mark-sexp -1))
    (if (> arg 1)
        (xah-extend-selection (1- arg) t)
      (if (looking-at "\\=\\(\\s_\\|\\sw\\)*\\_>")
          (goto-char (match-end 0))
        (unless (memq (char-before) '(?\) ?\"))
          (forward-sexp)))
      (mark-sexp -1))))

(defun xah-select-text-in-quote ()
  "Select text between the nearest left and right delimiters.
Delimiters here includes the following chars: \"<>(){}[]â€œâ€â€˜â€™â€¹â€ºÂ«Â»ã€Œã€ã€Žã€ã€ã€‘ã€–ã€—ã€Šã€‹ã€ˆã€‰ã€”ã€•ï¼ˆï¼‰
This command does not properly deal with nested brackets.
URL `http://ergoemacs.org/emacs/modernization_mark-word.html'
Version 2015-05-16"
  (interactive)
  (let (
        (-skipChars
         (if (boundp 'xah-brackets)
             (concat "^\"" xah-brackets)
           "^\"<>(){}[]â€œâ€â€˜â€™â€¹â€ºÂ«Â»ã€Œã€ã€Žã€ã€ã€‘ã€–ã€—ã€Šã€‹ã€ˆã€‰ã€”ã€•ï¼ˆï¼‰"))
        -p1
        -p2
        )
    (skip-chars-backward -skipChars)
    (setq -p1 (point))
    (skip-chars-forward -skipChars)
    (setq -p2 (point))
    (set-mark -p1)))


;; misc

(defun xah-user-buffer-q ()
  "Return t if current buffer is a user buffer, else nil.
Typically, if buffer name starts with *, it's not considered a user buffer.
This function is used by buffer switching command and close buffer command, so that next buffer shown is a user buffer.
You can override this function to get your idea of â€œuser bufferâ€.
version 2016-06-18"
  (interactive)
  (if (string-equal "*" (substring (buffer-name) 0 1))
      nil
    (if (string-equal major-mode "dired-mode")
        nil
      t
      )))

(defun xah-next-user-buffer ()
  "Switch to the next user buffer.
â€œuser bufferâ€ is determined by `xah-user-buffer-q'.
URL `http://ergoemacs.org/emacs/elisp_next_prev_user_buffer.html'
Version 2016-06-19"
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (< i 20)
      (if (not (xah-user-buffer-q))
          (progn (next-buffer)
                 (setq i (1+ i)))
        (progn (setq i 100))))))

(defun xah-previous-user-buffer ()
  "Switch to the previous user buffer.
â€œuser bufferâ€ is determined by `xah-user-buffer-q'.
URL `http://ergoemacs.org/emacs/elisp_next_prev_user_buffer.html'
Version 2016-06-19"
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (< i 20)
      (if (not (xah-user-buffer-q))
          (progn (previous-buffer)
                 (setq i (1+ i)))
        (progn (setq i 100))))))

(defun xah-next-emacs-buffer ()
  "Switch to the next emacs buffer.
â€œemacs bufferâ€ here is buffer whose name starts with *.
URL `http://ergoemacs.org/emacs/elisp_next_prev_user_buffer.html'
Version 2016-06-19"
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (and (not (string-equal "*" (substring (buffer-name) 0 1))) (< i 20))
      (setq i (1+ i)) (next-buffer))))

(defun xah-previous-emacs-buffer ()
  "Switch to the previous emacs buffer.
â€œemacs bufferâ€ here is buffer whose name starts with *.
URL `http://ergoemacs.org/emacs/elisp_next_prev_user_buffer.html'
Version 2016-06-19"
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (and (not (string-equal "*" (substring (buffer-name) 0 1))) (< i 20))
      (setq i (1+ i)) (previous-buffer))))

(defvar xah-recently-closed-buffers nil "alist of recently closed buffers. Each element is (buffer name, file path). The max number to track is controlled by the variable `xah-recently-closed-buffers-max'.")

(defvar xah-recently-closed-buffers-max 40 "The maximum length for `xah-recently-closed-buffers'.")

(defun xah-close-current-buffer ()
  "Close the current buffer.

Similar to `kill-buffer', with the following addition:

â€¢ Prompt user to save if the buffer has been modified even if the buffer is not associated with a file.
â€¢ If the buffer is editing a source file in an org-mode file, prompt the user to save before closing.
â€¢ If the buffer is a file, add the path to the list `xah-recently-closed-buffers'.
â€¢ If it is the minibuffer, exit the minibuffer

URL `http://ergoemacs.org/emacs/elisp_close_buffer_open_last_closed.html'
Version 2016-06-19"
  (interactive)
  (let (-emacs-buff-p
        (-org-p (string-match "^*Org Src" (buffer-name))))

    (setq -emacs-buff-p (if (string-match "^*" (buffer-name)) t nil))

    (if (string= major-mode "minibuffer-inactive-mode")
        (minibuffer-keyboard-quit) ; if the buffer is minibuffer
      (progn
        ;; offer to save buffers that are non-empty and modified, even for non-file visiting buffer. (because kill-buffer does not offer to save buffers that are not associated with files)
        (when (and (buffer-modified-p)
                   (not -emacs-buff-p)
                   (not (string-equal major-mode "dired-mode"))
                   (if (equal (buffer-file-name) nil)
                       (if (string-equal "" (save-restriction (widen) (buffer-string))) nil t)
                     t))
          (if (y-or-n-p (format "Buffer %s modified; Do you want to save? " (buffer-name)))
              (save-buffer)
            (set-buffer-modified-p nil)))
        (when (and (buffer-modified-p)
                   -org-p)
          (if (y-or-n-p (format "Buffer %s modified; Do you want to save? " (buffer-name)))
              (org-edit-src-save)
            (set-buffer-modified-p nil)))

        ;; save to a list of closed buffer
        (when (buffer-file-name)
          (setq xah-recently-closed-buffers
                (cons (cons (buffer-name) (buffer-file-name)) xah-recently-closed-buffers))
          (when (> (length xah-recently-closed-buffers) xah-recently-closed-buffers-max)
            (setq xah-recently-closed-buffers (butlast xah-recently-closed-buffers 1))))

        ;; close
        (kill-buffer (current-buffer))))))

(defun xah-open-last-closed ()
  "Open the last closed file.
URL `http://ergoemacs.org/emacs/elisp_close_buffer_open_last_closed.html'
Version 2016-06-19"
  (interactive)
  (if (> (length xah-recently-closed-buffers) 0)
      (find-file (cdr (pop xah-recently-closed-buffers)))
    (progn (message "No recently close buffer in this session."))))

(defun xah-open-recently-closed ()
  "Open recently closed file.
Prompt for a choice.
URL `http://ergoemacs.org/emacs/elisp_close_buffer_open_last_closed.html'
Version 2016-06-19"
  (interactive)
  (find-file (ido-completing-read "open:" (mapcar (lambda (f) (cdr f)) xah-recently-closed-buffers))))

(defun xah-list-recently-closed ()
  "List recently closed file.
URL `http://ergoemacs.org/emacs/elisp_close_buffer_open_last_closed.html'
Version 2016-06-19"
  (interactive)
  (let ((-buf (generate-new-buffer "*recently closed*")))
    (switch-to-buffer -buf)
    (mapc (lambda (-f) (insert (cdr -f) "\n"))
          xah-recently-closed-buffers)))

(defun xah-new-empty-buffer ()
  "Open a new empty buffer.
URL `http://ergoemacs.org/emacs/emacs_new_empty_buffer.html'
Version 2016-08-11"
  (interactive)
  (let ((-buf (generate-new-buffer "untitled")))
    (switch-to-buffer -buf)
    (funcall initial-major-mode)
    (setq buffer-offer-save t)))

;; note: emacs won't offer to save a buffer that's
;; not associated with a file,
;; even if buffer-modified-p is true.
;; One work around is to define your own my-kill-buffer function
;; that wraps around kill-buffer, and check on the buffer modification
;; status to offer save
;; This custome kill buffer is close-current-buffer.



(defun xah-run-current-file ()
  "Execute the current file.
For example, if the current buffer is the file x.py, then it'll call ã€Œpython x.pyã€ in a shell.
The file can be Emacs Lisp, PHP, Perl, Python, Ruby, JavaScript, Bash, Ocaml, Visual Basic, TeX, Java, Clojure.
File suffix is used to determine what program to run.

If the file is modified or not saved, save it automatically before run.

URL `http://ergoemacs.org/emacs/elisp_run_current_file.html'
version 2016-01-28"
  (interactive)
  (let (
         (-suffix-map
          ;; (â€¹extensionâ€º . â€¹shell program nameâ€º)
          `(
            ("php" . "php")
            ("pl" . "perl")
            ("py" . "python")
            ("py3" . ,(if (string-equal system-type "windows-nt") "c:/Python32/python.exe" "python3"))
            ("rb" . "ruby")
            ("go" . "go run")
            ("js" . "node") ; node.js
            ("sh" . "bash")
            ("clj" . "java -cp /home/xah/apps/clojure-1.6.0/clojure-1.6.0.jar clojure.main")
            ("rkt" . "racket")
            ("ml" . "ocaml")
            ("vbs" . "cscript")
            ("tex" . "pdflatex")
            ("latex" . "pdflatex")
            ("java" . "javac")
            ;; ("pov" . "/usr/local/bin/povray +R2 +A0.1 +J1.2 +Am2 +Q9 +H480 +W640")
            ))
         -fname
         -fSuffix
         -prog-name
         -cmd-str)

    (when (null (buffer-file-name)) (save-buffer))
    (when (buffer-modified-p) (save-buffer))

    (setq -fname (buffer-file-name))
    (setq -fSuffix (file-name-extension -fname))
    (setq -prog-name (cdr (assoc -fSuffix -suffix-map)))
    (setq -cmd-str (concat -prog-name " \""   -fname "\""))

    (cond
     ((string-equal -fSuffix "el") (load -fname))
     ((string-equal -fSuffix "java")
      (progn
        (shell-command -cmd-str "*xah-run-current-file output*" )
        (shell-command
         (format "java %s" (file-name-sans-extension (file-name-nondirectory -fname))))))
     (t (if -prog-name
            (progn
              (message "Runningâ€¦")
              (shell-command -cmd-str "*xah-run-current-file output*" ))
          (message "No recognized program file suffix for this file."))))))

(defun xah-clean-empty-lines (&optional *begin *end *n)
  "Replace repeated blank lines to just 1.
Works on whole buffer or text selection, respects `narrow-to-region'.

*N is the number of newline chars to use in replacement.
If 0, it means lines will be joined.
By befault, *N is 2. It means, 1 visible blank line.

URL `http://ergoemacs.org/emacs/elisp_compact_empty_lines.html'
Version 2016-10-07"
  (interactive
   (if (region-active-p)
       (list (region-beginning) (region-end))
     (list (point-min) (point-max))))
  (when (null *begin)
    (setq *begin (point-min) *end (point-max)))
  (save-excursion
    (save-restriction
      (narrow-to-region *begin *end)
      (progn
        (goto-char (point-min))
        (while (search-forward-regexp "\n\n\n+" nil "noerror")
          (replace-match (make-string (if (null *n) 2 *n ) 10)))))))

(defun xah-clean-whitespace (&optional *begin *end)
  "Delete trailing whitespace, and replace repeated blank lines to just 1.
Only space and tab is considered whitespace here.
Works on whole buffer or text selection, respects `narrow-to-region'.

URL `http://ergoemacs.org/emacs/elisp_compact_empty_lines.html'
Version 2016-10-15"
  (interactive
   (if (region-active-p)
       (list (region-beginning) (region-end))
     (list (point-min) (point-max))))
  (when (null *begin)
    (setq *begin (point-min)  *end (point-max)))
  (save-excursion
    (save-restriction
      (narrow-to-region *begin *end)
      (progn
        (goto-char (point-min))
        (while (search-forward-regexp "[ \t]+\n" nil "noerror")
          (replace-match "\n")))
      (xah-clean-empty-lines (point-min) (point-max))
      (progn
        (goto-char (point-max))
        (while (equal (char-before) 32) ; char 32 is space
          (delete-char -1))))))

(defun cibin/xah-make-backup ()
  "Make a backup copy of current file or dired marked files.
If in dired, backup current file or marked files.
The backup file name is
 â€¹nameâ€º~â€¹timestampâ€º~
example:
 file.html~20150721T014457~
in the same dir. If such a file already exist, it's overwritten.
If the current buffer is not associated with a file, nothing's done.
URL `http://ergoemacs.org/emacs/elisp_make-backup.html'
Version 2015-10-14"
  (interactive)
  (let ((-fname (buffer-file-name)))
    (if -fname
        (let ((-backup-name
               (concat -fname "~" (format-time-string "backup %d-%b-%Y %Hh %Mm %Ss") "~")))
          (copy-file -fname -backup-name t)
          (message (concat "Backup saved at: " -backup-name)))
      (if (string-equal major-mode "dired-mode")
          (progn
            (mapc (lambda (-x)
                    (let ((-backup-name
                           (concat -x "~" (format-time-string "backup %d-%b-%Y %Hh %Mm %Ss") "~")))
                      (copy-file -x -backup-name t)))
                  (dired-get-marked-files))
            (message "marked files backed up"))
        (user-error "buffer not file nor dired")))))

(defun xah-make-backup-and-save ()
  "Backup of current file and save, or backup dired marked files.
For detail, see `xah-make-backup'.
If the current buffer is not associated with a file nor dired, nothing's done.
URL `http://ergoemacs.org/emacs/elisp_make-backup.html'
Version 2015-10-14"
  (interactive)
  (if (buffer-file-name)
      (progn
        (cibin/xah-make-backup)
        (when (buffer-modified-p)
          (save-buffer)))
    (progn
      (cibin/xah-make-backup))))

(defun xah-delete-current-file-make-backup (&optional *no-backup-p)
  "Delete current file, makes a backup~, closes the buffer.

Backup filename is â€œâ€¹nameâ€º~â€¹date time stampâ€º~â€. Existing file of the same name is overwritten. If the file is not associated with buffer, the backup file name starts with â€œxx_â€.

When `universal-argument' is called first, don't create backup.

URL `http://ergoemacs.org/emacs/elisp_delete-current-file.html'
Version 2016-07-20"
  (interactive "P")
  (let* (
         (-fname (buffer-file-name))
         (-buffer-is-file-p -fname)
         (-backup-suffix (concat "~" (format-time-string "%Y%m%dT%H%M%S") "~")))
    (if -buffer-is-file-p
        (progn
          (save-buffer -fname)
          (when (not *no-backup-p)
            (copy-file
             -fname
             (concat -fname -backup-suffix)
             t))
          (delete-file -fname)
          (message "Deleted. Backup created at ã€Œ%sã€." (concat -fname -backup-suffix)))
      (when (not *no-backup-p)
        (widen)
        (write-region (point-min) (point-max) (concat "xx" -backup-suffix))
        (message "Backup created at ã€Œ%sã€." (concat "xx" -backup-suffix))))
    (kill-buffer (current-buffer))))

(defun xah-delete-current-file-copy-to-kill-ring ()
  "Delete current buffer/file and close the buffer, push content to `kill-ring'.
URL `http://ergoemacs.org/emacs/elisp_delete-current-file.html'
Version 2016-09-03"
  (interactive)
  (let ((-bstr (buffer-string)))
    (when (> (length -bstr) 0)
      (kill-new -bstr)
      (message "Buffer content copied to kill-ring."))
    (when (buffer-file-name)
      (when (file-exists-p (buffer-file-name))
        (progn
          (delete-file (buffer-file-name))
          (message "Deleted file: ã€Œ%sã€." (buffer-file-name)))))
    (let ((buffer-offer-save nil))
      (set-buffer-modified-p nil)
      (kill-buffer (current-buffer)))))

(defun xah-delete-current-file (&optional *no-backup-p)
  "Delete current buffer/file.
If buffer is a file, makes a backup~, else, push file content to `kill-ring'.

This commands calls `xah-delete-current-file-make-backup' or
 `xah-delete-current-file-copy-to-kill-ring'.

If next buffer is dired, refresh it.

URL `http://ergoemacs.org/emacs/elisp_delete-current-file.html'
Version 2016-07-20"
  (interactive "P")
  (if (buffer-file-name)
      (xah-delete-current-file-make-backup *no-backup-p)
    (xah-delete-current-file-copy-to-kill-ring))
  (when (eq major-mode 'dired-mode)
    (revert-buffer)))



(defun xah-search-current-word ()
  "Call `isearch' on current word or text selection.
â€œwordâ€ here is A to Z, a to z, and hyphen ã€Œ-ã€ and underline ã€Œ_ã€, independent of syntax table.
URL `http://ergoemacs.org/emacs/modernization_isearch.html'
Version 2015-04-09"
  (interactive)
  (let ( -p1 -p2 )
    (if (use-region-p)
        (progn
          (setq -p1 (region-beginning))
          (setq -p2 (region-end)))
      (save-excursion
        (skip-chars-backward "-_A-Za-z0-9")
        (setq -p1 (point))
        (right-char)
        (skip-chars-forward "-_A-Za-z0-9")
        (setq -p2 (point))))
    (setq mark-active nil)
    (when (< -p1 (point))
      (goto-char -p1))
    (isearch-mode t)
    (isearch-yank-string (buffer-substring-no-properties -p1 -p2))))

(defun xah-open-in-desktop ()
  "Show current file in desktop (OS's file manager).
URL `http://ergoemacs.org/emacs/emacs_dired_open_file_in_ext_apps.html'
Version 2015-11-30"
  (interactive)
  (cond
   ((string-equal system-type "windows-nt")
    (w32-shell-execute "explore" (replace-regexp-in-string "/" "\\" default-directory t t)))
   ((string-equal system-type "darwin") (shell-command "open ."))
   ((string-equal system-type "gnu/linux")
    (let (
          (process-connection-type nil)
          (openFileProgram (if (file-exists-p "/usr/bin/gvfs-open")
                               "/usr/bin/gvfs-open"
                             "/usr/bin/xdg-open")))
      (start-process "" nil openFileProgram "."))
    ;; (shell-command "xdg-open .") ;; 2013-02-10 this sometimes froze emacs till the folder is closed. eg with nautilus
    )))

(defun xah-open-in-external-app ()
  "Open the current file or dired marked files in external app.
The app is chosen from your OS's preference.
URL `http://ergoemacs.org/emacs/emacs_dired_open_file_in_ext_apps.html'
Version 2016-10-15"
  (interactive)
  (let* (
         (-file-list
          (if (string-equal major-mode "dired-mode")
              (dired-get-marked-files)
            (list (buffer-file-name))))
         (-do-it-p (if (<= (length -file-list) 5)
                       t
                     (y-or-n-p "Open more than 5 files? "))))
    (when -do-it-p
      (cond
       ((string-equal system-type "windows-nt")
        (mapc
         (lambda (-fpath)
           (w32-shell-execute "open" (replace-regexp-in-string "/" "\\" -fpath t t))) -file-list))
       ((string-equal system-type "darwin")
        (mapc
         (lambda (-fpath)
           (shell-command
            (concat "open " (shell-quote-argument -fpath))))  -file-list))
       ((string-equal system-type "gnu/linux")
        (mapc
         (lambda (-fpath) (let ((process-connection-type nil))
                            (start-process "" nil "xdg-open" -fpath))) -file-list))))))

(defun xah-open-in-terminal ()
  "Open the current dir in a new terminal window.
URL `http://ergoemacs.org/emacs/emacs_dired_open_file_in_ext_apps.html'
Version 2015-12-10"
  (interactive)
  (cond
   ((string-equal system-type "windows-nt")
    (message "Microsoft Windows not supported. File a bug report or pull request."))
   ((string-equal system-type "darwin")
    (message "Mac not supported. File a bug report or pull request."))
   ((string-equal system-type "gnu/linux")
    (let ((process-connection-type nil))
      (start-process "" nil "x-terminal-emulator"
                     (concat "--working-directory=" default-directory) )))))

(defun xah-next-window-or-frame ()
  "Switch to next window or frame.
If current frame has only one window, switch to next frame.
If `universal-argument' is called first, do switch frame."
  (interactive)
  (if (null current-prefix-arg)
      (if (one-window-p)
          (other-frame 1)
        (other-window 1))
    (other-frame 1)))

(defun xah-describe-major-mode ()
  "Display inline doc for current `major-mode'."
  (interactive)
  (describe-function major-mode))



(setq xah-dvorak-to-qwerty-kmap
      '(
        ("a" . "a")
        ("b" . "n")
        ("c" . "i")
        ("d" . "h")
        ("e" . "d")
        ("f" . "y")
        ("g" . "u")
        ("h" . "j")
        ("i" . "g")
        ("j" . "c")
        ("k" . "v")
        ("l" . "p")
        ("m" . "m")
        ("n" . "l")
        ("o" . "s")
        ("p" . "r")
        ("q" . "x")
        ("r" . "o")
        ("s" . ";")
        ("t" . "k")
        ("u" . "f")
        ("v" . ".")
        ("w" . ",")
        ("x" . "b")
        ("y" . "t")
        ("z" . "/")
        ("." . "e")
        ("," . "w")
        ("'" . "q")
        (";" . "z")
        ("/" . "[")
        ("[" . "-")
        ("]" . "=")
        ("=" . "]")
        ("-" . "'")))

(defun xah-dvorak-to-qwerty (charstr)
  "Convert dvorak key to qwerty. charstr is single char string."
  (interactive)
  (cdr (assoc charstr xah-dvorak-to-qwerty-kmap)))

(defun xah-qwerty-to-dvorak (charstr)
  "Convert qwerty key to dvorak. charstr is single char string."
  (interactive)
  (car (rassoc charstr xah-dvorak-to-qwerty-kmap)))

(defun xah-fly-map-keys (*kmap-name *key-cmd-alist)
  "similar to `define-key' but map over a alist."
  (interactive)
  (mapc
   (lambda (-pair)
     (define-key *kmap-name (xah-fly-kbd (car -pair)) (cdr -pair)))
   *key-cmd-alist))

(defun xah-fly-kbd (*arg)
  "similar to `kbd' but are translated to current `xah-fly-key-layout' first,
*arg must be a single char."
  (interactive)
  (if (or (null xah-fly-key-layout)
          (string-equal xah-fly-key-layout "dvorak"))
      (kbd *arg)
    (progn (kbd (xah-dvorak-to-qwerty *arg)))))

(defun xah-dired-sort ()
  "Sort dired dir listing in different ways.
Prompt for a choice.
URL `http://ergoemacs.org/emacs/dired_sort.html'
Version 2015-07-30"
  (interactive)
  (let (-sort-by -arg)
    (setq -sort-by (ido-completing-read "Sort by:" '( "date" "size" "name" "dir")))
    (cond
     ((equal -sort-by "name") (setq -arg "-Al --si --time-style long-iso "))
     ((equal -sort-by "date") (setq -arg "-Al --si --time-style long-iso -t"))
     ((equal -sort-by "size") (setq -arg "-Al --si --time-style long-iso -S"))
     ((equal -sort-by "dir") (setq -arg "-Al --si --time-style long-iso --group-directories-first"))
     (t (error "logic error 09535" )))
(dired-sort-other -arg )))

(provide 'cbn-xah-fly-keys-functions)