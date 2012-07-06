; SICP exercse 1.46

(define (iterative-improve good-enough? improve)
   (define (iter guess)
     (if (good-enough? guess)
         guess
         (iter (improve guess))))
   iter)

; That's all, that's it, looking forward for chapter 2!