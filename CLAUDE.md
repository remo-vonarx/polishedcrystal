# CLAUDE.md

This fork of Polished Crystal is being translated into German, to be played on a New 3DS through Virtual Console. Vocabulary lives in `GLOSSARY.md`: use its terms in code, commits and conversation, and steer clear of its _Avoid_ words.

## Upstream

- `master` mirrors upstream (Rangi42/polishedcrystal), and translation work lives on branches. Upstream fixes bugs within days, so take fixes from upstream through a merge and keep this fork's diff limited to the translation.
- Keep translated text out of engine code, in separate files (the abandoned upstream `i18n` branch, a French proof of concept, uses `locale/<lang>/` selected by a build flag). This keeps upstream merges cheap. Large upstream renames, such as draft PR #1652, are the main source of conflicts.
- Upstream's English text is still changing ahead of v3.3.0. Translate against a tagged release.

## Build

- On macOS: `brew install rgbds coreutils`. The build leaves an untracked `tools/parsemap.h.pch`.
- The deliverable is `make vc`, which produces a `.gbc`, a `_vc.gbc` and the VC patch. A change counts as working once it holds on Virtual Console, beyond what an emulator shows. Packaging a CIA and playtesting on the real Virtual Console emulator (Azahar) are covered in `vc/README.md`.
- `vc.patch.template` refers to labels in the link code. Those labels keep their names, or the VC patch breaks.

## ROM space

- The 2 MB ROM is full: about 24 KB was free on 2026-11-14. Re-measure with `make freespace`, which writes `bank_ends.txt`. German text runs roughly 20–30% longer than the source text and won't fit.
- The translation targets a 4 MB MBC3 ROM (`docs/adr/0001-4mb-rom-for-virtual-console.md`). Stock Virtual Console reaches only 2 MB; poke-cia's `build_mbc30` applies the MBC30 patch. The Kristall VC v0.1.0 base CIA has an emulator byte-identical to the English release's, so the patch applies unchanged. Verified 2026-11-14 in Azahar and on a New 3DS.
- For 4 MB, `tools/bankends.c` needs `#define BANKS 256` instead of 128. Engine far pointers store the bank as a full byte (their flag bits live in address bit 15), so content above bank `$7F` works.

## Names

- A Modern name wins over a Gen 2 name (`docs/adr/0002-modern-names-over-gen-2-names.md`). A name over its Name limit gets one Abbreviation, reused everywhere.

## Text engine

- Text is Huffman-compressed with tables built from the current text. After changing text, regenerate them as described in `utils/huffman.py`'s docstring. Its context model hardcodes `VOWELS = "AEIOUaeiou"`; add `äöüÄÖÜ` for German.
- The Character set is full. `Ä ä Ö ö Ü ü` took the Spanish slots `$c9`–`$cf` (not `$cb`); the mapping and the reasons are in `docs/superpowers/specs/2026-11-14-umlaut-glyphs-design.md`. ß is written "ss" (`docs/adr/0003-ss-instead-of-eszett.md`). Every glyph lives in each selectable font in `gfx/font/` and in `vwf.png`, where gray columns set the glyph's width; `vwf_bw.png` is unused. After editing a font PNG, run `python3 utils/grayscale.py <png>` to restore 2-bit grayscale. The naming screen (`engine/menus/naming_screen.asm`) still has no umlaut keys.
- The assembler only warns (`-Wunmapped-char`) on a character missing from the charmap, such as ß or á, and that text assembles to garbage. Treat that warning as an error.
- Name limits come from `constants/text_constants.asm`. The `*_LENGTH` values include the `@` terminator.
