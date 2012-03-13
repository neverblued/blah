;; (c) Дмитрий Пинский <demetrius@neverblued.info>
;; Допускаю использование и распространение согласно
;; LLGPL -> http://opensource.franz.com/preamble.html

(in-package #:blah)

;; language

(defvar language :ru)

(defmacro with-language (language &body body)
  `(let ((language ,language))
     ,@body))

;; package

(defparameter dictionary-packages
  '(:common-lisp :cl-blackjack :blah))

(defun update-dictionary-package ();&optional (current (name-keyword
                                   ;                   (package-name *package*))))
  (delete-package :blah-dictionary)
;  (let ((dictionary-packages (adjoin current dictionary-packages)))
    (macrolet ((init-package ()
                 `(defpackage #:blah-dictionary
                    (:use ,@dictionary-packages))))
      (init-package)));)

(update-dictionary-package)

;; dictionary

(defvar dictionary nil)

(defun check-dictionary ()
  (unless dictionary
    (error "Словарь не найден.")))

(defun check-language ()
  (unless language
    (error "Язык не определён.")))

(defmacro with-dictionary (path &body body)
  `(let ((*package* (find-package :blah-dictionary)))
     (let ((dictionary (load-from-file ,path)))
       (check-dictionary)
       ,@body)))

(defun dictionary-item (key)
  (rest (find key dictionary :key #'first :test #'equal)))

;; speak

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
