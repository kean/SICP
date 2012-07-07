; SICP. Exercise 2-02.

(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

(define (make-segment start-point end-point)
  (cons start-point end-point))

(define (start-segment s)
  (car s))

(define (end-segment s)
  (cdr s))

(define (midpoint seg)
  (let ((s-p (start-segment seg))
	(e-p (end-segment seg)))
    (make-point (/ (- (x-point e-p)
		      (x-point s-p)) 2)
		(/ (- (y-point e-p)
		      (y-point s-p)) 2))))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

; testing

(define x-p (make-point 1 2))
(define y-p (make-point 3 5))
(define segm (make-segment x-p y-p))
(print-point (midpoint segm))
; (1,3/2)