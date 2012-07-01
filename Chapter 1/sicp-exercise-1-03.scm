; SICP exercise 1-3

; there are built-in Scheme procedures square, max, min
; however we are not aware of them at that point of the book

(define (sum-of-largest-squares a b c)
  (+ (square (max a b))
     (square (max c (min a b)))))

(define (square x)
  (* x x))

(define (max a b)
  (if (> a b)
      a
      b))

(define (min a b)
  (if (< a b)
      a
      b))