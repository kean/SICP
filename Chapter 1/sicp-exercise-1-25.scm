; SICP exercise 1.25

(define (expmod-alyssa base exp m)
  (remainder (fast-expt base exp) m))

(define (fast-expt b n)
  (cond ((= n 0) 1)
	((even? n) (square (fast-expt b (/ n 2))))
	(else (* b (fast-expt b (- n 1))))))

; original expmod
(define (expmod base exp m)
  (cond ((= exp 0) 1)
	((even? exp)
	 (remainder (square (expmod base (/ exp 2) m))
		    m))
	(else
	 (remainder (* base (expmod base (- exp 1) m))
		    m))))

; When we wrote original expmod function we used a shortcut, 
; a fact that for even n: x^n mod m = (x^(n/2) mod m)^2 mod m
; and that for odd k: x^k mod m = ((x mod m)(x^(k-1) mod m)) mod m.
; Since fermat test is based on raising some random number a (which is 1<a<(n-1))
; to a power n. Alyssa's expmod might work well for checking primality of relitevely
; small numbers (it might be even faster than original expmod). But results for 
; large numbers are gonna be really awful. 
; Just imaging raising 100000000018  to 100000000019 power when checking for primality
; number 100000000019 (ofc if random returns n-1). Scheme does support
; infinite integers though...

; Let's write a timed test procedure to find out which expmod function is 
; better for fermat-test. This procedure runs fermat test for specified
; number. It uses specified in input expmod procedure. Timed-test runs
; the same test specified number of times and prints the average elapsed time.

(define (timed-test numb expmod-proc run-times)
  (define (timed-test-fire start-time)
    (fast-prime? numb 1000 expmod-proc)
    (- (runtime) start-time))
  (define (timed-test-iter run-times)
    (if (= run-times 0)
	0
	(+ (timed-test-fire (runtime)) (timed-test-iter (- run-times 1))))) 
  (newline)
  (display "Time elapsed: ")
  (display (/ (timed-test-iter run-times) run-times)))

; fermat test
(define (fast-prime? n times expmod-proc)
  (cond ((= times 0) true)
	((fermat-test n expmod-proc) (fast-prime? n (- times 1) expmod-proc))
	(else false)))
(define (fermat-test n expmod-proc)
  (define (try-it a)
    (= (expmod-proc a n n) a))
  (try-it (+ 1 (random (- n 1)))))
(define false #f)
(define true #t)

; Let's start with really small number 101

(timed-test 101 expmod 100)
Time elapsed: 2.0599999999999986e-2
(timed-test 101 expmod-alyssa 100)
Time elapsed: 1.8900000000000007e-2

; Yes, Fermat test with Alyssa's method ran slightly faster than
; the test with original expmod.

(timed-test 541 expmod 100) ; almost 2 times faster
Time elapsed: .02710000000000001
(timed-test 541 expmod-alyssa 100)
Time elapsed: 3.5999999999999976e-2

(timed-test 1009 expmod 100)
Time elapsed: .03
(timed-test 1009 expmod-alyssa 100)
Time elapsed: .06850000000000005

(timed-test 10007 expmod 100)
Time elapsed: .03829999999999998 ; that's the power of an algorithm. 
(timed-test 10007 expmod-alyssa 100)
Time elapsed: 6.5136 

; now let's double the input

(timed-test 20011 expmod 100)
Time elapsed: .03970000000000027
(timed-test 20011 expmod-alyssa 10)
Time elapsed: 30.113999999999987 ; the elapsed time doubled

(timed-test 50021 expmod 10)
Time elapsed: 4.2000000000007275e-2
(timed-test 50021 expmod-alyssa 1)
Time elapsed: 224.76
