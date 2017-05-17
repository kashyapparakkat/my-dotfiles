;; https://github.com/kaushalmodi/.emacs.d/blob/master/setup-files/setup-ag.el
;; check function in ag.el
;; helm-ag


;;TODO check ag/kill-process

(require 'ag)

;; TODO update definition when ag.el is updated
(defun cibin/ag-files-cwd (string file-type directory)
  "Search using ag in a given DIRECTORY for a given search STRING,
limited to files that match FILE-TYPE. STRING defaults to
the symbol under point.
If called with a prefix, prompts for flags to pass to ag."
  (interactive (list (read-from-minibuffer "Search string: " (ag/dwim-at-point))
                     (ag/read-file-type)
                     ;; (read-directory-name "Directory: ")
                     (file-name-directory (buffer-file-name))
                     ))
  (apply #'ag/search string directory file-type))


(defun cibin/helm-do-ag-cwd ()
  (interactive)
(setq helm-do-ag--extensions '(".e" ".txt"))
;; (setq helm-do-ag--extensions '("\\.txt\\'" "\\.mkd\\'"))
  (let ((rootdir (file-name-directory (buffer-file-name))))
    (unless rootdir
      (error "Could not find the project root. Create a git, hg, or svn repository there first. "))
    (helm-do-ag rootdir)))

;; TODO check regex option
(defun modi/ag-regexp-cwd (string)
      "SEARCH using ag in the CURRENT DIRECTORY for a given search REGEXP,
with REGEXP defaulting to the symbol under point.
If called with a prefix, prompts for flags to pass to ag."
      (interactive
       (list (read-from-minibuffer "Search regexp in current dir: "
                                   (ag/dwim-at-point))))
      (ag/search string (file-name-directory (buffer-file-name)) :regexp t))

 ;; Redefine the ag-regexp function where the default search pattern is
    ;; word at point



(defun ag-regexp (string directory)
      "Search using ag in a given DIRECTORY for a given search REGEXP,
with REGEXP defaulting to the symbol under point.
Search using ag in a given directory for a given regexp.
If called with a prefix, prompts for flags to pass to ag."
      (interactive (list (read-from-minibuffer "Search regexp: " (ag/dwim-at-point))
                         (read-directory-name "Directory: ")))
      (ag/search string directory :regexp t))
(bind-keys
     :map ag-mode-map
      ("i" . wgrep-change-to-wgrep-mode)
      ("/" . isearch-forward)
      ("n" . next-error-no-select)
      ("p" . previous-error-no-select)
      ("q" . ag-kill-buffers))

;; (message (format "%s" (ag/read-file-type)))
;; (:file-type python)
;; (let* ((all-types-with-extensions (ag/get-supported-types))
         ;; (all-types (mapcar 'car all-types-with-extensions))
         ;; (file-type
          ;; (completing-read "Select file type: "
                           ;; (append '("custom (provide a PCRE regex)") all-types)))
         ;; (file-type-extensions
          ;; (cdr (assoc file-type all-types-with-extensions))))
    ;; (if file-type-extensions
        ;; (list :file-type file-type)
      ;; (list :file-regex
            ;; (read-from-minibuffer "Filenames which match PCRE: "
                                  ;; (ag/buffer-extension-regex)))))
(with-eval-after-load 'helm
(define-key helm-map  (kbd "C-f")  'helm-next-source)
(define-key helm-map  (kbd "C-j")  'helm-previous-source)
)
(provide 'advanced-search)