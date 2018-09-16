(setq-default indent-tabs-mode nil)

(setq tab-width 4)

(global-auto-revert-mode 1)

(setq x-select-enable-clipboard t)

(winner-mode t)
(windmove-default-keybindings)

(menu-bar-mode -1)

(tool-bar-mode -1)

(setq inhibit-startup-screen t)

(scroll-bar-mode -1)

(column-number-mode)

(global-hl-line-mode)

(highlight-indent-guides-mode 1)

(global-linum-mode 1)
(setq linum-format "%d ")

(electric-pair-mode 1)
(when (fboundp 'electric-indent-mode) (electric-indent-mode -1)) ; Disable electric-indent-mode

(show-paren-mode)

(ido-mode)

(which-key-mode 1)

(xterm-mouse-mode 1)

(setq multi-term-program "/bin/zsh")

(setq
    backup-by-copying t      ; don't clobber symlinks
    backup-directory-alist
    '(("." . "~/.emacs-backups"))    ; don't litter my fs tree
    delete-old-versions t
    kept-new-versions 6
    kept-old-versions 2
    version-control t)       ; use versioned backups

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))

(setq mouse-wheel-progressive-speed nil)

(setq mouse-wheel-follow-mouse 't)

(setq scroll-step 1)

(global-set-key [f7] 'neotree-toggle)
(global-set-key [f8] 'helm-projectile)
(global-set-key [f9] 'helm-projectile-grep)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-commad)

(global-set-key (kbd "<mouse-4>") 'scroll-down-line)
(global-set-key (kbd "<mouse-5>") 'scroll-up-line)

(add-hook 'prog-mode-hook #'hs-minor-mode)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js-mode-hook 'js2-minor-mode)
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-jsx-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-jsx-mode))

(add-to-list 'auto-mode-alist '("\\.tsx?\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.ts?\\'" . typescript-mode))

(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)

(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-enable-auto-pairing t)
(setq web-mode-enable-css-colorization t)
(setq web-mode-enable-comment-keywords t)

(add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))

(setq flymake-python-pyflakes-executable "flake8")

(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-hook 'yaml-mode-hook 'flymake-yaml-load)

(autoload 'apache-mode "apache-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.htaccess\\'"   . apache-mode))
(add-to-list 'auto-mode-alist '("httpd\\.conf\\'"  . apache-mode))
(add-to-list 'auto-mode-alist '("srm\\.conf\\'"    . apache-mode))
(add-to-list 'auto-mode-alist '("access\\.conf\\'" . apache-mode))
(add-to-list 'auto-mode-alist '("sites-\\(available\\|enabled\\)/" . apache-mode))

(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)
(setq-default c-basic-offset 4)
(c-add-style "my-style" 
    '("stroustrup"
         (indent-tabs-mode . nil)        ; use spaces rather than tabs
         (c-basic-offset . 4)            ; indent by four spaces
         (c-offsets-alist . ((inline-open . 0)  ; custom indentation rules
             (brace-list-open . 0)
             (statement-case-open . +)))))

(defun my-c++-mode-hook ()
  (c-set-style "my-style")        ; use my-style defined above
  (auto-fill-mode)
  (c-toggle-auto-hungry-state 1))

(add-hook 'c++-mode-hook 'my-c++-mode-hook)

(add-hook 'org-mode-hook 'org-bullets-mode)

(setq doc-view-continuous t)

(setq org-todo-keywords
    '((sequence "TODO" "PENDING" "DOING" "|" "DONE" "DELEGATED")))

(require 'ox-reveal)
(setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/")
(setq Org-Reveal-title-slide nil)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))

(when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))

(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t) ; Org-mode's repository
(add-to-list 'package-archives '("elpy" . "https://jorgenschaefer.github.io/packages/")) ; package-install elpy
