; SICP. Exercise 2-29.

(define (make-mobile left right)
  (list left right))
(define (make-branch length structure)
  (list length structure))

; A

(define (left-branch x)
  (car x))
(define (right-branch x)
  (car (cdr x)))
(define (branch-length b)
  (car b))
(define (branch-structure b)
  (car (cdr b)))

; B

(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))
(define (branch-weight branch)
  (let ((struct (branch-structure brach))
	(if (not (pair? struct))
	    struct
	    (total-weight struct)))))

; C

; Well, now i can trully say that "wishful thinking" 
; and Lisp idea of telling what the stuff is by
; telling what is what it is constructed from are really 
; powerful

(define (branch-torque b)
  (* (branch-length b)
     (branch-weight b)))
(define (balanced-branch? b)
  (if (pair? (branch-structure b))
      (balanced-mobile? (branch-structure b))
      #t))
(define (balanced-mobile? m)
  (and (= (branch-torque (left-branch m))
	  (branch-torque (right-branch m)))
       (balanced-branch? (left-branch m))
       (balanced-branch? (right-branch m))))

; D

; Since we've implemented abstraction layer from
; realisation of make-mobile and make-branch
; we only need to change two procedures from part A
; a little bit:

(define (right-branch x)
  (cdr x))
(define (branch-structure b)
  (cdr b))

; The authors made a great job showing us
; how you are supposed to implement lightly-coupled systems.