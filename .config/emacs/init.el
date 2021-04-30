;; GUI settings
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

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

;; Theme
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-ayu-mirage t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)
  
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package dashboard
  :ensure t
  :init
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Welcome")
  (setq dashboard-items '((recents . 10)
			  (agenda . 5)
			  (bookmarks . 5)
			  (projects . 5)
			  (registers . 5)))
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
       "f f" '(find-file :which-key "Find file")
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
   '(general which-key doom-themes evil-collection evil use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
