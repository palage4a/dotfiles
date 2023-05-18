(provide 'rtm)

;; rtm/* functions require gh(github-cli) and js(for parsing json)
(defconst rtm/gh-pr-create-cmd "gh pr create --assignee @me --base main --head 'release-%s' --title 'Release %s' --reviewer %s --body-file - <<- EOF
%s
EOF")

(defconst rtm/release-reviewers '("palage4a" "tecl1s" "runsfor"))

(defconst rtm/release-description "Related to tarantool/megafon-rtm#%s

Я не забыл про:

- [x] Описание
- [x] Связанный тикет
- [x] Тесты
- [x] Документацию
- [x] Обновление CHANGELOG.md")

(defun rtm/get-release-issue (date)
  (shell-command-to-string (format "gh issue list --search '[RELEASE] %s'  --repo tarantool/megafon-rtm --json number | jq '.[0].number'" date)))

;; NOTE: After execution this function you need to update CHANGLOG.md
;; TODO: The changlog updating is very mechanical work. We should to automote it.
(defun rtm/setup-release-branch (date)
  (shell-command-to-string "git checkout dev")
  (shell-command-to-string "git pull origin dev")
  (shell-command-to-string (format "git checkout -b release-%s" date)))

;; NOTE: before ran this function you should update CHANGELOG.md
(defun rtm/create-release-pr (date)
  (shell-command-to-string "git add CHANGELOG.md")
  (shell-command-to-string (format "git commit -m 'Wrap up %s release'" date))
  (shell-command-to-string "git push origin HEAD")
  (let ((issue-number (rtm/get-release-issue date)))
    (let ((pr-description (format rtm/release-description issue-number))
          (reviewers (mapconcat 'identity rtm/release-reviewers ",")))
      (async-shell-command (format rtm/gh-pr-create-cmd
                                   date date reviewers pr-description)))))

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
  (let ((changelog (concat default-directory rtm/changelog-filename)))
    (with-temp-file changelog
      (insert-file-contents changelog)
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
##")))))

;; git checkout main
;; git pull
;; release="2023-04-06"
;; project=$(gh repo view --json name | jq -r '.name')
;; gh release create ${release} --draft --target main --title "Release ${release}" --notes-file - <<- EOF
;; 	Изменения:

;; 	- Рефакторинг интеграционных тестов api профиля абонента ([RTM-2464](https://jira.megafon.ru/browse/RTM-2464))
;; 	- Улучшена стабильность CI. Исправлены flaky-тесты ([RTM-2464](https://jira.megafon.ru/browse/RTM-2464))
;; 	- Возвращено тестирование маппинга атрибутов прямого загрузчика в модель данных ([RTM-2464](https://jira.megafon.ru/browse/RTM-2464))
;; 	- Удалены упоминания домена scoring из кода ([RTM-2410](https://jira.megafon.ru/browse/RTM-2410))

;; 	[Ссылка](https://github.com/tarantool/${project}/blob/main/CHANGELOG.md#${release}) на changelog
;; EOF


(defconst rtm/release-notes-entry-start-template "# %s\n")

(defconst rtm/release-notes-entry-end "\n\n\\|# ")

(defconst rtm/release-notes-body-template "
Изменения:

%s

[Ссылка](https://github.com/tarantool/megafon-%s/blob/main/CHANGELOG.md#%s) на changelog")

(defun rtm/gh-issue-list-project-body (date)
  (shell-command-to-string (format "gh issue list --search '[RELEASE] %s'  --repo tarantool/megafon-rtm --json body | jq '.[].body'" date)))

(defun rtm/release-issue-body (date)
  (rtm/fix-special-chars
   (rtm/gh-issue-list-project-body date)))

(defun rtm/fix-special-chars (body)
  (replace-regexp-in-string "\\\\r" ""
                            (replace-regexp-in-string "\\\\n" "\n" body)))

;; Extract the section of text that starts after \"# <project name>\"
;; and ends before the next section or newline symbol."
(defun rtm/extract-changes (project date)
  (with-temp-buffer
    (insert (rtm/release-issue-body date))
    (beginning-of-buffer)
    (re-search-forward "Release Notes")
    (let ((start (re-search-forward (format rtm/release-notes-entry-start-template project) nil)))
      (when start
        (let ((end (re-search-forward rtm/release-notes-entry-end nil)))
              (buffer-substring start (match-beginning 0)))))))

(defun rtm/gh-release-draft-create (project date changes)
  (async-shell-command (format "gh release create %s --draft --target main --title 'Release %s' --notes-file - <<- EOF
%s" date date (format rtm/release-notes-body-template changes project date))))

(defun rtm/create-draft-release (project date)
  (shell-command-to-string "git checkout main")
  (shell-command-to-string "git pull")
  (let ((changes (rtm/extract-changes project date)))
    (rtm/gh-release-draft-create project date changes)))

;; Extracts current directory name from default-directory
;; and removes "megafon-" prefix from it
(defun rtm/get-project-name ()
  (let ((dirname (car (last (split-string default-directory "/") 2))))
    (replace-regexp-in-string "megafon-" "" dirname)))

(defun rtm/create-release (dir date)
  (interactive "DProject dir:\nMRelease date (eg 2023-05-04): ")
  (let ((default-directory dir))
    (let ((project (rtm/get-project-name)))
      ;; (rtm/setup-release-branch date)
      ;; (rtm/update-changelog date)
      (rtm/create-release-pr date)
      (rtm/create-draft-release project date))
    ))

(defun rtm/gh-pr-merge (date)
  (async-shell-command (format "gh pr merge release-%s --delete-branch" date)))

(defun rtm/merge-release (dir date)
  (interactive "DProject dir:\nMRelease date (eg 2023-05-04): ")
  (let ((default-directory dir))
    (rtm/gh-pr-merge date)))
