; SICP exercise 1-4

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; After substituting parameters a and b Scheme evaluates the operator (if (> b 0) + -)
; and the operands. The operator evaluates to either procedure + or -.