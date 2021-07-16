(define-module (uniks krimyn))
(use-modules (home)
             (home ssh)
             (home profile)
             (home utils)
             (home bash)
             (home zsh)
             (giiks)
             (oop goops)
             (ice-9 format)
             (guix store)
             (guix packages)
             (guix derivations)
             (guix git-download)
             (guix gexp))
(export (->home))

(define (newline-strings strings)
  (string-join strings "\n" 'prefix))

(define (shell-set-env env-value-pairs)
  (define (export-env env-value-pair)
    (format #f "export ~a=~a"
	    (car env-value-pair) (car (cdr env-value-pair))))
  (newline-strings (map export-env env-value-pairs)))

(define coleremak-drv
  (origin->derivation
   (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/maisiliym/coleremak")
           (commit "ffe10ed51234728b5f29f574a7768d7f427487f2")))
     (sha256
      (base32 "0wnjl269y01hnd41r78h6h564j99236n27izmprs2c07f9pv2g08")))))

(define coleremak
  (make <deriveicyn> #:inyr coleremak-drv))

(define zsh-coleremak
  (newline-strings
   (list
    (string-append ". " (->path coleremak) "/coleremak.zsh") )))

(define shell-env 
  (shell-set-env 
   (quote 
    (("PATH" "~/.config/guix/current/bin:$PATH")
     ("GUILE_LOAD_PATH" "~/.config/guix/current/share/guile/site/3.0:$GUILE_LOAD_PATH")
     ("GUILE_LOAD_COMPILED_PATH" "~/.config/guix/current/lib/guile/3.0/site-ccache:$GUILE_LOAD_COMPILED_PATH")))))

(define zsh-env 
  (shell-set-env 
   (quote
    (("HISTFILE" "~/.local/share/zsh/history")
     ("HISTSIZE" 10000)
     ("SAVEHIST" 1000)
     ("SHARE_HISTORY" 1)))))

(define interactive-zsh-env 
  (shell-set-env 
   (quote
    (("SSH_AUTH_SOCK" "$(gpgconf --list-dirs agent-ssh-socket)")
     ("EDITOR" "emacs")
     ("FZF_DEFAULT_OPTS" "\"--bind=ctrl-o:up,ctrl-e:up,ctrl-n:down,ctrl-k:down,ctrl-i:clear-screen,ctrl-s:delete-char/eof,ctrl-f:end-of-line,alt-t:forward-word,alt-s:kill-word,ctrl-u:toggle+down,ctrl-l:unix-line-discard,ctrl-j:yank --color=bg:#f9f5d7,bg+:#ebdbb2,fg:#665c54,fg+:#3c3836,header:#076678,hl:#076678,hl+:#076678,info:#b57614,marker:#427b58,pointer:#427b58,prompt:#b57614,spinner:#427b58\"")
     ("FZF_DEFAULT_COMMAND" "\"fd -tf\"")))))

(define interactive-zsh
  (newline-strings
   (list
    "export GPG_TTY=$(tty)"
    "gpg-connect-agent --quiet updatestartuptty /bye > /dev/null"
    "bindkey -v"
    "autoload -U compinit && compinit"
    "autoload -Uz url-quote-magic"
    "zle -N self-insert url-quote-magic"
    "autoload -Uz bracketed-paste-magic"
    "zle -N bracketed-paste bracketed-paste-magic"
    "fpath=(~/.home-profile/share/zsh/site-functions $fpath)"
    ". ~/.home-profile/src/github.com/junegunn/fzf/shell/completion.zsh"
    ". ~/.home-profile/src/github.com/junegunn/fzf/shell/key-bindings.zsh"
    "bindkey '^T' fzf-history-widget"
    "bindkey '^P' fzf-cd-widget"
    "bindkey '^F' fzf-file-widget"
    "bindkey '^N' fzf-completion")))

(define source-home-profile (source-profile '~/.home-profile))

(define gnupg-conf '())

(define guile-geiser-file
  (local-file "guile-geiser.scm"))

(define guile-file
  (local-file "guile.scm"))

(define wofi-config-file
  (local-file "wofi/config"))

(define wofi-style-file
  (local-file "wofi/style.css"))

(define-method ->home (krimyn <krimyn>)
  (->home (<-krimyn last-raizyn krimyn)))

(define-method (->home (raizyn <raizyn>))
  (define krimyn (->kimyn raizyn))
  (define prineksys (->prineksys raizyn))
  (define neksys (->neksys raizyn))
  (define prineksys-neim (->neim prineksys))
  (define prikriom (->prikriom krimyn prineksys-neim))
  
  (define data-directory (string-append "/home/." (->neim krimyn)))
  
  (define (data-mirror path)
    (symlink-file-home (string-append data-directory path) path))

  (define sshcontrol-file 
    (mixed-text-file "sshcontrol" (->keygrip prikriom)))

  (define gitconfig-file
    (make-ini-file
     "git-config"
     `(("commit"
	(("gpgSign" "true")))
       ("init"
	(("defaultBranch" "mein"))) 
       ("user"
	(("email" ,(->email krimyn neksys))
	 ("name" ,(->neim krimyn))
	 ("signingKey" ,(string-append "&" (->keygrip prikriom)))))
       ("ghq"
	(("root" "/git")))
       ("github"
	(("user" ,(->github-user krimyn)))))))

  (home
   (data-directory data-directory)
   (configurations
    (list
     (data-mirror "git")
     (data-mirror "Downloads")
     (data-mirror ".gnupg")
     (data-mirror ".password-store")
     (symlink-file-home "/home/.li/git/imaks" ".config/emacs") ; TODO
     (symlink-file-home "/home/.li/git/li/sway.conf" ".config/sway/config") ; TODO
     (symlink-file-home gitconfig-file ".config/git/config")
     (symlink-file-home wofi-config-file ".config/wofi/config")
     (symlink-file-home wofi-style-file ".config/wofi/style.css")
     (data-mirror ".config/tox")   
     (data-mirror ".guile-geiser")
     (data-mirror ".guile")
     (data-mirror ".slime")
     (data-mirror ".geiser_history")
     ;; (symlink-file-home gitconfig-file ".config/git/config")
     ;; (symlink-file-home guile-geiser-file ".guile-geiser") 
     (user-home
      ssh-home-type
      (ssh-configuration
       (known-hosts
	(list
	 (ssh-known-host-configuration
          (names '("github.com"))
	  (algo "ssh-rsa")
          (key "AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ=="))
	 (ssh-known-host-configuration
          (names '("dante"))
	  (algo "ssh-ed25519")
          (key "AAAAC3NzaC1lZDI1NTE5AAAAIGjgYK7TBRSDa6Iuapw18VkS970p4IgZAo3iC/QiiypL"))
	 (ssh-known-host-configuration
          (names '("xerxes"))
	  (algo "ssh-ed25519")
          (key "AAAAC3NzaC1lZDI1NTE5AAAAIIFxIyvJxTrKCdXDrLi1ac3kZW8VE/+pW4f/SZVwj2Ue"))))))
     (user-home
      zsh-home-type
      (zsh-configuration
       (env (list shell-env zsh-env))
       (profile (list
		 source-etc-profile
		 source-home-profile))
       (rc (list interactive-zsh-env interactive-zsh zsh-coleremak))
       (history (string-append data-directory ".local/share/zsh/history"))))
     (user-home
      bash-home-type
      (bash-configuration
       (rc (reverse (append default-bashrc
			    (list source-home-profile))))
       (profile (append default-bash-profile
			(list "EDITOR=emacs\n")))
       (history (string-append data-directory ".local/share/bash/history"))))
     (user-home
      package-profile-home-type
      (append
       %style-packages %crypto-packages %dev-packages
       %comms-packages %multimedia-packages
       %network-tools-packages %emacs-packages
       %sway-packages))))))

(use-modules (giiks emacs-xyz)
	     (flat packages emacs)
	     (gnu packages admin)	     
	     (gnu packages networking)
	     (gnu packages linux)
	     (gnu packages guile)
	     (gnu packages xdisorg)
	     (gnu packages web-browsers)
	     (gnu packages wm)
	     (gnu packages pdf)
	     (gnu packages gnome)
	     (gnu packages messaging)
	     (gnu packages package-management)
	     (gnu packages fonts)
	     (gnu packages autotools)
	     (gnu packages gdb)
	     (gnu packages gettext)
	     (gnu packages perl)
	     (gnu packages gnupg)
	     (gnu packages lisp)
	     (gnu packages emacs)
	     (gnu packages emacs-xyz)
	     (gnu packages dvtm)
	     (gnu packages abduco)
	     (gnu packages shells)
	     (gnu packages terminals)
	     (gnu packages bittorrent)
	     (gnu packages video)
	     (gnu packages ncurses)
	     (gnu packages fontutils)
	     (gnu packages version-control)
	     (gnu packages rust-apps))

(define %style-packages
  (list
   fontconfig font-google-material-design-icons
   hicolor-icon-theme font-awesome))

(define %crypto-packages
  (list
   gnupg pinentry-tty pinentry-gnome3 pinentry-emacs))

(define %dev-packages
  (list
   git mercurial ghq guix shepherd
   zsh fzf perl tokei gdb))

(define %comms-packages
  (list
   nheko qtox gajim gajim-omemo))

(define %multimedia-packages
  (list
   mpv evince nyxt
   zathura zathura-cb zathura-ps zathura-djvu zathura-pdf-mupdf))

(define %network-tools-packages
  (list
   aria2
   transmission transmission-remote-cli
   youtube-dl))

(define %sway-packages
  (list
   wofi foot waybar swaylock swayidle
   wl-clipboard
   redshift-wayland))

(define %emacs-packages
  (list
   emacs-pgtk-native-comp
   emacs-sway emacs-shackle
   emacs-pinentry emacs-password-store
   emacs-xah-fly-keys
   emacs-which-key
   emacs-helpful
   emacs-org
   emacs-org-roam
   emacs-orgit
   emacs-doom-modeline emacs-doom-themes
   emacs-deadgrep
   ;; emacs-treemacs ; testing dired
   emacs-dired-hacks
   emacs-dired-sidebar
   emacs-diredfl
   emacs-dired-rsync
   emacs-dired-git-info
   ;; emacs-all-the-icons-dired ; huge slowdown
   emacs-fish-completion fish
   emacs-adaptive-wrap
   emacs-ggtags
   emacs-geiser ; scheme
   emacs-geiser-guile guile-3.0-latest
   emacs-guix ; broken
   emacs-eshell-bookmark
   emacs-esh-autosuggest
   emacs-eshell-prompt-extras
   emacs-eshell-syntax-highlighting
   emacs-lispy
   emacs-shen-mode emacs-shen-elisp
   emacs-cider ; clojure
   emacs-slime sbcl ; common-lisp
   emacs-nix-mode
   emacs-markdown-mode ;; emacs-polymode-markdown ; build broken
   emacs-magit
   emacs-forge emacs-git-link emacs-github-review
   emacs-git-undo ; unproven to work
   emacs-yasnippet emacs-yasnippet-snippets
   emacs-company
   emacs-selectrum
   emacs-posframe
   emacs-orderless
   emacs-consult
   emacs-embark
   emacs-posframe
   emacs-prescient
   emacs-marginalia
   emacs-ghq
   emacs-git-gutter
   emacs-expand-region
   emacs-multiple-cursors-dev
   emacs-phi-search
   emacs-projectile
   emacs-sx ; stackexchange
   emacs-matrix-client))
