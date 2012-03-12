Blah the language framework
===========================

Подключить словарь можно так:

```cl
(defparameter test

  ((:hello :english "Hello"
           :russian "Привет"
           :udaff "Превед")
           
   (:goose :* (morph-if :genitive ; родительный падеж
                        (russian-number* "гуся" "гусей" "гусей")
                        (russian-number* "гусь" "гуся" "гусей")))

  ))

(let ((dictionary test))
  (say :hello :in :russian))
```

или так:

```cl
(with-dictionary "/path/to/dictionary.lisp"
  (with-language :udaff (say :hello)))
```

Возлюби двух гусей!

```cl
(with-dictionary test (join "Возлюби двух " (with-morphing :genitive (say-numerous 2 :goose)) "!"))
```
