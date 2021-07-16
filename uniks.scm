(define-module (uniks))
(use-modules (oop goops))
(export <prikriom> <krimyn>
	<raizyn> <neksys> <prineksys>
	->substitute-urls ->prikriom
	->os-user ->os-users ->authorized-keys)

(define-class <raizyn> ()
  (neksiz #:init-keyword #:neksiz
	  #:getter ->neksiz
	  #:setter <-neksiz)
  (neksys #:init-keyword #:neksys
	  #:getter ->neksys
	  #:setter <-neksys)
  (prineksiz #:init-keyword #:prineksiz
	     #:getter ->prineksiz
	     #:setter <-prineksiz)
  (prineksys #:init-keyword #:prineksys
	     #:getter ->prineksys
	     #:setter <-prineksys)
  (krimynz #:init-keyword #:krimynz
	   #:getter ->krimynz
	   #:setter <-krimynz)
  (krimyn #:init-keyword #:krimyn
	  #:getter ->krimyn
	  #:setter <-krimyn))

(define-class <prikriom> ()
  (pidjipi #:init-keyword #:pidjipi
	   #:getter ->pidjipi
	   #:setter <-pidjipi)
  (ssh #:init-keyword #:ssh
       #:getter ->ssh
       #:setter <-ssh)
  (keygrip #:init-keyword #:keygrip
	   #:getter ->keygrip
	   #:setter <-keygrip))

(define-class <krimyn> ()
  (neim #:init-keyword #:neim
	#:getter ->neim
	#:setter <-neim)
  (spici #:init-keyword #:spici
	 #:getter ->spici
	 #:setter <-spici)
  (trost #:init-keyword #:trost
	 #:getter ->trost
	 #:setter <-trost)
  (saiz #:init-keyword #:saiz
	#:getter ->saiz
	#:setter <-saiz)
  (prikriomz #:init-keyword #:prikriomz
	     ;; #:type (alist-of (<prineksys-neim> . <prikriom)>)
	     #:getter ->prikriomz
	     #:setter <-prikriomz))

(define-class <prineksys> ()
  (neim #:init-keyword #:neim
	#:getter ->neim
	#:setter <-neim)
  (spici #:init-keyword #:spici
	 #:getter ->spici
	 #:setter <-spici)
  (trost #:init-keyword #:trost
	 #:getter ->trost
	 #:setter <-trost)
  (saiz #:init-keyword #:saiz
	#:getter ->saiz
	#:setter <-saiz)
  (prikriom #:init-keyword #:prikriom
	    #:getter ->prikriom
	    #:setter <-prikriom))

(define-class <neksys> ()
  (neim #:init-keyword #:neim
	#:getter ->neim
	#:setter <-neim)
  (trost #:init-keyword #:trost
	 #:getter ->trost
	 #:setter <-trost) )

(define-method (->prikriom (krimyn <krimyn>)
			   (prineksys <prineksys>))
  (let*
      ((prikriomz (->prikriomz krimyn))
       (prineksys-neim (->neim prineksys)))
    (assq-ref prikriomz prineksys-neim)))
