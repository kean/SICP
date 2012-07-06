; SICP exercise 1.44

; code from previous exercises:

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated x n)
  (if (= n 1)
      x
      (compose x (repeated x (- n 1)))))

; new smooth function:

(define (smooth f dx)
  (lambda (x)
    (/ (+ (f (- x dx))
	  (f x)
	  (f (+ x dx)))
       3)))

(define (n-fold-smooth f dx n)
  (repeated (smooth f dx) n))