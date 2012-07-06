; SICP exercise 1.43

(define (repeated x n)
  (if (= n 1)
      x
      (compose x (repeated x (- n 1)))))