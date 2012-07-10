; SICP. Exercise 2-36.

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      nil
      (cons (accumulate op init <??>)
	    (accumulate-n op init <??>))))

; What do we see. Seqs is supposed to be the sequence of sequences,
; which means that there are only two "layers". That makes our task
; pretty simple. 

; The first call to  accumulate is gonna accumulate the first elements
; of the elements of initial sequence. We need to write the procedure
; that collects thos elements. I guess using map to produce 
; this sequence is the best option:

(map car seqs) 

; The procedure that returns the rest of the sequence would be:

(map cdr seqs)

; Which results into procedure:

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      nil
      (cons (accumulate op init (map car seqs))
	    (accumulate-n op init (map cdr seqs)))))

