; http://ergoemacs.org/misc/emacs_abbrev_shell_elisp.html

(defcustom xah-shell-abbrev-alist nil "alist of xah's shell abbrevs")

(setq xah-shell-abbrev-alist
      '(
        ("rsync1" . "rsync -z -r -v -t --chmod=Dugo+x --chmod=ugo+r --delete --exclude='*~' --exclude='.bash_history' --exclude='logs/'  --rsh='ssh -l u80781' ~/web/ u80781@s30097.example.com:~/")

        ("ssh" . "ssh -l u80781 xahlee.org ")
        ("img1" . "convert -quality 85% ")
        ("imgScale" . "convert -scale 50% -quality 85% ")
        ("img256" . "convert +dither -colors 256 ")
        ("imgBatch" . "find . -name \"*png\" | xargs -l -i basename \"{}\" \".png\" | xargs -l -i  convert -quality 85% \"{}.png\" \"{}.jpg\"")
        ("img-bmp2png" . "find . -name \"*bmp\" | xargs -l -i basename \"{}\" \".bmp\" | xargs -l -i  convert \"{}.bmp\" \"{}.png\"")

        ("grep" . "grep -r -F 'xxx' --include='*html' ~/web")

        ("rm empty" . "find . -type f -empty")
        ("chmod file" . "find . -type f -exec chmod 644 {} ';'")
        ("rm~" . "find . -name \"*~\" -exec rm {} ';'")
        ("findEmptyDir" . "find . -depth -empty -type d")
        ("rmEmptyDir" . "find . -depth -empty -type d -exec rmdir {} ';'")
        ("chmod2" . "find . -type d -exec chmod 755 {} ';'")
        ("lynx" . "lynx -dump -assume_local_charset=utf-8 -display_charset=utf-8 -width=100")
        ("vp" . "feh --randomize --recursive --auto-zoom --action \"gvfs-trash '%f'\" --geometry 1600x1000 ~/Pictures/ &")))

(defun xah-shell-commands (*cmd-abbrev)
  "insert shell command from a list of abbrevs.

URL `http://ergoemacs.org/misc/emacs_abbrev_shell_elisp.html'
version 2015-02-05"
  (interactive
   (list
    (ido-completing-read "shell abbrevs:" (mapcar (lambda (x) (car x)) xah-shell-abbrev-alist) "PREDICATE" "REQUIRE-MATCH")))
  (progn
    (insert (cdr (assoc *cmd-abbrev xah-shell-abbrev-alist)))))