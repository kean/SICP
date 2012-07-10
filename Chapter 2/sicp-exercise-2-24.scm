; SICP. Exercise 2-24.

(list 1 (list 2 (list 3 4)))

; We start reading this structure from left to right.
; It's list of 1 and another list which is
; list of 2 and another list ... etc.
; It's obvious how that structure can be
; represented as a box-and-pointer structure or as a tree.