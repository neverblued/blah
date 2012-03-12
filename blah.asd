;; (c) Дмитрий Пинский <demetrius@neverblued.info>
;; Допускаю использование и распространение согласно
;; LLGPL -> http://opensource.franz.com/preamble.html

(defpackage #:blah-system
  (:use #:common-lisp #:asdf))

(in-package #:blah-system)

(defsystem #:blah
  :serial t
  :depends-on (#:blackjack #:iterate)
  :components ((:file "package")
               (:file "blah")))
