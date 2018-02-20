;; Commenting this prevents it from being added
;; (require 'package)
;; (package-initialize)

(require 'cl-lib)

(use-package evil
  :bind ("C-c 0" . evil-mode)
  :config (evil-mode 1))

(use-package dash
  :demand t)

(setq imalison:use-frame-mode nil)

(setq imalison:fonts
      '("Source Code Pro:pixelsize=14:weight=semi-bold:slant=normal:width=normal:spacing=100:scalable=true"))

(defun imalison:join-paths (root &rest dirs)
  (let ((result root))
    (cl-loop for dir in dirs do
             (setq result (concat (file-name-as-directory result) dir)))
    result))

(defun imalison:org-file (&rest file-paths)
  (apply 'imalison:join-paths imalison:org-dir file-paths))

(defvar imalison:sparkleshare-dir "~/SparkleShare")
(defvar imalison:org-dir (imalison:join-paths imalison:sparkleshare-dir "org"))
(defvar imalison:dark-theme 'solarized-dark)
(defvar imalison:use-ido t)
(defvar imalison:package-archive-triples
  '(("elpa" "tromey.com/elpa/" "http")
    ("org" "orgmode.org/elpa/" "http")
    ("melpa"  "melpa.org/packages/" "http")
    ;; ("melpa-stable" "stable.melpa.org/packages/" nil)
    ))

;; Setup org files
(defvar imalison:org-calendar-file
  (imalison:org-file "calendar.org"))
(defvar imalison:org-gtd-file
  (imalison:join-paths imalison:org-dir "gtd.org"))
(defvar imalison:org-habits-file nil) ;; "~/SparkleShare/org/habits.org")
(defvar imalison:org-inbox-file (imalison:org-file "inbox.org"))

;; Setup custom org capture templates
(unless (boundp 'org-capture-templates)
  (defvar org-capture-templates nil))

;; (add-to-list 'org-capture-templates
;;              `("rs" "Room Share" entry (file ,)
;;                (function imalison:make-org-linked-todo-template)))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(anzu-deactivate-region t)
 '(anzu-mode-lighter "")
 '(anzu-replace-threshold 50)
 '(anzu-replace-to-string-separator " => ")
 '(anzu-search-threshold 1000)
 '(notmuch-search-line-faces
   (quote
	(("unread" :foreground "#aeee00")
	 ("flagged" :foreground "#0a9dff")
	 ("deleted" :foreground "#ff2c4b" :bold t))))
 '(safe-local-variable-values
   (quote
	((pytest-cmd-flags . "-sx --enable-logger=okcupyd --enable-logger=requests")
	 (pytest-global-name . "tox -e py27 --")
	 (eval when
		   (and
			(buffer-file-name)
			(file-regular-p
			 (buffer-file-name))
			(string-match-p "^[^.]"
							(buffer-file-name)))
		   (unless
			   (featurep
				(quote package-build))
			 (let
				 ((load-path
				   (cons "../package-build" load-path)))
			   (require
				(quote package-build))))
		   (package-build-minor-mode)
		   (set
			(make-local-variable
			 (quote package-build-working-dir))
			(expand-file-name "../working/"))
		   (set
			(make-local-variable
			 (quote package-build-archive-dir))
			(expand-file-name "../packages/"))
		   (set
			(make-local-variable
			 (quote package-build-recipes-dir))
			default-directory))
	 (bug-reference-bug-regexp . "#\\(?2:[0-9]+\\)")
	 (projectile-project-compilation-cmd . "bear make")
	 (projectile-project-run-cmd . "make run")
	 (flycheck-ghc-args "-Wno-missing-signatures")
	 (flycheck-disabled-checkers emacs-lisp-checkdoc)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; Local Variables:
;; flycheck-disabled-checkers: (emacs-lisp-checkdoc)
;; End:
