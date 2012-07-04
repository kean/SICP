; SICP exercise 1.18

(define (mul-iter a b r)
  (cond ((= 0 b) r)
	((even? b) (mul-iter (double a) (halve b) r))
	(else (mul-iter a (- b 1) (+ a r)))))

(define (fast-mul a b)
  (if (< b 0)
      (mul-iter (- a) (- b) 0)
      (mul-iter a b 0)))

(define (double x)
  (* x 2))

(define (halve x)
  (/ x 2))