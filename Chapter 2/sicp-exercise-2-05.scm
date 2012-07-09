; SICP. Exercise 2-05.

(define (cons x y)
  (* (expt 2 x)
     (expt 3 y)))
(define (car x)
  (if (= (remainder x 2) 0)
      (+ 1 (car (/ x 2)))
      0))
(define (cdr x)
  (if (= (remainder x 3) 0)
      (+ 1 (cdr (/ x 3)))
      0))