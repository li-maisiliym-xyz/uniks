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
	  #:setter <-neksiz)
  (trost #:init-keyword #:trost
	 ;; #:type (alist-of (<neksys-neim> . <trost>))
	 #:getter ->trost
	 #:setter <-trost))

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
  (spici #:init-keyword #:spici
	 ;; #:type <spici>
	 #:getter ->spici
	 #:setter <-spici)
  
  (saiz #:init-keyword #:saiz
	;; #:type <saiz>
	#:getter ->saiz
	#:setter <-saiz)
  (prikriomz #:init-keyword #:prikriomz
	     ;; #:type (alist-of (<prineksys-neim> . <prikriom>))
	     #:getter ->prikriomz
	     #:setter <-prikriomz))

(define-class <prineksys> ()
  (spici #:init-keyword #:spici
	 ;; #:type <spici>
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

(define-class <neksys> ()
  (trost #:init-keyword #:trost
	 ;; #:type (alist-of (<=prineksys-neim> . <trost>))
	 #:getter ->trost
	 #:setter <-trost)
  (prineksiz #:init-keyword #:prineksiz
	     #:getter ->prineksiz
	     #:setter <-prineksiz)
  (krimynz #:init-keyword #:krimynz
	   #:getter ->krimynz
	   #:setter <-krimynz))

(define-method (->neim (krimyn <krimyn>)
		       (neksys <neksys>))
  (let*
      ((krimynz (->krimynz neksys))
       (prikriomz (->prikriomz krimyn))
       (same-prikriomz?
	(lambda (neim-krimyn-pair)
	  (let* ((compared-krimyn (cdr neim-krimyn-pair))
		 (compared-prikriomz (->prikriomz compared-krimyn)))
	    (equal? (->prikriomz neim-krimyn-pair) prikriomz))))
       (neim-value (filter same-prikriomz? krimynz)))
    (car neim-value)))

(define-method (->neim (krimyn <krimyn>)
		       (orydjin <orydjin>)
		       (kriyraizyn <kriyraizyn>))
  (let*
      ((neksys-neim (->neksys-neim orydjin))
       (neksys (assq-ref kriyraizyn neksys-neim)))
    (->neim krimyn neksys)))

(define-method (->neim (prineksys <prineksys>)
		       (neksys <neksys>))
  (let*
      ((prineksiz (->prineksiz prineksys))
       (prikriom (->prikriom prineksys))
       (same-prikriom?
	(lambda (neim-prineksys-pair)
	  (let* ((compared-prineksys (cdr neim-prineksys-pair))
		 (compared-prikriom (->prikriom compared-prineksys)))
	    (equal? (->prikriom neim-prineksys-pair) prikriom))))
       (neim-value (filter same-prikriom? prineksiz)))
    (car neim-value)))

(define-method (->neim (prineksys <prineksys>)
		       (orydjin <orydjin>)
		       (kriyraizyn <kriyraizyn>))
  (let*
      ((neksys-neim (->neksys-neim orydjin))
       (neksys (assq-ref kriyraizyn neksys-neim)))
    (->neim prineksys neksys)))
