(if (fboundp 'menu-bar-mode)
    (menu-bar-mode -1))

;;; Disable menu-bar, tool-bar, and scroll-bar.

(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))

(setq make-backup-files nil)
(setq gc-cons-threshold 100000000)
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
(setq-default show-trailing-whitespace t)
(setq inhibit-startup-screen t)
(setq initial-scratch-message "")
(fset 'yes-or-no-p 'y-or-n-p)
(show-paren-mode 1)
(setq linum-format"%4d ")
(delete-selection-mode 1)
(global-auto-revert-mode t)

;; deleting trailing whitespaces only in prog-modes
(add-hook 'before-save-hook
          (lambda ()
            (when (and (not (eq major-mode 'text-mode))
                       (not (eq major-mode 'fundamental-mode)))
	          (delete-trailing-whitespace))))

(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'prog-mode-hook 'electric-pair-mode)
(add-hook 'prog-mode-hook 'yas-minor-mode)

(setq create-lockfiles nil)

(load-theme 'modus-operandi)

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
  (setq lua-default-application "tarantool")

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

(defun rgc-lua-at-most-one-indent (old-function &rest arguments)
  (let ((old-res (apply old-function arguments)))
    (if (> old-res 4) 4 old-res)))

(advice-add #'lua-calculate-indentation-block-modifier
            :around #'rgc-lua-at-most-one-indent)

(use-package eglot
  :ensure t
  :hook  ((lua-mode . eglot-ensure)
          (c++-mode . eglot-ensure)
          (c-mode . eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs
               '(lua-mode . ("lua-language-server")))
  (add-to-list 'eglot-server-programs
               '((c++-mode c-mode) . ("clangd"))))

(use-package xterm-color
  :ensure t
  :config
  (setq compilation-environment '("TERM=xterm-256color"))
  (defun plgc-advice-compilation-filter (f proc string)
    (funcall f proc (xterm-color-filter string)))
  (advice-add 'compilation-filter :around #'plgc-advice-compilation-filter))

(use-package jsonnet-mode
  :ensure t)

(defun plgc-available-fonts ()
  (interactive)
  (seq-filter (lambda (font)
                (when-let ((info (font-info font)))
                  (string-match-p "spacing=100" (aref info 1))))
              (font-family-list)))

(defun plgc-rel-filename ()
  (file-relative-name buffer-file-truename
                      (project-root (project-current t))))

(defun plgc-org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
  (interactive)
  (setq filename
        (concat
         (make-temp-name
          (concat (buffer-name)
                  "_"
                  (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
  (call-process "pngpaste" nil nil nil filename)
  (insert "#+ATTR_ORG: :width 50%\n")
  (org-insert-link nil (concat "./" filename))
  (org-display-inline-images))

(setq custom-file (concat user-emacs-directory "custom.el"))
(if (file-exists-p custom-file)
    (load custom-file))

(defun kill-all-buffers ()
  (interactive)
  (mapcar 'kill-buffer (buffer-list))
  (delete-other-windows))

(setq org-export-backends '(ascii html latex md))

(put 'upcase-region 'disabled nil)

(defun plgc-clone-repos (repos directory)
  "Clone a list of repositories from a GitHub USER into DIRECTORY."
  (let ((default-directory directory))
    (dolist (repo repos)
      (eshell-command (format "git clone https://cicd-git.megafon.ru/MFactory/apiration/%s.git" repo)))))

(defun plg-multi-apply (dirs patch)
(dolist (directory dirs)
  (let ((default-directory directory))
    (magit-run-git "apply" "--index" patch))))

;; (let ((dir "~/code/MFactoryConf/apiration/"))
;;   (seq-remove (lambda (d) (or (string= d ".") (string= d "..")))
;;               (directory-files dir nil nil t)))


(defun my-git-patch-diff-apply (source-dir target-dir)
  "Create patch from last commit in the SOURCE-DIR directory and apply it to the TARGET-DIR directory."
  (interactive "DDirectory with source repository: \nDDirectory with target repository: ")
  (let ((default-directory source-dir)
        (patch-file (concat (substring (shell-command-to-string "git rev-parse --show-toplevel") 0 -1) "last-commit.patch")))
    (shell-command (concat "git format-patch -1 -o " patch-file))
    (message (concat "Patch created: " patch-file))
    (let ((default-directory target-dir))
      (shell-command (concat "git am " patch-file))
      (message "Patch applied.")))
  patch-file)


;; (defun git-pull-all-subdirs ()
;;   "Perform git pull on all subdirectories of a interactively specified directory."
;;   (interactive)
;;   (setq directory (read-directory-name "Enter directory: "))
;;   (setq subdirs (directory-files directory t "^[^.]" t))
;;   (dolist (subdir subdirs)
;;     (shell-command (concat "git -C " subdir " pull"))))

(defun git-pull-all-subdirs-with-progress ()
  "Perform git pull on all subdirectories of a interactively specified directory and display a progress bar and report."
  (interactive)
  (setq directory (read-directory-name "Enter directory: "))
  (setq subdirs (directory-files directory t "^[^.]" t))
  (setq total (length subdirs))
  (setq count 0)
  (with-current-buffer (get-buffer-create "*git-pull-progress*")
    (erase-buffer)
    (insert (format "Performing git pull on %d subdirectories...\n" total))
    (progress-reporter-update (progress-reporter-update-bar nil))
    (dolist (subdir subdirs)
      (shell-command (concat "git -C " subdir " pull"))
      (setq count (1+ count))
      (progress-reporter-update (/ count total)))
    (progress-reporter-done)
    (insert (format "Finished git pull on %d subdirectories.\n" total)))
  (display-buffer "*git-pull-progress*"))


(defun git-pull-all-subdirs-with-progress ()
  "Perform git pull on all subdirectories of a interactively specified directory and display a progress bar and report."
  (interactive)
  (setq directory (read-directory-name "Enter directory: "))
  (setq subdirs (directory-files directory t "^[^.]" t))
  (setq total (length subdirs))
  (setq count 0)
  (with-current-buffer (get-buffer-create "*git-pull-progress*")
    (erase-buffer)
    (insert (format "Performing git pull on %d subdirectories...\n" total))
    (setq progress (make-progress-reporter "git-pull-all-subdirs" count total))
    (dolist (subdir subdirs)
      (shell-command (concat "git -C " subdir " pull"))
      (setq count (1+ count))
      (progress-reporter-update progress count))
    (progress-reporter-done progress)
    (insert (format "Finished git pull on %d subdirectories.\n" total)))
  (display-buffer "*git-pull-progress*"))

(defun get-git-statuses-in-directory ()
    "Return a list of git statuses in subdirectories of a user-selected directory."
    (interactive)
    (let ((directory (read-directory-name "Select directory: ")))
        (let ((subdirectories (seq-remove (lambda (x) (string-match-p "^\\.+$" x))
                (directory-files directory t "^[^.].*" 'nosort))))
            (dolist (subdirectory subdirectories)
                (let ((result (condition-case nil
                                (shell-command-to-string (concat "cd " subdirectory " && git status"))
                                (error (concat "Error in " subdirectory)))))
                    (message "Git status in %s: %s" subdirectory result))))))

