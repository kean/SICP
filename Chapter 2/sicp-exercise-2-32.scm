; SICP. Exercise 2.32.

(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
	(append rest (map <??> rest)))))

; Since we already got the body of the procedure we can
; easily out what should be mapped to the <rest> to get
; the proper result. Let's take a look at the substitution of (1 2 3)

; If s is null it simply returns null.

; rest <- (subsets (cdr s)) ; rest is subsets of (2 3)
; append rest (map <??> rest) ; the result is subsets of (2 3) appended to (map <??> rest)
; Apparently (map <??> rest) produces a list of lists with all combinations of (1) and all
; subsets of (2 3) including 0. So what we need is to simply append (car s) to all
; the subsets of the rest (2 3).

(define (subsets s)
  (if (null? s)
      (list '())
      (let ((rest (subsets (cdr s))))
	(append rest (map (lambda (x) (cons (car s) x)) rest)))))



