;; -*- lexical-binding: t; -*-

(setq user-emacs-directory (expand-file-name "~/.emacs.d"))

(add-to-list 'load-path (expand-file-name "core" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "packages" user-emacs-directory))

(require 'core)
(require 'packages)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(ace-window clang-format color-theme-sanityinc-solarized company
		counsel dashboard diredfl doom-themes evil-collection
		evil-mu4e hugoista ivy-posframe ivy-rich leetcode
		lsp-ui olivetti yasnippet)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
