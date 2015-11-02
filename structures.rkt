#lang racket
(provide (all-defined-out))

(struct synonym (name list));;string and list of strings

;;string for name and location, and favorites will be a special learned for things that are their favorite
(struct profile (name location favorites))

;;two lists that correspond of things that have been learned
(struct learned (list1 list2))

;;all the things that have been learned
;;a profile, a list of synonyms, and a learn set
(struct experience (profile synonyms learned))