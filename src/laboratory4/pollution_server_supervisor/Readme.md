## Laboratorium nr 4 - wzorce projektowe i OTP

Przebieg zajęć

Odporność na awarie

Dodaj do modułu pollution_server funkcję crash/0, która spowoduje wykonanie niepoprawnej operacji arytmetycznej w procesie serwera.

Napisz moduł pollution_server_sup, który będzie startował pollution_server i restartował go po awarii.

## Wzorce OTP

Napisz moduł pollution_gen_server, który będzie implementował serwer usługi oparty o moduł pollution z poprzednich zajęć, 
korzystającą z **wzorca projektowego OTP gen_server.** 

Powinien on udostępniać przynajmniej funkcje:
```erlang
start/0,

stop/0,

addStation/2,

addValue/4,

getOneValue/3
```

… pozostałe funkcje modułu pollution w miarę dostępnego czasu, ale wcześniej:

- Dodaj do interfejsu serwera funkcję crash/0, która spowoduje wykonanie niepoprawnej operacji arytmetycznej w procesie serwera.
 
- Sprawdź, czy serwer działa po jej wywołaniu.
 
- Utwórz moduł nadzorujący serwer przy pomocy wzorca supervisor, który odtworzy serwer w przypadku jego niespodziewanego zakończenia.

- Sprawdź teraz działanie funkcji crash/0.

- Co dzieje się z danymi w przypadku awarii serwera? Spróbuj naprawić to zjawisko.
