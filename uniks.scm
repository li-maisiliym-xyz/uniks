(define-module (uniks))
(use-modules (oop goops))
(export <prikriom> <krimyn>
	<raizyn> <metaneksys> <neksys>
	->substitute-urls ->prikriom
	->os-user ->os-users ->authorized-keys)

(define-class <raizyn> ()
  (metaneksiz #:init-keyword #:metaneksiz
	      #:getter ->metaneksiz
	      #:setter <-metaneksiz)
  (metaneksys #:init-keyword #:metaneksys
	      #:getter ->metaneksys
	      #:setter <-metaneksys)
  (neksys #:init-keyword #:neksys
	  #:getter ->neksys
	  #:setter <-neksys)
  (krimyn #:init-keyword #:krimyn
	  #:getter ->krimyn
	  #:setter <-krimyn)
  (neksiz #:init-keyword #:neksiz
	  #:getter ->neksiz
	  #:setter <-neksiz)
  (krimynz #:init-keyword #:krimynz
	   #:getter ->krimynz
	   #:setter <-krimynz))

(define-class <prikriom> ()
  (ful #:init-keyword #:ful
       #:getter ->ful
       #:setter <-ful)
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
	     ;; #:type (alist-of (<neksys-neim> . <prikriom)>)
	     #:getter ->prikriomz
	     #:setter <-prikriomz))

(define-class <neksys> ()
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

(define-class <metaneksys> ()
  (neim #:init-keyword #:neim
	#:getter ->neim
	#:setter <-neim)
  (trost #:init-keyword #:trost
	 #:getter ->trost
	 #:setter <-trost) )

(define-method (->prikriom (krimyn <krimyn>)
			   (neksys <neksys>))
  (let*
      ((prikriomz (->prikriomz krimyn))
       (neksys-neim (->neim neksys)))
    (assq-ref prikriomz neksys-neim)))
