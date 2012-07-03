; SICP exercise 1.7

; Code from the textbook:

(define (sqrt-sicp x)
  (sqrt-iter 1.0 x))
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
		 x)))
(define (improve guess x)
  (average guess (/ x guess)))
(define (average x y)
  (/ (+ x y) 2))
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

; Testing sqrt of very small and very big numbers

; TEST-01:
(sqrt-sicp 0.001)

; Result: .04124542607499115
; The expected result was around .0316227766
(square 0.04124542607499115) ; yeilds  1.7011851721075596e-3 (~0.0017011)
; The result is within our tolerence, everything is ok

; TEST-02:
(sqrt-sicp 0.0000001)

; Result: .03125106561775382
; When we try to square that number
(square 0.03125106561775382)
; we get 9.76629102245155e-4 which is ~ 0.0009766
; The difference between 0.0009766 and 0.0000001 is indeed less than 0.001
; But in fact the 0.0009766 is a 10000 times bigger then 0.0000001 which is not a good result

; TEST-03
(sqrt-sicp 1000000000)
; Result: 31622.776601684047
1000000000.00001604413
; Good enough

; TEST-04
(sqrt-sicp 99999999999999999999998)
; And it never stops evaluating. 
; In order to find out what's the problem is i use (trace) function on sqrt-iter
(trace sqrt-iter)
; and run it this way
(sqrt-iter 1.0 9999999999999998)
; After 20+ iterations we see that there is not enough precision 
; to find the correct answer. Improve guess starts producing the same
; number each iteration

[Entering #[compound-procedure 8 sqrt-iter]
    Args: 100004343.48109704
          9999999999999998]
[Entering #[compound-procedure 8 sqrt-iter]
    Args: 100000000.09432504
          9999999999999998]
[Entering #[compound-procedure 8 sqrt-iter]
    Args: 100000000.
          9999999999999998]
[Entering #[compound-procedure 8 sqrt-iter]
    Args: 100000000.
          9999999999999998]

; REWRITING SQUARE ROOT

(define (good-enough? guess x)
  (< (abs (- guess
	     (improve guess x))) 0.001))

; This implementation doesn't require change of other procedures
; however it executes (improve) twice during each iteration. 
; The faster approach would be to define good-enough with 
; additional parameter - previous-guess

; After executing new good-enough? sqrt-sicp works just fine

1 ]=> (sqrt-sicp 9999999999999998)
;Value: 100000000.

1 ]=> (sqrt-sicp 239023490238409283904829034829034802394)
;Value: 1.5460384543678378e19

