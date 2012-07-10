; SICP. Exercise 2-34.

(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms) <??>)
	      0
	      coefficient-sequence))

; As we can see from the example the coefficient-sequence starts
; from the coefficient to (x^0).
; Example:
; 1 + 3x + 5x^3 + x^5
; Sequence:
; (list 1 3 0 5 0 1)

; As we know, accumulate starts evaluation from the beginning of 
; the sequence (car sequence). So the first element we are gonna compute 
; is a*x^0. The accumulator-procedure is simple addition.

; Well, knowing the formula implementing this procedure becomes easy as pie:

(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms)
		(+ this-coeff
		   (* x (higher-terms))))
	      0
	      coefficient-sequence))