(provide 'tnt)

(defconst tnt-env "source sdk/env.sh")
(defconst tnt-test ".rocks/bin/luatest")
(defconst tnt-lint ".rocks/bin/luacheck . --formatter plain")

(defun concat-args (args &optional seporator)
  (let ((seporator (or seporator " ")))
    (mapconcat (function (lambda (x) (format "%s" x))) args seporator)))

(defun tnt-current-group ()
  (save-excursion
    (save-match-data
      (goto-char (point-min))
      (re-search-forward "t.group('")
      (re-search-forward (lua-rx lua-name))
      (match-string-no-properties 0))))

;; NOTE: work only with "g.test_debug = function()" functions headers
(defun tnt-current-test-case ()
  (save-excursion
    (save-match-data
      (let ((name-patttern (lua-rx lua-name)))
        (re-search-backward lua--beginning-of-defun-re nil t)
        (lua-forward-sexp 2)
        (re-search-backward name-patttern nil t)
        (match-string-no-properties 0)))))

(defun tnt-run (action &optional args)
  (let ((compile-command (format "%s && %s %s" tnt-env action
                                 (if args
                                     (concat-args args))))
        (default-directory (project-root (project-current t))))
    (compile compile-command)))

(defun tnt-run-tests (&optional args)
  (tnt-run tnt-test args))

(defun tnt-run-lint ()
  (interactive)
  (tnt-run tnt-lint ""))

(transient-define-prefix tnt-popup ()
  "Tarantool"
  ["Commands"
   ("t" "Luatest" luatest-popup)
   ("l" "Luacheck" tnt-run-lint)
   ("k" "Kill all tnts" tnt-kill-all)])

(transient-define-argument luatest-repeat()
  :description "Limit number of commits"
  :class 'transient-option
  :shortarg "-r"
  :argument "-r "
  :reader #'transient-read-number-N+)

(transient-define-prefix luatest-popup ()
  "Luatest"
  ["Arguments"
   ("-v" "Verbose" "-v")
   ("-c" "Capturing output" "-c")
   ("-r" "Repeatition of each test case" luatest-repeat)]
  ["Commands"
   ("t" "run test case" tnt-run-test-case)
   ("g" "run test group" tnt-run-group)
   ("a" "run all test" tnt-run-all-tests)])

(defun tnt-run-test-case (&optional args)
  (interactive (list (transient-args 'luatest-popup)))
  (let ((groupname (tnt-current-group))
        (casename (tnt-current-test-case)))
    (let ((testname (concat-args (list groupname casename) ".")))
      (add-to-list 'args testname)
      (tnt-run-tests args))))

(defun tnt-run-all-tests (&optional args)
  (interactive (list (transient-args 'luatest-popup)))
  (tnt-run-tests args))

(defun tnt-run-group (&optional args)
  (interactive (list (transient-args 'luatest-popup)))
  (let ((groupname (tnt-current-group)))
    (tnt-run-tests (add-to-list 'args groupname))))

(defun tnt-kill-all ()
  (interactive)
  (shell-command "pkill -9 tarantool"))
