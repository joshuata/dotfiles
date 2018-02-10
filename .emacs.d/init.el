;;; init.el -- My Emacs configuration
;-*-Emacs-Lisp-*-

;;; Commentary:
;;
;; Based off of Aaron Bieber's emacs config
;;   https://github.com/aaronbieber/dotfiles/blob/master/configs/emacs.d/init.el
;;
;;; Code:

(package-initialize)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(require 'init-elpa)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(use-package base16-theme
  :ensure t)

(use-package evil
  :ensure t
  :config
  (evil-mode t)

  (use-package evil-leader
    :ensure t
    :config
    (global-evil-leader-mode))

  (use-package org-evil
    :ensure t
    :config)
  )

(use-package org
  :ensure t
  )

(use-package helm
    :ensure t
    :config
    (helm-mode t)
    (setq helm-buffers-fuzzy-matching t)
    (setq helm-autoresize-mode t)
    (setq helm-buffer-max-length 40)
    )

(load "~/.emacs.d/lisp/PG/generic/proof-site")
