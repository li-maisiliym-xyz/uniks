(define-module (uniks))
(use-modules (oop goops))
(export <prikriom> <krimyn> <orydjin>
	<kriyraizyn> <neksys> <prineksys>
	->prikriom)

(define-class <trost> ()
  (self #:init-keyword #:self
	;; #:type <u2>
	#:getter ->self
	#:setter <-self)
  (sobtrosts #:init-keyword #:sobtrosts
	     ;; #:type (alist-of (<neksys-neim> . <sobtrosts>))
	     #:getter ->sobtrosts
	     #:setter <-sobtrosts))

(define-class <kriyraizyn> ()
  (orydjin #:init-keyword #:orydjin
	   ;; #:type <orydjin>
	   #:getter ->orydjin
	   #:setter <-orydjin)
  (neksiz #:init-keyword #:neksiz
	  ;; #:type (list-of <neksiz>)
	  #:getter ->neksiz
	  #:setter <-neksiz))

(define-class <orydjin> ()
  (neksys #:init-keyword #:neksys
	  ;; #:type <neksys>
	  #:getter ->neksys
	  #:setter <-neksys
	  #:init-value #f)
  (prineksys #:init-keyword #:prineksys
	     ;; #:type <prineksys>
	     #:getter ->prineksys
	     #:setter <-prineksys
	     #:init-value #f)
  (krimyn #:init-keyword #:krimyn
	  ;; #:type <krimyn>
	  #:getter ->krimyn
	  #:setter <-krimyn
	  #:init-value #f))

(define-class <prikriom> ()
  (pidjipi #:init-keyword #:pidjipi
	   ;; #:type <pidjipi>
	   #:getter ->pidjipi
	   #:setter <-pidjipi)
  (ssh #:init-keyword #:ssh
       ;; #:type <ssh>
       #:getter ->ssh
       #:setter <-ssh)
  (keygrip #:init-keyword #:keygrip
	   ;; #:type <keygrip>
	   #:getter ->keygrip
	   #:setter <-keygrip))

(define-class <krimyn> ()
  (neim #:init-keyword #:neim
	;; #:type <neim>
	#:getter ->neim
	#:setter <-neim)
  (spici #:init-keyword #:spici
	 ;; #:type <krimyn-spici>
	 #:getter ->spici
	 #:setter <-spici)
  (saiz #:init-keyword #:saiz
	;; #:type <saiz>
	#:getter ->saiz
	#:setter <-saiz)
  (prikriomz #:init-keyword #:prikriomz
	     ;; #:type (list-of (<prineksys-neim> . <prikriom>))
	     #:getter ->prikriomz
	     #:setter <-prikriomz))


(define-class <neksys> ()
  (neim #:init-keyword #:neim
	;; #:type <neim>
	#:getter ->neim
	#:setter <-neim)
  (trost #:init-keyword #:trost
	 ;; #:type <trost>
	 #:getter ->trost
	 #:setter <-trost)
  (sobneksys #:init-keyword #:sobneksys
	     #:getter ->sobneksys
	     #:setter <-sobneksys))

(define-class <sobneksys> ()
  (prineksiz #:init-keyword #:prineksiz
	     ;; #:type (list-of <prineksys>)
	     #:getter ->prineksiz
	     #:setter <-prineksiz)
  (krimynz #:init-keyword #:krimynz
	   ;; #:type (list-of <krimyn>)
	   #:getter ->krimynz
	   #:setter <-krimynz))

(define-class <prineksys> ()
  (neim #:init-keyword #:neim
	;; #:type <neim>
	#:getter ->neim
	#:setter <-neim)
  (trost #:init-keyword #:trost
	 ;; #:type <trost>
	 #:getter ->trost
	 #:setter <-trost)
  (sobprineksys #:init-keyword #:sobprineksys
	 ;; #:type <sobprineksys>
	 #:getter ->sobprineksys
	 #:setter <-sobprineksys)))

(define-class <sobprineksys> ()
  (spici #:init-keyword #:spici
	 ;; #:type <prineksys-spici>
	 #:getter ->spici
	 #:setter <-spici)
  (trost #:init-keyword #:trost
	 ;; #:type (alist-of (krimyn-neim . <trost>))
	 #:getter ->trost
	 #:setter <-trost)
  (saiz #:init-keyword #:saiz
	;; #:type <saiz>
	#:getter ->saiz
	#:setter <-saiz)
  (prikriom #:init-keyword #:prikriom
	    ;; #:type <prikriom>
	    #:getter ->prikriom
	    #:setter <-prikriom))
