# Naming screen umlauts: design

## Intent

Players can type `Ä Ö Ü ä ö ü` in names and mail, so German names such as "Jürgen" or "Möwe" are possible. The glyphs already exist (`docs/superpowers/specs/2026-11-14-umlaut-glyphs-design.md`); only the keyboards lack them.

## Approaches

- **A. Kristall's layout, with the contractions making room (chosen).** As in Kristall, the umlauts open the fourth row of every page. The English contraction keys, useless in German names, give up their places. Symbols displaced on the uppercase pages move to the lowercase pages, so no other key is lost.
- **B. Keep the contractions and drop symbols** (`¥`, `★`, `♪` …): this loses keys players may use and keeps keys they won't.
- **C. A separate umlaut page:** needs new naming-screen code and an extra page switch, for six keys.

## Decisions

All 8 grids live in `data/text/input_chars.asm`. QWERTY pages get the same new row as their ABC pages; all other rows stay as they are.

| Grid (ABC and QWERTY) | Row | Was | Now |
|---|---|---|---|
| Name, upper | 4 | `/ ( ) ¥ <PK> <MN> ★ ♥ ♪` | `Ä Ö Ü ¥ <PK> <MN> ★ ♥ ♪` |
| Name, lower | 4 | `é 'd 'l 'm 'r 's 't 'v 0` (QWERTY: `é 'r 't 's 'd 'l 'v 'm 0`) | `ä ö ü é ' ( ) / 0` |
| Mail, upper | 5 | `<PK> <MN> <PO> <KE> & ♂ ♀ ¥ × /` | `Ä Ö Ü <PK> <MN> <PO> <KE> & ♂ ♀` |
| Mail, lower | 4 | `é 'd 'l 'm 'r 's 't 'v ( )` (QWERTY: `é 'r 't 's 'd 'l 'v 'm ( )`) | `ä ö ü é 's ¥ × / ( )` |

- Name entry gains a plain apostrophe `'`, so names like "D'Arcy" still work.
- Mail keeps `'s`, which German uses ("geht's"). Every other contraction leaves the keyboards; they stay in the Character set for text.
- The naming-screen code treats no character specially, so only the data changes.

## Non-goals

- Translating the naming screen's own words (`lower`, `DEL`, `END`, prompts).
- Preset names.

## Checks

- The built ROM's 8 tables contain exactly the rows above.
- In Azahar, on the real Virtual Console emulator: the name-entry pages show the new rows, a name typed with umlauts is accepted, and the game prints it afterwards.
