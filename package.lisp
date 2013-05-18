;; (c) mail@neverblued.info
;; http://opensource.franz.com/license.html

(defpackage #:blah
  (:use #:cl #:blackjack #:iter)
  (:export #:language #:in-language
           #:dictionary #:with-dictionary #:dictionary-versions
           #:say #:speak
           #:morphing
           #:with-morphing #:with-morphings
           #:check-morphing #:morph-if #:morph-case
           #:morph-number #:russian-number #:russian-number*
           #:say-numerous
           ))
