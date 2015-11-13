#lang racket
(require rackunit lens "structures.rkt" "simplify.rkt")
(provide check-learned)

;;memory and the raw input string, or the read string -> memory or false
(define (check-learned m r)
  ;(define l (list-of-words* r))
  (define check-lists (match-string-in-lists r (lens-view memory-list1-lens m) (lens-view memory-list2-lens m)))
  (cond
    [check-lists
     (writeln check-lists)
     m]
    [else
     false]))

;;string, list, list -> string from other list, or false
;;two lists of the same length, matches a string to one of the lists, and returns the string in the other list with the same position
(define (match-string-in-lists s l1 l2)
  (define l1-member (member (string-foldcase s) (map string-foldcase l1)))
  (define l2-member (member (string-foldcase s) (map string-foldcase l2)))
  (cond
    [l1-member
     (list-ref l2 (- (length l2) (length l1-member)))]
    [l2-member
     (list-ref l1 (- (length l1) (length l2-member)))]
    [else
     false]))

(module+ test
  (check-equal? (match-string-in-lists "awesome" (list "cheEse" "AweSome" "Sifudhalijd" "adNs" "coLLo") (list "Bean" "K man" "ya" "hmmm" "ooKKK"))
                "K man"))