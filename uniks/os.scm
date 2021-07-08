(define-module (uniks os))
(use-modules (uniks)
	     (oop goops)
	     (srfi srfi-1)
	     (guix gexp)
	     (gnu services)
	     (gnu services base)
	     (gnu services pm)
	     (gnu services desktop)  
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

(define %unwanted-desktop-services
  (list avahi-service-type
	gdm-service-type))

(define %wanted-desktop-services
  (append
   (list
    (service sddm-service-type)
    (service thermald-service-type)
    (service tlp-service-type
             (tlp-configuration
	      (cpu-scaling-governor-on-bat '("powersave"))
              (cpu-scaling-governor-on-ac '("powersave")))))
   (remove-services %desktop-services %unwanted-desktop-services)))

(define-public %edj-services
  (modify-services
      %wanted-desktop-services
    (guix-service-type
     config =>
     (guix-configuration
      (inherit config)
      (substitute-urls
       (append
	%guix-substitute-urls %default-substitute-urls))
      (authorized-keys
       (append
	%guix-authorized-keys %default-authorized-guix-keys))
      (extra-options '("--max-jobs=2"))))))

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

(define-public %uniks-setuid-programs
  (let*
      ((%unwanted-setuid-programs
	(list (file-append inetutils "/bin/ping")
	      (file-append inetutils "/bin/ping6"))))
    (append
     (list (file-append iputils "/bin/ping")
	   (file-append swaylock "/bin/swaylock"))
     (remove-members %setuid-programs %unwanted-setuid-programs))))

(define ssh-service
  (define authorized-keys
    (->authorized-keys neksys krimynz))
  (service openssh-service-type
	   (openssh-configuration
	    (openssh openssh-sans-x)
	    (password-authentication? #false)
	    (permit-root-login 'without-password)
	    (authorized-keys authorized-keys))))

(define-method (->os (rairyn <raizyn>))
  (operating-system
  (locale "en_US.utf8")
  (timezone "Asia/Bangkok")
  (kernel-arguments (cons "intel_pstate=disable" %default-kernel-arguments))
  (keyboard-layout (keyboard-layout "us" "colemak"))
  (host-name (->neim neksys))
  (users (append (->os-users krimynz)
		 %base-user-accounts))
  (packages
   (append
    %uniks-base-packages
    (list
     (specification->package "nss-certs")
     sway swayidle swaylock brightnessctl
     font-google-material-design-icons
     alsa-utils adb)))
  (services
   (cons* ssh-service %edj-services))
  (setuid-programs %uniks-setuid-programs)
  (bootloader (->bootloader neksys))
  (swap-devices (->swap-devices neksys))
  (file-systems (cons* (->file-systems neksys) %base-file-systems))))
