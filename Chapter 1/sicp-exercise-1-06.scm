; SICP exercise 1.6

(sqrt-iter 1 4)
(new-if (good-enough? 1 4) 1
	(sqrt-iter (improve 1 4) 4))

; Operands are evaluated before they are
; substituted to the body of new-if function

...
   (new-if (good-enough? 5/2 4) 5/2
	   (sqrt-iter (improve 5/2 4) 4))

; new-if never gets evaluated while
; sqrt-iter never stopes executing