; SICP exercise 1.45

; Well, i confess:) i was too lazy to implement this all by myself
; so i kinda borrowed a couple ideas..

(define (nth-root x n)
  (fixed-point
      ((repeated average-damp (floor (log2 n)))
          (lambda (y) (/ x (expt y (- n 1)))))
      1.0))

(define (log2 x)
  (/ (log x) (log 2)))

; This procedure works just fine. Ty.