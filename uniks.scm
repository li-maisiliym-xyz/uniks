(define-module (uniks))
(use-modules (oop goops))
(export (<prikriom>
	  <krimyn>))


(define-class <raizyn> ()
  (metaneksis #:init-keyword #:metaneksis)
  (neksis #:init-keyword #:neksis)
  (krimyn #:init-keyword #:krimyn))

(define-class <prikriom> ()
  (ful #:init-keyword #:ful)
  (ssh #:init-keyword #:ssh)
  (keygrip #:init-keyword #:keygrip))

(define-class <krimyn> ()
  (neim #:init-keyword #:neim)
  (spici #:init-keyword #:spici)
  (trost #:init-keyword #:trost)
  (saiz #:init-keyword #:saiz)
  (prikriom ; #:type <prikriom>
   #:init-Keyword #:prikriom))

(define-class <neksis> ()
  (neim #:init-keyword #:neim)
  (spici #:init-keyword #:spici)
  (saiz #:init-keyword #:saiz)
  (prikriom ; #:type <prikriom>
   #:init-Keyword #:prikriom)
  (krimynz #:init-keyword #:krimynz)
  (keygrip #:init-keyword #:keygrip))

