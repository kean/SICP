; SICP exercise 1.8

; We need to change only one function - improve - 
; since we use the good-enough? implementation from exercise 1-07

(define (improve guess x)
  (/ (+ (* x (square guess))
	(* 2 guess))
     3))