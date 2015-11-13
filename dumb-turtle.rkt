#lang racket
(require readline "structures.rkt" "synonyms.rkt" "simplify.rkt" "patterns.rkt" "variables.rkt" "check-learned.rkt")

(define (start)
  (read-one
   DEFAULT-STATE))

;; Takes the input and gives an answer
;;e is an experience
(define (read-one m)
  (define r (read-line))
  (define learned (check-learned m r))
  (define p (read-pattern m r))
  (define s-list (simplify-grammar r));;list preserves case unless there is a contraction
  (define s (string-foldcase (make-sentence s-list)));;makes it all lowercase
  (cond
    [learned
     (read-one learned)]
    [p
     (read-one p)]
    [(synonyms? "hello" s)
     (writeln "howdy")
     (read-one m)]
    [(synonyms? "thank you" s)
     (writeln "no problem");;later make UDC
     (read-one m)]
    [(synonyms? "current-state" s)
     (println m)
     (read-one m)]
    [(ormap (lambda (x) (> (string-length x) 10)) s-list)
     (writeln "nice gibberish you got there.")
     (read-one m)]
    [else
     (writeln "idk");;make the UDC
     (read-one m)]))

(start)