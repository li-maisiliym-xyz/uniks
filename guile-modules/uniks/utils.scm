(define-module (uniks utils))
(use-modules (oop goops)
	     ((srfi srfi-1) #:select ((remove . srfi-remove))))
(export remove)

(define-method (remove (list <list>) (unwanted-list <list>))
  (srfi-remove
   (lambda (x) (member x unwanted-list)) list))
