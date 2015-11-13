#lang racket
(require lens)
(provide (all-defined-out))

(struct/lens synonym (name list));;string and list of strings

;;string for name and location, and favorites will be a special learned for things that are their favorite
(struct/lens profile (name location favorites) #:transparent)

;;two lists that correspond of things that have been learned
(struct/lens learned (list1 list2) #:transparent)

;;all the things that have been learned
;;a profile, a list of synonyms, and a learn set
(struct/lens experience (profile synonyms learned) #:transparent)

;;both are strings
(struct/lens short-memory (last-said topic) #:transparent)

;;A short-memory and long is an experience
(struct/lens memory (short long) #:transparent)

(define experience-learned-list1-lens (lens-thrush experience-learned-lens learned-list1-lens))
(define experience-learned-list2-lens (lens-thrush experience-learned-lens learned-list2-lens))
(define memory-long-learned-list2-lens (lens-thrush memory-long-lens experience-learned-list2-lens))
(define memory-long-learned-list1-lens (lens-thrush memory-long-lens experience-learned-list1-lens))
(define memory-list1-lens memory-long-learned-list1-lens)
(define memory-list2-lens memory-long-learned-list2-lens)