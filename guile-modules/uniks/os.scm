(define-module (uniks os))
(use-modules (uniks utils)
	     (uniks packages)
	     (giiks formats)
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
	     (gnu bootloader)
	     (gnu bootloader grub)
	     ((gnu system file-systems)
	      #:select (%base-file-systems file-system))
	     (gnu system)
	     (gnu system keyboard)
	     (gnu system accounts)
	     (gnu system pam))
(export <os-config> <user-config> ->os)

(define-class <os-config> ()
  (name #:init-keyword #:name #:getter ->name #:setter name!)
  (domain #:init-keyword #:domain #:getter ->domain #:setter domain!)
  (spici #:init-keyword #:spici #:getter ->spici #:setter spici!)
  (saiz #:init-keyword #:saiz #:getter ->saiz #:setter saiz!)
  (user-configs #:init-keyword #:user-configs #:getter ->user-configs #:setter user-configs!)
  (substitute-urls #:init-keyword #:substitute-urls #:getter ->substitute-urls #:setter substitute-urls!)
  (disks #:init-keyword #:disks #:getter ->disks #:setter disks!)
  (arch #:init-keyword #:arch #:getter ->arch #:setter arch!)
  (swap-disks #:init-keyword #:swap-disks #:getter ->swap-disks #:setter swap-disks!)
  (guix-authorized-keys #:init-keyword #:guix-authorized-keys #:getter ->guix-authorized-keys #:setter !guix-authorized-keys!))

(define-class <user-config> ()
  (name #:init-keyword #:name #:getter ->name #:setter name!)
  (spici #:init-keyword #:spici #:getter ->spici #:setter spici!)
  (akses #:init-keyword #:akses #:getter ->akses #:setter akses!)
  (saiz #:init-keyword #:saiz #:getter ->saiz #:setter saiz!)
  (sshz #:init-keyword #:sshz #:getter ->sshz #:setter sshz!)
  (pgp #:init-keyword #:pgp #:getter ->pgp #:setter pgp!)
  (keygrip #:init-keyword #:keygrip #:getter ->keygrip #:setter keygrip!)
  (github #:init-keyword #:github #:getter ->github #:setter github!))

(define-method (->user-account (user-config <user-config>))
  (let* ((name (->name user-config))
	 (akses (->akses user-config))
	 (kor-groups (list "video"))
	 (min-groups (append kor-groups '()))
	 (med-groups (append (list "netdev" "audio")))
	 (max-groups (append med-groups (list "wheel")))
	 (supplementary-groups
	  (match akses
	    (3 max-groups)
	    (2 med-groups)
	    (1 min-groups)
	    (0 kor-groups)))
	 (home-directory (string-append "/home/" name))
	 (shell user-shell))
    (user-account
     (name name)
     (group "users")
     (home-directory home-directory)
     (shell shell)
     (supplementary-groups supplementary-groups))))

(define-method (->users (user-configs <list>))
  (map ->user-account user-configs))

(define-method (->ssh-authorized-keys (user <user-config>))
  (let* ((username (->name user))
	 (sshz (->sshz user))
	 (file-name (string-append username ".pub"))
	 (sshz-string (newline-strings sshz))
	 (sshz-file
	  (plain-file file-name sshz-string)))
    (list username plain-file)))

(define-method (->ssh-authorized-keys (user-configs <list>))
  (let*
      ((result (map ->ssh-authorized-keys user-configs)))
    result))

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
       (sentyr-services %base-services)
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

(define-method (->services (os-config <os-config>)
			   (spici <string>) (saiz <integer>)
			   (user-configs <list>))
  (let*
      ((stock-services (->services spici saiz))
       (substitute-urls
	(append %default-substitute-urls (->substitute-urls os-config)))
       (guix-authorized-keys
	(append %default-authorized-guix-keys (->guix-authorized-keys os-config)))
	(ssh-authorized-keys (->ssh-authorized-keys user-configs))
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
  (let
      ((arch-arguments
	(match (->arch os-config)
	  ("intel" '("intel_pstate=disable"))
	  (_ '()))))
    (append arch-arguments  %default-kernel-arguments)))

(define-method (->file-systems (os-config <os-config>))
  (let ((disks (->disks os-config)))
    (append disks %base-file-systems)))

(define-method (->keyboard-layout (os-config <os-config>))
  (keyboard-layout "us" "colemak"))

(define-method (->os (os-config <os-config>))
  (let*
      ((spici (->spici os-config))
       (saiz (->saiz os-config))
       (user-configs (->user-configs os-config))
       (locale "en_US.utf8")
       (timezone "Asia/Bangkok")
       (keyboard-layout (->keyboard-layout os-config))
       (bootloader
	(bootloader-configuration
	 (bootloader grub-efi-bootloader)
	 (target "/boot/efi")
	 (keyboard-layout keyboard-layout))))
    
    (operating-system
     (locale locale)
     (timezone timezone)
     (kernel-arguments (->kernel-arguments os-config))
     (keyboard-layout keyboard-layout)
     (host-name (->name os-config))
     (users (->users user-configs))
     (packages (->packages spici saiz))
     (services (->services os-config spici saiz user-configs))
     (setuid-programs (->setuid-programs spici saiz))
     (bootloader bootloader)
     (swap-devices (->swap-disks os-config))
     (file-systems (->file-systems os-config)))))
