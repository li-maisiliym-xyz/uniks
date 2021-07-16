(define-module (uniks os))
(use-modules (uniks)
	     (uniks utils)
	     (uniks packages)
	     (oop goops)
	     (ice-9 match)
	     (srfi srfi-1)
	     (guix gexp)
	     ((guix store) #:select (%default-substitute-urls))
	     (gnu services)
	     (gnu services base)
	     (gnu services ssh)
	     (gnu services pm)
	     ((gnu services desktop) #:select (%desktop-services))
	     (gnu services shepherd)
	     (gnu services sddm)
	     (gnu services xorg)
	     (gnu services networking)
	     (gnu services sound)
	     (gnu services avahi)
	     ((gnu system file-systems) #:select (%elogind-file-systems file-system))
	     (gnu system)
	     (gnu system accounts)
	     (gnu system pam))

(define-method (->os-user (krimyn <krimyn>))
  (let* ((name (->neim krimyn))
	 (trost (->trost krimyn))
	 (kor-groups (list "video"))
	 (min-groups (append kor-groups '()))
	 (med-groups (append (list "netdev" "audio")))
	 (max-groups (append med-groups (list "wheel")))
	 (supplementary-group
	  (match trost
	    (3 max-groups)
	    (2 med-groups)
	    (1 min-groups)
	    (0 kor-groups)))
	 (home-directory (append "/home/" name))
	 (shell (file-append zsh "/bin/zsh")))
    (user-account
     (name name)
     (group "users")
     (home-directory home-directory)
     (shell shell)
     (supplementary-groups supplementary-groups))))

(define-method (->os-users (krimynz <list>))
  (map ->os-user krimynz))

(define-method (->authorized-keys (neksys <neksys>) (krimynz <list>))
  (let* ()
    ()))

(define-method (->substitute-urls (metaneksys <metaneksys>))
  (let* ()
    ()))

(define-method (->services (spici <string>) (saiz <integer>))
  (let*
      ((kor-services
	(list
	 (service thermald-service-type)
	 (service tlp-service-type
		  (tlp-configuration
		   (cpu-scaling-governor-on-bat '("powersave"))
		   (cpu-scaling-governor-on-ac '("powersave"))))))
       (unwanted-services
	(list avahi-service-type gdm-service-type))
       (sentyr-services '())
       (edj-services
	(append %desktop-services
		(list (service sddm-service-type))))
       (haibrid-services (append sentyr-services edj-services))
       (unfiltered-spici-services
	(match spici
	  ("sentyr" sentyr-services)
	  ("haibrid" haibrid-services)
	  ("edj" edj-services)))
       (spici-services (remove unfiltered-spici-services unwanted-services)))
    (append kor-services spici-services)))

(define-method (->ssh-service (authorized-keys <list>))
  (service
   openssh-service-type
   (openssh-configuration
    (openssh openssh-sans-x)
    (password-authentication? #false)
    (permit-root-login 'prohibit-password)
    (authorized-keys ssh-authorized-keys))))

(define-method (->services (spici <string>) (saiz <integer>)
			   (metaneksys-substitute-urls <list>)
			   (metaneksys-guix-keys <list>)
			   (ssh-authorized-keys <list>))
  (let*
      ((stock-services (->services spici saiz))
       (substitute-urls (append %default-substitute-urls metaneksys-substitute-urls))
       (guix-authorized-keys (append %default-authorized-guix-keys metaneksys-guix-keys))
       (ssh-service (->ssh-service ssh-authorized-keys))
       (base-services (list ssh-service))
       (modified-stock-services (modify-services stock-services
				(guix-service-type
				 config =>
				 (guix-configuration
				  (inherit config)
				  (substitute-urls substitute-urls)
				  (authorized-keys guix-authorized-keys))))))
    (append base-services modified-stock-services)))

(define-method (->kernel-arguments (neksys <neksys>))
  (cons "intel_pstate=disable" %default-kernel-arguments))

(define-method (->os (raizyn <raizyn>))
  (let*
      ((neksys (->neksys raizyn))
       (neksys-spici (->spici <string>))
       (neksys-saiz (->saiz <string>))
       (krimynz (->krimynz raizyn))
       (host-name (->neim neksys))
       (kernel-arguments (->kernel-arguments neksys))
       (authorized-keys (->authorized-keys neksys krimynz))
       (metaneksys-substitute-urls (->substitute-urls metaneksys))
       (metaneksys-guix-keys (->guix-keys metaneksys))
       (ssh-authorized-keys (->authorized-keys neksys krimynz))
       (services (->services neksys-spici neksys-saiz
			     metaneksys-substitute-urls
			     metaneksys-guix-keys
			     ssh-authorized-keys ))
       (packages (->packages neksys-spici neksys-saiz))
       (users
	(append (->os-users krimynz) %base-user-accounts))
       (setuid-programs (->setuid-programs neksys-spici neksys-saiz))
       (bootloader (->bootloader neksys))
       (swap-devices (->swap-devices neksys))
       (file-systems (append (->file-systems neksys) %base-file-systems)))

    (operating-system
      (locale "en_US.utf8")
      (timezone "Asia/Bangkok")
      (kernel-arguments kernel-arguments)
      (keyboard-layout (keyboard-layout "us" "colemak"))
      (host-name host-name)
      (users users)
      (packages packages)
      (services services)
      (setuid-programs setuid-programs)
      (bootloader bootloader)
      (swap-devices swap-devices)
      (file-systems file-systems))))
