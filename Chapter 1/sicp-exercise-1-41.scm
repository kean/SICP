; SICP exercise 1.41

(define (double func)
  (lambda (x) (func (func x)))
(define (inc x) (+ x 1))

; What's returned by:

(((double (double double)) inc) 5)
(((double (lambda (x) (double (double x)))) inc) 5)

(((lambda (y)
    ((lambda (x) (double (double x)))
     ((lambda (x) (double (double x))) y))) inc) 5)

(((lambda (x) (double (double x)))
  ((lambda (x) (double (double x))) inc)) 5)

(((lambda (x) (double (double x)))
  (double (double inc))) 5)

(((lambda (x) (double (double x)))
  (double (lambda (y) (inc (inc y))))) 5)

(((lambda (x) (double (double x)))
  (lambda (z)
    ((lambda (y) (inc (inc y)))
     ((lambda (y) (inc (inc y))) z)))) 5)

; Let's make our life easier:
; ==========================
(define lambda-1
  (lambda (x) (double (double x))))
(define lambda-2
  (lambda (z)
    ((lambda (y) (inc (inc y)))
     ((lambda (y) (inc (inc y))) z))))
; ==========================

((lambda-1 lambda-2) 5))

((double (double lambda-2)) 5)

((double (lambda (x) (lambda-2 (lambda-2 x)))) 5)
 
((lambda (y)
  ((lambda (x) (lambda-2 (lambda-2 x)))
   ((lambda (x) (lambda-2 (lambda-2 x))) y))) 5)

((lambda (x) (lambda-2 (lambda-2 x)))
 ((lambda (x) (lambda-2 (lambda-2 x))) 5))

; (lambda-2 x) is the same as (+ x 4)

((lambda (x) (lambda-2 (lambda-2 x)))
 (lambda-2 (lambda-2 5)))

((lambda (x) (lambda-2 (lambda-2 x)))
 13)

; Result: 21
; Wow that's was mind-blowing


; Next day i tried to evaluate this in mind for 
; the second time. Now i used more intermidiate functions (l1, l2, l3)

(((double (double double)) inc) 5)

(define l1
  (lambda (x) (double (double x))))

(((double l1) inc) 5)

(define l2
  (lambda (x) (l1 (l1 x))))

((l2 inc) 5)

((l1 (l1 inc)) 5)

((l1 (double (double inc))) 5)

(define l3
  (lambda (x) (inc (inc (inc (inc x))))))

((l1 l3) 5)

((double (double l3)) 5)

((double (lambda (x) (l3 (l3 x)))) 5)

((lambda (x) (l3 (l3 x)))
 ((lambda (x) (l3 (l3 x))) 5))

((lambda (x) (l3 (l3 x)))
 (l3 (l3 5)))

((lambda (x) (l3 (l3 x)))
 (l3 (inc (inc (inc (inc 5))))))

((lambda (x) (l3 (l3 x)))
 (l3 9))

(l3 (l3 13))

(l3 17)

; Result: 21