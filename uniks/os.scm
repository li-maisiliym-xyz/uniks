(define-module (uniks os))
(use-modules (uniks)
	     (uniks utils)
	     (uniks packages)
	     (oop goops)
	     (ice-9 match)
	     ;; (srfi srfi-1)
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

(define-class <os-config> ()
  (hostname #:init-keyword #:hostname
	    #:getter ->hostname
	    #:setter <-hostname)
  (users-config #:init-keyword #:users-config
		#:getter ->user-configz
		#:setter <-users-config)
  )

(define-method (->user-account (krimyn <krimyn>))
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

(define-method (->users (krimynz <list>))
  (map ->user-account krimynz))

(define-class <ssh-user> ()
  (user #:init-keyword #:user
	#:getter ->user
	#:setter <-user)
  (sshz #:init-keyword #:sshz
	#:getter ->sshz
	#:setter <-sshz))

(define-method (->ssh-user
		(prineksys-neim <string>) (krimyn <krimyn>))
  (let*
      ((prikriomz (->prikriomz krimyn))
       (exprineksiz-prikriomz (assoc-remove! prikriomz prineksys-neim))
       (user (->neim krimyn))
       (sshz (map ->ssh exprineksiz-prikriomz))
       (result (make <ssh-user>
		 #:user user
		 #:sshz sshz)))
    result))

(define-method (->ssh-users
		(prineksys-neim <string>) (krimynz <list>))
  (let*
      ((->ssh-user*
	(lambda (krimyn)
	  (->ssh-user prineksys-neim krimyn)))
       (result (map ->ssh-user* krimynz)))
    result))

(define-method (->ssh-authorized-keys (ssh-user <ssh-user>))
  (let* ((username (->username ssh-user))
	 (file-name (string-append username ".pub"))
	 (sshz-string (newline-strings sshz))
	 (sshz-file
	  (plain-file file-name sshz-string))
	 (result (list username plain-file)))
    result))

(define-method (->ssh-authorized-keys (ssh-users <list>))
  (let* ((result (map ->ssh-authorized-keys ssh-users)))
    result))

(define-method (->ssh-authorized-keys (prineksys-neim <string>)
				      (krimynz <list>))
  (let* ((ssh-users (->ssh-users prineksys-neim krimynz))
	 (result (->ssh-authorized-keys ssh-users)))
    result))

(define-method (->substitute-urls (neksys <neksys>))
  (let* ((var #f))
    '()))

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
    (password-authentication? #f)
    (permit-root-login 'prohibit-password)
    (authorized-keys authorized-keys))))

(define-method (->services (os-config <os-config>))
  (let*
      ((stock-services (->services spici saiz))
       (substitute-urls
	(append %default-substitute-urls neksys-substitute-urls))
       (guix-authorized-keys
	(append %default-authorized-guix-keys neksys-guix-keys))
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

(define-method (->kernel-arguments (os-config <os-config>))
  (cons "intel_pstate=disable" %default-kernel-arguments))

(define-method (->os (os-config <os-config>))
  (let*
      ((disks (->disks os-config)))
    (operating-system
      (locale "en_US.utf8")
      (timezone "Asia/Bangkok")
      (kernel-arguments (->kernel-arguments os-config))
      (keyboard-layout (keyboard-layout "us" "colemak"))
      (host-name (->hostname os-config))
      (users (->users users-config))
      (packages (->packages os-config))
      (services (->services os-config))
      (setuid-programs (->setuid-programs os-config))
      (bootloader (->bootloader os-config))
      (swap-devices (->swap-devices disks))
      (file-systems (->file-systems disks)))))

(define-method (->user-config prineksys-trost neim.krimyn)
  (let*
      ((neim (car neim.krimyn))
       (krimyn (cdr neim.krimyn))
       (trost (assoc prineksys-trost neim))
       (authorized-keys )
       )
    (make <user-config>
      #:name neim
      #:spici (->spici krimyn)
      #:saiz (->saiz krimyn)
      #:trost trost
      #:authorized-keys authorized-keys)))

(define-method (->disks))
(define-method (->guix-config))
(define-method (->network-config))

(define-method (->os-config (kriyraizyn <kriyraizyn>) )
  (let*
      ((orydjin (->orydjin kriyraizyn))
       (prineksys (->prineksys kriyraizyn orydjin))
       (prineksys-trost (->trost prineksys))
       (krimynz (->krimynz kriyraizyn))
       (user-configz
	(map (->user-config prineksys-trost) krimynz)))
    (make <os-config>
      #:spici (->spici prineksys)
      #:saiz (->saiz prineksys)
      #:hostname (->prineksys-neim orydjin)
      #:users-config (->user-configz krimynz)
      #:disks (->disks os-config)
      #:guix-config (->guix-config kriyraizyn)
      #:network-config (->network-config kriyraizyn))))
