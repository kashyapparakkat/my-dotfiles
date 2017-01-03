

; more customisations at https://www.emacswiki.org/emacs/TabBarMode
; Speed up by not using images

; Tabbar can slow down Emacs considerably, especially simply moving the cursor up or down. This can be rectified by adding this to your .emacs file, which makes Tabbar use characters to represent the three images in the top-left corner:

 (setq tabbar-use-images nil)

(require 'tabbar)
 (tabbar-mode)
 
 
; http://amitp.blogspot.in/2007/04/emacs-buffer-tabs.html
;; Note: for tabbar 2.0 use 
;; tabbar-default not tabbar-default-face,
;; tabbar-selected not tabbar-selected-face,
;; tabbar-button not tabbar-button-face,
;; tabbar-separator not tabbar-separator-face


(set-face-attribute
 'tabbar-default nil
 :background "gray60")

(set-face-attribute
 'tabbar-unselected nil
 :background "gray85"
 :foreground "gray30"
 :box nil)
(set-face-attribute
 'tabbar-selected nil
 :background "#f2f2f6"
 :foreground "black"
 :box nil)
(set-face-attribute
 'tabbar-button nil
 :box '(:line-width 1 :color "gray72" :style released-button))
(set-face-attribute
 'tabbar-separator nil
 :height 0.7)

 ; ===============================
 ;;; highlight-focus.el --- highlight the active buffer

;; Author: Amit J Patel <amitp@cs.stanford.edu>

;;; Commentary:
;; 
;; I find that I'm not good at tracking when focus changes across
;; apps, windows, and within a window. As much as possible, I try to
;; have all my applications somehow draw attention to what has
;; focus. In X11 I marked the focus in red. In Firefox I marked the
;; text fields in yellow. This Emacs package highlights the active
;; buffer. It's inspired by an earlier package I had written for
;; XEmacs, which changes the window color and modeline color for the
;; current window.
;;
;;; History:
;;
;; 2014-05-07: Updated to use the Emacs 24 focus-{in,out}-hook
;; 2013-05-10: Rewritten to use the Emacs 23 "remap faces" feature.
;; 2007-04-16: Initial version, temporarily highlighting the active buffer

;; Also see <https://github.com/emacsmirror/auto-dim-other-buffers>

;;; Code:

(require 'face-remap)
(defvar highlight-focus:last-buffer nil)
(defvar highlight-focus:cookie nil)
(defvar highlight-focus:background "white")
(defvar highlight-focus:app-has-focus t)

(defun highlight-focus:check ()
  "Check if focus has changed, and if so, update remapping."
  (let ((current-buffer (and highlight-focus:app-has-focus (current-buffer))))
    (unless (eq highlight-focus:last-buffer current-buffer)
      (when (and highlight-focus:last-buffer highlight-focus:cookie)
        (with-current-buffer highlight-focus:last-buffer
          (face-remap-remove-relative highlight-focus:cookie)))
      (setq highlight-focus:last-buffer current-buffer)
      (when current-buffer
        (setq highlight-focus:cookie
              (face-remap-add-relative 'default :background highlight-focus:background))))))

(defun highlight-focus:app-focus (state)
  (setq highlight-focus:app-has-focus state)
  (highlight-focus:check))

(defadvice other-window (after highlight-focus activate)
  (highlight-focus:check))
(defadvice select-window (after highlight-focus activate)
  (highlight-focus:check))
(defadvice select-frame (after highlight-focus activate)
  (highlight-focus:check))
(add-hook 'window-configuration-change-hook 'highlight-focus:check)

(add-hook 'focus-in-hook (lambda () (highlight-focus:app-focus t)))
(add-hook 'focus-out-hook (lambda () (highlight-focus:app-focus nil)))

(provide 'highlight-focus)

;;; highlight-focus.el ends here