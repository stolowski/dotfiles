(setq inhibit-startup-screen t)

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
(global-hl-line-mode)

;; lista ostatnio otwartych plikow recentf-open-files
(recentf-mode 1)

(line-number-mode 1)
(column-number-mode 1)
(global-linum-mode t)

;;====================================================================================================
;; Load modules
;;====================================================================================================
(require 'package)
(package-initialize)
;; load bs to make bs-configurations available
(require 'bs)
(require 'evil)
(setq load-path (append (list nil "~/.emacs.d/") load-path ))
(setq load-path (append (list nil "~/.emacs.d/elpa/vala-mode-0.1") load-path ))
(require 'linum)
(require 'ibuffer)
(require 'whitespace)
(require 'personal)
(require 'find-file)
(require 'speedbar)
(require 'ace-jump-mode)
(require 'org)
(require 'vala-mode)
;;(require 'scf-mode)

;;====================================================================================================
;; HELM
;;====================================================================================================
(add-to-list 'load-path "~/.emacs.d/helm")
(require 'helm-config)

;;====================================================================================================
;; PACKAGE
;;====================================================================================================
(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(load-theme 'pastels-on-dark t)

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
(setq c-basic-offset 4)

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

;;(add-to-list 'bs-configurations '("vala" "\\.*.vala\\$" nil nil bs-visits-non-file bs-sort-buffer-interns-are-last))
;;(add-to-list 'bs-configurations '("sources" "^\\*.\\(h\\|cpp\\|py\\|vala\\)$" nil nil bs-visits-non-file bs-sort-buffer-interns-are-last))

;; speedbar
(setq speedbar-use-images nil)
(speedbar-add-supported-extension ".tcc")
(speedbar-add-supported-extension ".hs")
(add-to-list 'speedbar-fetch-etags-parse-list '("\\.tcc" . speedbar-parse-c-or-c++tag))

(setq Man-switches "-a")

;;
;; dodanie indeksu imenu dla plikow wybranych trybow
(add-hook 'haskell-mode-hook 'imenu-add-menubar-index)
(add-hook 'c-mode-hook 'imenu-add-menubar-index)
(add-hook 'c-mode-common-hook 'smart-tab-mode)
(add-hook 'c-mode-common-hook (lambda () (setq indent-tabs-mode nil)))
(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))

;;====================================================================================================
;; VALA SETTINGS
;;====================================================================================================
(setq vala-imenu-generic-expression  (list
                                     (list "Types" "^ *\\(public\\|private\\|internal\\) *\\(class\\|struct\\|enum\\) *\\([_a-zA-Z0-9]+\\)" 3)
                                     (list "Methods" "^ *\\(public\\|private\\|internal\\) *\\(static\\|abstract\\|override\\|virtual\\)* *\\([._0-9a-zA-Z]*?\\) *\\([_a-zA-Z0-9]+\\) *(" 4)
                                     ))
(defun my-vala-init ()
  (progn
    (setq c-basic-offset 2)
    (setq imenu-generic-expression vala-imenu-generic-expression)
    (setq find-extensions '("*.vala"))
    (imenu-add-menubar-index))
  )
(add-hook 'vala-mode-hook 'my-vala-init)

;;(add-hook 'vala-mode-hook (lambda () (set-variable imenu-generic-expression vala-imenu-generic-expression t)))

;; show code when browsing occurences in grep/occur modes
;;(add-hook 'occur-mode-hook 'next-error-follow-minor-mode)
;;(add-hook 'grep-mode-hook 'next-error-follow-minor-mode)
;;(add-hook 'grep-mode-hook (lambda () (scf-mode 1)))


;;====================================================================================================
;; MARK-MULTIPLE
;;====================================================================================================
(add-to-list 'load-path "~/.emacs.d/mark-multiple")
(require 'mark-more-like-this)
(global-set-key (kbd "C-<") 'mark-previous-like-this)
(global-set-key (kbd "C->") 'mark-next-like-this)
(global-set-key (kbd "C-M-m") 'mark-more-like-this) ; like the other two, but takes an argument (negative is previous)
(global-set-key (kbd "C-*") 'mark-all-like-this)


;;====================================================================================================
;; ACK-AND-A-HALF
;;====================================================================================================
(add-to-list 'load-path "~/.emacs.d/ack-and-a-half")
(require 'ack-and-a-half)
;; Create shorter aliases
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)

;;====================================================================================================
;; skroty klawiszowe
(global-set-key [f1] 'manual-entry)
(setq Man-notify-method 'newframe)
;;(global-set-key [f3] 'ibuffer)
(global-set-key [f3] 'bs-show)
(global-set-key [f4] 'helm-buffers-list)
(global-set-key [f5] 'previous-error)
(global-set-key [f6] 'next-error)
(global-set-key [f9] 'compile)
(global-set-key (kbd "C-<f5>") 'linum-mode)
(global-set-key "\C-x/" '(lambda ()(interactive)(multi-occur-in-matching-buffers ".*" (read-string '"Search all buffers: "))))
(global-set-key "\C-x?" 'list-matching-lines)
(global-set-key "\C-xg" 'header-guard-insert-default)
(global-set-key "\C-xa" 'ff-find-other-file)
;;(global-set-key "\C-\M-f" 'ack)
(global-set-key "\C-x_" 'ack-and-a-half-same)
(global-set-key "\C-R" 'rename-uniquely)
(global-set-key "\C-x>" 'sql-send-region)
(global-set-key "\C-x;" 'comment-or-uncomment-region)
(global-set-key [(control .)] 'complete-tag)
(global-set-key [(control tab)] 'other-frame)
(global-set-key [(backtab)] 'other-window)
(global-set-key [(control \`)] 'helm-browse-project)
(global-set-key "\M-/" 'dabbrev-expand)
(global-set-key [(control \')] 'copy-above-char)
(global-set-key "\C-xj" 'jump-to-register)
(global-set-key "\C-xm" 'point-to-register)
(global-set-key "\C-\M-z" 'ace-jump-line-mode)
(global-set-key "\C-z" 'ace-jump-word-mode)
(global-set-key "\C-x|" 'split-window-right)
(global-set-key "\C-x-" 'split-window-below)
(global-set-key "\M-g" 'goto-line)

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
 '(custom-safe-themes (quote ("30fe7e72186c728bd7c3e1b8d67bc10b846119c45a0f35c972ed427c45bacc19" "71b172ea4aad108801421cc5251edb6c792f3adbaecfa1c52e94e3d99634dee7" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'set-goal-column 'disabled nil)
