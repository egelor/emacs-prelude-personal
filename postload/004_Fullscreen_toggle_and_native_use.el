;;; Fullscreen_toggle_and_native_use --- 2017-08-16 01:17:41 AM
;;; Commentary:
;;; enable native fullscreen mode and define key for toggling.

;;; Code:
(setq ns-use-native-fullscreen nil)
(global-set-key (kbd "H-t") 'toggle-frame-fullscreen)
(provide 'Fullscreen_toggle_and_native_use)
;;; 004_Fullscreen_toggle_and_native_use.el ends here
