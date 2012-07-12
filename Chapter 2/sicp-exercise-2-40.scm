; SICP. Exercise 2-40.

; The initial procedure was:
(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
	       (flatmap
		(lambda (i)
		  (map (lambda (j) (list i j))
		       (enumerate-interval 1 (- i 1))))
		(enumerate-interval 1 n)))))

; Let's define unique-pairs

(define (unique-pairs n)
  (flatmap
   (lambda (i)
     (map (lambda (j) (list i j))
	  (enumerate-interval 1 (- i 1))))
   (enumerate-interval 1 n)))

; Test
(unique-pairs 4)
; ((2 1) (3 1) (3 2) (4 1) (4 2) (4 3))

; Simplifing the definition of prime-sum-pairs
(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
	       (prime-sum-pairs n))))