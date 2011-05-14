(in-package #:blah)

(defvar dictionary)

(defun load-dictionary (lang)
  (load-from-file (format nil "~a/~a.lisp" dictionary lang)))

(defun say (what &optional (lang :ru))
  (let* ((ln (string-downcase (symbol-name lang)))
         (dict (load-dictionary ln)))
    (if dict
        (aif (find-assoc what dict :test #'string=)
             it
             (join "[say:" what "@" ln "]"))
        (join "[say@" ln "]"))))
