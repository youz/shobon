;;; -*- mode:lisp; package:shobon -*-

;;; forked from http://pc12.2ch.net/test/read.cgi/software/1226425897/809

(defpackage :shobon
  (:use :lisp :editor))

(in-package :shobon)

(defvar shobobon
  '("( 　 　´)""(　　 ´･)""(　 ´･ω)""(　´･ω･)" 
    "(´･ω･｀)""(･ω･｀　)""(ω･｀ 　)""(･｀ 　　)" 
    "(｀ 　 　)""( 　　　 )"))

(defun user::shobon ()
  "(�L��֥�M)���ް�"
  (interactive)
  (do ((wait 0.1) (d 1) (h 0)
       (i 0 (mod (+ i d) 10))
       (j 0 (- 25 (expt (- 4 i) 2))))
      ()
    (case (read-char-no-hang *keyboard*)
      (#\n (setq wait (max 0.01 (- wait 0.01))))
      (#\p (setq wait (min 0.15 (+ wait 0.01))))
      (#\r (setq d (- d)))
      (#\j (setq h (mod (1+ h) 4)))
      (#\q (return))
      (t (sit-for wait)
	 (minibuffer-prompt "~VT~A" (* h j) (nth i shobobon))))))
