(define-module (uniks utils))
(use-modules (oop goops))
(export remove)

(define-method (remove (list <list>) (unwanted-list <list>))
  (remove
   (lambda (x) (member x unwanted-list)) list))
