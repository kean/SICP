; SICP exercise 1.38

(define (cont-frac n d k)
  (define (frac i)
    (if (< i k)
	(/ (n i) (+ (d i) (frac (+ i 1))))
	(/ (n i) (d i))))
  (frac 1))

(define (euler-log k)
  (let ((d (lambda (k) (if (= 0 (remainder (+ k 1) 3))
			   (* 2 (/ (+ k 1) 3))
			   1)))
	(n (lambda (k) 1.0)))
    (cont-frac n d k)))

(define e
  (+ 2 (euler-log 100)))