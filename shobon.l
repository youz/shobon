;;; -*- mode:lisp; package:shobon -*-

;;; forked from http://pc12.2ch.net/test/read.cgi/software/1226425897/809
;;;
;;; *usage*
;;; M-x shobon
;;; M-x shobon-toggle-status
;;; M-x shobon-toggle-modeline

(defpackage :shobon
  (:use :lisp :editor))

(in-package :shobon)

(defvar *shobobon*
  '("(      ÅL)""(     ÅL•)""(   ÅL•É÷)""(  ÅL•É÷•)" 
    "(ÅL•É÷•ÅM)""(•É÷•ÅM  )""(É÷•ÅM   )""(•ÅM     )" 
    "(ÅM      )""(        )"))

(defvar *status-timer* nil)
(defvar *mode-line-timer* nil)
(defvar *mode-line-original* nil)

(defvar *wait* 0.1)
(defvar *direction* 1)
(defvar *shaki-n* nil)

(defun get-face (idx)
  (let ((face (nth idx *shobobon*)))
    (if *shaki-n*
	(map 'string (lambda (c) (case c (#\ÅM #\ÅL) (#\ÅL #\ÅM) (t c))) face)
      face)))

(defun reset-timer (timer)
  (when timer
    (stop-timer timer)
    (start-timer *wait* timer)))

(defun user::shobon ()
  "(ÅL•É÷•ÅM)ºÆŒﬁ∞›"
  (interactive)
  (do ((i 0 (mod (+ i *direction*) 10))
       (h 0) (j 0 (- 25 (expt (- 4 i) 2))))
      ()
    (case (read-char-no-hang *keyboard*)
      (#\n
       (setq *wait* (max 0.01 (- *wait* 0.01)))
       #0=(reset-timer *status-timer*)
       #1=(reset-timer *mode-line-timer*))
      (#\p (setq *wait* (min 0.15 (+ *wait* 0.01))) #0# #1#)
      (#\r (setq *direction* (- *direction*)))
      (#\j (setq h (mod (1+ h) 4)))
      (#\s (setq *shaki-n* (not *shaki-n*)))
      (#\q (return))
      (t (sit-for *wait*)
	 (minibuffer-prompt "~VT~A" (* h j) (get-face i))))))

(defun user::shobon-toggle-status ()
  (interactive)
  (if *status-timer*
      (progn
	(stop-timer *status-timer*)
	(setq *status-timer* nil))
    (let ((i 0))
      (labels ((msg ()
		 (setq i (mod (+ i *direction*) 10))
		 (message "~A" (get-face i))))
	(start-timer *wait* (setq *status-timer* #'msg))))))

(defun user::shobon-toggle-modeline ()
  (interactive)
  (if *mode-line-timer*
      (progn
	(stop-timer *mode-line-timer*)
	(setq *mode-line-timer* nil
	      mode-line-format *mode-line-original*)
	(refresh-screen))
    (let ((i 0))
      (labels ((update ()
		 (setq i (mod (+ i *direction*) 10))
		 (setq mode-line-format
		       (concat *mode-line-original* "    " (get-face i)))
		 (refresh-screen)))
	(setq *mode-line-original* mode-line-format
	      *mode-line-timer* #'update)
	(start-timer *wait* *mode-line-timer*)))))

(provide "shobon")
