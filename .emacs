(setq gc-cons-threshold 100000000)

;;; Disable menu-bar, tool-bar, and scroll-bar.
(if (fboundp 'menu-bar-mode)
    (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))

(setq make-backup-files nil)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(setq indent-line-function 'insert-tab)



;; setup package.el
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(unless package--initialized (package-initialize))

;; setup use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

(setq-default cursor-type 'bar)
(setq inhibit-startup-screen t)
(setq initial-scratch-message "")
(fset 'yes-or-no-p 'y-or-n-p)
(show-paren-mode 1)
(setq linum-format"%4d ")
(delete-selection-mode 1)
(global-auto-revert-mode t)


(add-hook 'before-save-hook
	  'delete-trailing-whitespace)

(add-hook 'prog-mode-hook
	  (if (and (fboundp 'display-line-numbers-mode) (display-graphic-p))
	      #'display-line-numbers-mode
	    #'linum-mode))
(add-hook 'prog-mode-hook
          (lambda ()
            (setq show-trailing-whitespace t)))
(add-hook 'prog-mode-hook 'electric-pair-mode)

(load-theme 'tango t)

(setq create-lockfiles nil)

;; git related packages
(use-package magit
  :config
  (global-set-key (kbd "C-x g") 'magit-status))

(use-package counsel ;; ivy
  :config
  (ivy-mode 1)
  (setq ivy-height 25)
  (use-package ivy-posframe)
  ;(setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
  ;(ivy-posframe-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (global-set-key "\C-s" 'swiper)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "C-c k") 'counsel-rg)
  (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history))

;; Company is for code auto-completion
(use-package company
  :hook (after-init . global-company-mode)
  :bind ("M-/" . company-idle-delay-complete)
  :bind ("C-x C-/" . dabbrev-expand)
  :config
  (setq company-idle-delay 0))

(use-package lua-mode
  :ensure t)

(use-package eglot
  :ensure t
  :config
  (add-to-list 'eglot-server-programs
               '(lua-mode . ("lua-language-server", "--stdio"))))

(use-package tree-sitter-langs
  :ensure t
  :after tree-sitter)

(use-package tree-sitter
  :ensure t
  :config
  (global-tree-sitter-mode))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(tree-sitter-langs eglot lua-mode company ivy-posframe counsel magit use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
