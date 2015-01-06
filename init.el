
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

; Setup the required goodies
(load-library "view")
(require 'cc-mode)
(require 'ido)
(require 'compile)
(ido-mode t)

; Setup my custom theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/emacs-color-theme-solarized")
(load-theme 'solarized-dark t)

; Make my window size correct
(add-to-list 'default-frame-alist '(height . 60))
(add-to-list 'default-frame-alist '(width . 195))
(split-window-horizontally)

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

; Compilation
(setq compilation-directory-locked nil)
(setq owensd-makescript "./build.sh")

(setq compilation-context-lines 0)
(setq compilation-error-regexp-alist
    (cons '("^\\([0-9]+>\\)?\\(\\(?:[a-zA-Z]:\\)?[^:(\t\n]+\\)(\\([0-9]+\\)) : \\(?:fatal error\\|warnin\\(g\\)\\) C[0-9]+:" 2 3 nil (4))
     compilation-error-regexp-alist))

(defun find-project-directory-recursive ()
  "Recursively search for a makefile."
  (interactive)
  (if (file-exists-p owensd-makescript) t
      (cd "../")
      (find-project-directory-recursive)))

(defun lock-compilation-directory ()
  "The compilation process should NOT hunt for a makefile"
  (interactive)
  (setq compilation-directory-locked t)
  (message "Compilation directory is locked."))

(defun unlock-compilation-directory ()
  "The compilation process SHOULD hunt for a makefile"
  (interactive)
  (setq compilation-directory-locked nil)
  (message "Compilation directory is roaming."))

(defun find-project-directory ()
  "Find the project directory."
  (interactive)
  (setq find-project-from-directory default-directory)
  (switch-to-buffer-other-window "*compilation*")
  (if compilation-directory-locked (cd last-compilation-directory)
  (cd find-project-from-directory)
  (find-project-directory-recursive)
  (setq last-compilation-directory default-directory)))

(defun make-without-asking ()
  "Make the current build."
  (interactive)
  (if (find-project-directory) (compile owensd-makescript))
  (other-window 1))
(define-key global-map "\em" 'make-without-asking)
