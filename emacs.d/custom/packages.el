(provide 'packages)

(use-package magit
   :config
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
  ;(setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
  ;(ivy-posframe-mode 1)
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
  :bind ("M-/" . company-idle-delay-complete)
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
              :around #'rgc-lua-at-most-one-indent)

  (defconst tnt-env "source sdk/env.sh")
  (defconst tnt-test ".rocks/bin/luatest")
  (defconst tnt-lint ".rocks/bin/luacheck . --formatter plain")

  (defun tnt-run (cmd arg)
    (let ((compile-command (format "%s && %s %s" tnt-env cmd arg)))
      (call-interactively #'project-compile)))

  (defun tnt-run-tests (arg)
    (tnt-run tnt-test arg))

  (defun tnt-run-lint ()
    (interactive)
    (tnt-run tnt-lint ""))

  (defun tnt-current-group ()
    (save-excursion
      (save-match-data
        (goto-char (point-min))
        (re-search-forward "t.group('")
        (re-search-forward (lua-rx lua-name))
        (match-string 0))))

  ;; NOTE: work only with "g.test_debug = function()" functions headers
  (defun tnt-current-test-case ()
    (save-excursion
      (save-match-data
        (let ((name-patttern (lua-rx lua-name)))
          (re-search-backward lua--beginning-of-defun-re nil t)
          (lua-forward-sexp 2)
          (re-search-backward name-patttern nil t)
          (match-string 0)))))

  (defun tnt-run-test-case ()
    (interactive)
    (let ((groupname (tnt-current-group))
          (casename (tnt-current-test-case)))
      (tnt-run-tests (format "%s.%s" groupname casename))))

  (defun tnt-run-group ()
    (interactive)
    (let ((groupname (tnt-current-group)))
      (tnt-run-tests groupname)))

  (defun tnt-run-test-file ()
    (interactive)
    (tnt-run-tests (plgc-rel-filename)))
  (defun tnt-run-all-tests ()
    (interactive)
    (tnt-run-tests ""))
  (defun tnt-kill-all ()
    (interactive)
    (shell-command "pkill -9 tarantool"))

  (global-set-key (kbd "C-c t t") 'tnt-run-test-case)
  (global-set-key (kbd "C-c t g") 'tnt-run-group)
  (global-set-key (kbd "C-c t f") 'tnt-run-test-file)
  (global-set-key (kbd "C-c t a") 'tnt-run-all-tests)
  (global-set-key (kbd "C-c t l") 'tnt-run-lint)
  (global-set-key (kbd "C-c t k") 'tnt-kill-all))

(use-package go-mode)

(use-package xterm-color
  :config
  (setq compilation-environment '("TERM=xterm-256color"))
  (defun plgc-advice-compilation-filter (f proc string)
    (funcall f proc (xterm-color-filter string)))
  (advice-add 'compilation-filter :around #'plgc-advice-compilation-filter))

(use-package jsonnet-mode)

(use-package eglot
  :hook  ((lua-mode . eglot-ensure)
          (c++-mode . eglot-ensure)
          (c-mode . eglot-ensure)
          (go-mode . eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs
               '(lua-mode . ("lua-language-server")))
  (add-to-list 'eglot-server-programs
               '((c++-mode c-mode) . ("clangd")))
  (add-to-list 'eglot-server-programs
               '(go-mode . ("gopls"))))

(use-package org
  :config
  (setq org-export-backends '(ascii html latex md))
  (setq org-default-notes-file (concat org-directory "/notes.org"))
  (setq org-startup-indented t)
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c c" . org-capture)))
