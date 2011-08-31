;;(setq load-path (cons "~/.emacs.d/" "~/.emacs.d/icicles" load-path ))
(setq load-path (append (list nil "~/.emacs.d/" "~/.emacs.d/icicles" ) load-path ))

(setq inhibit-startup-screen t)

(require 'color-theme)
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

;; standardowe klawisze kopiowania i wklejania
;(cua-mode)

;; podswietlanie aktualnej linii
(global-hl-line-mode)

;; lista ostatnio otwartych plikow recentf-open-files
(recentf-mode 1)

(line-number-mode 1)
(column-number-mode 1)
(require 'linum)

;; dopasowywanie nazw buforow
(ido-mode t)
(setq ido-enable-flex-matching t)

;; pokazywanie nazwy aktualnej metody/funkcji
(which-function-mode t)

;;(define-key text-mode-map (kbd "<tab>") 'tab-to-tab-stop)
(setq-default indent-tabs-mode nil)
;;(setq tab-stop-list '(5 9 13 17 21 25 29 33 37 41 45 49 53 57 61 65 69 73 77 81 85 89 93))
;;(setq c-basic-offset 4)

;;(require 'auto-complete)
;;(global-auto-complete-mode t)

(require 'buff-menu+)

(require 'whitespace)
;;(whitespace-global-mode)

(require 'personal)

(set-default-font "Droid Sans Mono 11")
;; domyslna czcionka dla wszystkich okien
;;(add-to-list 'default-frame-alist '(font . "9x15"))
(add-to-list 'default-frame-alist '(font . "Droid Sans Mono 11"))

(setq c-default-style "stroustrup")
(add-to-list 'auto-mode-alist '("\.rb$" . ruby-mode))
(setq auto-mode-alist (append '(("\\.tcc$" . c++-mode)) auto-mode-alist))

;; zachowanie funkcji otwierania alternatywnego pliku
(require 'find-file)
(setq cc-other-file-alist (append '((".tcc")) cc-other-file-alist )) ;;dziala?
(setq ff-always-try-to-create nil)
;;(setq ff-always-try-to-create (append (list "./*/src" "./*/*/src" ) ff-search-directories))
;;(setq ff-ignore-include t)

(setq abbrev-file-name "~/.emacs.d/abbrev_defs")

;; speedbar
;;(when window-system  ; start speedbar if we're using a window system
;;  (speedbar t))
(require 'speedbar)
(setq speedbar-use-images nil)
(speedbar-add-supported-extension ".tcc")
(add-to-list 'speedbar-fetch-etags-parse-list '("\\.tcc" . speedbar-parse-c-or-c++tag))

(require 'org)

(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")

(setq Man-switches "-a")

;;====================================================================================================
;; skroty klawiszowe
(global-set-key [f1] 'manual-entry)
(setq Man-notify-method 'newframe)
(global-set-key [f3] 'buffer-menu)
(global-set-key [f5] 'previous-error)
(global-set-key [f6] 'next-error)
(global-set-key [f9] 'compile)
(global-set-key (kbd "<f2>") '(lambda ()(interactive)(switch-to-buffer "*Tree*")))
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
(windmove-default-keybindings)

(defalias 'lml 'list-matching-lines)
(defalias 'hr 'highlight-regexp)

(server-start)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

