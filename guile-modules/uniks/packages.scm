iff(define-module (uniks packages)
  #:use-module ((gnu packages ssh) #:select (openssh-sans-x))
  #:re-export (openssh-sans-x))
(use-modules (uniks)
	     (uniks utils)
	     (oop goops)
	     (ice-9 match)
	     (guix gexp)
	     ((gnu system) #:select (%setuid-programs %base-packages))
	     ((gnu packages) #:select (specification->package))
	     (gnu packages glib)
	     (gnu packages admin)
	     (gnu packages networking)  
	     (gnu packages suckless)
	     (gnu packages wm)
	     (gnu packages linux)
	     (gnu packages shells)
	     (gnu packages dvtm)
             (gnu packages abduco)
	     (gnu packages rsync)
             (gnu packages rust-apps)
	     (gnu packages cryptsetup)
	     ((gnu packages ssh) #:select (openssh-sans-x))
	     (gnu packages fonts))
(export ->packages ->setuid-programs user-shell)

(define user-shell (file-append zsh "/bin/zsh"))

(define-method (->packages (spici <string>) (saiz <integer>))
  (let* ((unwanted-base-packages (list inetutils))
	 (base-packages
	  (remove %base-packages unwanted-base-packages))
	 (%kor-packages
	  (append base-packages
		  (list (specification->package "nss-certs")
			mksh rsync cryptsetup)))
	 (sentyr-packages '())
	 (%kor-edj-packages
	  (append %kor-packages
		 (list zsh brightnessctl)))
	 (%min-edj-packages
	  (append %kor-edj-packages
		 (list sway swayidle swaylock alsa-utils )))
	 (%med-edj-packages
	  (append %min-edj-packages
		(list font-google-material-design-icons)))
	 (edj-packages (match saiz
			 (0 %kor-edj-packages)
			 (1 %min-edj-packages)
			 (2 %med-edj-packages)))
	 (haibrid-packages
	  (append sentyr-packages edj-packages)))
    (match spici
      ("sentyr" sentyr-packages)
      ("haibrid" haibrid-packages)
      ("edj" edj-packages))))

(define-method (->setuid-programs (spici <string>) (saiz <integer>))
  (let* ((unwanted-guix-setuid-programs
	  (list (file-append inetutils "/bin/ping")
		(file-append inetutils "/bin/ping6")))
	 (filtered-guix-setuid-programs
	  (remove %setuid-programs
		  unwanted-guix-setuid-programs))
	 (kor-setuid-programs
	  (append filtered-guix-setuid-programs
		  (list (file-append iputils "/bin/ping")
			(file-append swaylock "/bin/swaylock"))))
	 (sentyr-setuid-programs '())
	 (edj-setuid-programs '())
	 (haibrid-setuid-programs
	  (append sentyr-setuid-programs edj-setuid-programs))
	 (spici-setuid-programs
	  (match spici
	    ("sentyr" sentyr-setuid-programs)
	    ("haibrid" haibrid-setuid-programs)
	    ("edj" edj-setuid-programs))))
    (append kor-setuid-programs spici-setuid-programs)))
