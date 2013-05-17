;; (c) mail@neverblued.info
;; http://opensource.franz.com/license.html

(defpackage #:blah-system
  (:use #:common-lisp #:asdf))

(in-package #:blah-system)

(defsystem #:blah
  :version "0.3"
  :depends-on (#:iterate #:blackjack)
  :serial t
  :components ((:file "package")
               (:file "language")
               (:file "dictionary")
               (:file "say")
               (:file "morphing")))
