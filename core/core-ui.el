;; -*- lexical-binding: t; -*-
(display-time-mode 1)

(setq custom-safe-themes t
      ring-bell-function 'ignore
      cursor-type 'box
      fringes-outside-margins t
      display-time-24hr-format t ; 时间使用 24 小时制
      display-time-day-and-date t ; 时间显示包括日期和时间
      display-time-interval 60    ; 刷新频率
      display-time-format "%a %b %-e %H:%M" ; 时间格式
      scroll-step 1
      scroll-conservatively 10000)

(load-theme 'doom-Iosvkem)

(when (display-graphic-p)
  (set-frame-size (selected-frame) 143 40))

(global-display-line-numbers-mode t)
(provide 'core-ui)
