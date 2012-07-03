; SICP exercise 1-10

(define (A x y)
  (cond ((= y 0) 0)
	((= x 0) (* 2 y))
	((= y 1) 2)
	(else (A (- x 1)
		 (A x (- y 1))))))

; EVALUATIONG EXPRESSIONS
; =======================
; (A 1 10) (A 2 4) (A 3 3)

; I'm not gonna use the computer for the first expression
; (A 1 10)
; (A 0 (A 1 9))
; (A 0 (A 0 (A 1 8)))
; Here we can see the pattern of the function for x = 1
; Due to the pattern there are 9x (A 0 ... expressions

; ... (A 0 (A 1 1))
; (A 1 1) -> 2 
; (A 0 2) -> 4 which is (* 2 y)
; We can see that we got 2 as the base and y as the power
; (A 1 1) represents 2^1
; Which means that (A 1 10) represents 2^10 = 1024
; (A 1 10) -> 1024

; (A 2 4) -> 65536
; (A 3 3) -> 65536

; DEFINING FUNCTIONS
; ==================

; FUNCTION-01

(define (f n) (A 0 n))
; Due to the body of A function (A 0 n) evaluates to (* 2 y)
; Definiion: f(n) = 2n

; FUNCTION-02

(define (g n) (A 1 n))
; We are already familiar whith this pattern
; The only difference is that for g(0) we get 0, not 1
; Definition:
; g(n) = 0, if n = 0
; g(n) = 2^n, if n > 0

; FUNCTION-03

(define (h n) (A 2 n))
; Evaluating expressions:
; (h 0) -> 0
; (h 1) -> 2 = 2^1
; (h 2) -> 4 = 2^2
; (h 3) -> 16 = 2^4
; (h 4) -> 65536 = 2^16
; (h 5) -> Aborting!: maximum recursion depth exceeded

; We can see the pattern: g(n) = 2^h(n-1)
; Let's prove this pattern using mathematical induction

; We need a base case and inductive case.

; Inductive case: 

; Speaking in terms of Scheme we can represent h(k+1) in terms of h(k) where k is integer and k > 0.

; (A 2 k)
; (A 1 (A 2 (- k 1)),
; which transcribes to h(k+1) -> g(h(k)) in mathematical terms. Knowing some base h(k) we can compute h(k+1) and any h(n) where n is larger than k.

; Base case:

; let n = 1
; h(1) -> 2
; h(n+1) -> g(h(n)) -> 2^2 = 4

; And there is a special case for (A 2 n) where n = 0. h(0) -> 0.

; So we proved the formula for all non-negative integers.

; FUNCTION-04

(define (k n) (+ 5 n n))
; k(n) = 2n + 5

