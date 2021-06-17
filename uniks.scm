(define-module (uniks))
(use-modules (oop goops))
(export (<prikriom> <krimyn>
	 <raizyn> <metaneksys>
	 <neksys>))

(define-class <raizyn> ()
  (metaneksys #:init-keyword #:metaneksys
	      #:getter ->metaneksys
	      #:setter <-metaneksys)
  (neksys #:init-keyword #:neksys
	  #:getter ->neksys
	  #:setter <-neksys)
  (krimyn #:init-keyword #:krimyn
	  #:getter ->krimyn
	  #:setter <-krimyn))

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
  (prikriom #:init-keyword #:prikriom
	    #:getter ->prikriom
	    #:setter <-prikriom))

(define-class <neksys> ()
  (neim #:init-keyword #:neim
	#:getter ->neim
	#:setter <-neim)
  (spici #:init-keyword #:spici
	 #:getter ->spici
	 #:setter <-spici)
  (saiz #:init-keyword #:saiz
	#:getter ->saiz
	#:setter <-saiz)
  (prikriom #:init-keyword #:prikriom
	    #:getter ->prikriom
	    #:setter <-prikriom)
  (krimynz #:init-keyword #:krimynz
	   #:getter ->krimynz
	   #:setter <-krimynz)
  (keygrip #:init-keyword #:keygrip
	   #:getter ->keygrip
	   #:setter <-keygrip))

(define-class <metaneksys> ()
  (neim #:init-keyword #:neim
	#:getter ->neim
	#:setter <-neim)
  (spici #:init-keyword #:spici
	 #:getter ->spici
	 #:setter <-spici)
  (saiz #:init-keyword #:saiz
	#:getter ->saiz
	#:setter <-saiz)
  (prikriom #:init-keyword #:prikriom
	    #:getter ->prikriom
	    #:setter <-prikriom)
  (neksiz #:init-keyword #:neksiz
	  #:getter ->neksiz
	  #:setter <-neksiz))
