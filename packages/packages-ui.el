;; -*- lexical-binding: t; y-*-
(use-package ace-window
  :ensure t
  :bind
  (("C-x o" . ace-window)))

(use-package counsel
  :ensure t)

(use-package dashboard
  :ensure t
  :config
  (setq dashboard-startup-banner 'logo
        dashboard-banner-logo-title "Welcome to Verdant's Emacverse!!!"
        dashboard-center-content t
        dashboard-set-heading-icons t
        dashboard-items '((recents  . 10)
                          (bookmarks . 5))
        dashboard-footer-messages '("verdant.el"))

  ;; 核心三件套
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
  (dashboard-setup-startup-hook)
  (add-hook 'after-init-hook #'dashboard-open t))

(use-package ivy-posframe
  :ensure t
  :config
  (ivy-posframe-mode t))

(use-package ivy-rich
  :ensure t
  :config
  (ivy-rich-mode t))

(use-package diredfl
  :ensure t
  :hook (dired-mode . diredfl-mode))


(provide 'packages-ui)
