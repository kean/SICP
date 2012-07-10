; SICP. Exercise 2.18.

(define (reverse items)
 (if (null? items)
     items
     (append (reverse (cdr items)) (list (car items)))))