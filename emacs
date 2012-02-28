;|
;| File          : ~/.emacs
;| Last modified : 2011-12-13
;| Author        : Fabien Cazenave
;| Licence       : WTFPL
;|

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(diary-file "~/Documents/diary.org")
 '(ns-command-modifier (quote control))
 '(ns-right-alternate-modifier (quote none))
 '(org-hide-emphasis-markers t))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )


;|===========================================================================
;|   General Preferences
;|===========================================================================

;; No bell, thanks.
;(setq visible-bell 1)
(setq ring-bell-function 'ignore)

;; No startup screen, thanks.
(setq inhibit-startup-screen t)
(setq inhibit-splash-screen t)

;; Parenthesis matching
(show-paren-mode 1)

;; highlight current line
;(global-hl-line-mode)

;; Add line numbers on the left
(global-linum-mode 1)
(column-number-mode t)
(line-number-mode t)
;; 1-char separation in CLI mode becomes 2 in GUI mode (Emacs really sucks!)
(if (window-system) (setq linum-format "%4d") (setq linum-format "%4d "))

;; Navigate windows with M-<arrows>
;(windmove-default-keybindings 'meta)
;(setq windmove-wrap-around t)

;; Whenever an external process changes a file underneath emacs, and there
;; was no unsaved changes in the corresponding buffer, just revert its
;; content to reflect what's on-disk.
(global-auto-revert-mode 1)

;; M-x shell is a nice shell interface to use, let's make it colorful.
;; Note: if you need a terminal emulator rather than just a shell,
;; consider M-x term instead.
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Color theme
;(require 'color-theme)
;(color-theme-initialize)
;(color-theme-charcoal-black)
(load-file "~/.emacs.d/color-theme-desert.el")
(color-theme-initialize)
(color-theme-desert)

;; Full-screen toggle (GUI only)
(defun fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
    (if (frame-parameter nil 'fullscreen) nil 'fullboth)))
(global-set-key [f11] 'fullscreen)


;|===========================================================================
;|   Input Mode
;|===========================================================================

;; Hide menubar in CLI mode
(if (window-system) (menu-bar-mode 1) (menu-bar-mode 0))

;; Enable mouse in CLI mode
(xterm-mouse-mode t)

;; make cut, copy and paste (keys and menu bar items) use the clipboard
;(menu-bar-enable-clipboard)

;; Use the clipboard, pretty please, so that copy/paste "works"
(setq x-select-enable-clipboard t)

;; Viper-Mode
;; funny but very limited and way to slow in "insert" mode
;(setq viper-mode t)
;(require 'viper)

;; ErgoEmacs
;; brings most standard shortcuts to Emacs, adds interesting stuff
;(load-file "~/.emacs.d/ergoemacs_1.9.1.1/site-lisp/site-start.el")

;; CUA-Mode
;; not as natural to use as ErgoEmacs but brings C-[z|x|c|v] shortcuts
;(cua-mode 1)

;; Notepad-Mode
;; extends CUA-Mode with a few ErgoEmacs features
(load-file "~/.emacs.d/notepad.el")


;|===========================================================================
;|   Org-Mode Settings
;|===========================================================================
; because Org is the only reason why I sometimes use Emacs ;-)

(setq load-path (cons "~/.emacs.d/org-7.7/lisp"         load-path))
(setq load-path (cons "~/.emacs.d/org-7.7/contrib/lisp" load-path))

(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-default-notes-file "~/Documents/org/quicktasks.org")
(setq org-agenda-files (list "~/Documents/org/todo.org"
                             "~/Documents/org/tutorial.org"))
