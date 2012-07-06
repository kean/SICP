; SICP exercise 1.36

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (newline)
    (display "guess: ")
    (display guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
	  next
	  (try next))))
  (try first-guess))

(define tolerance 0.001)

(fixed-point (lambda (x) (/ (log 1000) (log x))) 2.0)

guess: 2.
guess: 9.965784284662087
guess: 3.004472209841214
guess: 6.279195757507157
guess: 3.759850702401539
guess: 5.215843784925895
guess: 4.182207192401397
guess: 4.8277650983445906
guess: 4.387593384662677
guess: 4.671250085763899
guess: 4.481403616895052
guess: 4.6053657460929
guess: 4.5230849678718865
guess: 4.577114682047341
guess: 4.541382480151454
guess: 4.564903245230833
guess: 4.549372679303342
guess: 4.559606491913287
guess: 4.552853875788271
guess: 4.557305529748263
guess: 4.554369064436181
guess: 4.556305311532999
guess: 4.555028263573554
;Value: 4.555870396702851

; 24 steps

(define (avg x y)
  (/ (+ x y) 2))

(fixed-point (lambda (x) (avg x (/ (log 1000) (log x)))) 2.0)
guess: 2.
guess: 5.9828921423310435
guess: 4.922168721308343
guess: 4.628224318195455
guess: 4.568346513136242
guess: 4.5577305909237005
guess: 4.555909809045131
;Value: 4.555599411610624

; 8 steps