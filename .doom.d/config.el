(global-auto-revert-mode t)

(setq doom-theme 'doom-one)

;; (add-hook! 'org-mode-hook #'+org-pretty-mode #'mixed-pitch-mode)

;; (add-hook! 'org-mode-hook (company-mode -1))
;; (add-hook! 'org-capture-mode-hook (company-mode -1))

(setq user-full-name "Keith Butler"
      user-mail-address "20089137@mail.wit.ie")

(setq display-line-numbers-type 'relative)

(setq plantuml-jar-path "~/Documents/SDKs/plantuml.jar")
(setq org-plantuml-jar-path
      (expand-file-name "~/Documents/SDKs/plantuml.jar"))

(after! org
  (setq org-directory "~/org/")
  (setq org-agenda-files '(list "~/org" "~/org/journal" "~/org/gcal.org" "~/org/holidays.org"))
  (setq org-log-done 'time)
  (setq org-startup-folded 'show2levels)
  ;;(setq org-hide-block-startup 't)
  ;; (require 'org-bullets)
  ;; (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  )

;; (use-package! org-super-agenda
;; ;;   :after org-agenda
;; ;;   :init
(setq org-super-agenda-groups '((:name "Today"
                                 :time-grid t
                                 :scheduled today)
                                (:name "Due today"
                                 :deadline today)
                                (:name "Important"
                                 :priority "A")
                                (:name "Overdue"
                                 :deadline past)
                                (:name "Due soon"
                                 :deadline future)
                                (:name "Big Outcomes"
                                 :tag "bo")))
;; ;; :config
;; (org-super-agenda-mode))

(setq org-journal-date-prefix "#+TITLE "
      org-journal-time-prefix "* "
      org-journal-date-format "%a, %Y-%m-%d"
      org-journal-file-format "%Y-%m-%d.org")

(setq org-roam-directory "~/org/roam")

(use-package org-roam-server
  :ensure t
  :config
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 8080
        org-roam-server-export-inline-images t
        org-roam-server-authenticate nil
        org-roam-server-network-poll t
        org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20))

(setq org-capture-templates
      '(("a" "Appointment" entry (file  "~/org/gcal.org" )
         "* %?\n\n%^T\n\n:PROPERTIES:\n\n:END:\n\n")
        ("l" "Link" entry (file+headline "~/org/links.org" "Links")
         "* %? %^L %^g \n%T" :prepend t)
        ("b" "Blog idea" entry (file+headline "~/org/i.org" "Blog Topics:")
         "* %?\n%T" :prepend t)
        ("t" "To Do Item" entry (file+headline "~/org/i.org" "To Do")
         "* TODO %?\n%u" :prepend t)
        ("n" "Note" entry (file+headline "~/org/i.org" "Note space")
         "* %?\n%u" :prepend t)
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")
        ("s" "Screencast" entry (file "~/org/screencastnotes.org")
         "* %?\n%i\n")))

(setq package-check-signature nil)

(use-package org-gcal
  :ensure t
  :config
  (setq org-gcal-client-id "536318722404-0pvh418ch2bn0ro8ji1j232jh7teg5bl.apps.googleusercontent.com"
        org-gcal-client-secret "NUHrL-sYKbe9wctNJh99PB8o"
        org-gcal-file-alist '(("keithbutler2001@gmail.com" .  "~/org/gcal.org")
                              ("en.irish#holiday@group.v.calendar.google.com" . "~/org/holidays.org"))))
;;("en.irish#holiday@group.v.calendar.google.com" .  "~/org/gcal.org"))))

(add-hook 'org-agenda-mode-hook (lambda () (org-gcal-sync) ))
(add-hook 'org-capture-after-finalize-hook (lambda () (org-gcal-sync) ))

(map! :ne "M-/" #'comment-or-uncomment-region)
(map! :ne "SPC / r" #'deadgrep)

(eval-after-load
    'company
  '(add-to-list 'company-backends #'company-omnisharp))

;; (global-font-lock-mode t)
;; (load "/home/shimakur/Emacs/ess/lisp/ess-site")

(defun my-csharp-mode-setup ()
  (omnisharp-mode)
  (company-mode)
  (flycheck-mode)

  (setq indent-tabs-mode nil)
  (setq c-syntactic-indentation t)
  (c-set-style "ellemtel")
  (setq c-basic-offset 4)
  (setq truncate-lines t)
  (setq tab-width 4)
  (setq evil-shift-width 4)

  ;csharp-mode README.md recommends this too
  ;(electric-pair-mode 1)       ;; Emacs 24
  ;(electric-pair-local-mode 1) ;; Emacs 25

  (local-set-key (kbd "C-c r r") 'omnisharp-run-code-action-refactoring)
  (local-set-key (kbd "C-c C-c") 'recompile))

(add-hook 'csharp-mode-hook 'my-csharp-mode-setup t)
