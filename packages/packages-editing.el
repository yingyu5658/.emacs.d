;; -*- lexical-binding: t; -*-
(use-package evil
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode)
  :ensure t)

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package olivetti)

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

(use-package ivy
  :ensure t
  :init
  (ivy-mode 1)
  (counsel-mode 1)
  :config
  (setq ivy-use-selectable-prompt t)
  (setq ivy-use-preview t)
  (setq ivy-fixed-height-minibuffer t)
  (setq ivy-use-preview t)
  (setq ivy-use-virtual-buffers t)
  (setq search-default-mode #'char-fold-to-regexp)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-initial-inputs-alist nil)  ;; 不预设初始输入
  (setq ivy-use-selectable-prompt t)   ;; 允许选择提示
  :bind
  (("C-s" . 'swiper)
   ("C-x b" . 'ivy-switch-buffer)
   ("C-c v" . 'ivy-push-view)
   ("C-c s" . 'ivy-switch-view)
   ("C-c V" . 'ivy-pop-view)
   ("C-x C-@" . 'counsel-mark-ring); 在某些终端上 C-x C-SPC 会被映射为 C-x C-@，比如在 macOS 上，所以要手动设置
   ("C-x C-SPC" . 'counsel-mark-ring)
   :map minibuffer-local-map
   ("C-r" . counsel-minibuffer-history)))

;; 启用 company-mode 全局补全
(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0.0
	company-minimum-prefix-length 1)
  (global-company-mode)

  (with-eval-after-load 'company
    ;; 补全列表背景
    (set-face-attribute 'company-tooltip nil
			:foreground "white" :background "gray20")
    ;; 选中项背景
    (set-face-attribute 'company-tooltip-selection nil
			:foreground "blue" :background "gray20")
    ;; 输入前缀高亮
    (set-face-attribute 'company-tooltip-common nil
			:foreground "orange" :background "gray20")
    ;; 右侧注释/类型
    (set-face-attribute 'company-tooltip-annotation nil
			:foreground "cyan" :background "gray20")))

(use-package lsp-mode
  :ensure t
  :init
  (setq read-process-output-max (* 1024 1024))
  :hook (
	 (c-mode . lsp)
	 (go-mode .lsp)
	 (css-mode . lsp)
	 (html-mode . lsp))
  )

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(use-package clang-format
  :ensure t
  :hook
  (c-mode-common-hook . (lambda () (add-hook 'before-save-hook 'clang-format-buffer nil t)))
  :bind
  (:map c-mode-base-map
        ("C-c C-f" . clang-format-buffer))
  :config
  (setq clang-format-executable (executable-find "clang-format")))

(provide 'packages-editing)
