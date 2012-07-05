; SICP exercise 1.31

(define (product term a next b)
  (if (> a b)
      1
      (* (term a) 
	 (product term (next a) next b))))

(define (factorial n)
  (product (lambda (x) x)
	   1
	   (lambda (x) (+ x 1))
	   n))

(define (pi-approx n)
  (* (/ 8.0 3.0) ; Computes Pi insted of Pi/4
     (product (lambda (a)
		(* (/ a (- a 1))
		   (/ a (+ a 1))))
	      4.0
	      (lambda (x) (+ x 2))
	      n)))

; COMMENT #1
; Recursive algorithm won't let us compute Pi with a good precision:
(pi-approx 100000)
;Aborting!: maximum recursion depth exceeded
(pi-approx 10000)
;Value: 3.141435593589908

; COMMENT #2
; I implemented Wallis algorithm straighforward-way.
; The other way is to use more clever Wallis Formula insted:
; http://mathworld.wolfram.com/WallisFormula.html

; PART b - Iterative process
; ==========================

(define (product term a next b)
  (define (iter a result)
    (if (> a b)
	result
	(iter (next a)
	      (* result (term a)))))
    (iter a 1))

; Now we are able to compute Pi with more precision.
(pi-approx 10000)
;Value: 3.141435593589908
 (pi-approx 100000)
;Value: 3.141576945822872
; But the process is really slow because product in pi-approx 
; is computed using rational numbers - not floating point numbers.
; It casts to floating point number only when it's get 
; multiplied by (/ 8.0 3.0)

; Let's test pi-approx speed and precision with iterative product 
; and rational and with float numbers used in product.

(define (test-proc proc arg)
  (define (fire start-time)
    (newline)
    (display (proc arg))
    (newline)
    (display "Elapsed time: ")
    (display (- (runtime) start-time)))
  (fire (runtime)))

(define (pi-approx-float n)
  (* (/ 8.0 3.0) ; Computes Pi insted of Pi/4
     (product (lambda (a)
		(* (/ a (- a 1))
		   (/ a (+ a 1))))
	      4.0  ; That's the only difference from original pi-approx
	      (lambda (x) (+ x 2))
	      n)))

; PI =  3.14159 26535 89793 23846 ...

;  N         |              RESULT                    |                  TIME
;            | PI-RATIONAL         PI-FLOAT           | PI-RATIONAL             PI-FLOAT 
;===================================================================================================
;  1000        3.140023818600597   3.140023818600581    1.0000000000218279e-2   1.0000000000218279e-2
;  10000       3.141435593589908   3.141435593589842    .14000000000032742      .03999999999996362
;  100000      3.141576945822872   3.1415769458226817   15.609999999999673      .22999999999956344
;  1000000     -                   3.1415910827949025   approx. 25 min.         2.3599999999996726
;  10000000    -                   3.1415924965071182   -                       23.170000000000073
;  100000000   -                   3.141592635654933    -                       239.6899999999996
; Looks like time for pi-float is O(n) and for pi-rational is O(n^2)