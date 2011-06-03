(in-package #:blah)

;; language

(defvar language :ru)

(defmacro with-language (language &body body)
  `(let ((language ,language))
     ,@body))

;; dictionary

(defvar dictionary)

(defun load-dictionary (lang)
  (load-from-file (format nil "~a/~a.lisp" dictionary lang)))

;; speak

(defun say (what &optional (lang language))
  (let* ((ln (string-downcase (symbol-name lang)))
         (dict (load-dictionary ln)))
    (if dict
        (aif (find-assoc what dict :test #'string=)
             (eval it)
             (join "[say:" what "@" ln "]"))
        (join "[say@" ln "]"))))

(defmacro speak (&rest phrasebook)
  `(case language
     ,@(group phrasebook 2)))
