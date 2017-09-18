;; http://oremacs.com/swiper/#example---counsel-locate
;; https://github.com/abo-abo/swiper/issues/385

(require 'counsel)
(defun counsel-locate-function (str)
  (if (< (length str) 3)
      (counsel-more-chars 3)
    (counsel--async-command
     (format "locate %s '%s'"
             (mapconcat #'identity counsel-locate-options " ")
             (counsel-unquote-regex-parens
              (ivy--regex str))))
    '("" "working...")))

;;;###autoload
(defun counsel-locate (&optional initial-input)
  "Call the \"locate\" shell command.
INITIAL-INPUT can be given as the initial minibuffer input."
  (interactive)
  (ivy-read "Locate: " #'counsel-locate-function
            :initial-input initial-input
            :dynamic-collection t
            :history 'counsel-locate-history
            :action (lambda (file)
                      (with-ivy-window
                        (when file
                          (find-file file))))
            :unwind #'counsel-delete-process
            :caller 'counsel-locate))

(defcustom counsel-locate-options (if (eq system-type 'darwin)
                                      '("-i")
                                    '("-i" "--regex")
                                    ;; '("")
                                    )
  "Command line options for `locate`."
  :group 'ivy
  :type  '(repeat string))

(global-set-key (kbd "C-x R") 'counsel-locate)




(defun counsel-find-function (str)
  (if (< (length str) 3)
      (counsel-more-chars 3)
    (let ((cmd
            (format
              ;; "lfind %s ! -readable -maxdepth 1 -prune -o -iname \"%s*\" -print"
             ;; "c:/cygwin64/home/cibin/delete.sh %s" str
             "cat \"c:/Users/cibin/Downloads/all_files.db\"|fzy -e%s|head -n 50|sed -e \"s/\\/cygdrive\\/\\(.\\)\\//\\1:\\//\"" str
                                        ; NOTE: some versions of `find' may require parentheses,
              ; like this: \( ! -readable -prune \)
              ;; default-directory
              ;; (counsel-unquote-regex-parens
               ;; (ivy--regex str))
              )))
      (message "%s" cmd)
      (counsel--async-command cmd))
    '("" "working...")))

;;;###autoload
(defun counsel-find (&optional initial-input)
  "Use GNU find, counsel and ivy  to present all paths
   in a directory tree that match the REGEX input"
  (interactive)
  (ivy-read "Find: " #'counsel-find-function
            :initial-input initial-input
            :dynamic-collection t
            :history 'counsel-find-history
            :action (lambda (file)
                      (with-ivy-window
                        (when file
                          (find-file file))))
            :unwind #'counsel-delete-process
            :caller 'counsel-find))
(with-eval-after-load 'counsel
(counsel-set-async-exit-code 'counsel-find 1 "Nothing found")
)
(provide 'custom-ivy)
