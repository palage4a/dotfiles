(provide 'packages)

(use-package magit
  :config
  ;; Performance tricks (idk is it working or not)
  (setq magit-auto-revert-mode nil)
  (remove-hook 'magit-refs-sections-hook 'magit-insert-tags)
  (remove-hook 'server-switch-hook 'magit-commit-diff)
  (remove-hook 'with-editor-filter-visit-hook 'magit-commit-diff)
  (global-set-key (kbd "C-x g") 'magit-status))

(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)))

(use-package counsel ;; ivy
  :config
  (ivy-mode 1)
  (setq ivy-height 25)
  (use-package ivy-posframe)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (global-set-key "\C-s" 'swiper)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  ;; (global-set-key (kbd "C-c k") 'counsel-rg)
  ;; (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history))
  )

;; Company is for code auto-completion
(use-package company
  :hook (after-init . global-company-mode)
  :bind ("C-x C-/" . dabbrev-expand)
  :config
  (setq company-idle-delay 0))

(use-package yasnippet
  :hook
  (prog-mode . yas-minor-mode)
  :config
  (setq yas-snippet-dirs
        '("~/.emacs.d/custom/snippets"))
  (yas-reload-all))

(use-package xterm-color
  :config
  (setq compilation-environment '("TERM=xterm-256color"))
  (defun plgc-advice-compilation-filter (f proc string)
    (funcall f proc (xterm-color-filter string)))
  (advice-add 'compilation-filter :around #'plgc-advice-compilation-filter))

(use-package org
  :config
  (setq org-export-backends '(ascii html latex md))
  (setq org-default-notes-file (concat org-directory "/notes.org"))
  (setq org-startup-indented t)
  (setq org-todo-keywords
        '((sequence "TODO(t)" "|" "DONE(d)")
          (sequence "|" "CANCELED(c)")))
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c c" . org-capture)
         ("C-c e" . org-edit-src-code)))

(use-package org-roam
  :config
  (setq org-roam-directory "~/org/roam/")
  (org-roam-db-autosync-mode)
  :bind(("C-c o c" . org-roam-capture)
        ("C-c o f" . org-roam-node-find)
        ("C-c o i" . org-roam-node-insert)))

(use-package org-roam-ui)

;; Languages
(use-package markdown-mode
  :mode ("\\.md\\'" . gfm-mode)
  :commands (markdown-mode gfm-mode))
(use-package dockerfile-mode)
(use-package protobuf-mode)
(use-package jsonnet-mode)
(use-package js2-mode)
(use-package typescript-mode)
(use-package rust-mode)
(use-package go-mode
  :config
  (add-hook 'before-save-hook 'gofmt-before-save))

(use-package yaml-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode)))
(use-package lua-mode
  :config
  (autoload 'lua-mode "lua-mode" "Lua editing mode." t)
  (add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
  (add-to-list 'interpreter-mode-alist '("lua" . lua-mode))
  (setq lua-indent-level 4)
  (setq lua-indent-string-contents nil)
  (setq lua-indent-close-paren-align nil)
  (setq lua-default-application "tarantool")
  (defun rgc-lua-at-most-one-indent (old-function &rest arguments)
    (let ((old-res (apply old-function arguments)))
      (if (> old-res 4) 4 old-res)))
  (advice-add #'lua-calculate-indentation-block-modifier
              :around #'rgc-lua-at-most-one-indent))

(use-package flymake
  :config
  (global-set-key (kbd "C-x `") 'flymake-goto-next-error))

(use-package eglot
  :hook  ((lua-mode . eglot-ensure)
          (c++-mode . eglot-ensure)
          (c-mode . eglot-ensure)
          (go-mode . eglot-ensure)
          (typescript-mode . eglot-ensure)
          (jsonnet-mode . eglot-ensure)
          (rust-mode . eglot-ensure))
  :config
  (setq-default eglot-workspace-configuration
                '(:rust-analyzer (:files (:excludeDirs ("target")))))
  (add-to-list 'eglot-server-programs
               '(lua-mode . ("lua-language-server")))
  (add-to-list 'eglot-server-programs
               '((c++-mode c-mode) . ("clangd")))
  (add-to-list 'eglot-server-programs
               '((typescript-mode) . ("typescript-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs
               '((jsonnet-mode) . ("jsonnet-language-server")))

  (global-set-key (kbd "C-c e o") 'eglot-code-action-organize-imports)
  (global-set-key (kbd "C-c e f") 'eglot-format-buffer)
  (global-set-key (kbd "C-c e a") 'eglot-code-actions)
  (global-set-key (kbd "C-c e r") 'eglot-rename))
