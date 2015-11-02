#lang racket
(require rackunit)
(provide simplify-grammar make-sentence)

;;takes a string and removes some contractions and punctuation
;;string->list of strings
(define (simplify-grammar s)
  (map simplify-word (list-of-words s)))

(module+ test
  (check-equal? (simplify-grammar "there's")
                "there is")
  {check-equal? (simplify-grammar "there's a pony down yonder, thank's!")
                "there is a pony down yonder, thank you"})

;;list of list pairs with words to simplify, corrections/simplifications on the right
(define SIMPLIFY-WORD-PAIRS
  (list
   (list "that's" "that is")
   (list "there's" "there is")
   (list "thx" "thank you")
   (list "thank's" "thank you")))

;;tries to simplify any word, takes out contractions, correct spelling or abbreviations
;;string -> string
(define (simplify-word s)
  (simplify-word-helper SIMPLIFY-WORD-PAIRS s))

(module+ test
  (check-equal? (simplify-word "thank's")
        "thank you")
  (check-equal? (simplify-word "that's")
        "that is"))

;;list of pairs, string -> string
(define (simplify-word-helper p s)
  (cond
    [(empty? p) s]
    [(equal? (first (first p)) s)
     (second (first p))]
    [else
     (simplify-word-helper (rest p) s)]))

;;makes a string from a list of strings, with spaces in between
(define (make-sentence l)
  (cond
    [(empty? l)
     (error 'make-sentence "something happened, something happened")]
    [(equal? (length l) 1)
     (first l)]
    [else
     (string-append (first l) " " (make-sentence (rest l)))]))

(module+ test
  (check-equal? (make-sentence (list "there" "is" "a" "pig" "in" "my" "soup"))
                "there is a pig in my soup")
  (check-equal? (make-sentence (list "oliver," "you" "are" "the" "best" "programmer"))
                "oliver, you are the best programmer"))

;;creates a list of all words seperated by spaces in the string, removing punctuation as well
;;string -> listof strings
(define (list-of-words s)
  (list-of-words-helper empty "" s))

(module+ test
  (check-equal? (list-of-words "how many of !them?!")
                (list "how" "many" "of" "them"))
  (check-equal? (list-of-words "yes,")
                (list "yes,"))
  (check-equal? (punctuation? (substring "!adklsf" 0 1))
                true))

;;accumulates the list, incomplete string, and the string yet to be added
;;list, string, string -> list of stings
(define (list-of-words-helper l nw s);;list accumulator, new word accumulator, and string
  (cond
    [(equal? (string-length s) 0)
     (append l (list nw))]
    [(punctuation? (substring s 0 1))
     (list-of-words-helper l nw (substring s 1))]
    [(equal? (substring s 0 1) " ")
     (list-of-words-helper (append l (list nw)) "" (substring s 1))]
    [else
     (list-of-words-helper l (string-append nw (substring s 0 1)) (substring s 1))]))

;;checks if a string is a punctuation mark
;;string -> bool
(define (punctuation? s)
  (ormap (lambda (x) (equal? x s)) (list "." "!" "?")))