
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  '(auto-save-default nil)
  '(auto-save-interval 0)
  '(auto-save-list-file-prefix nil)
  '(auto-save-timeout 0)
  '(auto-show-mode t t)
  '(delete-auto-save-files nil)
  '(delete-old-versions (quote other))
  '(imenu-auto-rescan t)
  '(imenu-auto-rescan-maxout 500000)
  '(kept-new-versions 5)
  '(kept-old-versions 5)
  '(make-backup-file-name-function (quote ignore))
  '(make-backup-files nil)
  '(mouse-wheel-follow-mouse nil)
  '(mouse-wheel-progressive-speed nil)
  '(mouse-wheel-scroll-amount (quote (15)))
  '(version-control nil)) 

; Setup my custom theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/emacs-color-theme-solarized")
(load-theme 'solarized-dark t)

; Make my window size correct
(add-to-list 'default-frame-alist '(height . 60))
(add-to-list 'default-frame-alist '(width . 120))

; Turn off the toolbar
(tool-bar-mode 0)

; Turn off the bell on Mac OS X
(defun nil-bell ())
(setq ring-bell-function 'nil-bell)

; Hide the ugly scroll bar
(scroll-bar-mode 0)

; Set the fonts
(add-to-list 'default-frame-alist '(font . "Menlo-12"))
(set-face-attribute 'default t :font "Menlo-12")
