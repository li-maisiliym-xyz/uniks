(define-module (uniks)
  #:use-module (oop goops)
  #:export (PriKriom
	    Krimyn))

(define-class PriKriom ()
  (spici #:init-keyword #:spici)
  (valiu #:init-keyword #:valiu))

(define-class Krimyn ()
  (pri-kriomz ; #:type (list-of PriKriom)
   #:init-Keyword #:pri-kriomz))

