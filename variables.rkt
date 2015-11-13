#lang racket
(require "structures.rkt")
(provide (all-defined-out))

(define DEFAULT-STATE
  (memory
   (short-memory
    "none"
    "none")
   (experience
    (profile "unknown" "unknown" empty)
    empty
    (learned empty empty))))