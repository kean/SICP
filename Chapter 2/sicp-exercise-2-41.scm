; SICP. Exercise 2-41.

; We already have a procedure to generate unique-pairs. All we need
; to do next is create triples 

; Well, it's easy as pie to implement a procedure that generate triples in C:

; struct triple {
;  	int i;
;  	int j;
;   	int k;
; };

; void generate_triples(int n)
; {
;     struct triple arr[200];
;     int pos_arr;
;     int i, j, k;
;     for (i = 1; i < n; i++) {
;         for (j = (i+1); j < n; j++) {
;             for (k = (j+1); k < n; k++) {
;                 struct triple tmp = { i, j, k };
;                 arr[pos_arr++] = tmp;
;             }
;         }
;     }
;  	
;     i = 0;
;     while (i < pos_arr) {
;         printf("(%d, %d, %d)\n", arr[i].i, arr[i].j, arr[i].k);
;         i++;
;     }
; }	

; In scheme it can be implemented like this:

(define (ordered-triples n)
   (flatmap (lambda (i)
      (flatmap (lambda (j)
         (map (lambda (k)
                (list i j k))
              (enumerate-interval 1 (- j 1))))
       (enumerate-interval 1 (- i 1))))
    (enumerate-interval 1 n)))

(define (triple-sum-equals-s? triple s)
  (= s (accumulate + 0 triple)))

