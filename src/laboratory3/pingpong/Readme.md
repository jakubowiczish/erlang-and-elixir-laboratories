## Ping - Pong
- Napisz moduł pingpong, który będzie eksportował funkcje:
  - start/0, która utworzy 2 procesy i zarejestruje je pod nazwami ping i pong,
  - stop/0, która zakończy oba procesy,
  - play/1, która wyśle wiadomość z liczbą całkowitą N do procesu ping.

- Po otrzymaniu wiadomości, proces ping ma rozpocząć wymianę N wiadomości z procesem pong. 
- Przy odebraniu każdej wiadomości procesy mają wypisać na standardowe wyjście informację o przebiegu odbijania.
- Dla zwiększenia czytelności działania warto użyć funkcji timer:sleep(Milisec).
- Procesy ping i pong powinny samoczynnie kończyć działanie po 20 sekundach bezczynności.

- Zmodyfikuj proces ping by przechowywał stan - sumę wszystkich liczb z komunikatów, które otrzymał. 
- Dodaj tę sumę do informacji wypisywanej po odebraniu komunikatu.