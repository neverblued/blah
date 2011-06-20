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
         (or (eval (getf it language (getf it :*)))
             (dongle))
         (dongle))))

(defmacro speak (&rest phrasebook)
  `(case language
     ,@(group phrasebook 2)))

(defvar morphing nil)

(defmacro with-morphing (morphing &body body)
  `(let ((morphing (adjoin ,morphing morphing)))
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
