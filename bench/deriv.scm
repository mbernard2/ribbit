(define imap (lambda (f l r)
               (if (not (pair? l))
                 (reverse r)
                 (imap f (cdr l) (cons (f (car l)) r)))))

(define my-map (lambda (f l)
              (imap f l '())))

(define deriv
  (lambda (a)
    (if (not (pair? a))
      (if (eq? a 'x) 1 0)
      (if (eq? (car a) '+)
        (cons '+ (my-map deriv (cdr a)))
        (if (eq? (car a) '-)
          (cons '- (my-map deriv (cdr a)))
          (if (eq? (car a) '*)
            (cons '* (cons a (cons '+ (my-map (lambda (a) (cons '/ (cons (deriv a) (cons a '())))) (cdr a))) ))
            (if (eq? (car a) '/)
              (cons '- (cons (cons '/ (cons (deriv (cadr a)) (cons (caddr a '()))))
                             (cons '/ (cons (cadr a) (cons '* (cons (caddr a) (cons (caddr a) (cons (deriv (caddr a)) '()))))))))
              0)))))))


(define run
  (lambda ()
    (deriv '(+ (* 3 x x) (* a x x) (* b x) 5))))



(run)
