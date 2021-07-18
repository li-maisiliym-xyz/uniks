(define-module (uniks))
(use-modules (oop goops))
(export <prikriom> <krimyn> <orydjin>
	<kriyraizyn> <neksys> <prineksys>
	->prikriom)

(define-class <kriyraizyn> ()
  (orydjin #:init-keyword #:orydjin
	   ;; #:type <orydjin>
	   #:getter ->orydjin
	   #:setter <-orydjin)
  (neksiz #:init-keyword #:neksiz
	  ;; #:type (alist-of (<neksys-neim> . <neksiz>))
	  #:getter ->neksiz
	  #:setter <-neksiz))

(define-class <orydjin> ()
  (neksys-neim #:init-keyword #:neksys-neim
	       ;; #:type <neksys-neim>
	       #:getter ->neksys-neim
	       #:setter <-neksys-neim
	       #:init-value #f)
  (prineksys-neim #:init-keyword #:prineksys-neim
		  ;; #:type <prineksys-neim>
		  #:getter ->prineksys-neim
		  #:setter <-prineksys-neim
		  #:init-value #f)
  (krimyn-neim #:init-keyword #:krimyn-neim
	       ;; #:type <krimyn-neim>
	       #:getter ->krimyn-neim
	       #:setter <-krimyn-neim
	       #:init-value #f))

(define-class <prikriom> ()
  (pidjipi #:init-keyword #:pidjipi
	   ;; #:type <orydjin>
	   #:getter ->pidjipi
	   #:setter <-pidjipi)
  (ssh #:init-keyword #:ssh
       ;; #:type <orydjin>
       #:getter ->ssh
       #:setter <-ssh)
  (keygrip #:init-keyword #:keygrip
	   ;; #:type <orydjin>
	   #:getter ->keygrip
	   #:setter <-keygrip))

(define-class <krimyn> ()
  (neim #:init-keyword #:neim
	;; #:type <neim>
	#:getter ->neim
	#:setter <-neim)
  (spici #:init-keyword #:spici
	 ;; #:type <spici>
	 #:getter ->spici
	 #:setter <-spici)
  (trost #:init-keyword #:trost
	 ;; #:type <trost>
	 #:getter ->trost
	 #:setter <-trost)
  (saiz #:init-keyword #:saiz
	;; #:type <saiz>
	#:getter ->saiz
	#:setter <-saiz)
  (prikriomz #:init-keyword #:prikriomz
	     ;; #:type (alist-of (<prineksys-neim> . <prikriom>))
	     #:getter ->prikriomz
	     #:setter <-prikriomz))

(define-class <prineksys> ()
  (neim #:init-keyword #:neim
	;; #:type <neim>
	#:getter ->neim
	#:setter <-neim)
  (spici #:init-keyword #:spici
	 ;; #:type <spici>
	 #:getter ->spici
	 #:setter <-spici)
  (trost #:init-keyword #:trost
	 ;; #:type <trost>
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

(define-class <neksys> ()
  (neim #:init-keyword #:neim
	#:getter ->neim
	#:setter <-neim)
  (trost #:init-keyword #:trost
	 #:getter ->trost
	 #:setter <-trost)
  (prineksiz #:init-keyword #:prineksiz
	     #:getter ->prineksiz
	     #:setter <-prineksiz)
  (krimynz #:init-keyword #:krimynz
	   #:getter ->krimynz
	   #:setter <-krimynz))

(define-method (->prikriom (krimyn <krimyn>)
			   (prineksys <prineksys>))
  (let*
      ((prikriomz (->prikriomz krimyn))
       (prineksys-neim (->neim prineksys)))
    (assq-ref prikriomz prineksys-neim)))
