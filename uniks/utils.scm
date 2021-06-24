(define-module (uniks utils))
(use-modules (giiks)
             (oop goops)
             (ice-9 format)
             (guix store)
             (guix packages)
             (guix derivations)
             (guix git-download)
             (guix gexp)
	     )
(export ())

(define (newline-strings strings)
  (string-join strings "\n" 'prefix))

(define (shell-set-env env-value-pairs)
  (define (export-env env-value-pair)
    (format #f "export ~a=~a"
	    (car env-value-pair) (car (cdr env-value-pair))))
  (newline-strings (map export-env env-value-pairs)))