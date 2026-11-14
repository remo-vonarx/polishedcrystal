# Umlaut Glyphs Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Put `Ä ä Ö ö Ü ü` into the Character set, replacing the Spanish slots, so German text can use them while English keeps working.

**Architecture:** Three layers change together. `constants/charmap.asm` maps the characters to tile IDs. `constants/huffman_text.inc` names the same characters for text compression. The font PNGs in `gfx/font/` hold the glyph pixels at those tile IDs. Pilar's text in `maps/ShamoutiCoast.asm` loses the characters that no longer exist. An uncommitted test build then shows the result on the real Virtual Console emulator.

**Tech Stack:** RGBDS 1.0.4 (`make`, `make vc`), Python 3 with Pillow, the repo's vendored `utils/png.py` (used by `utils/grayscale.py`), Azahar via `vc/` scripts.

**Spec:** `docs/superpowers/specs/2026-11-14-umlaut-glyphs-design.md`

## Global Constraints

- Slot mapping, identical in every font: `$C9` `Ä`, `$CA` `ä`, `$CC` `Ö`, `$CD` `ö`, `$CE` `Ü`, `$CF` `ü`. `$C8` `é`, `$CB` `<BOLDH>`, `$C1`–`$C7` contractions and `$D0`/`$D1` `<PO>`/`<KE>` stay unchanged.
- No ß anywhere. Text writes "ss" (`docs/adr/0003-ss-instead-of-eszett.md`).
- Images to edit: `normal narrow bold italic serif micr chicago unown` and `vwf` (all `gfx/font/<name>.png`). Leave `vwf_bw.png` untouched; the build doesn't use it.
- Font PNGs stay 128×64 2-bit grayscale. After editing with Pillow, run `python3 utils/grayscale.py <png>` (without `-I`: it imports the vendored `utils/png.py`).
- Only the six slot tiles may change in each image. Every other pixel stays identical.
- Keep the fork's diff minimal (CLAUDE.md "Upstream"): no refactors and no regenerated Huffman table.
- The test build in Task 3 is never committed. `$SCRATCH` is a scratch directory outside the repo; scripts, probes, logs and screenshots go there.
- Tile `$NN` sits in a font PNG at column `(NN-0x80) % 16`, row `(NN-0x80) // 16`, 8×8 pixels each. Ink is 0, paper is 255, and VWF width markers are 170.

## Review Focus

1. **VWF spacing:** each umlaut's width must equal its base letter's (`Ä` = `A`, …), or German words look unevenly spaced. Task 2's check asserts this from `vwf.vwf.widths`.
2. **Dots next to the line above:** capital dots in pixel row 0 can touch descenders of the line above in single-spaced lists. Task 3's screenshots must show the options list (single-spaced items) legibly.
3. **Compressed text with escaped symbols:** the umlauts have no frequency in the Huffman table, so they take the escape path. Task 3 puts them in a compressed `text` description, and they must render there too.
4. **Stylised fonts (Unown, MICR, Chicago):** the dot scheme must stay recognisable in each style. The Task 2 preview sheet is approved per font by the user.
5. **PNG format drift:** saving through Pillow writes 8-bit PNGs, and gray could then map wrongly in `vwf.png`. Task 2's check asserts bit depth 2 and colour type 0 in every edited header.

---

### Task 1: Character mapping

**Files:**
- Modify: `constants/charmap.asm:159-166`
- Modify: `constants/huffman_text.inc` (18 lines: 92-98, 220-226, 348-354, minus the `é`/`<BOLDH>` lines)
- Modify: `maps/ShamoutiCoast.asm:107-128`
- Modify: `CLAUDE.md` ("Text engine" section)

**Interfaces:**
- Produces: the charmap entries `"Ä"`=`$c9`, `"ä"`=`$ca`, `"Ö"`=`$cc`, `"ö"`=`$cd`, `"Ü"`=`$ce`, `"ü"`=`$cf`, used by Task 3's test strings.

- [ ] **Step 1: Record baselines before any change**

```sh
make tidy && make -j4 vc 2>&1 | tee $SCRATCH/build_before.log
make tidy && make -j4 huffman > $SCRATCH/corpus_before.txt
grep -c "warning" $SCRATCH/build_before.log
```
Expected: both builds succeed. Note the warning count.

- [ ] **Step 2: Write the failing charmap probe**

`$SCRATCH/charmap_probe.asm`:
```asm
INCLUDE "constants/charmap.asm"
SECTION "probe", ROM0
	db "ÄäÖöÜü"
```
Run, from the repo root:
```sh
rgbasm -Weverything -I . -o $SCRATCH/probe.o $SCRATCH/charmap_probe.asm 2>&1; rgblink -o $SCRATCH/probe.gb $SCRATCH/probe.o && xxd -l 6 $SCRATCH/probe.gb
```
Expected now: three `warning: Unmapped character 0xC3` lines, and `xxd` prints the raw UTF-8 `c384 c3a4 c396`, so the probe fails. (Dry-run confirmed on 2026-11-14.)

- [ ] **Step 3: Remap the six charmap lines**

In `constants/charmap.asm`, replace `"É"`, `"á"`, `"í"`, `"ó"`, `"¿"`, `"¡"` with `"Ä"`, `"ä"`, `"Ö"`, `"ö"`, `"Ü"`, `"ü"`, keeping the values `$c9 $ca $cc $cd $ce $cf` in place.

- [ ] **Step 4: Rename the same six tokens in `constants/huffman_text.inc`**

Same substitution on the `huffesc`/`huffmap` lines in all three contexts (b, v, o). Codes and `; N` comments stay as they are.

- [ ] **Step 5: Strip Pilar's missing characters in `maps/ShamoutiCoast.asm`**

Replace `á`→`a`, `í`→`i`, `ó`→`o` and delete `¿` and `¡`. `é` stays. The result reads "Qué fuertes son", "montón"→"monton", "Hola! He venido", "acá"→"aca", "Qué tal si", "duraría"→"duraria", "más…"→"mas…".

- [ ] **Step 6: Run the probe again**

Same command as Step 2. Expected: no warning, and `xxd` prints `c9ca cccd cecf`.

- [ ] **Step 7: Build and compare**

```sh
make tidy && make -j4 vc 2>&1 | tee $SCRATCH/build_after.log
grep -c "warning" $SCRATCH/build_after.log
make tidy && make -j4 huffman > $SCRATCH/corpus_after.txt
diff $SCRATCH/corpus_before.txt $SCRATCH/corpus_after.txt
python3 utils/verify_huffman.py polishedcrystal-3.2.3.gbc polishedcrystal-3.2.3.sym $SCRATCH/corpus_after.txt
```
Expected:
- Both builds succeed with the same warning count as Step 1.
- The `diff` shows only Pilar's tokens: `"¡"` and `"¿"` lines removed, `"á"`/`"í"`/`"ó"` lines replaced by `"a"`/`"i"`/`"o"`.
- `verify_huffman.py` reports no mismatch. It checks the ROM that `make huffman` just built. Run it without `-I`, because it imports `utils/huffman.py`. If the version in the file names has changed, use what `ls *.gbc` shows.

- [ ] **Step 8: Update `CLAUDE.md`'s "Text engine" section**

Replace the bullet starting "All 128 printable slots" with two bullets:
- The Character set is full. `Ä ä Ö ö Ü ü` took the Spanish slots `$c9`–`$cf` (not `$cb`); the mapping and the reasons are in `docs/superpowers/specs/2026-11-14-umlaut-glyphs-design.md`. ß is written "ss" (ADR 0003). Every glyph lives in each selectable font in `gfx/font/` and in `vwf.png`, where gray columns set the glyph's width; `vwf_bw.png` is unused. After editing a font PNG, run `python3 utils/grayscale.py <png>` to restore 2-bit grayscale. The naming screen (`engine/menus/naming_screen.asm`) still has no umlaut keys.
- The assembler only warns (`-Wunmapped-char`) on a character missing from the charmap, such as ß or á, and that text assembles to garbage. Treat that warning as an error.

- [ ] **Step 9: Commit**

```sh
git add constants/charmap.asm constants/huffman_text.inc maps/ShamoutiCoast.asm CLAUDE.md
git commit -m "Map Ä ä Ö ö Ü ü to the Spanish slots"
```

---

### Task 2: Glyphs in the nine font images

**Files:**
- Modify: `gfx/font/{normal,narrow,bold,italic,serif,micr,chicago,unown,vwf}.png` (six tiles each)
- Create, uncommitted: `$SCRATCH/check_font_slots.py`, `$SCRATCH/draw_umlauts.py`, `$SCRATCH/preview.png`

**Interfaces:**
- Consumes: the slot mapping (Global Constraints).
- Produces: the six glyphs in every image, built into `gfx/font/*.1bpp` and `vwf.vwf.{1bpp,widths}` by `make`.

- [ ] **Step 1: Write the failing slot check `$SCRATCH/check_font_slots.py`**

It takes a git ref as its argument: Task 1's commit, which has the original glyphs. It compares each image against `git show <ref>:gfx/font/<name>.png` and asserts:
- `assert pixels outside the six slot tiles are identical to the reference` for all 9 images.
- `assert each slot tile differs from the reference tile` (the old Spanish glyph).
- `assert png header bit depth == 2 and colour type == 0` (bytes 24–25 of the file).
- For `normal.png`, `assert slot tiles == Kristall's`, with the 1bpp bytes from Kristall VC v0.1.0 (ROM `CGBBYTD0.837`, SHA-1 `accb5842…`, font at `0xf8200`, tiles `$c0`–`$c5`):
  ```
  Ä 281028447c828200   Ö 2838448282443800   Ü 2882828282423e00
  ä 280038043c443e00   ö 28003c4242423c00   ü 2800444444443c00
  ```
- For `vwf`, after `make`: `assert widths[slot] == widths[base letter]`, reading `gfx/font/vwf.vwf.widths`. Index 0 is the space and index `n` is character `$7f + n`. The base letters are `A=$80`, `a=$a0`, `O=$8e`, `o=$ae`, `U=$94`, `u=$b4`.

Run: `python3 -I $SCRATCH/check_font_slots.py <ref>`. Expected: FAIL on "slot tile differs" for every image.

- [ ] **Step 2: Draw candidate glyphs with `$SCRATCH/draw_umlauts.py`**

- **normal:** write Kristall's bytes above.
- **Other fonts:** derive each glyph from the font's own base letter.
  - **Lowercase:** the letter plus two dots in the free rows above the x-height.
  - **Capitals:** delete one repeated straight row of the letter, shift the rows above it down by one, and put the dots in row 0. Examples are `..#.#...` in A, and `#.....#.` in O and U.
  - **Dots:** 1 px dots, 2 px in bold and Chicago. Columns follow the letter's centre the way Kristall's do.
- **vwf:** derive from vwf.png's base letters the same way. Copy the base letter's gray marker columns into all 8 rows of the slot tile.

Save, then run `python3 utils/grayscale.py gfx/font/<name>.png` for each image.

- [ ] **Step 3: Build a zoomed preview sheet `$SCRATCH/preview.png`**

One row per image (9 rows). Each row shows its base letters `A a O o U u` beside the new `Ä ä Ö ö Ü ü`, followed by `Äpfel Öl Übung` set from that font, at 6× zoom on a light background with a 1 px tile grid. Look at it yourself first and fix anything that clearly breaks the scheme.

- [ ] **Step 4: User approval gate**

Show the user `$SCRATCH/preview.png` (its full absolute path). Iterate on Steps 2–3 until they approve every row. Don't continue without approval.

- [ ] **Step 5: Build and run the check**

```sh
make -j4 vc && python3 -I $SCRATCH/check_font_slots.py <ref>
```
Expected: the build succeeds (`tools/vwf` would fail on an inconsistent gray marker) and all assertions pass.

- [ ] **Step 6: Commit**

```sh
git add gfx/font/normal.png gfx/font/narrow.png gfx/font/bold.png gfx/font/italic.png gfx/font/serif.png gfx/font/micr.png gfx/font/chicago.png gfx/font/unown.png gfx/font/vwf.png
git commit -m "Draw Ä ä Ö ö Ü ü in every font"
```

---

### Task 3: On-screen check on Virtual Console (uncommitted)

**Files:**
- Modify temporarily: `data/options/option_names.asm` (`.Typeface`), `data/options/options_descriptions.asm` (`.Typeface`)
- Create, uncommitted: `$SCRATCH/umlauts.ctm`, `$SCRATCH/render_vwf.py`, screenshots

**Interfaces:**
- Consumes: Tasks 1 and 2.

- [ ] **Step 1: Put test strings on the options screen**

```asm
.Typeface:
	db "ÄÖÜäöü@"
```
```asm
.Typeface:
	text "ÄÖÜ äöü Ärger Öl"
	line "Übung, é, it's ok"
	prompt
```
The name is a raw string; the description is Huffman-compressed `text` (Review Focus 3). `é` and `'s` check that the neighbouring slots still work.

- [ ] **Step 2: Build the test CIA**

```sh
make -j4 vc && vc/build_cia.sh polishedcrystal-3.2.3.gbc umlauttest
```
Expected: `vc/local/out/umlauttest.game.cxi`, with the script confirming the MBC30 byte.

- [ ] **Step 3: Write the movie `$SCRATCH/umlauts.ctm` with `vc/gen_ctm.py`**

Sequence:
1. Tap A to dismiss the Virtual Console notice and skip the intro.
2. START at the title screen.
3. On the main menu ("New Game", "Options", …): DOWN, then A to open Options.
4. DOWN ×3 to reach the test row (4th).
5. Then 7 RIGHT presses, 4 s apart; each press reloads the next font.

Timing comes from a first run with dense screenshots, `--shots` every 2 s, to see when the title and main menu appear. Taps that land on the main menu too early start a New Game instead; the README's sample shows this by 20 s.

- [ ] **Step 4: Take the screenshots**

```sh
python3 -I vc/playtest.py vc/local/out/umlauttest.game.cxi --movie $SCRATCH/umlauts.ctm --shots <one per font> --out $SCRATCH/shots
```
Expected: 8 screenshots, each showing the test name in the list and the test description in the textbox, in Normal, Narrow, Bold, Italic, Serif, Chicago, MICR and Unown. The font name in the value column tells them apart. The umlauts must be legible next to the list rows above and below (Review Focus 2).

- [ ] **Step 5: Render VWF text `$SCRATCH/render_vwf.py`**

Read `gfx/font/space.vwf.1bpp`, `vwf.vwf.1bpp`, `space.vwf.widths` and `vwf.vwf.widths` as the engine concatenates them (`engine/gfx/vwf.asm:153-160`). Render `ÄÖÜ äöü Äpfel Öl Übung` by placing each glyph's columns `0..width-1` side by side, at 6× zoom. Expected: even spacing, matching `Apfel Ol Ubung` rendered next to it.

- [ ] **Step 6: Show the user**

Show the 8 screenshots and the VWF render, each with its full absolute path, and get confirmation.

- [ ] **Step 7: Revert the test strings**

```sh
git checkout data/options/option_names.asm data/options/options_descriptions.asm && git status --short
```
Expected: only the untracked files that were there before (`.idea/`, `tools/parsemap.h.pch`).
