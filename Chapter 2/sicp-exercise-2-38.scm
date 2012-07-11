; SICP. Exercise 2-38.

; fold-right from the textbook:

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
	result
	(iter (op result (car rest))
	      (cdr rest))))
  (iter initial sequence))
(define (fold-right op initial sequence)
  (accumulate op initial sequence))

; Let's eveluate the given expressions:

(fold-right / 1 (list 1 2 3))
; 3/2

(fold-left / 1 (list 1 2 3))
; 1/6

(fold-right list nil (list 1 2 3))
; (1 (2 (3 ())))

(fold-left list nil (list 1 2 3))
; (((() 1 ) 2) 3)

; op should have commutative property so that A op B = B op A