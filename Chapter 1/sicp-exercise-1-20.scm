; SICP exercise 1.20

; Euclid's Algorithm:
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

; NORMAL-ORDER EVALUATION
; =======================

(gcd 206 40)

(if (= 40 0)
    206
    (gcd 40 (remainder 206 40)))

(gcd 40 
     (remainder 206 40))

(if (= (remainder 206 40) 0) ; Predicate is evaluated (= 6 0) -> remainders: 1 
    40
    (gcd (remainder 206 40) (remainder 40 (remainder 206 40))))

(gcd (remainder 206 40) 
     (remainder 40 (remainder 206 40)))

(if (= (remainder 40 (remainder 206 40)) 0) ; Predicate is evaluated (= 4 0) -> remainders: (1+2) = 3
    (remainder 206 40)
    (gcd (remainder 40 (remainder 206 40))
	 (remainder (remainder 206 40)
		    (remainder 40 (remainder 206 40)))))

(gcd (remainder 40 (remainder 206 40))
     (remainder (remainder 206 40)
		(remainder 40 (remainder 206 40))))

(if (= (remainder (remainder 206 40) 
		  (remainder 40 (remainder 206 40)))
       0) ; Predicate is evaluated (= 2 0) -> remainders: (3+4) = 7
    (remainder 40 (remainder 206 40))
    (gcd (remainder (remainder 206 40)
		    (remainder 40 (remainder 206 40)))
	 (remainder (remainder 40 (remainder 206 40))
		    (remainder (remainder 206 40)
			       (remainder 40 (remainder 206 40))))))
		    

(gcd (remainder (remainder 206 40)
		(remainder 40 (remainder 206 40)))
     (remainder (remainder 40 (remainder 206 40))
		(remainder (remainder 206 40)
			   (remainder 40 (remainder 206 40)))))

(if (= (remainder (remainder 40 (remainder 206 40))
		  (remainder (remainder 206 40)
			     (remainder 40 (remainder 206 40))))
       0) ; Predicate is evaluated (= 0 0) -> remainders: (7+7) = 14
    (remainder (remainder 206 40)
	       (remainder 40 (remainder 206 40))) ; Consuquent is evaluated (2) -> remainders: (14+4) = 18
    ; else ...
    ; Alernative doesn't get evaluated here

; Remainders are evaluated 18 times

; APLICATIVE-ORDER EVALUATION
; ===========================

(gcd 206 40)

(if (= 40 0) ; Predicate is evaluated
    40 
    (gcd 40 (remainder 206 40)))

(gcd 40 (remainder 206 40)) ; Arguments are evaluated -> remainders: 1

(gcd 40 6)

(if (= 6 0)
    40
    (gcd 6 (remainder 40 6)))

(gcd 6 (remainder 40 6)) ; Arguments are evaluated -> remainders: (1+1) = 2

(gcd 6 4)

(if (= 4 0)
    4
    (gcd 6 (remainder 6 4)))

(gcd 4 (remainder 6 4)) ; Arguments are evaluated -> remainders: (2+1) = 3

(gcd 4 2)

(if (= 2 0)
    6
    (gcd 4 (remainder 4 2)))

(gcd 2 (remainder 4 2)) ; Arguments are evaluated -> remainders: (3+1) = 4

(gcd 2 0)

(if (= 0 0)
    2
    (gcd 2 (remainder 2 0)))

; Procedure returns 2
; Remainders are evaluated 4 times




