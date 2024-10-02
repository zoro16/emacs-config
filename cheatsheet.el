;; Don't edit this file, edit /home/user/Developments/configs/emacs-config/cheatsheet.org instead ...

  (use-package cheatsheet
    :config
    (setq cheatsheet--group-face '(:foreground "spring green"))
    (setq cheatsheet--key-face '(:foreground "orchid")))
(cheatsheet-add :group 'Common
                :key "C-c r"
                :description "Revert buffer")
(cheatsheet-add :group 'Common
                :key "C-c q"
                :description "Turn on/off autofill mode")
(cheatsheet-add :group 'Common
                :key "C-x u"
                :description "Show the undo-tree")
(cheatsheet-add :group 'Common
                :key "M-y"
                :description "Show the kill-ring")
(cheatsheet-add :group 'Common
                :key "C-x r l"
                :description "Show the bookmarks")
(cheatsheet-add :group 'Common
                :key "C-c s"
                :description "Swoop search through buffer")
(cheatsheet-add :group 'Common
                :key "C-x w"
                :description "Read news and RSS feeds")
(cheatsheet-add :group 'Common
                :key "C-c SPC"
                :description "Jump to char")
(cheatsheet-add :group 'Common
                :key "C-c C-d"
                :description "Hungry delete")
(cheatsheet-add :group 'Common
                :key "C-c i"
                :description "Ciel kill")
(cheatsheet-add :group 'Common
                :key "C-M-h"
                :description "Select region")
(cheatsheet-add :group 'Common
                :key "C-c +"
                :description "Increment number at point")
(cheatsheet-add :group 'Common
                :key "C-c -"
                :description "Decrement number at point")
(cheatsheet-add :group 'Org
                :key "C-c c"
                :description "Org Capture")
(cheatsheet-add :group 'Org
                :key "C-c ^"
                :description "Org sort")
(cheatsheet-add :group 'Org
                :key "C-c C-t"
                :description "Org cycle todo")
(cheatsheet-add :group 'Org
                :key "C-c '"
                :description "Edit code block")
(cheatsheet-add :group 'Org
                :key "C-c C-c"
                :description "Evaluate source block")
(cheatsheet-add :group 'Org
                :key "C-c C-o"
                :description "Show source block eval result")
(cheatsheet-add :group 'Projectile
                :key "C-c v"
                :description "Find file in project")
(cheatsheet-add :group 'Projectile
                :key "C-c C-v"
                :description "Find word in project")
(cheatsheet-add :group 'Projectile
                :key "C-c C-v C-w"
                :description "Find word under cursor in project")
(cheatsheet-add :group 'Projectile
                :key "C-c w"
                :description "Switch project")
(cheatsheet-add :group 'Emacs-Lisp
                :key "C-x C-e"
                :description "Evaluate sexp")
(cheatsheet-add :group 'Emacs-Lisp
                :key "C-c x"
                :description "Evaluate buffer")
(cheatsheet-add :group 'Emacs-Lisp
                :key "C-c X"
                :description "Evaluate region")
(cheatsheet-add :group 'Emacs-Lisp
                :key "C-h f"
                :description "Describe function")
(cheatsheet-add :group 'Emacs-Lisp
                :key "C-h v"
                :description "Describe variable")
(cheatsheet-add :group 'Code
                :key "C-c C-i"
                :description "List classes and functions in buffer via imenu")
(cheatsheet-add :group 'Code
                :key "C-x g"
                :description "Summon Magit")
(cheatsheet-add :group 'Code
                :key "C-c f"
                :description "Flycheck the buffer")
(cheatsheet-add :group 'Code
                :key "C-x C-;"
                :description "Comment out current line")
(cheatsheet-add :group 'Multiple-Cursors
                :key "C->"
                :description "Mark next like this")
(cheatsheet-add :group 'Multiple-Cursors
                :key "C-<"
                :description "Mark previous like this")
(cheatsheet-add :group 'Multiple-Cursors
                :key "C-c C-<"
                :description "Mark all like this")
(cheatsheet-add :group 'Multiple-Cursors
                :key "C-S-<mouse-1>"
                :description "Add cursor on click")
(cheatsheet-add :group 'Dumb-Jump
                :key "C-M-g"
                :description "Jump to function definition")
(cheatsheet-add :group 'Dumb-Jump
                :key "C-M-p"
                :description "Jump back to original location")
(cheatsheet-add :group 'Dumb-Jump
                :key "C-M-q"
                :description "Show tooltip")
(cheatsheet-add :group 'MySQL-to-Org
                :key "C-c C-m e"
                :description "Evaluate query in region")
(cheatsheet-add :group 'MySQL-to-Org
                :key "C-c C-m p"
                :description "Evaluate the string at point")
(cheatsheet-add :group 'MySQL-to-Org
                :key "C-c C-m s"
                :description "Open scratch buffer")
(cheatsheet-add :group 'Paredit
                :key "C-("
                :description "Slurp left")
(cheatsheet-add :group 'Paredit
                :key "C-)"
                :description "Slurp right")
(cheatsheet-add :group 'Paredit
                :key "C-{"
                :description "Barf left")
(cheatsheet-add :group 'Paredit
                :key "C-}"
                :description "Barf right")
(cheatsheet-add :group 'Paredit
                :key "M-("
                :description "Wrap sexp in ()")
(cheatsheet-add :group 'Paredit
                :key "M-("
                :description "Wrap sexp in ()")
(cheatsheet-add :group 'Paredit
                :key "M-s"
                :description "Splice sexp out of ()")
  (cheatsheet-add :group 'Origami
                  :key "C-c n o"
                  :description "Open node")
  (cheatsheet-add :group 'Origami
                  :key "C-c n c"
                  :description "Close node")
  (cheatsheet-add :group 'Origami
                  :key "C-c n a"
                  :description "Open all nodes")
  (cheatsheet-add :group 'Origami
                  :key "C-c n u"
                  :description "Undo folding")
  (cheatsheet-add :group 'Origami
                  :key "C-c n n"
                  :description "Fold all nodes but current one")
  (cheatsheet-add :group 'Origami
                  :key "C-c n TAB"
                  :description "Toggle node")
  (cheatsheet-add :group 'Eyebrowse
                  :key "C-c C-w 1"
                  :description "Switch to workspace 1")
  (cheatsheet-add :group 'Eyebrowse
                  :key "C-c C-w 2"
                  :description "Switch to workspace 2")
  (cheatsheet-add :group 'Eyebrowse
                  :key "C-c C-w '"
                  :description "Switch to previous workspace")
  (cheatsheet-add :group 'Eyebrowse
                  :key "C-c C-w \""
                  :description "Close current workspace")
