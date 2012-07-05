; SICP exercise 1.27

(define (fast-prime? n)
  (fermat-test n 2))

(define (fermat-test n a)
  (cond ((= a n) #t)
	((= (expmod a n n) a)
	 (fermat-test n (+ a 1)))
	(else #f)))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
	((even? exp)
	 (remainder (square (expmod base (/ exp 2) m))
		    m))
	(else
	 (remainder (* base (expmod base (- exp 1) m))
		    m))))

(fast-prime? 561)
;Value: #t
(fast-prime? 1105)
;Value: #t
(fast-prime? 1729)
;Value: #t
(fast-prime? 2465)
;Value: #t
(fast-prime? 2821)
;Value: #t
(fast-prime? 6601)
;Value: #t

; All Carmichael numbers from footnote 1.47 fooled Fermat test:
; test returned true (#t) -> the given number is prime which
; is not true