;; -*- lexical-binding: t; -*-
(show-paren-mode t)
(save-place-mode 1)
(global-subword-mode 1)
(add-hook 'prog-mode-hook #'show-paren-mode)

(electric-pair-mode 1)

(defun setup-markdown-writing-environment ()
  "为 Markdown 写作优化的环境：开启 Olivetti，关闭行号。"
  (interactive)
  (variable-pitch-mode 1)
  (display-line-numbers-mode -1)
  (pixel-scroll-precision-mode 1)
  (olivetti-mode))

(add-hook 'markdown-mode-hook
          (lambda ()
            ;; 取消 Evil 的 TAB 绑定，使用 markdown-cycle
            (define-key evil-normal-state-local-map (kbd "TAB") 'markdown-cycle)
            (define-key evil-insert-state-local-map (kbd "TAB") 'indent-for-tab-command)))

(setq evil-want-C-u-scroll t)

(provide 'core-editing)
