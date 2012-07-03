; SICP exercise 1.11

; recursive process

(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1))
	 (* 2 (f (- n 2)))
	 (* 3 (f (- n 3))))))

; iterative process

(define (f n)
  (if (< n 3)
     n
     (iter n 2 1 0)))

 (define (iter n f-1 f-2 f-3)
    (if (< n 3)
	f-1
	(iter (- n 1)
	      (+ f-1 (* 2 f-2) (* 3 f-3))
	      f-1
	      f-2)))
		 