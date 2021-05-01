;; GUI settings
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(show-paren-mode 1)
(setq whitespace-style '(face tabs tab-mark trailing))
(global-whitespace-mode)

;; Font
(set-face-attribute 'default nil
  :font "Source Code Pro 10"
  :weight 'medium)
(set-face-attribute 'variable-pitch nil
  :font "Ubuntu 10"
  :weight 'medium)
(set-face-attribute 'fixed-pitch nil
  :font "Source Code Pro 10"
  :weight 'medium)

(add-to-list 'default-frame-alist '(font . "Source Code Pro 10"))

;; Install the MELPA repository
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; Install use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Install Evil
(use-package evil
  :ensure t ;; install evil if not already installed
  :init     ;; tweak evil's configuration before loading it
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (evil-mode))
(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

;; Install projectile
(use-package projectile
  :ensure t
  :config
  (projectile-global-mode 1))

;; Install counsel
(use-package counsel
  :ensure t
  :config
  (counsel-mode))

;; Theme
(use-package all-the-icons
  :ensure t)

(use-package gruber-darker-theme
  :ensure t
  :config (load-theme 'gruber-darker t))

(use-package dashboard
  :ensure t
  :init
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Welcome")
  (setq dashboard-items '((recents . 15)
                          (projects . 15)))
  :config
  (dashboard-setup-startup-hook))

;; Add rust support
(use-package rust-mode
  :ensure t
  :init
  (setq rust-format-on-save t)
  :defer)

;; Add go support
(use-package go-mode
  :ensure t
  :defer)

;; Which key
(use-package which-key
  :ensure t
  :config (which-key-mode))

;; Keybindings
(use-package general
  :ensure t
  :config
  (general-evil-setup t))

(nvmap :states '(normal visual) :keymaps 'override :prefix "SPC"
       "SPC" '(counsel-M-x :which-key "M-x")
       "f f" '(counsel-find-file :which-key "Find file")
       ;; Window splits
       "w d" '(evil-window-delete :which-key "Close window")
       "w n" '(evil-window-new :which-key "New window")
       "w s" '(evil-window-split :which-key "Horizontal split window")
       "w v" '(evil-window-vsplit :which-key "Vertical split window")
       ;; Window motions
       "w h" '(evil-window-left :which-key "Window left")
       "w j" '(evil-window-down :which-key "Window down")
       "w k" '(evil-window-up :which-key "Window up")
       "w l" '(evil-window-right :which-key "Window right")
       "w w" '(evil-window-next :which-key "Goto next window")
       ;; Buffers
       "b b" '(ibuffer :which-key "Ibuffer")
       "b n" '(next-buffer :which-key "Next buffer")
       "b p" '(previous-buffer :which-key "Previous buffer")
       "b d" '(kill-buffer :which-key "Kill buffer"))

;; Zooming in and out
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

;; --------------------------------------------------------------------------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(general which-key go-mode rust-mode dashboard gruber-darker-theme all-the-icons counsel projectile evil-collection evil use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
