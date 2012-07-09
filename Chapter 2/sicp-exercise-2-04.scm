; SICP. Exercise 2-04.

(define (cons x y)
  (lambda (m) (m x y)))
(define (car z)
  (z (lambda (p q) p)))

; Let's substitute:
(car (cons a b))
(car (lambda (m) (m a b)))
((lambda (m) (m a b)) (lambda (p q) p))
((lambda (p q ) p) a b)
a

; Definition of cdr would be:
(define (cdr z)
  (z (lambda (p q) q)))