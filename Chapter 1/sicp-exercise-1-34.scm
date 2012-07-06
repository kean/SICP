; SICP exercise 1.34

(define (f g)
  (g 2))

; Let's substitute f as an argument to f (f f)

(f f)
(f 2)
(2 2)
; We would get an error: 2 isn't not a procedure it cannot by applied to argument 2

; Let's check this

(f f)
;The object 2 is not applicable.