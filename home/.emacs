(setq inhibit-startup-screen t)

;;====================================================================================================
;; Load modules
;;====================================================================================================
(setq load-path (append (list nil "~/.emacs.d/") load-path ))
(require 'color-theme)
(require 'linum)
(require 'ibuffer)
(require 'whitespace)
(require 'personal)
(require 'find-file)
(require 'speedbar)
(require 'org)
;;====================================================================================================

(color-theme-initialize)
(color-theme-pierson)

;; wylaczenie toolbara i scrollbara
(tool-bar-mode 0)
(toggle-scroll-bar -1)
(show-paren-mode t)

(fset 'yes-or-no-p 'y-or-n-p)

;;(desktop-save-mode 1)
(setq history-length 250)
;;(add-to-list 'desktop-globals-to-save 'file-name-history)

;; podswietlanie aktualnej linii
(global-hl-line-mode)

;; lista ostatnio otwartych plikow recentf-open-files
(recentf-mode 1)

(line-number-mode 1)
(column-number-mode 1)

;;
;; numerowanie linii w wybranych trybach
(add-hook 'c-mode-common-hook 'linum-mode)
(add-hook 'haskell-mode-hook 'linum-mode)

;;
;; wlaczenie trybu hide-show
(add-hook 'c-mode-common-hook 'hs-minor-mode)

;; dopasowywanie nazw buforow
(ido-mode t)
(setq ido-enable-flex-matching t)

;; pokazywanie nazwy aktualnej metody/funkcji
(which-function-mode t)

;;(define-key text-mode-map (kbd "<tab>") 'tab-to-tab-stop)
(setq-default indent-tabs-mode nil)
;;(setq c-basic-offset 4)
 
;;
;; font settings
(set-default-font "Droid Sans Mono 11")
(add-to-list 'default-frame-alist '(font . "Droid Sans Mono 11"))

(setq c-default-style "stroustrup")
(add-to-list 'auto-mode-alist '("\.rb$" . ruby-mode))
(setq auto-mode-alist (append '(("\\.tcc$" . c++-mode)) auto-mode-alist))

;; zachowanie funkcji otwierania alternatywnego pliku
(setq cc-other-file-alist (append '((".tcc")) cc-other-file-alist )) ;;dziala?
(setq ff-always-try-to-create nil)
;;(setq ff-always-try-to-create (append (list "./*/src" "./*/*/src" ) ff-search-directories))
;;(setq ff-ignore-include t)

(setq abbrev-file-name "~/.emacs.d/abbrev_defs")

;; speedbar
(setq speedbar-use-images nil)
(speedbar-add-supported-extension ".tcc")
(speedbar-add-supported-extension ".hs")
(add-to-list 'speedbar-fetch-etags-parse-list '("\\.tcc" . speedbar-parse-c-or-c++tag))

(setq Man-switches "-a")

;;
;; dodanie indeksu imenu dla plikow wybranych trybow
(add-hook 'haskell-mode-hook 'imenu-add-menubar-index)
(add-hook 'c-mode-common-hook 'imenu-add-menubar-index)

;;
;; C-n i C-p w trybie occur przechoda pomiedzy dopasowaniami
(add-hook 'occur-mode-hook 'next-error-follow-minor-mode)
;;====================================================================================================
;; skroty klawiszowe
(global-set-key [f1] 'manual-entry)
(setq Man-notify-method 'newframe)
(global-set-key [f3] 'ibuffer)
(global-set-key [f4] 'list-bookmarks)
(global-set-key [f5] 'previous-error)
(global-set-key [f6] 'next-error)
(global-set-key [f9] 'compile)
(global-set-key "\C-x/" '(lambda ()(interactive)(multi-occur-in-matching-buffers ".*" (read-string '"Search all buffers: "))))
(global-set-key "\C-x?" 'list-matching-lines)
(global-set-key "\C-xg" 'header-guard-insert-default)
(global-set-key "\C-xa" 'ff-find-other-file)
(global-set-key "\C-xF" 'ack-grep)
(global-set-key "\C-x>" 'sql-send-region)
(global-set-key "\C-x;" 'sql-send-paragraph)
(global-set-key [(control .)] 'complete-tag)
(global-set-key [(control tab)] 'other-frame)
(global-set-key [(backtab)] 'other-window)
(global-set-key "\M-g" 'goto-line)
(global-set-key [(control \`)] 'hippie-expand)
(global-set-key [(control \;)] 'copy-above-char)
(global-set-key "\C-xb" 'bookmark-set)
(global-set-key "\C-xj" 'jump-to-register)
(global-set-key "\C-xm" 'point-to-register)
(windmove-default-keybindings)

(defalias 'lml 'list-matching-lines)
(defalias 'hr 'highlight-regexp)

(server-start)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)
