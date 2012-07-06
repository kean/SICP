; SICP exercise 1.39

(define (cont-frac n d k)
  (define (frac i)
    (if (< i k)
	(/ (n i) (+ (d i) (frac (+ i 1))))
	(/ (n i) (d i))))
  (frac 1))

(define (tan-cf x k) 
  (let ((n (lambda (k)
	     (if (= k 1)
		 x
		 (- (square x)))))
	(d (lambda (k) (- (* 2 k) 1))))
    (cont-frac n d k)))
