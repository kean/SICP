; SICP exercise 1.24

(define (fast-prime? n times)
  (cond ((= times 0) true)
	((fermat-test n) (fast-prime? n (- times 1)))
	(else false)))

(define false #f)
(define true #t)

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
	((even? exp)
	 (remainder (square (expmod base (/ exp 2) m))
		    m))
	(else
	 (remainder (* base (expmod base (- exp 1) m))
		    m))))

; TIMED TESTS FROM PREVIOUS EXERCISES

(define (timed-prime-test n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (cond ((fast-prime? n 1000)
	 (report-prime n (- (runtime) start-time))
	 #t)
	(else #f)))
(define (report-prime n elapsed-time)
   (newline)
   (display n)  
   (display " *** ") 
   (display elapsed-time))
(define (search-for-primes from to)
   (if (even? from)
       (search-for-primes (+ from 1) to)
       (cond ((< from to)
	      (timed-prime-test from)
	      (search-for-primes (+ from 2) to)))))
(define (sfp-init from range)
  (search-for-primes from (+ from range)))

; Let's start our tests (we check fast-prime with 1000 different random values for each 
; number.
; Order of growth is O(log n). Initial resources used are R(n). O(log n) means that R(n) correlates with f(n) = log n. 
; If we square n than we get log n^2. There is a rule that log n^k = k log n so we get: 2 log n,
;  which means that R(n) is doubled (because R(n) correlates with f(n) = log n).

(sfp-init 10000000000 100) ; 10^10
10000000019 *** .11000000000012733
10000000033 *** .12999999999988177
10000000061 *** .11000000000012733

(sfp-init 100000000000 100) ; 10^11
100000000003 *** .12999999999988177
100000000019 *** .13000000000010914
100000000057 *** .11999999999989086

(sfp-init 1000000000000 100) ; 10^12
1000000000039 *** .14000000000010004
1000000000061 *** .12999999999988177
1000000000063 *** .14000000000010004

(sfp-init 10000000000000 100) ; 10^13
10000000000037 *** .13999999999987267
10000000000051 *** .15000000000009095
10000000000099 *** .13999999999987267

(sfp-init 100000000000000 100) ; 10^14
100000000000031 *** .16000000000008185
100000000000067 *** .16000000000008185
100000000000097 *** .15999999999985448

; Pow     Time (in sec.)       Ratio
; ===================================================
; 10^10   .11666666666671215   -
; 10^11   .12666666666662726   1.0857142857135247  (to previous)
; 10^12   .13666666666669394   1.0789473684216035  (to previous)
; 10^13   .14333333333327877   1.0487804878042695  (to previous)
; 10^14   .16000000000000605   1.116279069767909   (to previous)
; 10^20   .2333333333333485    1.9999999999993503  (to 10^10)
                        
; We proved that when we square the input the time consumed is doubled.

; btw the time consumed grows linearly with the amount of tests (times parameter of fast-prime?) so
; that is not exaclty true that the order of growth here is O(log n). It's O(m log n) where
; m is number of times we run test (number of random test-numbers).


