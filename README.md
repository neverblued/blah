Blah the language framework
===========================

Подключить словарь можно так:

```cl
(let ((dictionary ((:hello :english "Hello"
                           :russian "Привет"
                           :udaff "Превед")
           
                   (:goose :* (morph-if :genitive ; родительный падеж
                                        (russian-number* "гуся" "гусей" "гусей")
                                        (russian-number* "гусь" "гуся" "гусей"))))))
  (say :hello :in :russian))
```

или так:

```cl
(with-dictionary "/path/to/dictionary.lisp"
  (in-language :udaff (say :hello)))
```

Возлюби двух гусей!

```cl
(join "Возлюби двух " (with-morphing :genitive (say-numerous 2 :goose)) "!")
```
