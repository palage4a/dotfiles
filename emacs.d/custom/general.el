(provide 'general)

;;; Disable menu-bar, tool-bar, and scroll-bar.
(if (fboundp 'menu-bar-mode)
    (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))

(setq inhibit-startup-screen t)
(setq initial-scratch-message "")
(fset 'yes-or-no-p 'y-or-n-p)

(global-hl-line-mode 1)
(column-number-mode 1)
(global-auto-revert-mode 1)
(auto-save-visited-mode 1)
(global-auto-revert-mode t)

(setq make-backup-files nil)
(setq create-lockfiles nil)

(setq gc-cons-threshold 100000000)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(setq indent-line-function 'insert-tab)
(setq delete-trailing-lines nil)

(setq-default cursor-type 'bar)
(setq-default show-trailing-whitespace t)

;; Refresh package archives with every package install
;; see https://github.com/jwiegley/use-package/issues/256#issuecomment-263313693
(defun my-package-install-refresh-contents (&rest args)
  (package-refresh-contents)
  (advice-remove 'package-install 'my-package-install-refresh-contents))
(advice-add 'package-install :before 'my-package-install-refresh-contents)

(show-paren-mode 1)

(delete-selection-mode 1)

;; deleting trailing whitespaces only in prog-modes
(add-hook 'before-save-hook
          (lambda ()
            (when (and (not (eq major-mode 'text-mode))
                       (not (eq major-mode 'fundamental-mode)))
              (delete-trailing-whitespace))))

(add-hook 'prog-mode-hook 'electric-pair-mode)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(setq custom-file (expand-file-name "custom/variables.el" user-emacs-directory))

(savehist-mode)

(setq org-capture-templates
      '(("n" "Note" entry (file+datetree "~/org/notes.org")
         "* %?\nEntered on %U\n  %i")))

(load-theme 'leuven)

(setq mac-command-modifier 'nil)
(setq mac-option-modifier 'meta)
