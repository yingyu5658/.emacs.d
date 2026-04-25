;; -*- lexical-binding: t; -*-

(require 'smtpmail)

(add-to-list 'load-path "/usr/share/emacs/site-lisp/elpa-src/mu4e-1.8.14")

(setq gnutls-algorithm-priority "NORMAL:%COMPAT")

(defun mu4e-goodies~break-cjk-word (word)
  "Break CJK word into list of bi-grams like: 我爱你 -> 我爱 爱你"
  (if (or (<= (length word) 2)
          (equal (length word) (string-bytes word)))
      word
    (let ((pos nil)
          (char-list nil)
          (br-word nil))
      (if (setq pos (string-match ":" word))
          (concat (substring word 0 (+ 1 pos)) 
                  (mu4e-goodies~break-cjk-word (substring word (+ 1 pos))))
        (if (memq 'ascii (find-charset-string word))
            word
          (progn 
            (setq char-list (split-string word "" t))
            (while (cdr char-list)
              (setq br-word (concat br-word (concat (car char-list) (cadr char-list)) " "))
              (setq char-list (cdr char-list)))
            br-word))))))

(defun mu4e-goodies~break-cjk-query (expr)
  "Break CJK strings into bi-grams in query."
  (let ((word-list (split-string expr " " t))
        (new ""))
    (dolist (word word-list new)
      (setq new (concat new (mu4e-goodies~break-cjk-word word) " ")))))

(setq mu4e-query-rewrite-function 'mu4e-goodies~break-cjk-query)

(use-package mu4e
  :ensure nil
  :if (executable-find "mu")
  :commands (mu4e)
  :bind (:map mu4e-view-mode-map
              ("9" . scroll-down-command)
              ("0" . scroll-up-command)
              :map mu4e-search-minor-mode-map
              ("/" . mu4e-search-maildir)
              :map mu4e-main-mode-map
              ("g" . mu4e-update-mail-and-index)
              :map mu4e-headers-mode-map
              ("<backspace>" . scroll-down-command)
              ("j" . mu4e-headers-next)
              ("k" . mu4e-headers-prev)
              ("r" . mu4e-headers-mark-for-read)
              ("!" . mu4e-headers-flag-all-read)
              ("f" . mu4e-headers-mark-for-flag))
  
  :custom
  (mu4e-headers-fields '((:human-date . 12)
                         (:flags . 6)
                         (:from-or-to . 22)
                         (:thread-subject . nil)))
  (mu4e-view-fields '(:from :to :cc :bcc :subject :flags
                      :date :maildir :mailing-list :tags))
  (mu4e-modeline-show-global nil)
  (mu4e-hide-index-messages t)
  
  :init
  (setq user-mail-address "im@verdant.ee"
        user-full-name "Verdant"
        mu4e-debug t)
  
  (setq message-send-mail-function 'sendmail-send-it
        sendmail-program "/usr/bin/msmtp"
        mail-specify-envelope-from t
        mail-envelope-from 'header)
  
  (setq message-citation-line-format "\nOn %a, %b %d, %Y at %r %z, %N wrote:\n"
        message-citation-line-function 'message-insert-formatted-citation-line
        mm-discouraged-alternatives '("text/html" "text/richtext")
        gnus-article-time-format "%a, %Y-%m-%d %T %z"
        gnus-article-date-headers '(user-defined original))
  
  :config
  (require 'mu4e-contrib)
  
  (setq mail-user-agent 'mu4e-user-agent)
  
  (setq mu4e-contexts
        (list
         (make-mu4e-context
          :name "Verdant"
          :match-func (lambda (msg)
                        (when msg
                          (string-prefix-p "/ljc" (mu4e-message-field msg :maildir))))
          :vars '((mu4e-sent-folder . "/Verdant/Sent")
                  (mu4e-trash-folder . "/Verdant/Trash")
                  (mu4e-refile-folder . "/Verdant/Archive")
                  (mu4e-drafts-folder . "/Verdant/Drafts")
                  (user-mail-address . "im@verdant.ee")))))
  
  (setq mu4e-compose-complete-only-personal t
        mu4e-view-show-addresses t
        mu4e-view-show-images nil
        mu4e-attachment-dir "~/Downloads"
        mu4e-sent-messages-behavior 'sent
        mu4e-context-policy 'pick-first
        mu4e-compose-context-policy 'ask-if-none
        mu4e-compose-dont-reply-to-self t
        mu4e-confirm-quit nil
        mu4e-headers-date-format "%+4Y-%m-%d"
        mu4e-view-html-plaintext-ratio-heuristic most-positive-fixnum
        mu4e-update-interval (* 30 60)
        mu4e-get-mail-command "true"
        mu4e-compose-format-flowed t
        mu4e-completing-read-function 'ido-completing-read)
  
  (setq mu4e-bookmarks '((:name "All Inbox"
                          :query "maildir:/Verdant/INBOX"
                          :key ?i)
                         (:name "Unread messages"
                          :query "flag:unread AND NOT flag:trashed"
                          :key ?u)
                         (:name "Today's messages"
                          :query "date:today..now AND NOT flag:trashed"
                          :key ?t)
                         (:name "Last 7 days"
                          :query "date:7d..now AND NOT flag:trashed"
                          :hide-unread t
                          :key ?w)
                         (:name "Flagged"
                          :query "flag:flagged"
                          :key ?f)
                         (:name "Sent"
                          :query "maildir:/Verdant/Sent"
                          :key ?s)))
  
  (add-to-list 'mu4e-view-actions '("browser" . mu4e-action-view-in-browser) t)
  
  (defun my/mu4e-pre-update-hook ()
    (let ((inhibit-message t))
      (message "Update and index mu4e at %s" (format-time-string "%D %-I:%M %p"))))
  
  (defun my/mu4e-stop-update-task ()
    (interactive)
    (when mu4e--update-timer
      (cancel-timer mu4e--update-timer)
      (setq mu4e--update-timer nil)))
  
  (setq mu4e-update-pre-hook 'my/mu4e-pre-update-hook)
  
  (add-to-list 'mu4e-view-fields :bcc))

(provide 'packages-email)
