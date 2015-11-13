#lang racket
(require "structures.rkt")
(provide synonyms?)

;;A list of "synonym" words and phrases
(define SYNONYMS
  (list
   (synonym "hello" (list "hey" "howdy" "greetings"))
   (synonym "thank you" (list "you are the best" "cool" "awesome" "awesome" "that is awesome" "that is cool" "thx"))))

;;the synonym name and the input
;;string, string -> boolean
(define (synonyms? n i)
  (define s (find-synonyms n SYNONYMS))
  (cond
    [s
     (this-synonym? s i)]
    [else
     (equal? n i)]))

;;bool or synonym, and a string -> boolean
(define (this-synonym? s i)
  (cond
    [(equal? (synonym-name s) i)
     true]
    [else
     (list-contains? (synonym-list s) i)]))

;;list and any-> boolean
(define (list-contains? l a)
  (cond
    [(empty? l)
     false]
    [(equal? a (first l))
     true]
    [else
     (list-contains? (rest l) a)]))

;;finds the synonym set from l
;;string, list of synonyms->synonym
(define (find-synonyms s l)
  (cond
    [(empty? l)
     false];(error 'synonyms? (string-append s " is not in synonym database"))] this is if I want everything to be in the database
    [(equal? s (synonym-name (first l)))
     (first l)]
    [else
     (find-synonyms s (rest l))]))