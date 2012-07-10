; SICP. Exercise 2-27.

; Reverse procedure from exercise 2-18:
(define (reverse items)
 (if (null? items)
     items
     (append (reverse (cdr items)) (list (car items)))))

(define (deep-reverse items)
  (cond ((null? items) items)
	((pair? (car items))
	 (append (deep-reverse (cdr items)) (list (deep-reverse (car items)))))
	(else
	 (append (deep-reverse (cdr items)) (list (car items))))))

(define x (list (list 1 2) (list 3 4)))

; Let's use substituition to prove that it works jist fine.
(deep-reverse x)

(cond ((null? x) x)
      ((pair? (car x)) ; (car x) -> (1 2)
       (append (deep-reverse (cdr x)) (list (deep-reverse (car x)))))
      (else
       (append (deep-reverse (cdr x)) (list (car items)))))

(append (deep-reverse (cdr x)) (list (deep-reverse (car x))))

; Now let's consider two deep-reverse recursive calls:

(cdr x) ; -> ((3 4)) (list one one element which itself is a list
(deep-reverse (cdr x))
(car (cdr x)) ; -> (3 4) 
(append (deep-reverse (cdr (cdr x))) (list (deep-reverse (car (cdr x)))))
(cdr (cdr x)) ; -> null
(append () (list (deep-reverse (car (cdr x)))))
(deep-reverse (car (cdr x))) ; -> (4 3)

; The same way evaluates the second part. 
; That solution is not that concise. 

; There is a silutions that use map procedure for a great good:

(define (deep-reverse items)
  (if (pair? items)
      (reverse (map deep-reverse items))
      items))