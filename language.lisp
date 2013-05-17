;; (c) mail@neverblued.info
;; http://opensource.franz.com/license.html

(in-package #:blah)

(defvar language :*)

(defmacro in-language (language &body body)
  `(let ((language ,language))
     ,@body))

(defun check-language ()
  (unless language
    (error "Язык не определён.")))
