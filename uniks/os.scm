(define-module (uniks os))
(use-modules (raizyn)
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

