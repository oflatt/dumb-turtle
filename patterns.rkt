#lang racket
(require rackunit racket/match lens "structures.rkt" "simplify.rkt" "variables.rkt")
(provide read-pattern)

;; same-as : string -> (any -> boolean)
(define (same-as str)
  (lambda (x)
    (and (string? x)
         (string-ci=? x str))))

(define (same-as-list l)
  (lambda (x)
    (and (string? x)
         (ormap
          (lambda (s)
            (string-ci=? s x))
          l))))

;;memory and the raw input string, or the read string -> memory or false
(define (read-pattern m r)
  (define l (list-of-words* r))
  (match l
    [(list (? (same-as "if")) (? (same-as "i")) (? (same-as "say")) i ..1 (? (same-as "say")) o ..1)
     (writeln "OK")
     (learn m i o)]
    [(list (? (same-as-list (list "say" "store"))) o ..1 (? (same-as "for")) i ..1)
     (writeln "OK")
     (learn m i o)]
    [else
     false]))

;;memory, string, string -> memory
(define (learn m i o)
  (lens-transform
   memory-long-learned-list1-lens
   (lens-transform
    memory-long-learned-list2-lens
    m
    (lambda (list2)
      (cons (make-sentence o) list2)))
   (lambda (list1)
     (cons (make-sentence i) list1))))
  
(module+ test
  (check-equal? (read-pattern DEFAULT-STATE "If I SaY ThaNk's! bru saY tHat's ur totally welcome")
                (memory
                 (short-memory
                  "none"
                  "none")
                 (experience
                  (profile "unknown" "unknown" empty)
                  empty
                  (learned (list "ThaNk's! bru") (list "tHat's ur totally welcome"))))))