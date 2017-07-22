;;; calendar --- 2017-07-22 04:31:00 PM

;;; Commentary:

;; Tweak Emacs built-in calendar

;;; Code:

(require 'calendar)

(global-set-key (kbd "C-c c C-c") 'calendar)

;;; Override old calendar-goto-date to use org-read-date, since
;;; the latter is much more convenient.
;;; Unfortunately will not work if new date is not displayed in current calendar.
(defun calendar-goto-date-org-style (date)
  "Move cursor to DATE."
  (interactive (list (let ((date (org-parse-time-string (org-read-date))))
                       (list
                        (nth 4 date)
                        (nth 3 date)
                        (nth 5 date)))))
  (let ((month (calendar-extract-month date))
        (year (calendar-extract-year date)))
    (if (not (calendar-date-is-visible-p date))
        (calendar-other-month
         (if (and (= month 1) (= year 1))
             2
           month)
         year)))
  (calendar-cursor-to-visible-date date)
  (run-hooks 'calendar-move-hook)
  ;; make cursor visible again (otherwise it disappears:)
  (setq cursor-type "box"))

;;; (global-set-key (kbd "C-c c C-o") 'calendar-goto-date-org-style)

;;; provide 025_calendar
;;; 025_calendar.el ends here
(provide 'calendar)
;;; 019_calendar.el ends here