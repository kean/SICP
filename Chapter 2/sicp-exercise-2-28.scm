; SICP. Exercise 2-28.

(define x (list (list 1 2) (list 3 4)))

(define (fringe tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append (fringe (car tree))
                      (fringe (cdr tree))))))

(fringe x)
(append (fringe (car x))
	(fringe (cdr x)))

(fringe (car x))

