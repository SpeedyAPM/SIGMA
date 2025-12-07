# System Identyfikacji Graczy i Monitoringu Aktywności (SIGMA)

## Opis projektu
- Cel: zapewnienie legalności, przejrzystości i bezpieczeństwa rynku zakładów i kasyn online w Polsce poprzez scentralizowaną kontrolę graczy, operatorów oraz źródeł ruchu internetowego.
- Problem: brak jednego źródła prawidłowych danych o aktywności graczy i operatorów oraz trudność w wykrywaniu nielegalnych reklam/źródeł ruchu.
- Rozwiązanie: zestaw współpracujących modułów backend/frontend, które integrują się z rejestrami publicznymi, operatorami i źródłami ruchu. Projekt składa się z dwóch podprogramów:
  - `badhazard-main` — serwer analizujący ruch i wykrywający nielegalne reklamy (Traffic + Wyszukiwanie Kasyn Nielegalnych).
  - `BydgoszczKAS-flutterflow` — aplikacja administracyjna do monitorowania, skanowania podmiotów i wizualizacji danych (Frontend + część Regulacyjna/Raportowa).
![screen2](https://github.com/user-attachments/assets/4da085e6-3fe1-4008-a59a-2f6856037d96)
![screen1](https://github.com/user-attachments/assets/a13081d6-1622-4ba3-961e-2b5110ea2912)
![screen6](https://github.com/user-attachments/assets/0b2b92b7-d87d-499d-88b0-d53847ddb1e8)
![screen5](https://github.com/user-attachments/assets/2f00d8d0-bba6-4f1b-8a94-e5f6bb244c7a)
![screen4](https://github.com/user-attachments/assets/25e0edac-df0c-4307-b602-6a4ba55d9de2)
![screen3](https://github.com/user-attachments/assets/34a1544a-826c-4fde-8d56-24ff763e456e)

## Moduły systemu
  Zaimplementowane:
  - Moduł Regulacyjny: audyty RTP, weryfikacja dokumentów/regulaminów (AI/NLP), zgodność językowa.
  - Moduł Ruchu Sieciowego (Traffic): referer/UTM, analiza słów kluczowych, zrzuty ekranów (Puppeteer), automatyczne raporty.
  Do wdrożenia:
  - Moduł Graczy: centralny rejestr graczy, historia działań, ocena ryzyka, KYC/RG.
  - Moduł Operatorów: nadzór nad GGR/NGR/RTP, licencje i certyfikaty, systemy płatnicze.
  - Moduł Bezpieczeństwa: KYC/AML, lista zbanowanych, identyfikacja urządzeń/IP/VPN/TOR, ochrona DDoS.
  - Moduł Wyszukiwania Kasyn Nielegalnych: crawler, identyfikacja mirrorów, blokowanie DNS/Cloudflare, listy zgłoszeń.

## Założenia projektu
- Centralizacja danych o aktywności graczy i operatorów oraz źródłach ruchu.
- Zgodność z polskim prawem hazardowym; podejście „privacy by design”.
- Zrzuty ekranów oraz logi ruchu dla źródeł oznaczonych jako podejrzane; archiwizacja w formacie JSON Lines.
- Integracja frontend–backend: aplikacja `BydgoszczKAS-flutterflow` korzysta z API `badhazard-main` oraz Firestore do prezentacji i analiz.

## Architektura podprogramów
- `badhazard-main` (Node.js/Express, Puppeteer)
  - Endpointy:
    - `POST /api/log-visit` — przyjęcie wizyty, klasyfikacja podejrzeń, ewentualny zrzut ekranu. Implementacja: `badhazard-main/index.js:42`.
    - `GET /api/logs` — odczyt znormalizowanych wpisów z filtrowaniem/paginacją. Implementacja: `badhazard-main/index.js:140`, pomocniczo `badhazard-main/lib/logReader.js:31`.
    - `GET /api/stats` — statystyki łączne, źródła, oś czasu. Implementacja: `badhazard-main/index.js:153`, logika `badhazard-main/lib/logReader.js:144`.
    - `GET /export` — eksport pełnych logów `visits.log` w JSON. Implementacja: `badhazard-main/index.js:165`.
  - Snippet osadzalny: `badhazard-main/intergracja/snippet/tracker.js` — kolekcjonuje `timestamp/location/referer/utm`, wykrywa słowa kluczowe (bonus/free spin/bez podatku/…), rozpoznaje podejrzane UA (VPN/TOR) i wysyła `POST /api/log-visit`.
  - Przechowywanie: `visits.log` (JSONL) + katalog `screenshots/` dla PNG zrzutów.
  - Cel demonstracyjny: moduł wizualizuje raportowanie poprzez `https://badhazard.mipsdeb.online/logs.html` oraz udostępnia eksport przez API `https://badhazard.mipsdeb.online/export`, z którego korzysta aplikacja `BydgoszczKAS-flutterflow`.
  - Przykład integracji: w `badhazard-main/intergracja/` znajdują się przykłady implementacji po stronie operatora (folder `snippet`) oraz po stronie administracji skarbowej (folder `server`).
- `BydgoszczKAS-flutterflow` (Flutter, Firebase)
  - Ekrany: Logowanie administratora, Dashboard, Skanuj Podmiot, Historia/Waiting.
  - Dane: kolekcja Firestore `podmioty` (np. `Lp/KRS/Status/Ostatniskan/Alerty/Nazwapodmiotu/…`). Implementacja modelu: `BydgoszczKAS-flutterflow/lib/backend/schema/podmioty_record.dart:11`.
  - Integracje: wyświetlanie logów z `badhazard-main` przez `GET https://badhazard.mipsdeb.online/export` (`BydgoszczKAS-flutterflow/lib/backend/api_requests/api_calls.dart:15`), wsparcie Crashlytics/Analytics/Auth.

## Technologie
- Backend: `Node.js (Express)`, `Puppeteer`, `MongoDB`/`PostgreSQL` (opcjonalnie), `Axios/Cheerio` (crawler/parser — w razie potrzeby).
- Frontend: `Flutter` (projekt FlutterFlow), `Firebase` (Auth, Firestore, Analytics, Crashlytics), własny motyw (`ff_theme`).
- Monitorowanie: `Grafana + Prometheus` (opcjonalnie), raporty PDF/JSON.
- Przechowywanie zrzutów: lokalnie lub `AWS S3`.

## Instrukcja instalacji i uruchomienia
- Wymagania wspólne
  - System z `Node.js 18+` oraz przeglądarką `Chromium/Chrome` dla Puppeteer.
  - Środowisko `Flutter` (kanał `stable`) i `Dart SDK` dla aplikacji.
  - Dostęp do projektu Firebase (web/mobile) — pliki konfiguracyjne są dołączone (`google-services.json`, `GoogleService-Info.plist`).
- `badhazard-main`
  - Instalacja zależności:
    - `cd badhazard-main`
    - `npm i`
  - Uruchomienie serwera:
    - `node index.js`
    - Adres: `http://localhost:3000`
  - Opcjonalnie przez PM2: `pm2 start ecosystem.config.js`
  - Podgląd logów: otwórz `badhazard-main/public/logs.html` serwowane z serwera.
  - Osadzenie snippet-u na stronie źródłowej: umieść i serwuj `intergracja/snippet/tracker.js`; domyślny endpoint to `/api/log-visit`, można nadpisać przez `BadhazardConfig.endpoint`.
- `BydgoszczKAS-flutterflow`
  - Instalacja zależności:
    - `cd BydgoszczKAS-flutterflow`
    - `flutter pub get`
  - Uruchomienie (web):
    - `flutter run -d chrome`
  - Uruchomienie (Android/iOS): standardowa konfiguracja `flutter run` wraz z odpowiednimi plikami usług Firebase.

## Przykłady wyników
- Log JSONL (wycinek):
  - `{"timestamp":"2025-12-07T08:29:45.123Z","location":"https://badhazard.mipsdeb.online/efortuna_fake_clone.html","referer":"https://badhazard.mipsdeb.online/","utm":{"source":"brak","campaign":"brak","medium":"brak"},"suspicious":true,"screenshotFilename":"/screenshots/screenshot_1765052109315_http_127_0_0_1_3000_fake_ad_landing_html.png"}`
- Zrzuty ekranów i podglądy:
  - `badhazard-main/public/images/123.png`
  - `badhazard-main/public/images/456.png`
- Widok aplikacji (Flutter):
  - `BydgoszczKAS-flutterflow/assets/images/chart1.jpeg`
  - `BydgoszczKAS-flutterflow/assets/images/KAS_MS_logo1.png`

## Dodatkowa dokumentacja
- Szczegóły `badhazard-main`: `badhazard-main/README.md`, integracja: `badhazard-main/intergracja/server/README.md` oraz `badhazard-main/intergracja/snippet/README.md`.
- Projekt Flutter: `BydgoszczKAS-flutterflow/README.md`.
- Implementacje kluczowe:
  - Logika eksportu i API: `badhazard-main/index.js:140`, `badhazard-main/index.js:153`, `badhazard-main/index.js:165`.
  - Odczyt i normalizacja logów: `badhazard-main/lib/logReader.js:31`, `badhazard-main/lib/logReader.js:144`.

## Uwaga bezpieczeństwa
- Klucze i identyfikatory Firebase do aplikacji klienckiej są publiczne z założenia — uprawnienia dostępu do danych kontroluje konfiguracja reguł Firestore/Storage oraz zabezpieczenia na backendzie.
- Nie przechowuj w repozytorium sekretów serwerowych (tokeny, hasła, klucze prywatne); używaj zmiennych środowiskowych i managerów sekretów.
