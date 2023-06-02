(provide 'rtm)

(defconst rtm/gh-pr-create-cmd "gh pr create --assignee @me --title '%s' --base '%s' --head '%s' --reviewer '%s' --body-file - <<- EOF
%s
EOF")

(defconst rtm/reviewers '("palage4a" "tecl1s" "runsfor"))

(defun rtm/create-pr (title base head body)
  (let ((reviewers (mapconcat 'identity rtm/release-pr-reviewers ",")))
    (rtm/call-release-procedure (format rtm/gh-pr-create-cmd title base head reviewers body))))

(defconst rtm/release-pr-description "Related to tarantool/megafon-rtm#%s

Я не забыл про:

- [x] Описание
- [x] Связанный тикет
- [x] Тесты
- [x] Документацию
- [x] Обновление CHANGELOG.md")

(defun rtm/get-release-issue-number (date)
  (shell-command-to-string (format "gh issue list --search '[RELEASE] %s'  --repo tarantool/megafon-rtm --json number --jq '.[0].number' | tr -d '\n'" date)))

(defun rtm/release-pr-is-existed (date)
  "Return true is release pull request was finded otherwise returns nil
Explanation: Command exit code will be non-zero when Pull Request does not exist"
  (when (eq (rtm/call-release-procedure (format "gh pr view release-%s" date)) 0) t))

(defun rtm/release-is-existed (date)
  "Return true is release was finded otherwise returns nil
Explanation: Command exit code will be non-zero when Release does not exist"
  (when (eq (rtm/call-release-procedure (format "gh release view %s" date)) 0) t))

(defun rtm/setup-release-branch (date)
  "Creates a release branch at the development branch"
  (rtm/call-release-procedure "git checkout dev")
  (rtm/call-release-procedure "git pull origin dev")
  (rtm/call-release-procedure (format "git branch release-%s" date))
  (rtm/call-release-procedure (format "git checkout release-%s" date)))

(defun rtm/create-release-pr (date)
  "Creates release Pull Request, if it does not exist"
  (if (rtm/release-pr-is-existed date)
      (rtm/log "Release Pull Request is existed, noop")
    (rtm/call-release-procedure "git add CHANGELOG.md")
    (rtm/call-release-procedure (format "git commit -m 'Wrap up %s release'" date))
    (rtm/call-release-procedure "git push origin HEAD")
    (let ((issue-number (rtm/get-release-issue-number date)))
      (let ((pr-description (format rtm/release-pr-description issue-number)))
        (rtm/create-pr (format "Release %s" date) "main" (format "release-%s" date) pr-description)))))

(defconst rtm/changelog-filename "CHANGELOG.md")

;; NOTE: should be inserted at empty line before the first section
(defconst rtm/changelog-template-section "## [Unreleased]
#### ADDED:
#### CHANGED:
#### FIXED:
#### REMOVED:
")

(defconst rtm/empty-section-pattern "#### .+:
#")

(defconst rtm/empty-section-pattern-two "#### .+:

")

(defun rtm/update-changelog (date)
  "TODO Test it"
  (rtm/log "Updating changelog...")
  (let ((changelog (concat default-directory rtm/changelog-filename)))
    (with-temp-file changelog
      (insert-file-contents changelog)
      (if (re-search-forward date nil t)
          (rtm/log "Changelog was updated earlier, noop")
        (beginning-of-buffer)
        (re-search-forward "Unreleased" nil t 1)
        (replace-match date)
        ;; removes empty subsections in the middle of section
        (while (re-search-forward rtm/empty-section-pattern nil t 1)
          (replace-match "#"))
        ;; removes the last subsecton if it is empty
        (while (re-search-forward rtm/empty-section-pattern-two nil t 1)
          (replace-match "
"))
        (beginning-of-buffer)
        ;; places new empty section
        (re-search-forward "##" nil t 1)
        (replace-match (concat rtm/changelog-template-section "
##"))))))

(defconst rtm/release-notes-entry-start-template "# %s\r\n")

(defconst rtm/release-notes-entry-end "\r\n\r\n\\|# ")

(defconst rtm/release-notes-body-template "
Изменения:

%s

[Ссылка](https://github.com/tarantool/megafon-%s/blob/main/CHANGELOG.md#%s) на changelog")

(defun rtm/gh-issue-list-project-body (date)
  "TODO add a verb to function name"
  (shell-command-to-string (format "gh issue list --search '[RELEASE] %s'  --repo tarantool/megafon-rtm --json body --jq '.[].body'" date)))

(defun rtm/release-issue-body (date)
  "TODO Add a verb to function name
TODO reformat date from year-month-day -> day.month.year"
  (rtm/fix-special-chars
   (rtm/gh-issue-list-project-body date)))

(defun rtm/fix-special-chars (body)
  "FIXME this is broken"
  (replace-regexp-in-string "\\\\r" ""
                            (replace-regexp-in-string "\\\\n" "\n" body)))

(defun rtm/extract-changes (project date)
  "Extract the section of text that starts after \"# <project>\"
and ends before the next section or newline symbol."
  (with-temp-buffer
    (insert (rtm/release-issue-body date))
    (beginning-of-buffer)
    (re-search-forward "Release Notes")
    (let ((start (re-search-forward (format rtm/release-notes-entry-start-template project) nil)))
      (when start
        (let ((end (re-search-forward rtm/release-notes-entry-end nil)))
          (buffer-substring start (match-beginning 0)))))))

(defun rtm/gh-release-draft-create (project date changes)
  "TODO Add a verb to function name"
  (rtm/call-release-procedure (format "gh release create %s --draft --prerelease --target main --title 'Release %s' --notes-file - <<- EOF
%s" date date (format rtm/release-notes-body-template changes project date))))

(defun rtm/create-draft-release (project date)
  "Creates draft release, if it does not exist"
  (if (rtm/release-is-existed date)
      (rtm/log "Release is existed, noop")
    (let ((changes (rtm/extract-changes project date)))
      (rtm/gh-release-draft-create project date changes))))

(defun rtm/get-project-name (dir)
  "Extracts current directory name from default-directory
and removes 'megafon-' prefix from it"
  (let ((dirname (car (last (split-string dir "/") 2))))
    (if (string-equal dirname "megafon-rtm")
        "rtm-megafon"
      (replace-regexp-in-string "megafon-" "" dirname))))

(defun rtm/gh-release-pr-number (date)
  "TODO Add a verb to function name"
  (shell-command-to-string (format "gh pr list --search 'Release %s' --json number --jq '.[].number' | tr -d '\n'" date)))

(defun rtm/merge-release-pr (date)
  "Merges Release Pull Request"
  (let ((pr-number (rtm/gh-release-pr-number date)))
    (rtm/call-release-procedure (format "gh pr merge release-%s --delete-branch --merge --subject 'Release %s (#%s)'" date date pr-number))))

(defun rtm/undraft-release (date)
  "Edit previously created draft release"
  (rtm/call-release-procedure "git checkout main")
  (rtm/call-release-procedure "git pull origin main")
  (rtm/call-release-procedure (format "gh release edit %s --draft=false --prerelease=false --latest" date)))


(defun rtm/backport-pr-description (date)
  (let ((issue-number (rtm/get-release-issue-number date)))
    (format "Related to tarantool/megafon-rtm#%s" issue-number)))

(defun rtm/create-backport-pr (date)
  "Create Backport Pull Request"
  (rtm/call-release-procedure "git checkout main")
  (rtm/call-release-procedure "git pull origin main")
  (rtm/call-release-procedure (format "git branch backport-release-%s" date))
  (rtm/call-release-procedure (format "git checkout backport-release-%s" date))
  (rtm/call-release-procedure "git push origin HEAD")
  (rtm/create-pr (format "Backport Release %s" date) "dev" (format "backport-release-%s" date) (rtm/backport-pr-description date)))

(defconst rtm/output-buffer "*RTM Release Process*")

(defun rtm/log (message)
  (with-current-buffer (get-buffer-create rtm/output-buffer)
    (insert (concat message "\n"))))

(defun rtm/call-release-procedure (command)
  (let ((output-buffer (get-buffer-create rtm/output-buffer)))
    (rtm/log (format "Calling '%s':" command))
    (call-process-shell-command command nil output-buffer t)))

(defun rtm/open-release (dir date)
  "Creates draft release and does some preparation which is necessory
in the release process:
* updates changelog
* creates release PR"
  (interactive "DProject dir:\nMRelease date (eg 2023-05-04): ")
  (let ((output-buffer (get-buffer-create rtm/output-buffer)))
    (with-current-buffer output-buffer
      (let ((default-directory dir)
            (project (rtm/get-project-name dir)))
        (erase-buffer)
        (display-buffer output-buffer)
        (rtm/log "Start opening release")
        (rtm/setup-release-branch date)
        (rtm/update-changelog date)
        (rtm/create-release-pr date)
        (rtm/create-draft-release project date)))))

(defun rtm/close-release (dir date)
  "Finishes release cycle:
* merges release PR
* undrafts release
* merges changes from main into development branch"
  (interactive "DProject dir:\nMRelease date (eg 2023-05-04): ")
  (let ((output-buffer (get-buffer-create rtm/output-buffer)))
    (with-current-buffer output-buffer
      (let ((default-directory dir))
        (erase-buffer)
        (display-buffer output-buffer)
        (rtm/log "Start closing release")
        (rtm/merge-release-pr date)
        (rtm/undraft-release date)
        (rtm/create-backport-pr date)))))

(defun rtm/sync-repositories(source target date)
  "WORK IN PROGRESS
TODO: gitlab integration (for creating MR)
Rsyncs from github repo to gitlab (MF) repo"
  (let ((default-directory target))
    (rtm/call-release-procedure "git checkout master")
    (rtm/call-release-procedure "git pull origin master")
    (rtm/call-release-procedure (format "git checkout -b release-%s" date))
    (rtm/call-release-procedure (format "rsync -r --delete %s/app ." source))
    (rtm/call-release-procedure (format "rsync -r --delete %s/scripts ." source))
    (rtm/call-release-procedure (format "rsync -r --delete %s/test ." source))
    (rtm/call-release-procedure (format "rsync -r --delete %s/docs ." source))
    (rtm/call-release-procedure (format "rsync -r --delete %s/cartridge.yml ." source))
    (rtm/call-release-procedure (format "rsync -r --delete %s/init.lua ." source))
    (rtm/call-release-procedure (format "rsync -r --delete %s/*.rockspec ." source))
    (rtm/call-release-procedure (format "rsync -r --delete %s/grafana ." source))
    (rtm/call-release-procedure (format "rsync -r --delete %s/docs ." source))
    (rtm/call-release-procedure "git add .")
    (rtm/call-release-procedure (format "git commit -m 'Release %s'" date))
    (rtm/call-release-procedure "git push origin HEAD")))
