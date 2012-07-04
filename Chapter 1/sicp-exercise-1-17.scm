; SICP exercise 1.17

; Fast-mul is the initial procedure that provides
; support for negative integers

(define (fast-mul a b)
  (cond ((or (= b 0)
	     (= a 0))
	     0)
	((< b 0) (mul-iter (- a) (- b)))
	(else  (mul-iter a b))))

(define (mul-iter a b)
  (cond ((= b 1) a)
	((even? b) (double (mul-iter a (halve b))))
	(else (+ a (mul-iter a (- b 1))))))

(define (double x)
  (* x 2))

(define (halve x)
  (/ x 2))
