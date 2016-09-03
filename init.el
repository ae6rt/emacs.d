;;; Hello package
(require 'package)

;;; https://www.emacswiki.org/emacs/ElectricPair
(electric-pair-mode 1)

;;; https://melpa.org/#/getting-started
(add-to-list 'package-archives
     '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;;; http://ergoemacs.org/emacs/emacs_set_backup_into_a_directory.html
(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)
(setq auto-save-default t)

;; http://elfs.livejournal.com/1216037.html
(defun paren-bounce ()  (interactive)
       (let ((prev-char (char-to-string (preceding-char)))
             (next-char (char-to-string (following-char))))
         (cond ((string-match "[[{(<]" next-char)
                (forward-sexp 1))
               ((string-match "[\]})>]" prev-char)
                (backward-sexp 1))
               (t (error "%s" "Not an expression boundary.")))))
(global-set-key [(control ?%)] 'paren-bounce)

;;; show line:column
(setq column-number-mode t)

;; http://www.masteringemacs.org/articles/2011/01/19/script-files-executable-automatically/
(add-hook 'after-save-hook
           'executable-make-buffer-file-executable-if-script-p)

;;; show matching parens
(show-paren-mode 1)

;;; smooth scrolling
(setq scroll-step 1)

;;; disable tabs for indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 3)
;;; (setq indent-line-function 'insert-tab)
;;; (setq tab-width 3)

;;; ----------------------------

;;; yaml
;;; https://raw.githubusercontent.com/yoshiki/yaml-mode/master/yaml-mode.el
(add-to-list 'load-path "~/.emacs.d/yaml-support")
(require 'yaml-mode)

;;; Install flycheck with MELPA
(add-hook 'after-init-hook #'global-flycheck-mode)

;;; Manually install go-mode
(add-to-list 'load-path "~/.emacs.d/go-support")
(require 'go-mode-autoloads)

;;; https://github.com/nschum/highlight-symbol.el
(add-to-list 'load-path "~/.emacs.d/highlight-support")
(require 'highlight-symbol)

;;; https://www.emacswiki.org/emacs/highlight-chars.el
(require 'highlight-chars)

;;; Manually install go-eldoc
; https://github.com/syohex/emacs-go-eldoc#setup
(require 'go-eldoc)

;;; go-rename.el at https://github.com/golang/tools/blob/master/refactor/rename/go-rename.el
(require 'go-rename)

;;; http://andrewjamesjohnson.com/configuring-emacs-for-go-development/
(defun go-mode-setup ()
  (setq compile-command "make test")
  (define-key (current-local-map) "\C-c\C-c" 'compile)
  (go-eldoc-setup)
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (local-set-key (kbd "M-.") 'godef-jump))
(add-hook 'go-mode-hook 'go-mode-setup)

;;; http://yousefourabi.com/blog/2014/05/emacs-for-go/
(add-hook 'go-mode-hook 'company-mode)
(add-hook 'go-mode-hook (lambda ()
			  (set (make-local-variable 'company-backends) '(company-go))
			  (company-mode)))

;;; http://www.emacswiki.org/emacs/SmoothScrolling
(setq scroll-step 1)
