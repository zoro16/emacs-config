;; Don't edit this file, edit /home/user/Developments/configs/emacs-config/config.org instead ...

  (require 'package)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
  (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))

  (when (< emacs-major-version 24)
      ;; For important compatibility libraries like cl-lib
      (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))

  (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t) ; Org-mode's repository
  (add-to-list 'package-archives '("elpy" . "https://jorgenschaefer.github.io/packages/")) ; package-install elpy

  ;; Make sure the NonGNU repo is added
  (add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/"))

  (package-initialize)
  (setq tls-checktrust t)
  (setq gnutls-verify-error t)
(if (eq system-type 'darwin)
  (use-package gnutls
    :config
      (require 'gnutls)
      (add-to-list 'gnutls-trustfiles "/usr/local/etc/openssl/cert.pem"))
)
(mapc
 (lambda (package)
   (if (not (package-installed-p package))
       (progn
         (package-refresh-contents)
         (package-install package))))
 '(use-package diminish bind-key))
(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)
(setq use-package-always-ensure t)
  (use-package flx)
  (use-package helm-flx)
  (use-package helm)
    ;; :demand
    ;; :diminish helm-mode
    ;; :bind (("M-x" . helm-M-x)
    ;;        ("M-y" . helm-show-kill-ring)
    ;;        ("C-x b" . helm-mini)
    ;;        ("C-x C-f" . helm-find-files)
    ;;        ("C-x r l" . helm-bookmarks)
    ;;        ("C-c s" . helm-occur)
    ;;        :map helm-find-files-map ;; I like these from Ido
    ;;        ("C-<tab>"         . helm-execute-persistent-action)
    ;;        ("C-<backspace>" . helm-find-files-up-one-level))
    ;; :config
    ;; (helm-mode 1)
    ;; (helm-flx-mode +1)
    ;; (setq helm-M-x-fuzzy-match t)
    ;; (setq helm-locate-fuzzy-match t)
    ;; (setq helm-lisp-fuzzy-completion t)
    ;; (setq helm-bookmark-show-location t))
  (defun imenu-anywhere-same-buffer-p (current other)
    (eq current other))

  (use-package imenu-anywhere
    :bind (("C-c C-i" . helm-imenu-anywhere))
    :config (setq imenu-anywhere-buffer-filter-functions
                  '(imenu-anywhere-same-buffer-p)))
  (use-package helm-system-packages)
(use-package magit
  :bind ("C-x g" . magit-status))
  (use-package git-timemachine)
    (use-package ssh-agency)
  (setq user-full-name "Mohamed Abdelgadir"
        calendar-latitude 52.520008
        calendar-longitude 13.404954
        calendar-location-name "Berlin, DE")
(defun generate-scratch-buffer ()
  "Create and switch to a temporary scratch buffer with a random
     name."
  (interactive)
  (switch-to-buffer (make-temp-name "scratch-")))
(defun sudo ()
  "Use TRAMP to `sudo' the current buffer"
  (interactive)
  (when buffer-file-name
    (find-alternate-file
     (concat "/sudo:root@localhost:"
             buffer-file-name))))
(defun replace-token (token)
  "Replace JSON web token for requests"
  (interactive "sEnter the new token: ")
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "Bearer .*\"" nil t)
      (replace-match (concat "Bearer " token "\"")))))
(eval-after-load "dired"
  '(progn
     (define-key dired-mode-map "F" 'my-dired-find-file)
     (defun my-dired-find-file (&optional arg)
       "Open each of the marked files, or the file under the point, or when prefix arg, the next N files "
       (interactive "P")
       (let* ((fn-list (dired-get-marked-files nil arg)))
         (mapc 'find-file fn-list)))))
(defun browse-current-file ()
  "Open the current file as a URL using `browse-url'."
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if (and (fboundp 'tramp-tramp-file-p)
             (tramp-tramp-file-p file-name))
        (error "Cannot open tramp file")
      (browse-url (concat "file://" file-name)))))
(defun refill-paragraphs ()
  "fill individual paragraphs with large fill column"
  (interactive)
  (let ((fill-column 100000))
    (fill-individual-paragraphs (point-min) (point-max))))
(defun copy-filename ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))
(defun align-docstring ()
  "Align lines by double space"
  (interactive)
  (align-regexp (region-beginning) (region-end) "\\(\\s-*\\)  " 1 1 t))
(defun rename-local-var (name)
  (interactive "sEnter new name: ")
  (let ((var (word-at-point)))
    (mark-defun)
    (replace-string var name nil (region-beginning) (region-end))))
  (defun increment-number-at-point ()
    (interactive)
    (skip-chars-backward "0-9")
    (or (looking-at "[0-9]+")
        (error "No number at point"))
    (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))

  (defun decrement-number-at-point ()
    (interactive)
    (skip-chars-backward "0-9")
    (or (looking-at "[0-9]+")
        (error "No number at point"))
    (replace-match (number-to-string (- (string-to-number (match-string 0)) 1))))
  (defun comment-line ()
    (interactive)
    (save-excursion
      (end-of-line)
      (set-mark (point))
      (beginning-of-line)
      (if (comment-only-p (region-beginning) (region-end))
          (uncomment-region (region-beginning) (region-end))
        (comment-region (region-beginning) (region-end)))))
  (defun edit-config-file ()
    (interactive)
    (find-file (concat config-load-path "config.org")))
  (defun email-selection ()
    (interactive)
    (copy-region-as-kill (region-beginning) (region-end))
    (let ((tmp-file (concat "/tmp/" (buffer-name (current-buffer))))
          (recipient (read-string "Enter a recipient: "))
          (subject (read-string "Enter a subject: ")))
      (find-file tmp-file)
      (yank)
      (save-buffer)
      (kill-buffer (current-buffer))
      (shell-command (concat "mutt -s \"" subject "\" " recipient " < " tmp-file))
      (shell-command (concat "rm -f " tmp-file)))
    (message "Sent!"))
  (defun move-file ()
    "Write this file to a new location, and delete the old one."
    (interactive)
    (let ((old-location (buffer-file-name)))
      (call-interactively #'write-file)
      (when old-location
        (delete-file old-location))))
  (defun insert-filename ()
    (interactive)
    (insert (read-file-name "File:")))
  (defun insert-relative-filename ()
    (interactive)
    (insert (file-relative-name (read-file-name "File: "))))
  (defun format-function-parameters ()
    "Turn the list of function parameters into multiline."
    (interactive)
    (beginning-of-line)
    (search-forward "(" (line-end-position))
    (newline-and-indent)
    (while (search-forward "," (line-end-position) t)
      (newline-and-indent))
    (end-of-line)
    (c-hungry-delete-forward)
    (insert " ")
    (search-backward ")")
    (newline-and-indent))
  (defun eshell-here ()
    "Opens up a new shell in the directory associated with the
      current buffer's file. The eshell is renamed to match that
      directory to make multiple eshell windows easier."
    (interactive)
    (let* ((height (/ (window-total-height) 3)))
      (split-window-vertically (- height))
      (other-window 1)
      (eshell "new")
      (insert (concat "ls"))
      (eshell-send-input)))

  (bind-key "C-!" 'eshell-here)
  (defun relative-pwd ()
    (interactive)
    (let* ((prj (cdr (project-current)))
           (current-file buffer-file-truename)
           (prj-name (file-name-as-directory (file-name-nondirectory (directory-file-name prj))))
           (output (concat prj-name (file-relative-name current-file prj))))
      (kill-new output)
      (message output)))
  (add-hook 'git-commit-setup-hook
      '(lambda ()
          (let ((has-ticket-title (string-match "^[A-Z]+-[0-9]+"
                                      (magit-get-current-branch)))
                (words (s-split-words (magit-get-current-branch))))
            (if has-ticket-title
                (insert (format "[%s-%s] " (car words) (car (cdr words))))))))
  (with-temp-file "~/.gnupg/gpg.conf"
    (insert "use-agent\npinentry-mode loopback"))

  (with-temp-file "~/.gnupg/gpg-agent.conf"
    (insert "allow-loopback-pinentry"))

  (define-key global-map (kbd "C-c r") 'revert-buffer)
(define-key global-map (kbd "C-c x") 'eval-buffer)
(define-key global-map (kbd "C-c X") 'eval-region)
  (global-set-key (kbd "<home>") 'beginning-of-buffer)
  (global-set-key (kbd "<end>") 'end-of-buffer)
  (global-set-key (kbd "C-c q") 'auto-fill-mode)
  (global-set-key (kbd "C-x C-;") 'comment-line)
     (use-package f)
     (use-package org)

     (setq org-agenda-files '("~/Essential/org/agenda.org"))

     (defun org-file-path (filename)
       "Return the absolute address of an org file, given its relative name."
       (concat (file-name-as-directory org-directory) filename))

     (defun org-find-file ()
       "Leverage Helm to quickly open any org files."
       (interactive)
      ( find-file (concat org-directory
                          (helm-comp-read "Select your org file: "
                                          (directory-files org-directory nil "\.org$")))))
   (setq org-src-fontify-natively t)
   (add-to-list 'auto-mode-alist '("\\.txt\\'" . org-mode))
   (add-to-list 'auto-mode-alist '(".*/[0-9]*$" . org-mode))   ;; Journal entries
  ;; (require 'color)
  ;; (if (display-graphic-p)
  ;;     (set-face-attribute 'org-block nil :background
  ;;                         (color-darken-name
  ;;                          (face-attribute 'default :background) 3)))

   (define-key org-mode-map (kbd "C-c a") 'org-agenda)
   (setq org-default-notes-file (concat org-directory "/notes.org"))
   (define-key global-map "\C-cc" 'org-capture)
  (setq org-capture-templates
   '(("t" "Tasks" entry
          (file+headline org-default-notes-file "Tasks")
          "* TODO %?\n %T\n %a")
     ("p" "Projects" entry
          (file+headline org-default-notes-file "Projects")
          "* %?\n ")
     ("e" "E-Learning" entry
          (file+headline org-default-notes-file "E-Learning")
          "* TODO %?\n %T\n %a")
     ("j" "Journal" entry
          (file+olp+datetree org-default-notes-file "Journal")
          "* %?\nEntered on %U\n %i\n")
     ("m" "Meeting Notes" entry
          (file+headline org-default-notes-file "Meeting Notes")
          "* %?\n ")
     ("s" "Scrum" entry
          (file+olp+datetree org-default-notes-file "Scrum")
          "* %?\n ")))
   (setq org-tag-alist '(("@work" . ?w)
                         ("@home" . ?h)
                         ("@event" . ?e)
                         ("project" . ?p)
                         ("study" . ?s)
                         ("planned" . ?x)
                         ("unplanned" . ?y)
                         ("2watch" . ?W)
                         ("laptop" . ?l)))
   (defun org-text-bold () "Wraps the region with asterisks."
     (interactive)
     (surround-text "*"))
   (defun org-text-italics () "Wraps the region with slashes."
     (interactive)
     (surround-text "/"))
   (defun org-text-code () "Wraps the region with equal signs."
     (interactive)
     (surround-text "="))
   (defun meeting-notes ()
   "Call this after creating an org-mode heading for where the notes for the meeting
   should be. After calling this function, call 'meeting-done' to reset the environment."
       (interactive)
           (outline-mark-subtree)                              ;; Select org-mode section
           (narrow-to-region (region-beginning) (region-end))  ;; Only show that region
           (deactivate-mark)
           (delete-other-windows)                              ;; Get rid of other windows
           (text-scale-set 2)                                  ;; Text is now readable by others
           (fringe-mode 0)
           (message "When finished taking your notes, run meeting-done."))
   (defun meeting-done ()
   "Attempt to 'undo' the effects of taking meeting notes."
       (interactive)
           (widen)                                       ;; Opposite of narrow-to-region
           (text-scale-set 0)                            ;; Reset the font size increase
           (fringe-mode 1)
           (winner-undo))                                ;; Put the windows back in place
  (define-key org-mode-map (kbd "C-c m o") 'meeting-notes)
  (define-key org-mode-map (kbd "C-c m d") 'meeting-done)
  (setq org-todo-keywords
        '((sequence "TODO(t)" "STARTED(s!)" "|" "DONE(d!)" "WAITING(w@)" "CANCELLED(c@)")))
  (font-lock-add-keywords
    'org-mode `(("^\\*+ \\(TODO\\) "
                (1 (progn (compose-region (match-beginning 1) (match-end 1) "⚑")
                          nil)))
               ("^\\*+ \\(STARTED\\) "
                (1 (progn (compose-region (match-beginning 1) (match-end 1) "⚐")
                          nil)))
               ("^\\*+ \\(DONE\\) "
                (1 (progn (compose-region (match-beginning 1) (match-end 1) "✔")
                          nil)))
                 ("^\\*+ \\(WAITING\\) "
                (1 (progn (compose-region (match-beginning 1) (match-end 1) "⌛")
                          nil)))
               ("^\\*+ \\(CANCELLED\\) "
                (1 (progn (compose-region (match-beginning 1) (match-end 1) "✘")
                          nil)))))
  ;; (setq org-todo-keyword-faces
  ;;            '(("WAIT" . "yellow")
  ;;              ("CANCELLED" . (:foreground "blue" :weight bold))))
  (add-hook 'org-mode-hook 'flyspell-mode)
  (add-hook 'text-mode-hook 'flyspell-mode)
  (use-package ob-kotlin)
  (use-package ob-go)
  (use-package ob-rust)
  (use-package ob-clojurescript)
  (org-babel-do-load-languages
   (quote org-babel-load-languages)
   (quote ((emacs-lisp . t)
	   (dot . t)
	   (plantuml . t)
	   (python . t)
	   (gnuplot . t)
	   (shell . t)
	   (org . t)
	   (js . t)
	   (sql . t)
	   (awk . t)
	   (sed . t)
	   (ditaa . t)
	   (latex . t)
	   (go . t)
	   (rust . t)
	   (kotlin . t)
	   (clojurescript . t)
	   (haskell . t))))
  (use-package org-bullets
    :config (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
  (setq org-startup-with-inline-images t)
   (use-package ox-twbs)
   (require 'ox-md)
   (require 'ox-twbs)
  (global-set-key (kbd "<f5>") 'org-find-file)
  (use-package org-journal
      :custom (org-journal-dir "~/Essential/org/journal" "Set journal location"))
  (use-package ox-reveal
    :config
      (require 'ox-reveal)
      (setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/")
      (setq Org-Reveal-title-slide nil))

  ;; ;; Install org-present if needed
  ;; (unless (package-installed-p 'org-present)
  ;;   (package-install 'org-present))

  ;; ;; Install visual-fill-column
  ;; (unless (package-installed-p 'visual-fill-column)
  ;;   (package-install 'visual-fill-column))


  ;; (defun my/org-present-prepare-slide (buffer-name heading)
  ;;   ;; Show only top-level headlines
  ;;   (org-overview)

  ;;   ;; Unfold the current entry
  ;;   (org-show-entry)

  ;;   ;; Show only direct subheadings of the slide but don't expand them
  ;;   (org-show-children))

  ;; (defun my/org-present-start ()
  ;;   ;; Configure fill width
  ;;   (setq visual-fill-column-width 110
  ;; 	visual-fill-column-center-text t)

  ;;   ;; Tweak font sizes
  ;;   (setq-local face-remapping-alist '((default (:height 1.5) variable-pitch)
  ;; 				     (header-line (:height 4.0) variable-pitch)
  ;; 				     (org-document-title (:height 1.75) org-document-title)
  ;; 				     (org-code (:height 1.55) org-code)
  ;; 				     (org-verbatim (:height 1.55) org-verbatim)
  ;; 				     (org-block (:height 1.25) org-block)
  ;; 				     (org-block-begin-line (:height 0.7) org-block)))

  ;;   ;; Set a blank header line string to create blank space at the top
  ;;   (setq header-line-format " ")

  ;;   ;; Display inline images automatically
  ;;   (org-display-inline-images)

  ;;   ;; Center the presentation and wrap lines
  ;;   (visual-fill-column-mode 1)
  ;;   (visual-line-mode 1))

  ;; (defun my/org-present-end ()
  ;;   ;; Reset font customizations
  ;;   (setq-local face-remapping-alist '((default variable-pitch default)))

  ;;   ;; Clear the header line string so that it isn't displayed
  ;;   (setq header-line-format nil)

  ;;   ;; Stop displaying inline images
  ;;   (org-remove-inline-images)

  ;;   ;; Configure fill width
  ;;   (setq visual-fill-column-width -1
  ;; 	visual-fill-column-center-text -1)

  ;;   ;; Stop centering the document
  ;;   (visual-fill-column-mode -1)
  ;;   (visual-line-mode -1))


  ;; ;; Register hooks with org-present
  ;; (add-hook 'org-present-mode-hook 'my/org-present-start)
  ;; (add-hook 'org-present-mode-quit-hook 'my/org-present-end)
  ;; (add-hook 'org-present-after-navigate-functions 'my/org-present-prepare-slide)


(defun org-inline-image--get-current-image ()
  "Return the overlay associated with the image under point."
  (car (--select (eq (overlay-get it 'org-image-overlay) t) (overlays-at (point)))))

(defun org-inline-image--get (prop)
  "Return the value of property PROP for image under point."
  (let ((image (org-inline-image--get-current-image)))
    (when image
      (overlay-get image prop))))

(defun org-inline-image-animate ()
  "Animate the image if it's possible."
  (interactive)
  (let ((image-props (org-inline-image--get 'display)))
    (when (image-multi-frame-p image-props)
      (image-animate image-props))))

(defun org-inline-image-animate-auto ()
  (interactive)
  (when (eq 'org-mode major-mode)
    (while-no-input
      (run-with-idle-timer 0.3 nil 'org-inline-image-animate))))

(setq org-inline-image--get-current-image (byte-compile 'org-inline-image--get-current-image))
(setq org-inline-image-animate  (byte-compile 'org-inline-image-animate ))
(add-hook 'post-command-hook 'org-inline-image-animate-auto)
   (use-package htmlize
     :config
       (require 'htmlize))

   (use-package grip-mode
     :ensure t
     :bind (:map markdown-mode-command-map
            ("g" . grip-mode)))
   (use-package ox-gfm)
   (use-package org-preview-html)
  (toggle-frame-maximized)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-message t)
(setq initial-major-mode 'emacs-lisp-mode)
(setq initial-scratch-message nil)
(setq visible-bell 1)
  (setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
  (setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
  (setq auto-window-vscroll nil)
(setq confirm-kill-emacs 'y-or-n-p)
(when window-system
  (global-hl-line-mode))
  (global-set-key [mouse-8] 'switch-to-prev-buffer)
  (global-set-key [mouse-9] 'switch-to-next-buffer)
  (setq-default visual-line-mode t)
  (add-hook 'visual-line-mode-hook 'visual-fill-column-mode)
  (global-set-key (kbd "C-x p") 'toggle-truncate-lines)
  (use-package dabbrev
    :diminish abbrev-mode)
  (global-set-key (kbd "M-/") 'hippie-expand)
(use-package ivy
  :config
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq enable-recursive-minibuffers t)
    (global-set-key (kbd "C-c C-r") 'ivy-resume)
    (global-set-key (kbd "<f6>") 'ivy-resume))
(use-package swiper
  :config (global-set-key "\C-s" 'swiper))
  (use-package counsel
    :config
      ;; (global-set-key (kbd "M-x") 'counsel-M-x)
      (global-set-key (kbd "C-x C-f") 'counsel-find-file)
      (global-set-key (kbd "<f1> f") 'counsel-describe-function)
      (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
      (global-set-key (kbd "<f1> l") 'counsel-find-library)
      (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
      (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
      ;; (global-set-key (kbd "C-c g") 'counsel-git)
      ;; (global-set-key (kbd "C-c j") 'counsel-git-grep)
      ;; (global-set-key (kbd "C-c k") 'counsel-ag)
      ;; (global-set-key (kbd "C-x l") 'counsel-locate)
      ;; (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
      (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history))
   (use-package smex
     :ensure t
     :bind (("M-x" . smex))
     :config (smex-initialize))
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory
                                               "backups"))))
(fset 'yes-or-no-p 'y-or-n-p)
(setq tags-revert-without-query 1)
  (put 'narrow-to-region 'disabled nil)
  ;; (use-package solarized-theme
  ;;   :config (load-theme 'solarized-dark t))

   ;; (use-package doom-themes
   ;;  :config
   ;;  ;; Global settings (defaults)
   ;;  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
   ;;    doom-themes-enable-italic t) ; if nil, italics is universally disabled
   ;;  (load-theme 'doom-solarized-dark t)

   ;;   ;; Enable flashing mode-line on errors
   ;;  (doom-themes-visual-bell-config))


   ;; Let the desktop background show through
  ;; (set-frame-parameter (selected-frame) 'alpha '(97 . 100))
  ;; (add-to-list 'default-frame-alist '(alpha . (90 . 90)))

     ;; Enable custom neotree theme (all-the-icons must be installed!)
  ;;   (doom-themes-neotree-config)
  ;;    ;; or for treemacs users
  ;;   ;; (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  ;;   ;; (doom-themes-treemacs-config)

  ;;    ;; Corrects (and improves) org-mode's native fontification.
  ;;   (doom-themes-org-config)

   ;; (use-package spacemacs-common

   ;;   :ensure spacemacs-theme
   ;;   :config (load-theme 'spacemacs-dark t))
   ;; REMEMBER TO SET THIS COLOR ON THE `spacemacs-common.el` FILE, REPLACE `#2aa1ae' WITH `#626262`
   ;; (custom-set-variables '(spacemacs-theme-custom-colors
   ;;                       '((comment . "#626262"))))


   ;; (use-package foggy-night-theme
   ;;     :config (load-theme 'foggy-night t))


   ;; ;
					  ; (use-package color-theme-sanityinc-tomorrow
   ;;   :config (load-theme 'sanityinc-tomorrow-eighties t))

   ;; (use-package dracula-theme
   ;;   :config (load-theme 'dracula t))

   ;; (use-package spacegray-theme
   ;;   :config (load-theme 'spacegray t))

   (use-package gruvbox-theme
     :config (load-theme 'gruvbox-dark-hard t))

   ;; (use-package afternoon-theme
   ;;   :config (load-theme 'afternoon t))

  ;; https://github.com/domtronn/all-the-icons.el
  (use-package all-the-icons
    :custom
    (all-the-icons-install-fonts))
  (use-package all-the-icons-gnus)
  (use-package all-the-icons-ivy-rich)
  (use-package all-the-icons-ibuffer)
  (use-package all-the-icons-dired)
  (use-package all-the-icons-completion)
  (use-package treemacs-all-the-icons)
  (setq-default mode-line-format '("%e"
                                   mode-line-front-space
                                   " "
                                   mode-line-modified
                                   " "
                                   "%[" mode-line-buffer-identification "%]"
                                   "   "
                                   "L%l"
                                   "  "
                                   "C%c"
                                   " "
                                   mode-line-modes
                                   mode-line-misc-info
                                   projectile-mode-line
                                   " "
                                   (vc-mode vc-mode)
                                   mode-line-end-spaces))
  (use-package minions
    :config (minions-mode 1))
    ;; (if (condition-case nil
    ;;     (x-list-fonts "Hack")
    ;;   (error nil))
    ;;     (progn
    ;;   (add-to-list 'default-frame-alist '(font . "Hack-13"))
    ;;   (set-face-attribute 'default nil :font "Hack-13")))

  ;; ;; Set reusable font name variables
  (defvar my/fixed-width-font "JetBrains Mono"
    "The font to use for monospaced (fixed width) text.")

  (defvar my/variable-width-font "Iosevka"
    "The font to use for variable-pitch (document) text.")

  ;; NOTE: These settings might not be ideal for your machine, tweak them as needed!
  (set-face-attribute 'default nil :font my/fixed-width-font :weight 'regular :height 110)
  (set-face-attribute 'fixed-pitch nil :font my/fixed-width-font :weight 'regular :height 130)
  (set-face-attribute 'variable-pitch nil :font my/variable-width-font :weight 'light :height 140)

(if (eq system-type 'windows-nt)
    (progn
      (setenv "PATH" (concat "C:\\cygwin64\\bin\\"
                             path-separator
                             (getenv "PATH")))
      )
  (progn
    (use-package exec-path-from-shell
      :config (exec-path-from-shell-copy-env "PATH"))
    )
  )
       (use-package vterm)
       (use-package multi-vterm)
  (use-package yasnippet
    :diminish yas-minor-mode
    :config (yas-global-mode 1))
  (use-package org-sync-snippets
    :config (setq org-sync-snippets-org-snippets-file
                  (concat (file-name-as-directory config-load-path) "snippets.org")))
  (use-package smart-tabs-mode
    :commands (smart-tabs-mode)
    :init
    (add-hook 'c-mode-common-hook #'smart-tabs-mode)
    :config
    (smart-tabs-advice c-indent-line     c-basic-offset)
    (smart-tabs-advice c-indent-region   c-basic-offset))

  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 4)
  (setq tab-width 4)
  (setq tab-stop-list '(2 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80))

(setq require-final-newline t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
  (setq-default buffer-file-coding-system 'utf-8-unix)
  (setq-default default-buffer-file-coding-system 'utf-8-unix)
  (set-default-coding-systems 'utf-8-unix)
  (prefer-coding-system 'utf-8-unix)
  ;; (defvar yank-indent-modes '(php-mode js2-mode)
  ;;   "Modes in which to indent regions that are yanked (or yank-popped)")

  ;; (defvar yank-advised-indent-threshold 1000
  ;;   "Threshold (# chars) over which indentation does not automatically occur.")

  ;; (defun yank-advised-indent-function (beg end)
  ;;   "Do indentation, as long as the region isn't too large."
  ;;   (if (<= (- end beg) yank-advised-indent-threshold)
  ;;       (indent-region beg end nil)))

  ;; (defadvice yank (after yank-indent activate)
  ;;   "If current mode is one of 'yank-indent-modes, indent yanked text (with prefix arg don't indent)."
  ;;   (if (and (not (ad-get-arg 0))
  ;;            (--any? (derived-mode-p it) yank-indent-modes))
  ;;       (let ((transient-mark-mode nil))
  ;;         (yank-advised-indent-function (region-beginning) (region-end)))))

  ;; (defadvice yank-pop (after yank-pop-indent activate)
  ;;   "If current mode is one of 'yank-indent-modes, indent yanked text (with prefix arg don't indent)."
  ;;   (if (and (not (ad-get-arg 0))
  ;;            (member major-mode yank-indent-modes))
  ;;       (let ((transient-mark-mode nil))
  ;;         (yank-advised-indent-function (region-beginning) (region-end)))))

  ;; (defun yank-unindented ()
  ;;   (interactive)
  ;;   (yank 1))
  (setq comment-start "#")
  (use-package prog-fill
    :bind (("M-q" . prog-fill)))
(show-paren-mode)
(electric-pair-mode)
  (use-package paradox
    :custom
    (paradox-execute-asynchronously t)
    :config
    (paradox-enable))
  (use-package avy
    :bind (("C-c SPC" . avy-goto-char-2)
           ("M-g f" . avy-goto-line)
           ("M-g w" . avy-goto-word-1)))
  ;; (windmove-default-keybindings)

  (global-set-key (kbd "S-<left>")  'windmove-left)
  (global-set-key (kbd "S-<right>") 'windmove-right)
  (global-set-key (kbd "S-<up>")    'windmove-up)
  (global-set-key (kbd "S-<down>")  'windmove-down)
(use-package which-key
  :diminish which-key-mode
  :config (which-key-mode 1))
(winner-mode 1)
(use-package smooth-scrolling
  :config
  (smooth-scrolling-mode 1)
  (setq smooth-scroll-margin 5))
(use-package neotree)
(use-package ibuffer-vc)
(use-package ibuffer-git)
(define-key global-map (kbd "C-x C-b") 'ibuffer)
(use-package yascroll
  :config (global-yascroll-bar-mode 1))
(use-package minimap
  :config
  (setq minimap-window-location "right")
  (setq minimap-major-modes '(prog-mode org-mode)))
  (use-package rotate
    :config (global-set-key (kbd "C-|") 'rotate-layout))
(use-package anzu
  :config (global-anzu-mode +1)
          (setq anzu-mode-lighter ""))
  (use-package hamburger-menu
    :config (setq mode-line-front-space 'hamburger-menu-mode-line))
  (define-globalized-minor-mode global-hs-minor-mode
  hs-minor-mode hs-minor-mode)
  (global-hs-minor-mode 1)
  (global-set-key (kbd "C-c h s") 'hs-show-all)
  (global-set-key (kbd "C-c h a") 'hs-hide-all)
  (global-set-key (kbd "C-c h g") 'hs-toggle-hiding)
  (use-package eyebrowse
    :config (eyebrowse-mode t))
(use-package multiple-cursors
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)
         ("C-S-<mouse-1>" . mc/add-cursor-on-click)))
(use-package zzz-to-char
  :bind ("M-z" . zzz-up-to-char))
  (use-package whole-line-or-region
    :diminish whole-line-or-region-global-mode
    :config (whole-line-or-region-global-mode t))
  (use-package viking-mode
    :diminish viking-mode
    :config
    (viking-global-mode)
    (setq viking-greedy-kill nil)
    (setq viking-enable-region-kill t)
    (setq viking-kill-functions (list '(lambda()
                                         (if (region-active-p)
                                             (kill-region (region-beginning) (region-end))
                                         (delete-char 1 t)))
                                      '(lambda()
                                         (insert (pop kill-ring)) ;; insert the char back
                                         (kill-new "") ;; start a new entry in the kill-ring
                                         (viking-kill-word)
                                         (kill-append " " nil)) ;; append the extra space
                                      'viking-kill-line-from-point
                                      'viking-kill-line
                                      'viking-kill-paragraph
                                      'viking-kill-buffer)))
  ;; (use-package undo-tree
  ;;   :diminish undo-tree-mode
  ;;   :config
  ;;   (global-undo-tree-mode t)
  ;;   (setq undo-tree-visualizer-diff t))
  (use-package volatile-highlights
    :diminish volatile-highlights-mode
    :config
    (vhl/define-extension 'undo-tree 'undo-tree-yank 'undo-tree-move)
    (vhl/install-extension 'undo-tree)
    (volatile-highlights-mode t))
(use-package ciel
  :bind (("C-c i" . ciel-ci)
         ("C-c o" . ciel-co)))
  (use-package fancy-narrow
    :diminish fancy-narrow-mode)
  (use-package ag)
  (use-package helm-ag)
  (setq projectile-go-function nil) ;; temporary workaround
  (use-package projectile
    :config
    (projectile-mode)
    (setq-default projectile-mode-line
     '(:eval
       (if (file-remote-p default-directory)
           " Proj"
         (format " Proj[%s]" (projectile-project-name)))))
    (add-to-list 'projectile-globally-ignored-directories "node_modules"))
(use-package helm-projectile
  :bind (("C-c v" . helm-projectile)
         ("C-c C-v" . helm-projectile-ag)
         ("C-c w" . helm-projectile-switch-project)))
(use-package company
  :ensure
  :custom
  (company-idle-delay 0.5) ;; how long to wait until popup
  ;; (company-begin-commands nil) ;; uncomment to disable popup
  :bind
  (:map company-active-map
	      ("C-n". company-select-next)
	      ("C-p". company-select-previous)
	      ("M-<". company-select-first)
	      ("M->". company-select-last)))

(use-package yasnippet
  :ensure
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook 'yas-minor-mode)
  (add-hook 'text-mode-hook 'yas-minor-mode))

  ;; (use-package company
  ;;   :diminish company-mode
  ;;   :config
  ;;   (add-hook 'after-init-hook 'global-company-mode)
  ;;   (setq company-minimum-prefix-length 2)
  ;;   (setq company-dabbrev-downcase nil))
  ;; (use-package company-go)
;;  (use-package flycheck
;;    :diminish flycheck-mode
;;    :config (flycheck-mode 1)
;;    (setq flycheck-phpcs-standard "PSR2")
;;    (add-hook 'python-mode-hook 'flycheck-mode)
;;    (add-hook 'emacs-lisp-mode-hook 'flycheck-mode)
;;    (add-hook 'json-mode-hook 'flycheck-mode)
;;    (add-hook 'rjsx-mode-hook 'flycheck-mode))
(use-package helm-flycheck
  :bind ("C-c f" . helm-flycheck))
  (use-package electric-operator
    :config
    (electric-operator-add-rules-for-mode 'php-mode
                                          (cons " - >" "->"))
    (electric-operator-add-rules-for-mode 'php-mode
                                          (cons " / /" "// "))
    (electric-operator-add-rules-for-mode 'php-mode
                                          (cons " = > " " => "))
    (electric-operator-add-rules-for-mode 'php-mode
                                          (cons " < ?" "<?"))
    (electric-operator-add-rules-for-mode 'js2-mode
                                          (cons " = > " " => "))
    (electric-operator-add-rules-for-mode 'js2-jsx-mode
                                          (cons " = > " " => "))
    (electric-operator-add-rules-for-mode 'rjsx-mode
                                          (cons " = > " " => ")))
  (use-package dumb-jump
    :config (setq dumb-jump-aggressive nil))
  (use-package highlight-numbers
    :config (add-hook 'prog-mode-hook 'highlight-numbers-mode))
    (setq column-number-mode t)
    (setq global-hl-line-mode t)
      ;; https://github.com/DarthFennec/highlight-indent-guides
      (use-package highlight-indent-guides
        :config
        (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
        (set-face-background 'highlight-indent-guides-odd-face "darkgray")
        (set-face-background 'highlight-indent-guides-even-face "dimgray")
        (set-face-foreground 'highlight-indent-guides-character-face "dimgray")
        (setq highlight-indent-guides-method 'fill))

      (setq global-display-line-numbers-mode t)
      ;; (setq linum-format "%d ")
  (use-package eldoc
    :diminish eldoc-mode
    :config (add-hook 'emacs-lisp-mode-hook 'eldoc-mode))
(use-package rainbow-delimiters
  :config
  (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode))
(use-package paredit
  :config
  (add-hook 'emacs-lisp-mode-hook 'paredit-mode))
  (use-package eros
    :config (add-hook 'emacs-lisp-mode-hook 'eros-mode))
  (use-package simple-call-tree)
  (use-package suggest)

  (defun efs/lsp-mode-setup ()
    (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
    (lsp-headerline-breadcrumb-mode))

  (use-package lsp-mode
    :commands (lsp lsp-deferred)
    :hook (lsp-mode . efs/lsp-mode-setup)
    :init
    (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
    :config
    (lsp-enable-which-key-integration t))


  (use-package lsp-ui
    :hook (lsp-mode . lsp-ui-mode)
    :custom
    (lsp-ui-doc-position 'bottom))


  (use-package lsp-treemacs
    :after lsp)

  (use-package dap-mode)
    ;; (use-package dap-mode
    ;;   ;; Uncomment the config below if you want all UI panes to be hidden by default!
    ;;   ;; :custom
    ;;   ;; (lsp-enable-dap-auto-configure nil)
    ;;   ;; :config
    ;;   ;; (dap-ui-mode 1)

    ;;   ;; :config
    ;;   ;; ;; Set up Node debugging
    ;;   ;; (dap-node-setup) ;; Automatically installs Node debug adapter if needed

    ;;   ;; Bind `C-c l d` to `dap-hydra` for easy access
    ;;   (general-define-key
    ;;     :keymaps 'lsp-mode-map
    ;;     :prefix lsp-keymap-prefix
    ;;     "d" '(dap-hydra t :wk "debugger")))


  ;; (add-hook 'LaTeX-mode-hook #'latex-extra-mode)
  ;; (use-package magic-latex-buffer)
  ;; (add-hook 'latex-mode-hook 'magic-latex-buffer)
  (add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-tail-mode))
  (require 'dired-x)
  (setq dired-listing-switches "-alh")
  (use-package yaml-mode
    :config
    (add-hook 'yaml-mode-hook 'flycheck-mode)
    (add-hook 'yaml-mode-hook 'flyspell-mode))
  (use-package flycheck-yamllint)
  (use-package restclient
    :mode ("\\.restclient\\'" . restclient-mode))
  (use-package company-restclient
    :config (add-to-list 'company-backends 'company-restclient))
  (use-package ob-restclient)
  (use-package plantuml-mode)
  (let ((plantuml-directory (concat config-load-path "extra/"))
        (plantuml-link "https://superb-dca2.dl.sourceforge.net/project/plantuml/plantuml.jar"))
    (let ((plantuml-target (concat plantuml-directory "plantuml.jar")))
      (if (not (f-exists? plantuml-target))
          (progn (message "Downloading plantuml.jar")
                 (shell-command
                  (mapconcat 'identity (list "wget" plantuml-link "-O" plantuml-target) " "))
                 (kill-buffer "*Shell Command Output*")))
      (setq org-plantuml-jar-path plantuml-target)))
  (use-package 2048-game)
  (use-package isend-mode)
  (use-package lorem-ipsum)
  (use-package markdown-mode)
  (use-package pdf-tools
    :defer t)
  (use-package refine)
  (use-package request)
  (use-package csv-mode)
  ;; (use-package csharp-mode)
  (use-package keychain-environment)
  (use-package prodigy)
  (use-package vlf)
  (use-package helm-flyspell)
  (use-package load-dir
    :config (setq load-dirs (concat config-load-path "extra/")))
  (use-package keyfreq
    :config
    (keyfreq-mode 1)
    (keyfreq-autosave-mode 1))

  (use-package f3
    :config  (setq eshell-visual-commands
             '("less" "tmux" "htop" "top" "bash" "zsh" "fish"))

             (setq eshell-visual-subcommands
             '(("git" "log" "l" "diff" "show")))

             ;; Prompt with a bit of help from http://www.emacswiki.org/emacs/EshellPrompt
             (defmacro with-face (str &rest properties)
             `(propertize ,str 'face (list ,@properties)))

             (defun eshell/abbr-pwd ()
                (let ((home (getenv "HOME"))
                    (path (eshell/pwd)))
                (cond
                    ((string-equal home path) "~")
                    ((f-ancestor-of? home path) (concat "~/" (f-relative path home)))
                    (path))))

             (defun eshell/my-prompt ()
                 (let ((header-bg "#161616"))
                    (concat
                        (with-face (eshell/abbr-pwd) :foreground "#008700")
                    (if (= (user-uid) 0)
                        (with-face "#" :foreground "red")
                        (with-face "$" :foreground "#2345ba"))
                        " ")))
             (setq eshell-prompt-function 'eshell/my-prompt)
             (setq eshell-highlight-prompt nil)
             (setq eshell-prompt-regexp "^[^#$\n]+[#$] ")
             (setq eshell-cmpl-cycle-completions nil))
(use-package kubernetes
  :ensure t
  :commands (kubernetes-overview)
  :config
  (setq kubernetes-poll-frequency 3600
        kubernetes-redraw-frequency 3600))
  (use-package terraform-mode
    :config
    (defun my-terraform-mode-init ()
      if you want to use outline-minor-mode
      (outline-minor-mode 1))

    (add-hook 'terraform-mode-hook 'my-terraform-mode-init))

  ;; terraform-ls is requered
  ;; https://github.com/hashicorp/terraform-ls
  (use-package lsp-mode
    :ensure t
    :hook (terraform-mode . lsp-deferred)
    :commands (lsp lsp-deferred)
    :custom
    (lsp-disabled-clients '(tfls))
    (lsp-terraform-ls-prefill-required-fields t)
    (lsp-terraform-ls-enable-show-reference t)
    (lsp-semantic-tokens-enable t)
    (lsp-semantic-tokens-honor-refresh-requests t)
    (lsp-enable-links t))

  (use-package dockerfile-mode
    :mode "Dockerfile\\'")
  (use-package docker-compose-mode
    :mode "docker-compose\\'")
  ;; https://www.openpolicyagent.org/docs/v0.11.0/get-started/
  (use-package rego-mode
    :ensure t
    :custom
    (rego-repl-executable "~/.local/bin/opa")
    (rego-opa-command "~/.local/bin/opa"))
  (use-package json-mode)
(use-package web-mode
  :mode "\\.phtml\\'"
  :mode "\\.volt\\'"
  :mode "\\.html\\'")
  (use-package emmet-mode
    :config
    (add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
    (add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
    )
  (require 'sql)
  (sql-set-product "postgres")
(use-package sqlup-mode
   :config (add-hook 'sql-mode-hook 'sqlup-mode))
(use-package sql-indent
   :config (add-hook 'sql-mode-hook 'sqlind-minor-mode))
  (use-package php-mode
    :config
    (add-hook 'php-mode-hook 'flycheck-mode)
    (add-hook 'php-mode-hook 'electric-operator-mode)
    (add-hook 'php-mode-hook 'dumb-jump-mode)
    (add-hook 'php-mode-hook 'php-enable-psr2-coding-style))
  (use-package company-php
    :config
    (add-hook 'php-mode-hook 'company-mode)
    (add-hook 'php-mode-hook '(lambda ()
                                (if (not (member 'php-mode company-dabbrev-code-modes))
                                    (add-to-list 'company-dabbrev-code-modes 'php-mode)))))
  (setq auto-complete-mode nil)
  (use-package php-eldoc
    :diminish eldoc-mode
    :config (add-hook 'php-mode-hook 'php-eldoc-enable))
  (use-package typescript-mode
    :mode "\\.ts\\'"
    :hook (typescript-mode . lsp-deferred)
    :config
    (setq typescript-indent-level 2))
  (use-package go-mode
    :config
    (add-hook 'before-save-hook #'gofmt-before-save)
    (add-hook 'go-mode-hook 'flycheck-mode)
    (add-hook 'go-mode-hook 'dumb-jump-mode)
    (setq go-packages-function 'go-packages-go-list))
  (use-package lsp-mode
    :commands (lsp lsp-deferred)
    :init
    (setq lsp-keymap-prefix "C-c l")
    :config
    (lsp-enable-which-key-integration t)
    :hook
    ((go-mode) . lsp))


  (use-package lsp-ui
    :hook (lsp-mode . lsp-ui-mode)
    :config
    (setq lsp-ui-doc-enable t))

  ;; To set the garbage collection threshold to high (100 MB) since LSP client-server communication generates a lot of output/garbage
  (setq gc-cons-threshold 100000000)
  ;; To increase the amount of data Emacs reads from a process
  (setq read-process-output-max (* 1024 1024))
  (add-hook 'python-mode-hook 'electric-operator-mode)
  (setq python-shell-interpreter "ipython"
        python-shell-interpreter-args "--simple-prompt -i")


  ;; ;; You need to install pyright in the system first =pip install pyright=, for Mac you might want on install it with `npm` =sudo npm install -g pyright=
  ;; (use-package lsp-pyright
  ;;   :ensure t
  ;;   :hook (python-mode . (lambda ()
  ;;                          (require 'lsp-pyright)
  ;;                          (lsp-deferred)))
  ;;   :custom
  ;;   (python-shell-interpreter "python3"))  ; or lsp-deferred
  (use-package elpy
    :ensure t
    :init
    (elpy-enable))
    ;; (use-package rustic
    ;;   :ensure
    ;;   :bind (:map rustic-mode-map
    ;; 		("M-j" . lsp-ui-imenu)
    ;; 		("M-?" . lsp-find-references)
    ;; 		("C-c C-c l" . flycheck-list-errors)
    ;; 		("C-c C-c a" . lsp-execute-code-action)
    ;; 		("C-c C-c r" . lsp-rename)
    ;; 		("C-c C-c q" . lsp-workspace-restart)
    ;; 		("C-c C-c Q" . lsp-workspace-shutdown)
    ;; 		("C-c C-c s" . lsp-rust-analyzer-status))
    ;;   :config
    ;;   ;; uncomment for less flashiness
    ;;   ;; (setq lsp-eldoc-hook nil)
    ;;   ;; (setq lsp-enable-symbol-highlighting nil)
    ;;   ;; (setq lsp-signature-auto-activate nil)

    ;;   ;; comment to disable rustfmt on save
    ;;   (setq rustic-format-on-save t)
    ;;   (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook))

    ;; (defun rk/rustic-mode-hook ()
    ;;   ;; so that run C-c C-c C-r works without having to confirm, but don't try to
    ;;   ;; save rust buffers that are not file visiting. Once
    ;;   ;; https://github.com/brotzeit/rustic/issues/253 has been resolved this should
    ;;   ;; no longer be necessary.
    ;;   (when buffer-file-name
    ;;     (setq-local buffer-save-without-query t))
    ;;   (add-hook 'before-save-hook 'lsp-format-buffer nil t))


  (use-package yasnippet
    :ensure t
    :hook ((lsp-mode . yas-minor-mode)))


  (use-package lsp-mode
    :ensure
    :commands lsp
    :custom
    ;; what to use when checking on-save. "check" is default, I prefer clippy
    (lsp-rust-analyzer-cargo-watch-command "clippy")
    (lsp-eldoc-render-all t)
    (lsp-idle-delay 0.6)
    ;; enable / disable the hints as you prefer:
    (lsp-inlay-hint-enable t)
    ;; These are optional configurations. See https://emacs-lsp.github.io/lsp-mode/page/lsp-rust-analyzer/#lsp-rust-analyzer-display-chaining-hints for a full list
    (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
    (lsp-rust-analyzer-display-chaining-hints t)
    (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names t)
    (lsp-rust-analyzer-display-closure-return-type-hints t)
    (lsp-rust-analyzer-display-parameter-hints t)
    (lsp-rust-analyzer-display-reborrow-hints t)
    :config
    (add-hook 'lsp-mode-hook 'lsp-ui-mode))

  (use-package lsp-ui
    :ensure
    :commands lsp-ui-mode
    :custom
    (lsp-ui-peek-always-show t)
    (lsp-ui-sideline-show-hover t)
    (lsp-ui-doc-enable nil))

  (use-package rust-mode
    :config (autoload 'rust-mode "rust-mode" nil t)
    (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
    (add-hook 'rust-mode-hook #'lsp))

    ;; JAVA 17+ is required to be installed for jdtls
    ;; https://github.com/eruizc-dev/jdtls-launcher
    (use-package lsp-java :config
      (add-hook 'java-mode-hook 'lsp))
   (use-package kotlin-mode)
   (use-package ob-kotlin)
   (require 'ob-kotlin)
  ;; (use-package scala-mode
  ;;   :interpreter ("scala" . scala-mode))
   (use-package clojure-mode
     :init
     (add-hook 'clojure-mode-hook 'lsp)
     (add-hook 'clojurescript-mode-hook 'lsp)
     (add-hook 'clojurec-mode-hook 'lsp))

  (when (cl-find-if-not #'package-installed-p package-selected-packages)
    (package-refresh-contents)
    (mapc #'package-install package-selected-packages))

  ;; (use-package cider)
  ;; (use-package clojure-lsp
  ;;   :ensure t
  ;;   :hook (clojure-mode . lsp-deferred)
  ;;   :commands (lsp lsp-deferred)
  ;;   :custom
  ;;   (setq lsp-clojure-custom-server-command '("bash" "-c" "/usr/local/bin/clojure-lsp"))
  ;;   (gc-cons-threshold (* 100 1024 1024))
  ;;   (read-process-output-max (* 1024 1024))
  ;;   (treemacs-space-between-root-nodes nil)
  ;;   (company-minimum-prefix-length 1)
  ;;   (lsp-enable-indentation nil) ; uncomment to use cider indentation instead of lsp
  ;;   (lsp-enable-completion-at-point nil)) ; uncomment to use cider completion instead of lsp
