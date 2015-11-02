#lang racket
(require readline "structures.rkt" "synonyms.rkt" "simplify.rkt")

(define (start)
  (read-one
   (experience
    (profile "unknown" "unknown" empty)
    empty
    (learned empty empty))))

;; Takes the input and gives an answer
;;e is an experience
(define (read-one e)
  (define s-list (simplify-grammar (string-foldcase (read-line))))
  (define s (make-sentence s-list))
  (cond
    [(synonyms? "hello" s)
     (writeln "howdy")
     (read-one e)]
    [(synonyms? "thank you" s)
     (writeln "no problem")
     (read-one e)]
    [else
     (read-one (read-pattern s-list))]))

(start)