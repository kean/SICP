; SICP exercise 1.21

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
	((divides? test-divisor n) test-divisor)
	(else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

; SLOW PRIME TEST 
(define (slow-prime? n)
  (= n (smallest-divisor n)))


; TIMED-PRIME-TEST

; i rewrited timped-prime-test since we are interested only in prime numbers, not all numbers
; now it also returns #t is the number was prime and #f if not
(define (timed-prime-test n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (cond ((prime-slow? n)
	 (report-prime n (- (runtime) start-time))
	 #t)
	(else #f)))
(define (report-prime n elapsed-time)
   (newline)
   (display n)  ; that's the first time when we see something familiar to imperative style programming
   (display " *** ") ; how do we know that those operators are evaluated in a row?
   (display elapsed-time))

; SEARCH-FOR-PRIMES

; This procedure is similar to Bill's implementation:
(define (search-for-primes from to)
   (if (even? from)
       (search-for-primes (+ from 1) to)
       (cond ((< from to)
	      (timed-prime-test from)
	      (search-for-primes (+ from 2) to)))))

; I added procedure for more convenience:
(define (sfp-init from range)
  (search-for-primes from (+ from range)))

; TESTING ALGORITHM'S SPEED
; =========================

; Apparently computers nowadays are faster than the computers
; that were used when the book was printed.
; If we want to achive more precision in our observation we should use
; not 10^3 but we shall start with at least 10^9

(sfp-init 1000000000 100) ; 10^9
1000000007 *** 6.0000000000002274e-2
1000000009 *** 6.0000000000002274e-2
1000000021 *** 6.0000000000002274e-2

(sfp-init 10000000000 100) ; 10^10
10000000019 *** .1799999999999926
10000000033 *** .18000000000000682
10000000061 *** .1700000000000017

(sfp-init 100000000000 100) ; 10^11
100000000003 *** .5600000000000023
100000000019 *** .5400000000000063
100000000057 *** .5800000000000125

(sfp-init 1000000000000 100) ; 10^12
1000000000039 *** 1.75
1000000000061 *** 1.7600000000000051
1000000000063 *** 1.7399999999999949

(sfp-init 10000000000000 100) ; 10^13
10000000000037 *** 5.560000000000002
10000000000051 *** 5.659999999999997
10000000000099 *** 5.589999999999989

(sfp-init 100000000000000 100) ; 10^14
100000000000031 *** 17.680000000000007
100000000000067 *** 17.70999999999998
100000000000097 *** 17.95999999999998

(sfp-init 1000000000000000 180) ; 10^15
1000000000000037 *** 56.43000000000001
1000000000000091 *** 56.31
1000000000000159 *** 56.25

; Ok that would be enough
; Let's analyze the results. We expect that testing for primes
; around 10^(n+1) should tak around  √10 (≈3.16227766)  as long as testing for 
; primes around 10^n.

; Results (i take average of three):

; Pow     Time (in sec.)       Ratio
; ===================================================
; 10^9    0.060000000000022    -
; 10^10   0.176666666666667    2.94444444444337037037
; 10^11   0.560000000000007    3.169811320754750623
; 10^12   1.750000000000000    3.1249999999999609375
; 10^13   5.603333333333329    3.20190476190475942857
; 10^14   17.78333333333332    3.17370612730517556563
; 10^15   56.330000000000005   3.16757263355201765141
;                         Avg: 3.130406547993339

; The average result is really close to what we expected.




