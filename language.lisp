;; (c) Дмитрий Пинский <demetrius@neverblued.info>
;; Допускаю использование и распространение согласно
;; LLGPL -> http://opensource.franz.com/preamble.html

(in-package #:blah)

(defvar language :*)

(defmacro in-language (language &body body)
  `(let ((language ,language))
     ,@body))

(defun check-language ()
  (unless language
    (error "Язык не определён.")))
