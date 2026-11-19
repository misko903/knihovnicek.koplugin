# Knihovníček pro KOReader

[Slovensky](README.md) · **Česky** · [English](README.en.md)

### 📚 Knihovní e-knihy přímo ve čtečce. Funguje se slovenskými i českými knihovnami!

Půjčujte si e-knihy ze **slovenských a českých knihoven** (přes Palmknihy)
a mějte je ve čtečce na jedno ťuknutí – bez počítače, bez kabelu, bez
přeposílání souborů. Výpůjčky se stáhnou rovnou do KOReaderu a po uplynutí
lhůty se samy uklidí.

Knihovníček je samostatný plugin pro [KOReader](https://koreader.rocks/). Nepotřebuje
žádný server ani počítač: s Palmknihy a katalogem knihovny komunikuje přímo
ze čtečky.

Co umí:

- **Moje výpůjčky** – seznam aktuálních výpůjček z Palmknihy (s datem
  vypršení); klepnutím knihu stáhnete, otevřete nebo smažete,
- **Stáhnout nové výpůjčky** – stáhne všechny e-knihy, které ještě nemáte,
- **Smazat prošlé knihy** – smaže soubory výpůjček, kterým skončila lhůta
  (po zapnutí **Nastavení → Mazat prošlé knihy automaticky** to dělá sám
  vždy, když se otevře správce souborů),
- **Hledat v katalogu knihovny** – vyhledá e-knihy (podle názvu i autora)
  v katalogu katalog.tsk.sk a jedním klepnutím je vypůjčí.

Rozhraní je ve slovenštině, češtině a angličtině podle jazyka KOReaderu.

## Původ a poděkování

Původní projekt [Neknihy](https://github.com/thalman/neknihy), ze kterého
vychází komunikace s Palmknihy, vytvořil **Tomáš Halman** ([@thalman](https://github.com/thalman)).
Tento plugin vznikl jako součást forku [Neknihy NextGen](https://github.com/misko903/neknihy)
(autor forku: misko903).

## Instalace

1. Stáhněte `knihovnicek.koplugin.zip` z [Releases](../../releases), rozbalte ho a složku `knihovnicek.koplugin` zkopírujte do složky `plugins` v KOReaderu
   (na Kobo `.adds/koreader/plugins/`, na Kindle `koreader/plugins/`,
   na PocketBook `applications/koreader/plugins/`, v Androidu
   `koreader/plugins/` v úložišti).
2. Restartujte KOReader. Plugin se objeví v horním menu
   (ikona ozubeného kola → **Nástroje** → **Knihovníček**).

## Aktualizace

Plugin se umí aktualizovat sám z nejnovějšího vydání na GitHubu: klepněte na **Knihovníček →
Nainstalovaná verze**. Jednou denně (jen když je čtečka už online) ho
zkontroluje i automaticky; vypnete to v **Nastavení → Kontrolovat aktualizace
automaticky**. Před instalací se vždy ptá; po aktualizaci je třeba restartovat KOReader.

## Nastavení

V menu **Knihovníček → Nastavení** zadejte:

| Položka | Význam |
| --- | --- |
| E-mail / heslo Palmknihy | přihlášení do účtu Palmknihy (potřebné pro výpůjčky a stahování) |
| Složka pro stažené knihy | ve výchozím nastavení `Knihovnicek` v domovské složce KOReaderu |
| Knihovna | katalog, ve kterém se hledá a půjčuje (výchozí VKMR v Trenčíně) |
| Heslo do knihovny | heslo do katalogu knihovny (potřebné pro vyhledávání a půjčování); přihlašovací jméno se přebírá z e-mailu Palmknihy, proto musí být e-mail v knihovně a v Palmknihy stejný |

> **Důležité:** bez zadaného hesla do katalogu knihovny plugin
> neumí vyhledávat knihy. Ke stahování již vypůjčených knih stačí
> přihlášení do Palmknihy, to funguje i bez přihlášení do katalogu.

Údaje se ukládají v souboru `knihovnicek.lua` ve složce nastavení KOReaderu
jako prostý text.

## Jak se půjčují e-knihy

Návod k registraci a půjčování e-knih (včetně propojení knihovního účtu
s Palmknihy) najdete na webových stránkách vaší knihovny.

## Omezení

Plugin zatím:

- pracuje jen s e-knihami (audioknihy KOReader nepřehrává),
- z EPUB neodstraňuje stránku se sociálním DRM,
- hledá a půjčuje jen v katalozích na katalog.tsk.sk (ne v Městské
  knihovně v Bratislavě).

Aktivní výpůjčku, jejíž soubor smažete, plugin skryje až do uplynutí lhůty,
takže se už nestahuje znovu.

## Vývoj

Čisté moduly (`nk_util`, `nk_http`, `nk_katalog`, `nk_palmknihy`) lze
testovat obyčejným Lua bez KOReaderu:

```bash
lua tests/run.lua
```

Uživatelské rozhraní (`main.lua`) běží jen v KOReaderu.
