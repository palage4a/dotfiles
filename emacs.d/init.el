(if (fboundp 'menu-bar-mode)
    (menu-bar-mode -1))

;;; Disable menu-bar, tool-bar, and scroll-bar.
(setq gc-cons-threshold 100000000)
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))

(setq make-backup-files nil)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(global-hl-line-mode 1)
(column-number-mode 1)
(global-auto-revert-mode 1)
(auto-save-visited-mode 1)

(set-frame-font "Terminus (TTF) 16" nil t)
(setq indent-line-function 'insert-tab)
(setq delete-trailing-lines nil)

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
(add-hook 'prog-mode-hook #'yas-minor-mode)

(setq create-lockfiles nil)

(load-theme 'modus-vivendi)

(use-package magit
   :config
   (global-set-key (kbd "C-x g") 'magit-status))

(use-package exec-path-from-shell
  :ensure t
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
  :ensure t
  :hook
  (prog-mode . yas-minor-mode)
  :config
  (yas-reload-all)
  (setq yas-snippet-dirs
        '("~/.emacs.d/snippets")))

(use-package yaml-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode)))

(use-package lua-mode
  :ensure t
  :config
  (autoload 'lua-mode "lua-mode" "Lua editing mode." t)
  (add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
  (add-to-list 'interpreter-mode-alist '("lua" . lua-mode))
  (setq lua-indent-level 4)
  (setq lua-indent-string-contents nil)
  (setq lua-indent-close-paren-align nil)
  (setq lua-default-application "tarantool"))

(defun rgc-lua-at-most-one-indent (old-function &rest arguments)
  (let ((old-res (apply old-function arguments)))
    (if (> old-res 4) 4 old-res)))

(advice-add #'lua-calculate-indentation-block-modifier
            :around #'rgc-lua-at-most-one-indent)

(use-package eglot
  :ensure t
  :hook
  (lua-mode . eglot-ensure)
  (c++-mode . eglot-ensure)
  (c-mode . eglot-ensure)
  :config
    (add-to-list 'eglot-server-programs
                 '(lua-mode . ("lua-language-server")))
    (add-to-list 'eglot-server-programs
                 '((c++-mode c-mode) . ("clangd"))))

(defun plgc-available-fonts ()
  (interactive)
  (seq-filter (lambda (font)
                (when-let ((info (font-info font)))
                  (string-match-p "spacing=100" (aref info 1))))
              (font-family-list)))

(defun tnt-run-test-file ()
  (interactive)
  (let ((compile-command (format "source sdk/env.sh && .rocks/bin/luatest -v %s" (file-relative-name buffer-file-truename (project-root (project-current t)))))) ;; FIXME refactor that
  (call-interactively #'project-compile )))

(defun tnt-run-tests ()) ;; TODO
(defun tnt-run-test-case ()) ;; TODO

(defun org-past-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
  (interactive)
  (setq filename
        (concat
         (make-temp-name
          (concat (buffer-file-name)
                  "_"
                  (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
  (call-process "pngpaste" nil nil nil filename)

  (insert (concat "[[" filename "]]"))
  (org-display-inline-images))

(setq custom-file (concat user-emacs-directory "custom.el"))
(if (file-exists-p custom-file)
    (load custom-file))

