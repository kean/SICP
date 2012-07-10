; SICP. Exercise 2.20.

(define (same-parity a . z)
  (define (iter take? list)
     (cond ((null? z)
	    nil)
	   ((take? (car z))
	    (cons (car z) (iter (cdr list))))
	   (else iter (cdr list))))
  (let ((take-proc (if (even? a)
		   even?
		   odd?)))
    (iter take-proc z)))
