; SICP exercise 1.23

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
	((divides? test-divisor n) test-divisor)
	(else (find-divisor n (next test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (next x)
  (if (= x 2)
      3
      (+ x 2)))

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

; This time let's test it only for powers [10, 14]

(sfp-init 10000000000 100) ; 10^10
10000000019 *** .1099999999999568
10000000033 *** .11000000000001364
10000000061 *** .12000000000000455

(sfp-init 100000000000 100) ; 10^11
100000000003 *** .37000000000000455
100000000019 *** .36000000000001364
100000000057 *** .37000000000000455

(sfp-init 1000000000000 100) ; 10^12
1000000000039 *** 1.1299999999999955
1000000000061 *** 1.1299999999999955
1000000000063 *** 1.1200000000000045

(sfp-init 10000000000000 100) ; 10^13
10000000000037 *** 3.579999999999984
10000000000051 *** 3.5399999999999636
10000000000099 *** 3.5400000000000205

(sfp-init 100000000000000 100) ; 10^14
100000000000031 *** 11.170000000000016
100000000000067 *** 11.199999999999989
100000000000097 *** 11.17999999999995

; RESULTS FROM 1.22 + NEW RESULTS (WITH PROCEDURE NEXT)

; Pow     Time(sec.)-before    Time(sec.)-after        Ratio
; ==========================================================
; 10^10   0.176666666666667    0.113333333333325       1.55882352941188226644
; 10^11   0.560000000000007    0.36666666666667425     1.52727272727271477686
; 10^12   1.750000000000000    1.1266666666666652      1.5532544378698245072
; 10^13   5.603333333333329    3.5533333333333226      1.57692307692308046688
; 10^14   17.78333333333332    11.183333333333318      1.5901639344262304962
;                                                 Avg: 1.5612875411807463

; I guessed that the result we've got was due to the overhead of calling 
; additional function - next. Let's prove this by rewriting prime-test. 

(define (smallest-divisor n)
  (if (divides? 2 n)
      2  
      (find-divisor n 3)))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
	((divides? test-divisor n) test-divisor)
	(else (find-divisor n (+ test-divisor 2)))))

(define (slow-prime? n)
  (= n (smallest-divisor n)))

; As the result we got:

(sfp-init 10000000000 100)
10000000019 *** .08999999999991815
10000000033 *** .08999999999991815
10000000061 *** .09000000000014552

(sfp-init 100000000000 100)
100000000003 *** .2899999999999636
100000000019 *** .2799999999999727
100000000057 *** .2899999999999636
; etc ... 

; Let's check the results:

; Pow     Time(sec.)-before    Time(sec.)-after        Ratio
; ==========================================================
; 10^10   0.176666666666667    .08999999999999393      1.962962962963099
; 10^11   0.560000000000007    .2866666666666333       1.9534883720932752
; 10^12   1.750000000000000    .9066666666666757       1.9301470588235101
; 10^13   5.603333333333329    2.869999999999967       1.9523809523809734
; 10^14   17.78333333333332    9.086666666666815       1.957079970652938
;                                                 Avg: 1.951211863382759

; That proves that calling additional function took almost 50% of the improvment raio 