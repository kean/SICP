; SICP. Exercise 2-33.

(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) nil sequence))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1)) ; since initial is appended to the end
; of sequence when (cdr sequence) reaches nil

(define (length sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence)) ; each element in a sequence counts as 1