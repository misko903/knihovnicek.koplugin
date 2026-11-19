# Knihovníček for KOReader

[Slovensky](README.md) · [Česky](README.cs.md) · **English**

### 📚 E-reader + library = free e-books. Works with Slovak and Czech libraries!

Borrow e-books from **Slovak and Czech libraries** (via Palmknihy) and have
them on your e-reader with a single tap – no computer, no cable, no copying
files around. Loans are downloaded straight into KOReader and tidied up
automatically once they expire.

Knihovníček is a standalone plugin for [KOReader](https://koreader.rocks/). It needs
no server or computer: it talks to Palmknihy and the library catalogue
directly from the e-reader.

What it does:

- **My loans** – lists your current Palmknihy loans (with the expiry date);
  tap a book to download, open or delete it,
- **Download new loans** – downloads all e-books you don't have yet,
- **Delete expired books** – deletes the files of loans whose term has ended
  (with **Settings → Delete expired books automatically** turned on, it does
  this by itself whenever the file browser opens),
- **Search the library catalogue** – finds e-books (by title or author) in
  the catalogue at katalog.tsk.sk and borrows them with one tap.

The interface is available in Slovak, Czech and English, following the
KOReader language.

## Origin and credits

The original project [Neknihy](https://github.com/thalman/neknihy), which the
Palmknihy communication is based on, was created by **Tomáš Halman**
([@thalman](https://github.com/thalman)). This plugin was developed as part
of the fork [Neknihy NextGen](https://github.com/misko903/neknihy)
(fork author: misko903).

## Installation

1. Download `knihovnicek.koplugin.zip` from [Releases](../../releases), unzip it and copy the `knihovnicek.koplugin` folder into KOReader's `plugins` folder
   (Kobo: `.adds/koreader/plugins/`, Kindle: `koreader/plugins/`,
   PocketBook: `applications/koreader/plugins/`, Android:
   `koreader/plugins/` in the storage).
2. Restart KOReader. The plugin appears in the top menu
   (gear icon → **Tools** → **Knihovníček**).

## Updates

The plugin can update itself from the latest GitHub release: tap **Knihovníček →
Installed version**. It also checks automatically once a day (only when the
e-reader is already online); turn that off in **Settings → Check for updates
automatically**. It always asks before installing; KOReader must be restarted
after an update.

## Settings

In **Knihovníček → Settings** enter:

| Item | Meaning |
| --- | --- |
| Palmknihy e-mail / password | login to your Palmknihy account (needed for loans and downloads) |
| Download folder | `Knihovnicek` in KOReader's home folder by default |
| Library | the catalogue used for searching and borrowing (VKMR in Trenčín by default) |
| Library password | password for the library catalogue (needed for searching and borrowing); the login name is taken from the Palmknihy e-mail, so the e-mail must be the same in the library and in Palmknihy |

> **Important:** without the library catalogue password the plugin cannot
> search for books. Downloading books you have already borrowed only needs
> your Palmknihy login and works without the catalogue login.

Your credentials are stored as plain text in `knihovnicek.lua` in KOReader's
settings folder.

## How to borrow e-books

Instructions for registering and borrowing e-books (including linking your
library account with Palmknihy) can be found on your library's website.

## Limitations

The plugin currently:

- handles e-books only (KOReader does not play audiobooks),
- does not remove the social-DRM page from EPUBs,
- searches and borrows only in catalogues at katalog.tsk.sk (not in the
  Bratislava City Library).

An active loan whose file you delete stays hidden until the loan expires,
so it is not downloaded again.

## Development

The pure modules (`nk_util`, `nk_http`, `nk_katalog`, `nk_palmknihy`) can be
tested with plain Lua, without KOReader:

```bash
lua tests/run.lua
```

The user interface (`main.lua`) only runs inside KOReader.
