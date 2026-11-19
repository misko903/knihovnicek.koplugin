# Knihovníček pre KOReader

**Slovensky** · [Česky](README.cs.md) · [English](README.en.md)

### 📚 Čítačka + knižnica = e-knihy zadarmo. Funguje so slovenskými aj českými knižnicami!

Požičiavajte si e-knihy z **slovenských a českých knižníc** (cez Palmknihy)
a majte ich v čítačke na jedno ťuknutie – bez počítača, bez kábla, bez
preposielania súborov. Výpožičky sa stiahnu rovno do KOReaderu a po vypršaní
lehoty sa samy upratajú.

Knihovníček je samostatný plugin pre [KOReader](https://koreader.rocks/). Nepotrebuje
žiadny server ani počítač: s Palmknihy a katalógom knižnice komunikuje priamo
z čítačky.

Čo vie:

- **Moje výpožičky** – zoznam aktuálnych výpožičiek z Palmknihy (s dátumom
  vypršania); ťuknutím knihu stiahnete, otvoríte alebo zmažete,
- **Stiahnuť nové výpožičky** – stiahne všetky e-knihy, ktoré ešte nemáte,
- **Zmazať prepadnuté knihy** – zmaže súbory výpožičiek, ktorým skončila lehota
  (po zapnutí **Nastavenia → Mazať prepadnuté knihy automaticky** to robí sám
  vždy, keď sa otvorí prehliadač súborov),
- **Hľadať v katalógu knižnice** – vyhľadá e-knihy (podľa názvu aj autora)
  v katalógu katalog.tsk.sk a jedným ťuknutím ich vypožičia.

Rozhranie je v slovenčine, češtine a angličtine podľa jazyka KOReaderu.

## Pôvod a poďakovanie

Pôvodný projekt [Neknihy](https://github.com/thalman/neknihy), z ktorého
vychádza komunikácia s Palmknihy, vytvoril **Tomáš Halman** ([@thalman](https://github.com/thalman)).
Tento plugin vznikol ako súčasť forku [Neknihy NextGen](https://github.com/misko903/neknihy)
(autor forku: misko903).

## Inštalácia

1. Stiahnite `knihovnicek.koplugin.zip` z [Releases](../../releases), rozbaľte ho a priečinok `knihovnicek.koplugin` skopírujte do priečinka `plugins` v KOReaderi
   (na Kobo `.adds/koreader/plugins/`, na Kindle `koreader/plugins/`,
   na PocketBook `applications/koreader/plugins/`, v Androide
   `koreader/plugins/` v úložisku).
2. Reštartujte KOReader. Plugin sa objaví v hornom menu
   (ikona ozubeného kolesa → **Nástroje** → **Knihovníček**).

## Aktualizácie

Plugin sa vie aktualizovať sám z najnovšieho vydania na GitHube: ťuknite na **Knihovníček →
Nainštalovaná verzia**. Raz denne (len keď je čítačka už online) ho
skontroluje aj automaticky; vypnete to v **Nastavenia → Kontrolovať aktualizácie
automaticky**. Pred inštaláciou sa vždy pýta; po aktualizácii treba reštartovať KOReader.

## Nastavenie

V menu **Knihovníček → Nastavenia** zadajte:

| Položka | Význam |
| --- | --- |
| E-mail / heslo Palmknihy | prihlásenie do účtu Palmknihy (potrebné pre výpožičky a sťahovanie) |
| Priečinok pre stiahnuté knihy | predvolene `Knihovnicek` v domovskom priečinku KOReaderu |
| Knižnica | katalóg, v ktorom sa hľadá a požičiava (predvolene VKMR v Trenčíne) |
| Heslo do katalógu | heslo do katalógu knižnice (potrebné na vyhľadávanie a požičiavanie); prihlasovacie meno sa preberá z e-mailu Palmknihy, preto musí byť e-mail v knižnici a v Palmknihy rovnaký |

> **Dôležité:** bez zadaného hesla do katalógu knižnice plugin
> nevie vyhľadávať knihy. Na sťahovanie už vypožičaných kníh stačí
> prihlásenie do Palmknihy, tie fungujú aj bez prihlásenia do katalógu.

Údaje sa ukladajú v súbore `knihovnicek.lua` v priečinku nastavení KOReaderu
ako obyčajný text.

## Ako sa požičiavajú e-knihy

Návod na registráciu a požičiavanie e-kníh (vrátane prepojenia
knižničného účtu s Palmknihy) nájdete na webovej stránke vašej knižnice.

## Obmedzenia

Plugin zatiaľ:

- pracuje len s e-knihami (audioknihy KOReader neprehráva),
- z EPUB neodstraňuje stranu so sociálnym DRM,
- hľadá a požičiava len v katalógoch na katalog.tsk.sk (nie v Mestskej
  knižnici v Bratislave).

Aktívnu výpožičku, ktorej súbor zmažete, plugin skryje až do vypršania lehoty,
takže sa už nesťahuje znova.

## Vývoj

Čisté moduly (`nk_util`, `nk_http`, `nk_katalog`, `nk_palmknihy`) sa dajú
testovať obyčajným Lua bez KOReaderu:

```bash
lua tests/run.lua
```

Používateľské rozhranie (`main.lua`) beží len v KOReaderi.
