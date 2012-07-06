; SICP exercise 1.33

(define (filtered-accumulate filter
			     combiner
			     null-value
			     term
			     a next b)
  (cond ((> a b) null-value)
	((filter a) (combiner (term a)
			      (filtered-accumulate filter combiner term
						   null-value term (next a) next b)))
	(else (filtered-accumulate filter combiner term
				   null-value term (next a) next b))))

(define (sum-squares-of-primes a b)
  (filtered-accumulate prime?
		       +
		       0
		       square
		       a (lambda (x) (+ 1 x)) b))

(define (product-pos-int b)
  (define (take? n)
    (= (gcd(n, b)) 1))
  (filtered-accumulate take?
		       *
		       1
		       (lambda (x) x)
		       1 (lambda (x) (+ 1 x)) (- b 1)))
		       
  
		       