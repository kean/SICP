; SICP. Exercise 2-37.

; Here is the complete procedure from the textbook:
(define (dot-product v w)
  (accumulate + 0 (map * v w)))
; And accumulate and accumulate-n procedures:
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
	  (accumulate op initial (cdr sequence)))))
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op init (map car seqs))
	    (accumulate-n op init (map cdr seqs)))))

; Now i'm gonna finish other matrix operations.

; 1. matrix-*-vector
; Basically what we see here is that the i-th element of the
; resulting vector is the dot-product of the initial vector v
; and i-th row of the matrix. Which results into the procedure:
(define (matrix-*-vector m v)
  (map (lambda (x) (dot-product v x)) m))

; 2. transpose matrix
; Transpose "turns" the matrix so that i,j element of the initial matrix
; becomes j,i element of the resulting matrix. Well, it's pretty easy since we
; already have an accumulate-n procedure. Each step we take all the n-th elements 
; from the subsequences and construct a list of them.
(define (transpose mat)
  (accumulate-n cons '() mat))

; 3. matrix-*-matrix.
; The product of matrix mxn and matrix nxy is the matrix mxy. The 
; i, j element of the resulting matrix is basically the dot-product
; of the i-th row of the left matrix and the j-th column of the right matrix.
(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (x) (matrix-*-vector cols x)) m)))

; Let's do some testing:
(define matrix-1 (list (list 1 2)
		  (list 3 4)
		  (list 5 6)
		  (list 7 8)))
(define matrix-2 (list (list 1 2 3 4)
		       (list 5 6 7 8)))
(define matrix-3 (list (list 1)))
(define matrix-4 (list (list 1 2 3 4 5)))
(define vector-1 (list 1 2 3 5))
(define vector-2 (list 4 3 2 1))
(define vector-3 (list 2 3))

; 1.
(dot-product vector-1 vector-2)
;Value: 21
; Check: 1*4 + 2*3 + 3*2 + 5*1 = 21

; 2. 
(matrix-*-vector matrix-1 vector-3)
; Value 18: (8 18 28 38)
; Check: (2*1 + 3*2) = 8
; (2*3 + 3*4) = 18
; (2*5 + 2*6) = 28
; etc

; 3.
(matrix-*-matrix matrix-1 matrix-2) ;->
; (11 14 17 20) 
; (23 30 37 44) 
; (35 46 57 68) 
; (47 62 77 92)

; Check:
;      ( 1  2  3  4)
;      ( 5  6  7  8)
; (1 2) 11 14 17 20 
; (3 4) 23 30 37 44
; (5 6) 35 46 57 68
; (7 8) 47 62 77 92