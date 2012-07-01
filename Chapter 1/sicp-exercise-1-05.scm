; SICP exercise 1-5

(define (p) (p))
(define (test x y)
  (if (= x 0) 0 y))

; 1) Applicative-order evaluation:
;
; (test 0 (p))  ; (p) -> (p)        
; (test 0 (p))
; 
; Operator and operands are evaluated first.
; The second operand (p) recursively calls itself and never stops evaluating.


; 2) Normal-order evaluation:
;
; (test 0 (p))
; (if (= 0 0) 0 (p))
; 0
;
; Interpreter substitutes operand expression for the second parameter.
; Predicate (= 0 0) yeilds #t and the returned value is 0.
; (p) never gets evaluated.