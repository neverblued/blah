;; (c) mail@neverblued.info
;; http://opensource.franz.com/license.html

(in-package #:blah)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defparameter dictionary-use-packages
    '(:common-lisp :blackjack :blah)))

(defmacro define-dictionary-package ()
  `(defpackage #:blah-dictionary
     (:use ,@dictionary-use-packages)))

;; @TODO: add packages

;;&optional (current (name-keyword
;;                   (package-name *package*))))
;;  (let ((dictionary-packages (adjoin current dictionary-packages)))

(defun update-dictionary-package ()
  (awhen (find-package '#:blah-dictionary)
    (delete-package it))
  (define-dictionary-package))

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

(defun blah-dictionary::item-id (item)
  (first item))

(defun blah-dictionary::item-versions (item)
  (rest item))

(defun dictionary-versions (id)
  (awhen (find id dictionary :test #'equal :key #'blah-dictionary::item-id)
    (blah-dictionary::item-versions it)))
