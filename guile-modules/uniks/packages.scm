(define-module (uniks packages))
(use-modules (uniks)
	     (oop goops)
	     (srfi srfi-1)
	     (guix gexp)
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
	     (gnu packages ssh)
	     #:re-export (openssh-sans-x))
(export ->packages ->setuid-programs user-shell)

(define user-shell (file-append zsh "/bin/zsh"))

(define-method (->packages (spici <string>) (saiz <integer>))
  (let* ((%unwanted-guix-packages (list inetutils))
	 (%kor-packages
	  (list (specification->package "nss-certs")
		mksh rsync cryptsetup))
	 (sentyr-packages '())
	 (%kor-edj-packages
	  (append %kor-edj-packages
		 (list brightnessctl)))
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
	  (remove filtered-guix-setuid-programs
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
