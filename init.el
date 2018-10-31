(package-initialize)
(elpy-enable)

(require 'org)
(org-babel-load-file "~/.emacs.d/config.org")

(require 'gnutls)
(add-to-list 'gnutls-trustfiles "/usr/local/etc/openssl/cert.pem")

(epa-file-enable)
(ac-config-default)
(put 'upcase-region 'disabled nil)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-safe-themes
   (quote
    ("83db918b06f0b1df1153f21c0d47250556c7ffb5b5e6906d21749f41737babb7" "ff7625ad8aa2615eae96d6b4469fcc7d3d20b2e1ebc63b761a349bebbb9d23cb" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "e297f54d0dc0575a9271bb0b64dad2c05cff50b510a518f5144925f627bb5832" "d606ac41cdd7054841941455c0151c54f8bff7e4e050255dbd4ae4d60ab640c1" solarized-dark)))
 '(menu-bar-mode nil)
 '(package-selected-packages
   (quote
    (ox-epub ox-hugo ox-impress-js ox-minutes ox-reveal solarized-theme which-key vue-mode typescript-mode todotxt-mode swift3-mode swift-mode solidity-mode smex rjsx-mode react-snippets ranger python-django python pylint pygen ox-twbs ox-html5slide org-trello org-tree-slide org-table-sticky-header org-repo-todo org-projectile-helm org-preview-html org-pdfview org-gcal org-download org-doing org-dashboard org-bullets org-brain org-beautify-theme org-autolist org-agenda-property org-ac neotree multi-term mc-extras matlab-mode markdown-mode+ magit-imerge karma jsx-mode jst json-navigator json-mode js2-refactor js2-highlight-vars js-format js-auto-beautify jist jenkins-watch jenkins jedi-direx jdee javadoc-lookup java-snippets java-imports jastadd-ast-mode jasminejs-mode jar-manifest-mode htmlize highlight-indent-guides helm-projectile helm-aws haskell-mode foggy-night-theme flymake-shell flymake-python-pyflakes flymake-jshint flymake-go flymake-gjshint flymake-cppcheck flycheck-yamllint flycheck-irony dracula-theme dockerfile-mode docker-compose-mode counsel color-theme-molokai color-theme cmake-mode arjen-grey-theme ansible android-mode all ace-isearch ac-slime ac-python ac-php ac-js2 ac-ispell ac-html-bootstrap ac-html-angular ac-html ac-helm)))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
