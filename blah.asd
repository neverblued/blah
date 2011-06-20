(defpackage #:blah-system
  (:use #:common-lisp #:asdf))

(in-package #:blah-system)

(defsystem #:blah
  :serial t
  :depends-on (#:blackjack #:iter)
  :components ((:file "package")
               (:file "blah")))
