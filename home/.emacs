(setq inhibit-startup-screen t)

;;====================================================================================================
;; Load modules
;;====================================================================================================
(require 'package)
(package-initialize)
(require 'evil)
(setq load-path (append (list nil "~/.emacs.d/") load-path ))
(require 'linum)
(require 'ibuffer)
(require 'whitespace)
(require 'personal)
(require 'find-file)
(require 'speedbar)
(require 'ace-jump-mode)
;;(require 'anything-config)
(require 'org)
;;(require 'scf-mode)

(add-to-list 'load-path "~/.emacs.d/helm")
(require 'helm-config)
;;====================================================================================================
(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(load-theme 'zenburn t)

;;(evil-mode 1)

;; wylaczenie toolbara i scrollbara
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode -1)
(show-paren-mode t)

;; track and maintain window layout changes
(winner-mode)

(fset 'yes-or-no-p 'y-or-n-p)
(setq use-dialog-box nil)

;;(desktop-save-mode 1)
(setq history-length 250)
;;(add-to-list 'desktop-globals-to-save 'file-name-history)

;; podswietlanie aktualnej linii
;;(global-hl-line-mode)

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
(add-to-list 'ido-ignore-files '("*.o"))
;; pokazywanie nazwy aktualnej metody/funkcji
(which-function-mode t)

;;(define-key text-mode-map (kbd "<tab>") 'tab-to-tab-stop)
(setq-default indent-tabs-mode nil)
;;(setq c-basic-offset 4)

(setq backup-directory-alist (quote ((".*" . "~/.emacs_backups/"))))

;;
;; font settings
(set-default-font "Droid Sans Mono 10")
(add-to-list 'default-frame-alist '(font . "Droid Sans Mono 10"))

(setq c-default-style "stroustrup")
(add-to-list 'auto-mode-alist '("\.rb$" . ruby-mode))
(setq auto-mode-alist (append '(("\\.tcc$" . c++-mode)) auto-mode-alist))

(add-to-list 'auto-mode-alist '("\\.vala$" . vala-mode))
(add-to-list 'auto-mode-alist '("\\.vapi$" . vala-mode))

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
;; vala-mode-hook doesn't work??
(add-hook 'vala-mode-hook (lambda () (setq find-extensions '("*.vala"))))
(add-hook 'c-mode-common-hook (lambda () (setq find-extensions '("*.h" "*.c" "*.cpp"))))
(add-hook 'c-mode-common-hook 'imenu-add-menubar-index)
(add-hook 'c-mode-common-hook 'smart-tab-mode)
(add-hook 'c-mode-common-hook (lambda () (setq indent-tabs-mode nil)))


;; show code when browsing occurences in grep/occur modes
;;(add-hook 'occur-mode-hook 'next-error-follow-minor-mode)
;;(add-hook 'grep-mode-hook 'next-error-follow-minor-mode)

;;(add-hook 'grep-mode-hook (lambda () (scf-mode 1)))

;;====================================================================================================
;; skroty klawiszowe
(global-set-key [f1] 'manual-entry)
(setq Man-notify-method 'newframe)
(global-set-key [f3] 'ibuffer)
(global-set-key [f4] 'anything)
;;(global-set-key [f5] 'previous-error)
(global-set-key [f6] 'next-error)
(global-set-key [f9] 'compile)
(global-set-key "\C-x/" '(lambda ()(interactive)(multi-occur-in-matching-buffers ".*" (read-string '"Search all buffers: "))))
(global-set-key "\C-x?" 'list-matching-lines)
(global-set-key "\C-xg" 'header-guard-insert-default)
(global-set-key "\C-xa" 'ff-find-other-file)
(global-set-key "\C-xF" 'ack-grep)
(global-set-key "\C-x_" 'grep-for-word-under-cursor)
(global-set-key "\C-x>" 'sql-send-region)
(global-set-key "\C-x;" 'comment-or-uncomment-region)
(global-set-key [(control .)] 'complete-tag)
(global-set-key [(control tab)] 'other-frame)
(global-set-key [(backtab)] 'other-window)
(global-set-key [(control \`)] 'hippie-expand)
(global-set-key [(control \')] 'copy-above-char)
(global-set-key "\C-xj" 'jump-to-register)
(global-set-key "\C-xm" 'point-to-register)
(global-set-key "\C-\M-z" 'ace-jump-line-mode)
(global-set-key "\C-z" 'ace-jump-word-mode)
                  
(windmove-default-keybindings)
(defalias 'lml 'list-matching-lines)
(defalias 'hr 'highlight-regexp)
(defalias 'ws 'whitespace-mode)

;; set frame title to file name / buffer name
(setq frame-title-format '("" invocation-name ": "(:eval (if (buffer-file-name) (abbreviate-file-name (buffer-file-name)) "%b"))))

(server-start)

;;(setq custom-file "~/.emacs.d/custom.el")
;;(load custom-file 'noerror)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("71b172ea4aad108801421cc5251edb6c792f3adbaecfa1c52e94e3d99634dee7" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-region 'disabled nil)
