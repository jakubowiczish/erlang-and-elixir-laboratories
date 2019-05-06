## Pollution
- Utwórz nowy moduł o nazwie pollution, który będzie zbierał i przetwarzał dane ze stacji mierzących jakość powietrza. 
- Moduł powinien przechowywać:
  - informacje o stacjach pomiarowych,
  - współrzędne geograficzne,
  - nazwy stacji pomiarowych,
  - zmierzone wartości pomiarów, np stężenia pyłów PM10, PM2.5 czy wartości temperatury (wraz z datą i godziną pomiaru).

- Nie powinno być możliwe:
  - dodanie dwóch stacji pomiarowych o tej samej nazwie lub tych samych współrzędnych;
  - dodanie dwóch pomiarów o tych samych:
  - współrzędnych,
  - dacie i godzinie,
  - typie (PM10, PM2.5, temperatura, …);
  - dodanie pomiaru do nieistniejącej stacji.

- Zaprojektuj strukturę danych dla przechowywania takich informacji (jest przynajmniej kilka dobrych rozwiązań tego problemu).

- Zaimplementuj funkcje w module pollution:
  - createMonitor/0 - tworzy i zwraca nowy monitor zanieczyszczeń;
  - addStation/3 - dodaje do monitora wpis o nowej stacji pomiarowej (nazwa i współrzędne geograficzne), zwraca zaktualizowany monitor;
  - addValue/5 - dodaje odczyt ze stacji (współrzędne geograficzne lub nazwa stacji, data, typ pomiaru, wartość), zwraca zaktualizowany monitor;
  - removeValue/4 - usuwa odczyt ze stacji (współrzędne geograficzne lub nazwa stacji, data, typ pomiaru), zwraca zaktualizowany monitor;
  - getOneValue/4 - zwraca wartość pomiaru o zadanym typie, z zadanej daty i stacji;
  - getStationMean/3 - zwraca średnią wartość parametru danego typu z zadanej stacji;
  - getDailyMean/3 - zwraca średnią wartość parametru danego typu, danego dnia na wszystkich stacjach;

- W funkcjach używaj następujących typów i formatów danych:
  - do przechowywania dat użyj struktur z modułu calendar (zob. calendar:local_time(). ),
  - współrzędne geograficzne to para (krotka) liczb,
  - nazwy, typy to ciągi znaków.

- Przetestuj działanie modułu.
  - P = pollution:createMonitor().
  - P1 = pollution:addStation(„Aleja Słowackiego”, {50.2345, 18.3445}, P).
  - P2 = pollution:addValue({50.2345, 18.3445}, calendar:local_time(), „PM10”, 59, P1).
  - P3 = pollution:addValue(„Aleja Słowackiego”, calendar:local_time(), „PM2,5”, 113, P2).

- Zabezpiecz moduł pollution - będzie on potrzebny na następnych zajęciach.

## Zadanie domowe
- Dokończ moduł pollution.
- Napisz testy do modułu pollution z wykorzystaniem EUnit. - to zrobimy później
- Niespodzianka :)
