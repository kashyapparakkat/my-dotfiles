; http://www.cibinmathew.com
; github.com/cibinmathew






(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-display-style 'fancy)
;;advise swiper to recenter on exit . The other tweak I have made is to get swiper to recenter the display when it exits – I found it a little unpredictable where the point was going to be after I finished swiper. This is done with a little bit of advice
(defun bjm-swiper-recenter (&rest args)
  "recenter display after swiper"
  (recenter)
  )
(advice-add 'swiper :after #'bjm-swiper-recenter)

(global-set-key (kbd "C-c C-r") 'ivy-resume)
; (global-set-key (kbd "<f6>") 'ivy-resume)
; (global-set-key (kbd "M-x") 'counsel-M-x)
; (global-set-key (kbd "C-x C-f") 'counsel-find-file)
; (global-set-key (kbd "<f1> f") 'counsel-describe-function)
; (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
; (global-set-key (kbd "<f1> l") 'counsel-find-library)
; (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
; (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
; (global-set-key (kbd "C-c g") 'counsel-git)
; (global-set-key (kbd "C-c j") 'counsel-git-grep)
; (global-set-key (kbd "C-c k") 'counsel-ag)
; (global-set-key (kbd "C-x l") 'counsel-locate)
; (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
; (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)



; https://www.emacswiki.org/emacs/SearchAtPoint

; If swiper is used, the following key bindings can be defined to simulate “*” in Vim with a better interface:
  (define-key evil-normal-state-map (kbd "*")
    (lambda () (interactive) (swiper (format "\\<%s\\>" (thing-at-point 'symbol)))))
  (define-key evil-normal-state-map (kbd "#")
    (lambda () (interactive) (swiper (format "\\<%s\\>" (thing-at-point 'word)))))
	


; Extending swiper
; With swiper, the following key bindings can be defined to insert the current symbol/word at point to the swiper minibuffer:
(define-key swiper-map (kbd "C-.")
  (lambda () (interactive) (insert (format "\\<%s\\>" (with-ivy-window (thing-at-point 'symbol))))))
(define-key swiper-map (kbd "M-.")
  (lambda () (interactive) (insert (format "\\<%s\\>" (with-ivy-window (thing-at-point 'word))))))	

                                        ; TODO
(global-set-key "\C-s" 'ora-swiper)	
(global-set-key "\C-s" 'avy-goto-char-timer)	
; ora-swiper is better than my-search-method-according-to-numlines
; (global-set-key "\C-s" 'my-search-method-according-to-numlines)

;;; remove ;; (global-set-key "\C-s" (lambda () (interactive) (swiper (format "\\<%s\\>" (thing-at-point 'word)))))

;; Use regex searches by default.
; (global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'vr/query-replace)
;; (define-key global-map (kbd "C-c l") 'vr/replace)
(define-key evil-normal-state-map (kbd "C-r") 'vr/query-replace)
(global-set-key (kbd "C-M-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-M-r") 'isearch-backward-regexp)

(global-set-key (kbd "M-s s") 'swiper-all)

;; Activate occur easily inside isearch
(define-key isearch-mode-map (kbd "C-o")
  (lambda () (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string (regexp-quote isearch-string))))))

	  
;; make isearch treat space dash underscore newline as same
(setq search-whitespace-regexp "[-_ \n]")
; put isearch-dabbrev.el somewhere in your load-path and add these lines to your .emacs:

(eval-after-load "isearch"
  '(progn
     (require 'isearch-dabbrev)
     (define-key isearch-mode-map (kbd "<tab>") 'isearch-dabbrev-expand)))
	
	
; http://karl-voit.at/2016/04/09/chosing-emacs-search-method/
 (defun my-search-method-according-to-numlines ()
    "Determines the number of lines of current buffer and chooses a search method accordingly"
    (interactive)
    (if (< (count-lines (point-min) (point-max)) 20000)
        (swiper)
      (isearch-forward)
      )
    )
(defun ora-swiper ()
  (interactive)
  (if (and (buffer-file-name)
           (not (ignore-errors
                  (file-remote-p (buffer-file-name))))
           (if (eq major-mode 'org-mode)
               (> (buffer-size) 60000)
             (> (buffer-size) 300000)))
      (progn
        (save-buffer)
        (counsel-grep))
    ;; swiper without default word
     (swiper--ivy (swiper--candidates))
; or
    ;; TODO autoselect word
    ;; (swiper (format "\\<%s\\>" (thing-at-point 'word)))
    ;; (swiper (format "%s" (thing-at-point 'word)))
	))

	
;; TODO
; (defun joe-duckduckgo-search (browser)
(defun joe-duckduckgo-search ()
  "Search DuckDuckGo from Emacs."
  ; (interactive)
  (setq myWord
	(if (region-active-p)
	(buffer-substring-no-properties (region-beginning) (region-end))
	(thing-at-point 'symbol)))
	


  
	
  (let ((search
        (concat "https://google.com/?q="
                (read-from-minibuffer "sDuckDuckGo: " myWord))))
				(message "%s" myWord)
    ; (if browser
        (browse-url search)
      (browse-web search)
	  ;)
	  ))
	  
	  

(global-set-key (kbd "M-s s") 'swiper-all)
;; TODO ;; (global-set-key (kbd "M-s r") ') ; recurse
(global-set-key (kbd "M-s h") 'cibin-search-in-files-advgrep-here)
(global-set-key (kbd "M-s c") 'cibin-search-in-common-files-bash)
(global-set-key (kbd "M-s p") 'ag-project-at-point)
(global-set-key (kbd "M-s o") 'occur)
; linked
(global-set-key (kbd "M-s l") 'cibin-search-in-text-files-related-bash)
(global-set-key (kbd "M-s /") 'my-multi-occur-in-matching-buffers)

(global-set-key (kbd "M-s a") 'helm-do-ag-buffers)
(global-set-key (kbd "M-s w") 'ag-files) ; advanced (string file-type directory))
(global-set-key (kbd "M-s y") 'cibin/ag-files-cwd) 
(global-set-key (kbd "M-s b") 'cibin/helm-do-ag-cwd)
(global-set-key (kbd "M-s d") 'helm-do-ag-this-file)
(global-set-key (kbd "M-s e") 'cibin/helm-ag-cwd)
(global-set-key (kbd "M-s j") 'helm-ag);; extension ; If you use helm-ag command, you can specify option like -G\.js$ search_pattern, or if you use helm-do-ag, you can use C-u prefix for specifying extension.

;; http://stackoverflow.com/questions/2641211/emacs-interactively-search-open-buffers
(defun my-multi-occur-in-matching-buffers (regexp &optional allbufs)
  "Show lines matching REGEXP in all file-visiting buffers.

Given a prefix argument, search in ALL buffers."
  (interactive (occur-read-primary-args))
  (multi-occur-in-matching-buffers "." regexp allbufs))

;Enable highlight-symbol-mode (usually done conditionally depending on major mode, as in this example), and set highlight-symbol-on-navigation-p.
; (add-hook 'prog-mode-hook (lambda () (highlight-symbol-mode)))
; (setq highlight-symbol-on-navigation-p t)
; (global-set-key [f3] 'highlight-symbol-next)
; (global-set-key [(shift f3)] 'highlight-symbol-prev)
