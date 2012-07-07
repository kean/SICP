; SICP. Exercise 1-03.

; Code from the previous exercise:
(define (make-point x y)
  (cons x y))
(define (x-point p)
  (car p))
(define (y-point p)
  (cdr p))

(define (make-segment start-point end-point)
  (cons start-point end-point))
(define (start-segment s)
  (car s))
(define (end-segment s)
  (cdr s))

; Perimeter and area procedures:

(define (perimeter rect)
  (* 2 (+ (height rect) (width rect))))
(define (area rect)
  (* (height rect) (width rect)))

; There are various ways to implement rectangles, height and weight.

; FIRST IMPLEMENTATION
; ====================
; First thing that comes to mind is to represent rectangle as a pair
; of two sides (width and height). This is the easiest implementation 
; if talking about calculating rectangle's width and height.
; We assume that we use only postive x and y coordinates.
; We consider width as a segment which start and end points are closest 
; points to the х-axis and the side opposite to that segment.

(define (make-rect width-seg height-seg)
  (cons width-seg height-seg))
(define (rect-width-seg rect)
  (car rect))
(define (rect-height-seg rect)
  (cdr rect))

; Now we only need length function to implement height and width

(define (length seg) ; It's calculated with the help of Pythagoras theorem as sqrt(dx^2 + dy^2)
  (let ((dx (- (x-point (end-segment seg))
	       (x-point (start-segment seg))))
	(dy (- (y-point (end-segment seg))
	       (y-point (start-segment seg)))))
    (sqrt (+ (square dx) (square dy)))))
(define (height rect)
  (length (rect-height-seg rect)))
(define (width rect)
  (length (rect-width-seg rect)))

; Let's test that implementation on the simplified example
(define rect (make-rect (make-segment (make-point 1 1)
				      (make-point 3 1))
			(make-segment (make-point 1 1)
				      (make-point 1 5))))
(area rect)
;Value: 8
(perimeter rect)
;Value: 12

; SECOND IMPLEMETATION
; ====================
; Rectangle as 4 points
; Negative x and y coordinates are allowed
; Angles of rectangle are ennumerated clockwise.
; Point a is the closest point to (-∞, -∞)

(define (make-rect a b c d)
  (cons (cons a b) (cons c d)))
(define (rect-a-point r)
  (car (car r)))
(define (rect-b-point r)
  (cdr (car r)))
(define (rect-c-point r)
  (car (cdr r)))
(define (rect-d-point r)
  (cdr (cdr r)))

; Due to the convention of naming angles of rectangle we 
; consider width of the rectangle as a length of side AD or BC
; and height as a length of AB or CD
(define (width rect)
  (length (make-segment (rect-a-point rect)
			(rect-d-point rect))))
(define (height rect)
  (length (make-segment (rect-a-point rect)
			(rect-b-point rect))))

; And let's make (length x) function more detached of 
; segment implementation. (abs is added)
(define (length seg) ; 
  (let ((dx (abs (- (x-point (end-segment seg))
		    (x-point (start-segment seg)))))
	(dy (abs (- (y-point (end-segment seg))
		    (y-point (start-segment seg))))))
    (sqrt (+ (square dx) (square dy)))))

; Let's test that implementation on the simplified example
(define rect (make-rect (make-point 1 1)
			(make-point 3 1)
			(make-point 1 1)
			(make-point 1 5)))
(area rect)
;Value: 8
(perimeter rect)
;Value: 12