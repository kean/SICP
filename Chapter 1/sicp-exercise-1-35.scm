; SICP exercise 1.35

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
	  next
	  (try next))))
  (try first-guess))

(define tolerance 0.00001)

; φ  (1+√5)/2 ~ Value: 1.618033988749895

(define golden-ratio
  (fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0))

 golden-ratio
;Value: 1.6180327868852458