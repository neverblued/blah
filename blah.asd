;; (c) Дмитрий Пинский <demetrius@neverblued.info>
;; Допускаю использование и распространение согласно
;; LLGPL -> http://opensource.franz.com/preamble.html

(defpackage #:blah-system
  (:use #:common-lisp #:asdf))

(in-package #:blah-system)

(defsystem #:blah
  :description "Language framework"
  :version "0.2"
  :author "Дмитрий Пинский <demetrius@neverblued.info>"
  :licence "LLGPL"
  :depends-on (#:blackjack #:iterate)
  :serial t
  :components ((:file "package")
               (:file "blah")))
