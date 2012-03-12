;; (c) Дмитрий Пинский <demetrius@neverblued.info>
;; Допускаю использование и распространение согласно
;; LLGPL -> http://opensource.franz.com/preamble.html

(defpackage #:blah
  (:use #:cl #:blackjack #:iter)
  (:export #:language #:with-language
           #:dictionary #:with-dictionary
           #:say #:speak
           #:morphing
           #:with-morphing #:with-morphings
           #:check-morphing #:morph-if #:morph-case
           #:morph-number #:russian-number #:russian-number*
           #:say-numerous
           ))
