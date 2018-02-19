(package-initialize)
(elpy-enable)

(require 'org)
(org-babel-load-file "~/.emacs.d/config.org")

(epa-file-enable)
(ac-config-default)
(put 'upcase-region 'disabled nil)

;; '(custom-enabled-themes (quote (solarized-dark)))
