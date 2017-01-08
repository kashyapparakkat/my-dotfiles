; http://amitp.blogspot.in/2011/08/emacs-custom-mode-line.html#more

; todo: length of this line
; enhanced status bar(slower) show count of occurence of present word
;; Mode line setup


(defvar my-mode-line-buffer-line-count nil)
(make-variable-buffer-local 'my-mode-line-buffer-line-count)



(setq-default
 mode-line-format
 '( 
			  "%e" mode-line-front-space
			  "%n " ; narrow
			  ; "%Z "
                ;; Standard info about the current buffer
                mode-line-mule-info
                mode-line-client
                ; mode-line-modified
   ; read-only or modified status
   (:eval
    (cond (buffer-read-only
           (propertize " RO  " 'face 'mode-line-read-only-face))
          ((buffer-modified-p)
           (propertize " *** " 'face 'mode-line-modified-face))
          (t "       ")))
		mode-line-remote
    " | "
	; show percentage
    (-4 "%p%")
    " L%l"

	 (:eval 
                         (let ((str ""))
                           (when (and (not (buffer-modified-p)) my-mode-line-buffer-line-count)
                             (setq str (concat str "/" my-mode-line-buffer-line-count)))
                           str))
                                        ; show column number
   ":"
   (:eval (propertize "%3c" 'face
                      (if (>= (current-column) 80)
                          'mode-line-80col-face
                        'mode-line-position-face)))   

   " | "
	(:propertize "All: len %i %IB" face mode-line-stats-face)
	; (:eval 
		; (setq lineCount 0)
		; (setq lineCount (count-lines (point-min) (point-max)))
		; (propertize lineCount 'face 'mode-line-stats-face)
		; (propertize (format "lines: %s" lineCount) 'face 'mode-line-stats-face)
	; )
	
	; (size-indication-mode ("/" (-5 "%I")))QS
	; Position, including warning for 80 columns
	; (line-number-mode ("%4l" (column-number-mode ":%3c")))
   ;; (:propertize "%4l:" face mode-line-position-face)
						
						
	" | "						
  ; for selected text
	    (:eval 
		  ; (if (region-active-p)
		  (if (use-region-p)
			(progn 
				(setq posBegin (region-beginning))
				(setq posEnd (region-end))
				(setq wordCount 0)
				(goto-char posBegin)
				(while (and (< (point) posEnd)
					(re-search-forward "\\w+\\W*" posEnd t))
				(setq wordCount (1+ wordCount)))

				(setq lineCount (count-lines posBegin posEnd))
				(setq charCnt (- posEnd posBegin))

				 (propertize (format " Sel: C%s | L%s | W%s " charCnt lineCount wordCount) 'face 'mode-line-selection-face)
			 
			 )))
			" "	
   ; emacsclient [default -- keep?]
   mode-line-client
   "  "
   "    "
   ; directory and buffer/file name
   (:propertize (:eval (shorten-directory default-directory 60))
                face mode-line-folder-face)
   (:propertize "%b"
                face mode-line-filename-face)
			  " %s " ; subprocess status
 
   ; mode indicators: vc, recursive edit, major mode, minor modes, process, global
   (vc-mode vc-mode)
   (flycheck-mode flycheck-mode-line) ; Flycheck status
   "  %["
   (:propertize mode-name
                face mode-line-mode-face)
   "%] "
   (:eval (propertize (format-mode-line minor-mode-alist)
                      'face 'mode-line-minor-mode-face))
   (:propertize mode-line-process
                face mode-line-process-face)
   (global-mode-string global-mode-string)
   
	(multiple-cursors-mode mc/mode-line) ; Number of cursors
   "    "
   ; nyan-mode uses nyan cat as an alternative to %p
   ; (:eval (when nyan-mode (list (nyan-create))))
   ))
(defvar jep:modeline-subs
  '(
    ("C:/Users/cibin/Downloads" . "Downloads/")
    ("c:/Users/cibin/" . "HOME/")    
    ("c:/Users/cibin/Desktop/" . "Desktop/")    
    ("c:/cbn_gits/AHK/" . "AHK")    
    ("/$" . "")
    ))
 
(defun jep:modeline-dir-abbrev (output)
  (str-replace-all output jep:modeline-subs))
 
 (defun str-replace-all (str pats)
  (if (null pats)
      str
    (let* ((pat (car pats))
       (lhs (car pat))
       (rhs (cdr pat)))
      (replace-regexp-in-string lhs rhs (str-replace-all str (cdr pats))))))

;; Helper function
(defun shorten-directory (dir max-length)
  "Show up to `max-length' characters of a directory name `dir'."
  (let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
        (output ""))
    (when (and path (equal "" (car path)))
      (setq path (cdr path)))
    (while (and path (< (length output) (- max-length 4)))
      (setq output (concat (car path) "/" output))
      (setq path (cdr path)))
    (when path
      (setq output (concat ".../" output))
	  
	  )
	  ; TODO
	  ; if dir is C:/users/username.... shorten it to HOME/
	  (setq output (jep:modeline-dir-abbrev output))
      (setq output (concat output "/"))
    output)
)
	
	
; if you update the line count all the time and have a large buffer it can make Emacs somewhat unresponsive since it's counting lines over and over. I wrote this to take a lazy approach to counting: it only does it when the file is first read in or after you save/revert it. If the buffer is modified it doesn't lie about the line count, it simply isn't shown until you save again.
; http://stackoverflow.com/a/8191130
	(defun my-mode-line-count-lines ()
  (setq my-mode-line-buffer-line-count (int-to-string (count-lines (point-min) (point-max)))))
  
  
(add-hook 'find-file-hook 'my-mode-line-count-lines)
(add-hook 'after-save-hook 'my-mode-line-count-lines)
(add-hook 'after-revert-hook 'my-mode-line-count-lines)
(add-hook 'dired-after-readin-hook 'my-mode-line-count-lines)


;; Extra mode line faces
(make-face 'mode-line-read-only-face)
(make-face 'mode-line-modified-face)
(make-face 'mode-line-folder-face)
(make-face 'mode-line-filename-face)
(make-face 'mode-line-position-face)
(make-face 'mode-line-mode-face)
(make-face 'mode-line-minor-mode-face)
(make-face 'mode-line-process-face)
(make-face 'mode-line-80col-face)
(make-face 'mode-line-stats-face)
(make-face 'mode-line-selection-face)

(set-face-attribute 'mode-line nil
    :foreground "gray60" :background "gray20"
    :inverse-video nil
    :box '(:line-width 6 :color "gray20" :style nil))
(set-face-attribute 'mode-line-inactive nil
    :foreground "gray80" :background "gray40"
    :inverse-video nil
    :box '(:line-width 6 :color "gray40" :style nil))

(set-face-attribute 'mode-line-read-only-face nil
    :inherit 'mode-line-face
    :foreground "#4271ae"
    :box '(:line-width 2 :color "#4271ae"))
(set-face-attribute 'mode-line-modified-face nil
    :inherit 'mode-line-face
    :foreground "#c82829"
    :background "#ffffff"
    :box '(:line-width 2 :color "#c82829"))
(set-face-attribute 'mode-line-folder-face nil
    :inherit 'mode-line-face
    :foreground "gray60")
(set-face-attribute 'mode-line-filename-face nil
    :inherit 'mode-line-face
    :foreground "#eab700"
    :weight 'bold)
(set-face-attribute 'mode-line-stats-face nil
	:inherit 'mode-line-face
    :foreground "#eab700"
    :weight 'bold)
(set-face-attribute 'mode-line-position-face nil
    :inherit 'mode-line-face
    :family "Menlo" :height 90)
(set-face-attribute 'mode-line-mode-face nil
    :inherit 'mode-line-face
    :foreground "gray80")
(set-face-attribute 'mode-line-minor-mode-face nil
    :inherit 'mode-line-mode-face
    :foreground "gray40"
    :height 100)
(set-face-attribute 'mode-line-process-face nil
    :inherit 'mode-line-face
    :foreground "#718c00")
(set-face-attribute 'mode-line-80col-face nil
    :inherit 'mode-line-position-face
    :foreground "black" :background "#eab700")
(set-face-attribute 'mode-line-selection-face nil
    :inherit 'mode-line-position-face
    :foreground "black" :background "#ffb780")