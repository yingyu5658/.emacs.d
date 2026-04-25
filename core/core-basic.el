;; -*- lexical-binding: t; -*-

(setq confirm-kill-emacs #'yes-or-no-p ; 关闭 Emacs 时询问 y or n
      auto-save-visited-interval 5
      native-comp-async-report-warinings-errors nil
      backup-directory-alist `((".*" . ,temporary-file-directory))
      auto-save-file-name-transforms `((".*" ,temporary-file-directory t))
      select-enable-clipboard t
      select-enable-primary t
      interprogram-cut-function
      (lambda (text &optional push)
	(let ((process-connection-type nil))
	  (let ((proc (start-process "xclip" nil "xclip" "-selection" "clipboard")))
	    (process-send-string proc text)
	    (process-send-eof proc))))
      interprogram-paste-function
      (lambda ()
	(shell-command-to-string "xclip -o -selection clipboard")))

(setq-default delete-by-moving-to-transh t ; 删除文件移动到垃圾箱
      	      window-combination-resize t  ; 新窗口平均其他左右窗口
	      x-stretch-cursor t           ; 将光标拉伸到字符宽度
	      )

(defun my/keyboard-escape-quit()
  "快速的 Esc 退出 minibuffer"
  (interactive)
  (keyboard-escape-quit))

(global-set-key (kbd "<escape>") #'my/keyboard-escape-quit)

;; 在 Dired 中，按`l`进入文件，按`h`回到上一级目录
(add-hook 'evil-mode-hook (lambda ()
(with-eval-after-load 'dired
  (add-hook 'dired-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "h") nil)
              (define-key evil-normal-state-local-map (kbd "l") nil)
              (define-key evil-normal-state-local-map (kbd "h") #'dired-up-directory)
              (define-key evil-normal-state-local-map (kbd "l") #'dired-find-file))))))

  (add-hook 'dired-mode-hook
            (lambda ()
	      (define-key dired-mode-map (kbd "C-b") nil)
	      (define-key dired-mode-map (kbd "C-f") nil)
	      (define-key dired-mode-map (kbd "C-b") #'dired-up-directory)
	      (define-key dired-mode-map (kbd "C-f") #'dired-find-file)))

(global-set-key (kbd "<escape>") #'my/keyboard-escape-quit)

(global-auto-revert-mode t) ; 另一程序修改文件让 Emacs 及时刷新 Buffer
(auto-save-mode 1)

(provide 'core-basic)
