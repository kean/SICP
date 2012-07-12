; CHEATSHEET

; 2.2.3 Sequences as Conventional Interfaces

; Map
; ===

; > Examples
(map square (list 1 2 3 4)) ; -> (1 4 9 16)


; Filter
; ======

; > Implementation
(define (filter predicate sequence)
  (cond ((null? sequence) '())
	((predicate (car sequence))
	 (cons (car sequence)
	       (filter predicate (cdr sequence))))
	(else (filter predicate (cdr sequence)))))

; It only works with flat sequences:

; > Examples
(filter odd? (list 1 2 3 4 5)) ; -> (1 3 5)


; Accumulate
; ==========

; > Implementation
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
	  (accumulate op initial (cdr sequence)))))

; > Examples
(accumulate + 0 (list 1 2 3 4 5)) ; -> 15
(accumulate * 1 (list 1 2 3 4 5)) ; -> 120
(accumulate cons nil (list 1 2 3 4 5)) ; -> (1 2 3 4 5)


; Enumerate interval
; ==================

; > Implementation
(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ low 1) high))))

; > Example
(enumerate-interval 2 7) ; -> (2 3 4 5 6 7)


; Enumerate-tree
; ==============

; > Implementation
(define (enumerate-tree tree)
  (cond ((null? tree) '())
	((not (pair? tree)) (list tree))
	(else (append (enumerate-tree (car tree))
		      (enumerate-tree (cdr tree))))))

; > Examples
(enumerate-tree (list 1 (list 2 (list 3 4)) 5)) ; -> (1 2 3 4 5)


; Accumulate-n
; ============

; > Implementation
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      nil
      (cons (accumulate op init (map car seqs))
	    (accumulate-n op init (map cdr seqs)))))

; > Examples
(accumulate-n + 0 (list (list 1 2 3) (list 4 5 6) (list 7 8 9))) ; -> (12 15 18)


; Flatmap
; =======

; > Implementation
(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

; > Examples
(flatmap (lambda (i) (map square i))
	 (list (list 1 2 3) (list 4 5 6) (list 7 8 9))) ; -> 
; (1 4 9 16 25 36 49 64 81)
