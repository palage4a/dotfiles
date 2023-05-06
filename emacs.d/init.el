;; setup package.el
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(unless package--initialized (package-initialize))

;; setup use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (add-to-list 'load-path (expand-file-name "custom" user-emacs-directory))
  (require 'use-package))
(setq use-package-always-ensure t)

(require 'general)
(require 'packages)
(require 'functions)
(require 'variables)
(put 'scroll-left 'disabled nil)
(put 'magit-clean 'disabled nil)
(put 'narrow-to-region 'disabled nil)
