;; (c) Дмитрий Пинский <demetrius@neverblued.info>
;; Допускаю использование и распространение согласно
;; LLGPL -> http://opensource.franz.com/preamble.html

(in-package #:blah)

(defparameter dictionary-packages
  '(:common-lisp :cl-blackjack :blah))

(defun update-dictionary-package ()
  (delete-package :blah-dictionary)
  (macrolet ((init-package ()
               `(defpackage #:blah-dictionary
                  (:use ,@dictionary-packages))))
    (init-package)))
                                   ;&optional (current (name-keyword
                                   ;                   (package-name *package*))))
;  (let ((dictionary-packages (adjoin current dictionary-packages)))

(update-dictionary-package)

(defvar dictionary nil)

(defun check-dictionary ()
  (unless dictionary
    (error "Словарь не найден.")))

(defmacro with-dictionary (path &body body)
  `(let ((*package* (find-package :blah-dictionary)))
     (let ((dictionary (load-from-file ,path)))
       (check-dictionary)
       ,@body)))

(defun dictionary-item (key)
  (rest (find key dictionary :key #'first :test #'equal)))
