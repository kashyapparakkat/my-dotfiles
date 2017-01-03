(setq org-agenda-files (list (format "C:/Users/%s/Downloads/todo.org" user-login-name)                           
                             "~/.emacs.d/my-files/org/work.org"))
							 
							 ;; set maximum indentation for description lists
(setq org-list-description-max-indent 5)

;; prevent demoting heading also shifting text inside sections
(setq org-adapt-indentation nil)