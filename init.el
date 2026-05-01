;; -*- lexical-binding: t; -*-
(require 'org)

(setq user-emacs-directory (expand-file-name "~/.emacs.d"))
(add-to-list 'load-path user-emacs-directory)
(let ((org-file (expand-file-name "config.org" user-emacs-directory))
      (el-file  (expand-file-name "config.el" user-emacs-directory)))
  (when (or (not (file-exists-p el-file))
            (file-newer-than-file-p org-file el-file))
    (org-babel-tangle-file org-file))
  (load-file el-file))
(require 'config)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(ace-window clang-format color-theme-sanityinc-solarized company
				counsel dashboard diredfl doom-themes evil-collection
				evil-mu4e hugoista ivy-posframe ivy-rich leetcode
				lsp-ui magit olivetti org-bullets ox-hugo sis
				yasnippet)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
