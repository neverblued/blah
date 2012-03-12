Blah the language framework
===========================

Основные возможности
--------------------

Подключить словарь можно так:

```cl
(defparameter test

  ((:hello :en "Hello"
           :ru "Привет"
           :udaff "Превед")
           
   (:goose :* (morph-if :genitive ; родительный падеж
                        (russian-number* "гуся" "гусей" "гусей")
                        (russian-number* "гусь" "гуся" "гусей")))

  ))

(let ((dictionary test))
  (with-language :udaff (say :hello)))
```

или так:

```cl
(with-dictionary "/path/to/dictionary.lisp"
  (with-language :udaff (say :hello)))
```

Прочие возможности
------------------

Возлюби двух гусей!

```cl
(with-dictionary test (join "Возлюби двух " (with-morphing :genitive (say-numerous 2 :goose)) "!"))

```
