;;; org-mode --- 2017-08-21 11:06:06 AM

  ;;; Commentary:

  ;; customize some org mode settings
  ;; define some useful functions

  ;;; Code:

  ;; load util to insert recipes for export customization:
  (require 'org-export-recipes)

  (setq org-attach-directory (file-truename "~/Documents/org-attachments/"))
  (setq org-agenda-sticky t) ;; open agenda and todo views in separate buffers
  ;; (setq org-agenda-diary-file (file-truename
  ;;                              (concat iz-log-dir "PERSONAL/DIARY2.txt")))

  ;; customize looks
  (custom-set-faces
   '(org-block-end-line ((t (:background "#3a3a3a" :foreground "gray99"))) t)
   '(org-level-1 ((t (:weight bold :height 1.1))))
   '(org-level-2 ((t (:weight bold :height 1.1))))
   '(org-level-3 ((t (:weight bold :height 1.1))))
   '(org-level-4 ((t (:weight bold :height 1.1))))
   '(org-level-5 ((t (:weight bold :height 1.1))))
   '(org-level-6 ((t (:weight bold :height 1.1))))
   '(org-level-7 ((t (:weight bold :height 1.1))))
   '(org-level-8 ((t (:weight bold :height 1.1))))
   '(org-level-9 ((t (:weight bold :height 1.1)))))

  (defun org-set-date (&optional active property)
    "Set DATE property with current time.  Active timestamp."
    (interactive "P")
    (org-set-property
     (if property property "DATE")
     (cond ((equal active nil)
            (format-time-string (cdr org-time-stamp-formats) (current-time)))
           ((equal active '(4))
            (concat "["
                    (substring
                     (format-time-string (cdr org-time-stamp-formats) (current-time))
                     1 -1)
                    "]"))
           ((equal active '(16))
            (concat
             "["
             (substring
              (format-time-string (cdr org-time-stamp-formats) (org-read-date t t))
              1 -1)
             "]"))
           ((equal active '(64))
            (format-time-string (cdr org-time-stamp-formats) (org-read-date t t))))))

  (defun org-insert-current-date (arg)
    "Insert current date in format readable for org-capture minibuffer.
  If called with ARG, do not insert time."
    (interactive "P")
    (if arg
        (insert (format-time-string "%e %b %Y"))
      (insert (format-time-string "%e %b %Y %H:%M"))))

  ;; This is run once after loading org for the first time
  ;; It adds some org-mode specific key bindings.
  (eval-after-load 'org
    '(progn
         ;; Note: This keybinding is in analogy to the default keybinding:
         ;; C-c . -> org-time-stamp
         (define-key org-mode-map (kbd "C-c C-.") 'org-set-date)
         (define-key org-mode-map (kbd "C-M-{") 'backward-paragraph)
         (define-key org-mode-map (kbd "C-M-}") 'forward-paragraph)
         (define-key org-mode-map (kbd "C-c C-S") 'org-schedule)
         (define-key org-mode-map (kbd "C-c C-s") 'sclang-main-stop)
         (define-key org-mode-map (kbd "C-c >") 'sclang-show-post-buffer)
         ;; own additions after org-config-examples below:
         (define-key org-mode-map (kbd "C-M-f") 'org-forward-heading-same-level)
         (define-key org-mode-map (kbd "C-M-b") 'org-backward-heading-same-level)
         (define-key org-mode-map (kbd "C-M-u") 'outline-up-heading)
         (define-key org-mode-map (kbd "C-M-n") 'org-next-src-block)
         (define-key org-mode-map (kbd "C-M-p") 'org-show-properties-block)
         (define-key org-mode-map (kbd "C-M-/") 'org-sclang-eval-babel-block)
            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         ;; from: http://orgmode.org/worg/org-configs/org-config-examples.html
         ;; section navigation
         (define-key org-mode-map (kbd "M-n") 'outline-next-visible-heading)
         (define-key org-mode-map (kbd "M-p") 'outline-previous-visible-heading)
         ;; table
         (define-key org-mode-map (kbd "C-M-w") 'org-table-copy-region)
         (define-key org-mode-map (kbd "C-M-y") 'org-table-paste-rectangle)
         (define-key org-mode-map (kbd "C-M-l") 'org-table-sort-lines)
         ;; display images
         (define-key org-mode-map (kbd "M-I") 'org-toggle-iimage-in-org)
         ;; Following are the prelude-mode binding, minus the conflicting table bindings.
         ;; prelude-mode is turned off for org mode, below.
         (define-key org-mode-map (kbd "C-c o") 'prelude-open-with)
         (define-key org-mode-map (kbd "C-c g") 'prelude-google)
         (define-key org-mode-map (kbd "C-c G") 'prelude-github)
         (define-key org-mode-map (kbd "C-c y") 'prelude-youtube)
         (define-key org-mode-map (kbd "C-c U") 'prelude-duckduckgo)
         ;;     ;; mimic popular IDEs binding, note that it doesn't work in a terminal session
         (define-key org-mode-map [(shift return)] 'prelude-smart-open-line)
         (define-key org-mode-map (kbd "M-o") 'prelude-smart-open-line)
         (define-key org-mode-map [(control shift return)] 'prelude-smart-open-line-above)
         (define-key org-mode-map [(control shift up)]  'move-text-up)
         (define-key org-mode-map [(control shift down)]  'move-text-down)
         (define-key org-mode-map [(control meta shift up)]  'move-text-up)
         (define-key org-mode-map [(control meta shift down)]  'move-text-down)
         ;;     ;; the following 2 break structure editing with meta-shift-up / down in org mode
         ;;     ;;    (define-key map [(meta shift up)]  'move-text-up)
         ;;     ;;    (define-key map [(meta shift down)]  'move-text-down)
         ;;     ;; new substitutes for above:  (these are overwritten by other modes...)
         ;;     ;; (define-key map (kbd "C-c [")  'move-text-up)
         ;;     ;; (define-key map (kbd "C-c ]")  'move-text-down)
         ;;     ;; (define-key map [(control meta shift up)]  'move-text-up)
         ;;     ;; (define-key map [(control meta shift down)]  'move-text-down)
         (define-key org-mode-map (kbd "C-c n") 'prelude-cleanup-buffer-or-region)
         (define-key org-mode-map (kbd "C-c f")  'prelude-recentf-ido-find-file)
         (define-key org-mode-map (kbd "C-M-z") 'prelude-indent-defun)
         (define-key org-mode-map (kbd "C-c u") 'prelude-view-url)
         (define-key org-mode-map (kbd "C-c e") 'prelude-eval-and-replace)
         (define-key org-mode-map (kbd "C-c s") 'prelude-swap-windows)
         (define-key org-mode-map (kbd "C-c D") 'prelude-delete-file-and-buffer)
         (define-key org-mode-map (kbd "C-c d") 'prelude-duplicate-current-line-or-region)
         (define-key org-mode-map (kbd "C-c M-d") 'prelude-duplicate-and-comment-current-line-or-region)
         (define-key org-mode-map (kbd "C-c r") 'prelude-rename-buffer-and-file)
         (define-key org-mode-map (kbd "C-c t") 'prelude-visit-term-buffer)
         (define-key org-mode-map (kbd "C-c k") 'prelude-kill-other-buffers)
         ;;     ;; another annoying overwrite of a useful org-mode command:
         ;;     ;; (define-key map (kbd "C-c TAB") 'prelude-indent-rigidly-and-copy-to-clipboard)
         (define-key org-mode-map (kbd "C-c I") 'prelude-find-user-init-file)
         (define-key org-mode-map (kbd "C-c S") 'prelude-find-shell-init-file)
         ;; replace not functioning 'prelude-goto-symbol with useful imenu-anywhere
         (define-key org-mode-map (kbd "C-c i") 'imenu-anywhere)
         ;;     ;; extra prefix for projectile
         (define-key org-mode-map (kbd "s-p") 'projectile-command-map)
         ;;     ;; make some use of the Super key
         (define-key org-mode-map (kbd "s-g") 'god-local-mode)
         (define-key org-mode-map (kbd "s-r") 'prelude-recentf-ido-find-file)
         (define-key org-mode-map (kbd "s-j") 'prelude-top-join-line)
         (define-key org-mode-map (kbd "s-k") 'prelude-kill-whole-line)
         (define-key org-mode-map (kbd "s-m m") 'magit-status)
         (define-key org-mode-map (kbd "s-m l") 'magit-log)
         (define-key org-mode-map (kbd "s-m f") 'magit-log-buffer-file)
         (define-key org-mode-map (kbd "s-m b") 'magit-blame)
         (define-key org-mode-map (kbd "s-o") 'prelude-smart-open-line-above)
         ))

  (defun org-next-src-block ()
    "Jump to the next src block using SEARCH-FORWARD."
    (interactive)
    (search-forward "\n#+BEGIN_SRC")
    (let ((block-beginning (point)))
      (org-show-entry)
      (goto-char block-beginning)
      (goto-char (line-end-position 2))))

  (defun org-show-properties-block ()
    "Show the entire next properties block using SEARCH-FORWARD."
    (interactive)
    (search-forward ":PROPERTIES:")
    (let ((block-beginning (point)))
      (org-show-entry)
      (goto-char block-beginning)
      (org-cycle)
      ;; (goto-char (line-end-position 2))
      ;; (org-hide-block-toggle t)
      ))

  ;; org-mode-hook is run every time that org-mode is turned on for a buffer
  ;; It customizes some settings in the mode.
  (add-hook
   'org-mode-hook
   (lambda ()
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;; own stuff:
     ;; Make javascript blocks open in sclang mode in org-edit-special
     ;; This is because sclang blocks must currently be marked as javascript
     ;; in order to render properly with hugo / pygments for webite creation.
     (setq org-src-lang-modes (add-to-list 'org-src-lang-modes '("javascript" . sclang)))
     (setq org-hide-leading-stars t)
     ;; (org-indent-mode) ;; this results in added leading spaces in org-edit-special
     (visual-line-mode)
     ;; turn off prelude mode because its key bindings interfere with table bindings.
     ;; Instead, the prelude-mode keybindings have been copied to org-mode above,
     ;; minus the unwanted keybindings for tables.
     (prelude-off)
     ;; disable whitespace mode, which was previously disabled by prelude-mode
     (whitespace-mode -1)
     ))

  (defun org-customize-mode ()
    "Customize some display options for ORG-MODE.
  - map javascript to sclang-mode in babel blocks.
  - hide extra leading stars for sections.
  - turn on visual line mode."
  )

  (global-set-key (kbd "C-c C-x t") 'org-insert-current-date)
(provide 'org-mode)
;;; 014_org-mode.el ends here