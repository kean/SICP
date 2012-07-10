; SICP. Exercise 2.19.

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
	((or (< amount 0) (no-more? coin-values)) 0)
	(else
	 (+ (cc amount
		(except-first-denomination
		 coin-values))
	    (cc (- amount (first-denomination coin-values))
		coin-values)))))

(define us-coins (list 50 25 10 5 1))

(define (first-denomination coins)
  (car coins))
(define (except-first-denomination coins)
  (cdr coins))
(define (no-more? coins)
  (null? coins))

; The order of the list coin-values doesn't affect the answer. 
; Why - because of the algorith that is used.