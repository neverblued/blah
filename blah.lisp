(in-package #:blah)

;; language

(defvar language :ru)

(defmacro with-language (language &body body)
  `(let ((language ,language))
     ,@body))

;; dictionary

(defvar dictionary nil)

(defun check-dictionary ()
  (unless dictionary
    (error "Словарь не найден.")))

(defun check-language ()
  (unless language
    (error "Язык не определён.")))

(defmacro with-dictionary (path &body body)
  `(let ((dictionary (load-from-file ,path)))
     (check-dictionary)
     ,@body))

;; speak

(defun say (token &optional (language language))
  (check-language)
  (check-dictionary)
  (flet ((dongle ()
           (join "[say:" token "@" (keyword-name language) "]")))
    (aif (rest (find token dictionary :key #'first :test #'equal))
         (or (awith (getf it language (getf it :*))
               (if (stringp it) it (eval it)))
             (dongle))
         (dongle))))

(defmacro speak (&rest phrasebook)
  `(case language
     ,@(group phrasebook 2)))

;; simple morphing

(defvar morphing nil)

(defmacro with-morphing (morphing &body body)
  `(let ((blah:morphing (adjoin ,morphing blah:morphing)))
     ,@body))

(defmacro with-morphings ((&rest morphings) &body body)
  `(let ((blah:morphing (append ',morphings blah:morphing)))
     ,@body))

(defmacro check-morphing (morphing)
  `(find ,morphing morphing))

(defmacro morph-if (mode-key then-value else-value)
  `(if (check-morphing ,mode-key) ,then-value ,else-value))

(defmacro morph-case (&rest clauses)
  `(cond ,@(iter (for (key value) in (group clauses 2))
                 (collect (if (eql t key)
                              `(t ,value)
                              `((check-morphing ,key) ,value))))))

;; number morphing

(defvar morph-number 0)

(defun say-numerous (quantity thing)
  (let ((morph-number quantity))
    (say thing)))

(defun russian-number (number form-1 form-2 form-5 &optional (form-1/2 form-2))
  (cond ((and (= 1 (rem number 10))
              (/= (rem number 100) 11))
         form-1)
        ((< 0 number 1)
         form-1/2)
        ((and (<= 2 (rem number 10) 4)
              (/= (rem number 100) 12))
         form-2)
        (t
         form-5)))

(defun russian-number* (form-1 form-2 form-5 &optional (form-1/2 form-2))
  (russian-number morph-number form-1 form-2 form-5 form-1/2))
