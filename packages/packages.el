;; -*- lexical-binding: t; -*-
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "https://https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/") t)
(add-to-list 'package-archives '("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/") t)
(package-initialize)

(require 'packages-editing)
(require 'packages-ui)
(require 'packages-email)
(require 'packages-misc)
;; (require 'packages-leetcode)
(provide 'packages)
