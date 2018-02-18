(package-initialize)
(elpy-enable)

(require 'org)
(org-babel-load-file "~/.emacs.d/config.org")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (foggy-night)))
 '(custom-safe-themes
   (quote
    ("83db918b06f0b1df1153f21c0d47250556c7ffb5b5e6906d21749f41737babb7" "d606ac41cdd7054841941455c0151c54f8bff7e4e050255dbd4ae4d60ab640c1" foggy-night)))
 '(package-selected-packages
   (quote
    (arjen-grey-theme which-key ace-isearch vue-mode typescript-mode todotxt-mode swift3-mode swift-mode solidity-mode solarized-theme smex rjsx-mode react-snippets ranger python-django python pylint pygen ox-twbs ox-html5slide org-trello org-tree-slide org-table-sticky-header org-repo-todo org-projectile-helm org-preview-html org-pdfview org-gcal org-download org-doing org-dashboard org-bullets org-brain org-beautify-theme org-autolist org-agenda-property org-ac neotree multi-term mc-extras matlab-mode markdown-mode+ magit-imerge karma jsx-mode jst json-navigator json-mode js2-refactor js2-highlight-vars js-format js-auto-beautify jist jenkins-watch jenkins jedi-direx jdee javadoc-lookup java-snippets java-imports jastadd-ast-mode jasminejs-mode jar-manifest-mode htmlize helm-projectile helm-aws haskell-mode foggy-night-theme flymake-shell flymake-python-pyflakes flymake-jshint flymake-go flymake-gjshint flymake-cppcheck flycheck-yamllint flycheck-irony dracula-theme dockerfile-mode docker-compose-mode color-theme-solarized color-theme-molokai cmake-mode ansible android-mode all ac-slime ac-python ac-php ac-js2 ac-ispell ac-html-bootstrap ac-html-angular ac-html ac-helm)))
 '(send-mail-function (quote smtpmail-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(epa-file-enable)
(ac-config-default)
(put 'upcase-region 'disabled nil)
