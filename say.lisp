;; (c) mail@neverblued.info
;; http://opensource.franz.com/license.html

(in-package #:blah)

(defun say-dongle (id language)
  (join "[say:" id "@" (keyword-name language) "]"))

(defun say (id &key (in language) (dongle t))
  (let ((language in)
        (id (typecase id
              (string id)
              (symbol (keyword-name id))
              (t (error 'type-error
                        :expected-type '(or string symbol)
                        :datum id)))))
    (check-language)
    (check-dictionary)
    (flet ((dongle ()
             (unless dongle
               (error "neither version nor dongle for ~a in ~a" id language))
             (say-dongle id language)))
      (aif (dictionary-versions id)
           (or (awith (getf it language (getf it :*))
                 (if (stringp it) it (eval it)))
               (dongle))
           (dongle)))))

(defmacro speak (&rest phrasebook)
  `(case language
     ,@(group phrasebook 2)))

(defmacro blah (&rest ids)
  `(progn ,@(iter (for id in ids)
                  (collect `(define-symbol-macro ,id
                                (say ,(symbol-name id)))))
          t))
