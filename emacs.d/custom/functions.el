(provide 'functions)

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

(defun plgc-clone-repos (repos directory)
  "Clone a list of repositories from a GitHub USER into DIRECTORY."
  (let ((default-directory directory))
    (dolist (repo repos)
      (eshell-command (format "git clone https://cicd-git.megafon.ru/MFactory/apiration/%s.git" repo)))))

(defun plg-multi-apply (dirs patch)
  (dolist (directory dirs)
    (let ((default-directory directory))
      (magit-run-git "apply" "--index" patch))))

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

(defun kill-all-buffers ()
  (interactive)
  (mapcar 'kill-buffer (buffer-list))
  (delete-other-windows))
