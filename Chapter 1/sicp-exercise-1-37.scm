; SICP exercise 1.37

(define (cont-frac n d k)
   (define (frac i)
     (if (< i k)
         (/ (n i) (+ (d i) (frac (+ i 1))))
         (/ (n i) (d i))))
  (frac 1))

; How to get 4 decimal places precision. Let's find this out straighforward way

(cont-frac (lambda (x) 1.0) (lambda (x) 1.0) 9)
;Value: .6181818181818182
(cont-frac (lambda (x) 1.0) (lambda (x) 1.0) 10)
;Value: .6179775280898876
(cont-frac (lambda (x) 1.0) (lambda (x) 1.0) 11)
;Value: .6180555555555556
(cont-frac (lambda (x) 1.0) (lambda (x) 1.0) 12)
;Value: .6180257510729613
(cont-frac (lambda (x) 1.0) (lambda (x) 1.0) 13)
;Value: .6180371352785146

; We got 4 decimal places precision in k = 11 times

(define (cont-frac n d k)
   (define (iter i result)
       (if (= i 0)
           result
           (iter (- i 1) (/ (n i) (+ (d i) result)))))
   (iter (- k 1) (/ (n k) (d k))))