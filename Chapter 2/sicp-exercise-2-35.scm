; SICP. Exercise 2-35.

(define (count-leaves t)
  (accumulate +
	      0
	      (map (lambda (x) 1)
		   (enumerate-tree t)))

; I guess i really like sequences as
; conventional interfaces...