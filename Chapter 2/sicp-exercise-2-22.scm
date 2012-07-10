; SICP. Exercise 2.22.

; square-list produces list in the reverse order because 
; is reads the initial list from the beggining and
; cons the result elements to the beginning of the answer-list.
; So the first number in items becomes last number in answer.

; It's wrong because it produces not the list but 
; some weird hierarchical structure like. 
; Let's substitute (square-list (list 1 2 3))
(iter (list 1 2 3) nil)
(iter (list 2 3) (() . 1)) ; pseudocode 
(iter (list 3) ((() . 1) . 6)))
(iter () (((() . 1) . 6) . 9))
; It looks like reverse list that could be constructed this way
(define l (cons (cons (cons () 1) 6) 9))
; We still can get the result, but it's defenitly not what we expected.
(cdr (cal l)) -> 6