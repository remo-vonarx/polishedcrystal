# Umlaut glyphs: design

## Intent

German text needs `ä ö ü Ä Ö Ü`. The Character set has no free glyph slots, so six existing slots are reassigned. Untranslated Source text must keep displaying correctly, because the Translation replaces it gradually.

## Approaches

- **A. The Spanish slots `É á í ó ¿ ¡` (chosen).** `É` is never used. The other five appear only in Sightseer Pilar's three texts on Shamouti Coast (`maps/ShamoutiCoast.asm`), a Spanish-speaking tourist Polished invented. Source text keeps working; Pilar loses those accents.
- **B. The contraction slots `'d 'l 'm 'r 's 't 'v`.** This gives the cleanest final layout, but the contractions appear about 5,300 times in the Source text, which would show wrong letters for the whole translation.
- **ß as a seventh glyph in the `<KE>` slot:** dropped together with ß itself (`docs/adr/0003-ss-instead-of-eszett.md`).

## Decisions

- **Slot mapping** (in `constants/charmap.asm`, same in every font):

  | Slot | `$C9` | `$CA` | `$CC` | `$CD` | `$CE` | `$CF` |
  |---|---|---|---|---|---|---|
  | Was | `É` | `á` | `í` | `ó` | `¿` | `¡` |
  | Now | `Ä` | `ä` | `Ö` | `ö` | `Ü` | `ü` |

  `é` (`$C8`), `<BOLDH>` (`$CB`), the contractions and `<PO>`/`<KE>` stay as they are.
- **No ß.** Text writes "ss" (ADR 0003).
- **Pilar:** her texts print `á í ó` as plain `a i o` and drop `¿ ¡`, so "acá, montón, duraría, más" become "aca, monton, duraria, mas". `é` survives. What she says in German is decided when she's translated. Once no Source text is left, the slots `'d 'l 'm 'r 't 'v` free up and could take `á í ó ¿ ¡` back.
- **Look:**
  - **Capitals** keep their height and baseline. The dots sit in the top row, and one repeated straight row of the letter is dropped to make room.
  - **Lowercase** letters get dots in the free rows above.
  - The normal font is Kristall's typeface (its letters are byte-identical), so it takes Kristall's six umlaut tiles unchanged. They match the scheme above, with the dots always in pixel columns 2 and 4.
  - Every other font follows the same scheme in its own style. Normal font (`#` = ink):

    ```
      Ä         Ö         Ü         ä         ö         ü
    ..#.#...  ..#.#...  ..#.#...  ..#.#...  ..#.#...  ..#.#...
    ...#....  ..###...  #.....#.  ........  ........  ........
    ..#.#...  .#...#..  #.....#.  ..###...  ..####..  .#...#..
    .#...#..  #.....#.  #.....#.  .....#..  .#....#.  .#...#..
    .#####..  #.....#.  #.....#.  ..####..  .#....#.  .#...#..
    #.....#.  .#...#..  .#....#.  .#...#..  .#....#.  .#...#..
    #.....#.  ..###...  ..#####.  ..#####.  ..####..  ..####..
    ........  ........  ........  ........  ........  ........
    ```
- **Images:**
  - The 8 selectable fonts in `gfx/font/`: `normal`, `narrow`, `bold`, `italic`, `serif`, `micr`, `chicago`, `unown`.
  - `vwf.png`, the variable-width font used by the Pokédex, Bill's PC and the ability pop-up. It has its own glyph drawings, and gray columns after each glyph set its width (`tools/vwf.c`).
  - `vwf_bw.png` isn't referenced by the build and stays untouched.
- **Compression table:** `constants/huffman_text.inc` names each character by its glyph, so the six entries are renamed in place and keep their codes. Characters missing from the table are escaped, so new text still compresses. Full regeneration, and adding the umlauts to `VOWELS` in `utils/huffman.py`, wait for the first German text.
- **Docs:** `CLAUDE.md`'s text-engine notes are updated. They currently name the contraction slots as candidates and list `vwf_bw.png`.

## Non-goals

- Naming screen keys for umlauts.
- Any German text.
- German quotation marks „ “.

## Checks

- A zoomed preview sheet of the six new glyphs in all 9 images, for the user to approve before anything is committed.
- A throwaway test build that shows `ÄÖÜ äöü` in each selectable font, screenshotted in Azahar on the real Virtual Console emulator. The options menu reloads the font live, so one screen serves all 8 fonts.
- VWF text is checked by rendering a test string from the build's own `vwf.vwf.1bpp` and `vwf.vwf.widths`. No VWF screen is reachable early in a new game, and the VWF engine itself is unchanged.
- `make` and `make vc` build without new warnings. The `make huffman` text dump differs from before only in Pilar's lines.

## Left to the builder

- The exact pixels per font, settled through the preview sheet.
- How the throwaway build puts the test string on screen.
