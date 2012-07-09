; SICP. Exercises 2.07 - 2.16.
; Since it's an "extended exercise" it would be convinient to 
; gather all the solutions into one file.

; We would definetly need code all readymade code from the book:

(define (add-interval x y)
   (make-interval (+ (lower-bound x) (lower-bound y))
                  (+ (upper-bound x) (upper-bound y))))
(define (mul-interval x y)
   (let ((p1 (* (lower-bound x) (lower-bound y)))
         (p2 (* (lower-bound x) (upper-bound y)))
         (p3 (* (upper-bound x) (lower-bound y)))
         (p4 (* (upper-bound x) (upper-bound y))))
     (make-interval (min p1 p2 p3 p4)
                    (max p1 p2 p3 p4))))
(define (div-interval x y)
   (mul-interval x
                 (make-interval (/ 1.0 (upper-bound y))
                                (/ 1.0 (lower-bound y)))))

; EXERCISE 2.07
; =============

(define (make-interval a b)
  (cons a b))
(define (lower-bound interval)
  (car interval))
(define (upper-bound interval)
  (cdr interval))

; EXERCISE 2.08
; =============

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
		 (- (upper-bound x) (lower-bound y))))

; EXERCISE 2.09
; =============

; Addition:
; (a,b) + (c,d) = (a+c, b+d)
; width (a, b) = (b-a)/2
; width (c, d) = (d-c)/2
; width (a+c; b+d) = ((b+d) - (a+c)) / 2 =  (b-a)/2 + (d-c)/2

; Subtraction:
; (a,b) - (c,d) = (a-d, b-c)
; width (a-d, b-c) = ((a-d) - (b-c))/2 = -(b-a)/2 - (d-c)/2

; Multiplication:
; Consider three intervals: a=(1,2), b=(10,11), c=(9,10). The all have the same width
; But the width of interal a*b != width of the interval b*c. Which means that we cannot 
; calculate the width of the resulting (result of multiplication) interval if
; we know the widths of the initial intervals.

; EXERCISE 2.10
; =============

(define (spans-zero? y)
   (and (<= (lower-bound y) 0)
        (>= (upper-bound y) 0)))

(define (div-interval x y)
   (if (spans-zero? y)
       (error "Error: The denominator should not span 0.")
       (mul-interval x
                 (make-interval (/ 1.0 (upper-bound y))
                                (/ 1.0 (lower-bound y))))))

; EXERCISE 2.11
; =============

; I guess in that exercise they show us that micro-optimisation
; is npt always a good thing. I'm too lazy to test the
; two implementation for evaluation speed. Ben's version
; is too complicated for human to read anyway.

; Well, we got 9 possible cases:
; [ a, b]*[ c, d] -> ac, bd
; [ a, b]*[-c, d] -> bc, bd
; [ a, b]*[-c,-d] -> bd, ac
; [-a, b]*[ c, d] -> ad, bd
; [-a, b]*[-c, d] -> ad/bc, ac/bd
; [-a, b]*[-c,-d] -> bd, ad
; [-a,-b]*[ c, d] -> bd, ac
; [-a,-b]*[-c, d] -> bd, bc
; [-a,-b]*[-c,-d] -> ac, bd

; Now let's write a procedure

(define (complex-mul-interval x y)
  (let ((a (lower-bound x))
	(b (upper-bound x))
	(c (lower-bound y))
	(d (upper-bound y)))
    (cond ((and (> a 0) (> b 0))
	   (cond ((and (> c 0) (> d 0))
		  (make-interval (* a c) (* b d)))
		 ((and (< c 0) (> d 0))
		  (make-interval (* b c) (* b d)))
		 ((and (< c 0) (< d 0))
		  (make-interval (* b d) (* a c)))))
	  ((and (< a 0) (> b 0))
	   (cond ((and (> c 0) (> d 0))
		  (make-interval (* a d) (* a c)))
		 ((and (< c 0) (> d 0))
		  (make-interval (min (* a d) (* b c))
				 (max (* a c) (* b d))))
		 ((and (< c 0) (< d 0))
		  (make-interval (* b d) (* a d)))))
	  ((and (< a 0) (< b 0))
	   (cond ((and (> c 0) (> d 0))
		  (make-interval (* b d) (* a c)))
		 ((and (< c 0) (> d 0))
		  (make-interval (* b d) (* b c)))
		 ((and (< c 0) (< d 0))
		  (make-interval (* a c) (* b d))))))))

; EXRCISE 2.12
; ============

; Code from the textbook:

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

; New code:

(define (make-center-percent center percent-tolerance)
  (make-center-width center (* center (/ percent-tolerance 100.0))))
(define (percent i)
  (* (/ (width i) (center i)) 100.0))

; EXERCISE 2.13
; =============

; Consider we have c1, p1 and c2, p2.
; If we take only positive numbers then the upper bound of 
; the product of two intervals would be:
;
; c1(1+p1/100.0)*c2(1+p2/100.0)
; c1c2 + c1c2(p1/100.0 + p2/100.0 + p1*p2/10000.0)
;
; Since p1*p2/10000.0 is a really small number (if p1 and p2 are small enough)
; so you can approximate the percentage olerance of the product of two 
; intervals as a sum of tolerances of factors.

; Complain:

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
		(add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
		  (add-interval (div-interval one r1)
				(div-interval one r2)))))

; Let's see what we get:
(define r1 (make-interval 1 2))
(define r2 (make-interval 3 4))
(par1 r1 r2) ; -> (.5 . 2.)
(par2 r1 r2) ; -> (.75 . 1.3333333333333333)

; EXERCISE 2.14
; =============

; I'm gonna follow the instructon from the book
(div-interval r1 r1) ; -> (.5 . 2.)
(div-interval r1 r2) ; -> (.25 . .6666666666666666)
; Seems ok to me. Let's try intervals with small "percentage".
(define r3 (make-interval 10000 10001))
(define r4 (make-interval 2000 2002))
(percent (div-interval r3 r3)) ; -> 9.999499999997228e-3
(percent (div-interval r3 r4)) ; -> 05497476113264008
; Still seems ok to me.

; Let's do the substitution instead.
; 1. PAR1

(par1 r1 r2)
(div-interval (mul-interval r1 r2) ; mul -> (3 . 8)
	      (add-interval r1 r2)) ; add -> (4 . 6)
(div-interval (make-interval 3 8)
	      (make-interval 4 6)) ; div -> (.5 . 2.)
; Yes, everything is ok, now the procedure that returned the wrong result:

; 2. PAR2
(par2 r1 r2)

(let ((one (make-interval 1 1)))
    (div-interval one
		  (add-interval (div-interval one r1)     ; div one r1 -> (.5 . 1.)
				(div-interval one r2))))  ; div one r2 -> (.25 . .3333333333333333)

(add-interval (div-interval one r1)    
				(div-interval one r2)) ; evaluates to (.75 . 1.3333333333333333) (ok)

(div-interval one
		  (add-interval (div-interval one r1)     
				(div-interval one r2)))

; Well seems that procedures work just as well as we expected them to work.
; Since the formulas are mathematicaly equal there is definetly something wrong
; with one of our procedures. I believe that it is based on the fact that 
; (div-interval r1 r1) doesn't yeild 1.0 (as it supposed to due to physic rules).
; I'll get back to this problem later.

; EXERCISE 2.15
; =============

; Yes, that is true, we've already introduced at least one problem 
; with repeating variables -> R1/R1 doesn't yeald 1 as a result of division.

; EXERCISE 2.16
; =============

; Well, the wikipedia has a really huge article on interval arithmetic.
; It might be even more different field of knowledge than the whole SICP.
;
; At least i can say that there is a definition of division in that
; article and it says nothing about R1/R1 = 1. Because interval mathematic
; works with uncertainty and you can clearly see that R1/R1 can yeild 
; differnet results depending on the chances. The result of that equation is 
; definetly not 1. So Lem's problem has nothing to do with our implementation.
; 
; [a, b] ÷ [c, d] = [min (a ÷ c, a ÷ d, b ÷ c, b ÷ d), max (a ÷ c, a ÷ d, b ÷ c, b ÷ d)] 
; when 0 is not in [c, d].
;
; update (from wiki):
; 
; The so-called dependency problem is a major obstacle to the application of
;  interval arithmetic. Although interval methods can determine the range of
;  elementary arithmetic operations and functions very accurately, this is not
;  always true with more complicated functions. If an interval occurs several times 
; in a calculation using parameters, and each occurrence is taken independently 
; then this can lead to an unwanted expansion of the resulting intervals.