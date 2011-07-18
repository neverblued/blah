(defpackage #:blah-system
  (:use #:common-lisp #:asdf))

(in-package #:blah-system)

(defsystem #:blah
  :serial t
  :depends-on (#:blackjack #:iterate)
  :components ((:file "package")
               (:file "blah")))
