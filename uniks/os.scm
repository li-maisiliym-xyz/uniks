(define-module (uniks os))
(use-modules (uniks)
	     (oop goops)
	     (srfi srfi-1)
	     (guix gexp)
	     ((guix store) #:select (%default-substitute-urls))
	     (gnu services)
	     (gnu services base)
	     (gnu services pm)
	     ((gnu services desktop)
	      #:select (%desktop-services) #:prefix guix:)
	     (gnu services shepherd)
	     (gnu services sddm)
	     (gnu services xorg)
	     (gnu services networking)
	     (gnu services sound)
	     (gnu services avahi)
	     ((gnu system file-systems)
              #:select (%elogind-file-systems file-system))
	     (gnu system)
	     (gnu system shadow)
	     (gnu system pam)
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
	     (gnu packages cryptsetup))

(define (remove-services services unwanted-services)
  (remove
   (lambda (service)
     (member (service-kind service) unwanted-services))
   services))

(define %unwanted-guix-desktop-services
  (list avahi-service-type
	gdm-service-type))

(define %modified-guix-desktop-services
  (modify-services
      (remove-services guix:%desktop-services %unwanted-guix-desktop-services)
    (guix-service-type
     config =>
     (guix-configuration
      (inherit config)
      (substitute-urls
       (append
	%default-substitute-urls ; To be removed
	(->substitute-urls metaneksys)))
      (authorized-keys
       (append
	%guix-authorized-keys %default-authorized-guix-keys))
      (extra-options '("--max-jobs=2"))))))

(define %edj-services
  (append
   %modified-guix-desktop-services
   (list
    (service sddm-service-type)
    (service thermald-service-type)
    (service tlp-service-type
             (tlp-configuration
	      (cpu-scaling-governor-on-bat '("powersave"))
              (cpu-scaling-governor-on-ac '("powersave")))))))

(define (remove-members list unwanted-list)
  (remove
   (lambda (x) (member x unwanted-list)) list))

(define-public %uniks-base-packages
  (let*
      ((%unwanted-base-packages
	(list inetutils)))
    (append
     (list iputils mksh dvtm abduco rsync
	   dmidecode htop cpufrequtils
	   fd ripgrep cryptsetup)
     (remove-members %base-packages %unwanted-base-packages))))

(define %edj-packages
  (list (specification->package "nss-certs")
	sway swayidle swaylock brightnessctl
	font-google-material-design-icons
	alsa-utils adb))

(define-public %uniks-setuid-programs
  (let*
      ((%unwanted-setuid-programs
	(list (file-append inetutils "/bin/ping")
	      (file-append inetutils "/bin/ping6"))))
    (append
     (list (file-append iputils "/bin/ping")
	   (file-append swaylock "/bin/swaylock"))
     (remove-members %setuid-programs %unwanted-setuid-programs))))

(define-method (->os (rairyn <raizyn>))
  (let*
      ((neksys (->neksys raizyn))
       (host-name (->neim neksys))
       (kernel-arguments
	(cons "intel_pstate=disable" %default-kernel-arguments))
       (authorized-keys (->authorized-keys neksys krimynz))
       (ssh-service
	(service
	 openssh-service-type
	 (openssh-configuration
	  (openssh openssh-sans-x)
	  (password-authentication? #false)
	  (permit-root-login 'without-password)
	  (authorized-keys authorized-keys))))
       (services (cons* ssh-service %edj-services))
       (packages (append %uniks-base-packages))
       (users
	(append (->os-users krimynz) %base-user-accounts))
       (bootloader (->bootloader neksys))
       (swap-devices (->swap-devices neksys))
       (file-systems (cons* (->file-systems neksys) %base-file-systems)))
    
    (operating-system
      (locale "en_US.utf8")
      (timezone "Asia/Bangkok")
      (kernel-arguments kernel-arguments)
      (keyboard-layout (keyboard-layout "us" "colemak"))
      (host-name host-name)
      (users users)
      (packages packages)
      (services services)
      (setuid-programs %uniks-setuid-programs)
      (bootloader bootloader)
      (swap-devices swap-devices)
      (file-systems file-systems))))
