;; (c) mail@neverblued.info
;; http://opensource.franz.com/license.html

(in-package #:blah)

(defun say (token &key (in language) (dongle t))
  (let ((language in))
    (check-language)
    (check-dictionary)
    (flet ((dongle ()
             (when dongle
               (join "[say:" token "@" (keyword-name language) "]"))))
      (aif (dictionary-item token)
           (or (awith (getf it language (getf it :*))
                 (if (stringp it)
                     it
                     (eval it)))
               (dongle))
           (dongle)))))

(defmacro speak (&rest phrasebook)
  `(case language
     ,@(group phrasebook 2)))
