; SICP exercise 1.12

; Assume that Pascal's triangle items are ennumerated by rows and columns
; starting with row 1. Items in row are ennumerated from left to right starting with 1 too.

(define (pascal row col)
  (if (or (= col 1)
	  (= col row))
      1
      (+ (pascal (- row 1) (- col 1))
	 (pascal (- row 1) col))))

; If numbers in Pascal's triangle are ennumerated in a sequence
; like 1, 2, 3, 4 starting with 1 we can easily convert position
; of a number to the pair of row and column.

(define (pascal-n pos)
  (define (iter row col)
    (if (> (- col row) 0)
	(iter (+ row 1) (- col row))
	(pascal row col)))
  (iter 1 pos))