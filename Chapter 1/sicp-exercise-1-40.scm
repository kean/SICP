; SICP exercise 1.40

(newtons-method (cubic a b c) 1)

(define (cubic a b c)
  (lambda (x)
    (+ (cube x)
       (* a (square x))
       (* b x)
       c)))