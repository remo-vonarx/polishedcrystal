# PC and Title-Prompt Text Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** The PC's menus and item storage, from the player's room and from a Pokémon Center, and the three title-screen prompts (clear save, reset clock, reset initial options) are German.

**Architecture:**
- German replaces the English string contents in place, in the files listed under Scope.
- One layout change, approved with this plan: both PC menu boxes grow one column to the right, as Kristall's do, so "PC von <PLAYER>" and "Item aufnehmen" (14 tiles) fit.
- Quantities follow Kristall's "N x <ITEM>" form. The German quantity texts drop `text_plural`, which can only add English plural endings.

**Tech Stack:** RGBDS 1.0.4 (`make vc`), `utils/huffman.py`, `utils/check_text_width.py` and `utils/check_text_mode.py`, Azahar through `vc/gen_ctm.py` and `vc/playtest.py`, the Kristall dump and ROM in `.claude/upload/`, Crystal Legacy in `~/Development/Pokemon_Crystal_Legacy`.

**Spec:** `docs/superpowers/specs/2026-11-15-german-translation-design.md` (section "PR 3 onward: text areas"); CLAUDE.md's Project decisions.

## Global Constraints

- CLAUDE.md governs every string: Project decisions, Source priority, Text constraints, Style, Validation, Testing in the game. This plan doesn't repeat them.
- Only string contents change, with two exceptions: the box widths (Task 1), and the quantity texts' commands (`text_plural` removed; `text_decimal wItemQuantityChangeBuffer, 1, 2` added to `_ItemsDiscardedText`, as Kristall prints the number there).
- Every settled term goes into `TERMS.md` in the same commit as the strings that use it.
- Open questions go to the user in question dialogs (CLAUDE.md, Working agreement). The spec's "table" wording predates that rule.
- Branch `pc-and-title-prompts`; PR "Translate the PC menus and title prompts" on the fork, squash-merged.
- `$SCRATCH` is `scratchpad/pcprompts/` in the session scratchpad; test scripts, test clones, movies and screenshots stay there.

## Scope

German below is the draft. K = Kristall (bank:address in the dump or ROM), re-cased; Own = own translation, flagged. Lines: `/` line, `+` cont, `//` para.

**PC menus** (`engine/events/pokecenter_pc.asm`). Text columns 2–15 after Task 1: 14 tiles.

| Label | English | German | Source |
|---|---|---|---|
| `.String_PlayersPC` | `<PLAYER>'s PC` | `PC von <PLAYER>` | K 05:562b |
| `.String_BillsPC` | Bill's PC | Bills PC | K 05:5603 |
| `.String_OaksPC` | Prof.Oak's PC | Eichs PC | K |
| `.String_HallOfFame` | Hall of Fame | Ruhmeshalle | K |
| `.String_TurnOff`, `.TurnOff`, `.LogOff` | Turn Off, Log Off | Ausloggen | K (both entries) |
| `.WithdrawItem` / `.DepositItem` / `.TossItem` | Withdraw / Deposit / Toss Item | Item aufnehmen / Item ablegen / Item wegwerfen | K 05:5761 |
| `.MailBox` / `.Decoration` | Mail Box / Decoration | Briefkasten / Dekoration | K |

**PC texts** (`data/text/common.asm`)

| Label | German | Source |
|---|---|---|
| `_PokecenterPCTurnOnText` | `<PLAYER> schaltet` / den PC ein. | K 70:569d |
| `_PokecenterPCWhoseText` | Zugriff auf / wessen PC? | K 70:56b5 |
| `_PokecenterBillsPCText` | Die Verbindung zu / Bills PC wurde + hergestellt. // Du hast Zugriff / auf das #mon- + Lagerungs-System. | K 70:56cd; the user kept Kristall's hyphen |
| `_PokecenterPlayersPCText` | Die Verbindung zu / deinem PC wurde + hergestellt. // Du hast Zugriff / auf das Item- + Lagerungs-System. | K 70:572c |
| `_PokecenterOaksPCText` | Die Verbindung zu / Prof. Eichs PC + wurde hergestellt. // Du hast Zugriff / auf die #dex- + Bewertung. | K 70:578c |
| `_PokecenterPCOaksClosedText` | … / Verbindung + beendet… | K 70:57ea |
| `_PokecenterPCCantUseText` | Dies kann nur / ein #mon + benutzen! | K 70:5561 (Kristall drops "Bzzzzt!") |
| `_PlayersPCAskWhatDoText` | Was möchtest du / tun? | K 70:559b |
| `_PlayersPCHowManyWithdrawText` | Wie viele möchtest / du mitnehmen? | K 70:55b1 |
| `_PlayersPCWithdrewItemsText` | N x `<ITEM>` / wurde mitgenommen. | K 70:55d7 |
| `_PlayersPCNoRoomWithdrawText` | Du kannst keine / weiteren Items + mehr tragen. | K 70:55f4 |
| `_PlayersPCNoItemsText` | Du trägst keine / Items! | K 70:5621 (shown when the Bag is empty) |
| `_PlayersPCCantDepositItemText` | Dieses Item kannst / du nicht ablegen. | Own (Polished's text); the user's choice |
| `_PlayersPCHowManyDepositText` | Wie viele möchtest / du ablegen? | K 70:5639 |
| `_PlayersPCDepositItemsText` | N x `<ITEM>` / wurde abgelegt. | K 70:565d |
| `_PlayersPCNoRoomDepositText` | Es ist kein Platz / für weitere Items. | K 70:5677 |
| `_ItemsTossOutHowManyText` | Wie viele / `<ITEM>` + wegwerfen? | K 70:5dcf |
| `_AskQuantityThrowAwayText` | Wegwerfen / N x `<ITEM>`? | K 70:5deb |
| `_ItemsDiscardedText` | N x `<ITEM>` / wurde weggeworfen. | K 70:5e0a (prints the number, unlike the English) |

N x `<ITEM>` is `text_decimal wItemQuantityChangeBuffer, 1, 2`, `text " x "`, `text_ram` of the text's English buffer; at most 2 + 3 + 12 = 17 tiles, 18 with `?`. Crystal Legacy's `data/text/common_2.asm` shows the same texts in asm.

The three toss texts are shared with the Bag (`TossItemFromPC` in `engine/pokemon/mon_menu.asm`, `_AskQuantityThrowAwayText` also in `engine/items/pack.asm`), so the Bag's toss turns German too.

**Item list:** `ScrollingMenu_CancelString` (`engine/menus/scrolling_menu.asm`): Cancel → Zurück (K, Kristall's item list; Task 3 confirms it by screenshot). Every scrolling menu shares it.

**Title-screen prompts** (`data/text/common.asm`; the callers are in `engine/menus/delete_save.asm` and `engine/rtc/reset_password.asm`)

| Label | English | German | Source |
|---|---|---|---|
| `_ClearAllSaveDataText` | Clear all save / data? | Spielstand / löschen? | K 71:580a |
| `_PasswordAskResetClockText` | Reset the clock? | Uhr neu stellen? | K 71:57e1 |
| `_PasswordAskResetText` | Select Continue to / set the time. | Wähle Weiter und / stelle die Uhr. | Own; the user's choice. Kristall's "Wähle Fortfahren & verwirf die Einstellungen." answers Crystal's password text, which Polished replaced |
| `ResetInitialOptionsText` | Reset the initial / game options? | Die Spieloptionen / zurücksetzen? | Own; the user's choice |

**Out**, each a later area: Bill's PC box screens (`engine/pc/`); Prof. Oak's rating texts (`_OakPCText1` onward); the Hall of Fame screens; the Mail Box and Decoration screens; the Bag's own texts, including `_ThrewAwayText`; the other `Cancel` strings; the plural table.

**Box widths (layout change, approved).** Kristall's PC menus end at column 16 (its ROM: `48 00 00 0c 10` and `40 00 00 0c 10`); Polished's end at 15. In `engine/events/pokecenter_pc.asm`:
- `.TopMenu`: `menu_coords 0, 0, 15, 12` → `menu_coords 0, 0, 16, 12`
- `PlayersPCMenuData`: `db 12, 15` → `db 12, 16`

**Answers** (2026-11-16, question dialogs with the plan):
1. Storage system: `#mon-Lagerungs-System`, `Item-Lagerungs-System`, Kristall's hyphen re-cased (the user first picked the compound, then kept Kristall's form after seeing it).
2. `_PasswordAskResetText`: "Wähle Weiter und / stelle die Uhr."
3. `ResetInitialOptionsText`: "Die Spieloptionen / zurücksetzen?"
4. `_PlayersPCCantDepositItemText`: "Dieses Item kannst / du nicht ablegen."
5. Both PC menus widen as Kristall's; native execution with one final review.

## Review Focus

1. **A widened menu leaves a stray column or covers something it shouldn't.** Expected: the border at column 16 in both menus, matching Kristall, and the map restored when they close. Task 3 screenshots both menus open and the overworld after Ausloggen.
2. **A quantity text prints the wrong number or garbage** now that `text_plural` is gone and `_ItemsDiscardedText` prints a number. Expected: the chosen quantity, right-aligned in 2 tiles (" 1 x Potion", "10 x Potion"). Task 3 moves a quantity of 1 and one of 10.
3. **The toss question's `cont` changes the flow:** the box scrolls and waits for A before the quantity box opens. Expected: the same as Kristall's toss. Task 3 screenshots both halves, in both games.
4. **The Bag's toss turns German while the rest of the Bag stays English.** Expected: the PR body says so, as it does for the Yes/No box.
5. **Text read from a bank at `$80` or above.** Task 2 lists the changed sections' banks from the `.sym` file; Task 3's screenshots prove any above `$7F`.

---

### Task 1: Widen the PC menus

**Files:**
- Modify: `engine/events/pokecenter_pc.asm` (`.TopMenu`, `PlayersPCMenuData`)

- [ ] **Step 1: Screenshot the player's PC menu before the change**, with the README's room movie (the PC opens at about 160 s). Expected: the border at column 15.
- [ ] **Step 2: Make the two changes from Scope.**
- [ ] **Step 3: Build and check.** `make vc`, no new warnings; the same screenshot shows the border at column 16 and the map to its right intact.
- [ ] **Step 4: Commit** `engine/events/pokecenter_pc.asm`: "Widen the PC menus for German".

### Task 2: Put the German strings in

**Files:**
- Modify: the Scope files, `constants/huffman_text.inc`, `TERMS.md`
- Create, uncommitted: `$SCRATCH/check_scope.py`

**Interfaces:**
- Produces: `python3 -I $SCRATCH/check_scope.py`, which prints `path:line: still English: <line>` for every in-scope string line equal to `master`'s and exits 1 if any are left. It's PR 3's script (`scratchpad/newgame/check_scope.py`) with this PR's labels.

- [ ] **Step 1: Write `check_scope.py` and run it.** Expected: every in-scope line listed, exit 1.
- [ ] **Step 2: Check each K source** against the dump, or the ROM where the dump skips a text, and Crystal Legacy's copy. Expected: every German line above matches Kristall apart from re-casing and the answers to the questions.
- [ ] **Step 3: Replace the strings, one commit per screen**, each with its `TERMS.md` rows:
  1. "Translate the PC menus" (menu strings, turn-on, whose-PC, the three "Verbindung" texts, can't-use, closed)
  2. "Translate the item storage" (the `_PlayersPC…` texts, the toss texts, Zurück)
  3. "Translate the title-screen prompts"

  Before each commit, the checkers print only CLAUDE.md's known hit, `check_scope.py` no longer lists that screen, and lines with `text_decimal` or `text_ram` are counted by hand at their longest.
- [ ] **Step 4: Regenerate the Huffman tables** (`utils/huffman.py`'s docstring), then `make tidy && make vc`. Expected: no new warnings, no `-Wunmapped-char`; a short jump pushed past 255 bytes switches to its long form (Project decisions). Commit `constants/huffman_text.inc`: "Regenerate the Huffman tables".
- [ ] **Step 5: Run `check_scope.py`.** Expected: exit 0.
- [ ] **Step 6: List the changed text sections' banks** from `polishedcrystal-3.2.3.sym` (Review Focus 5).

### Task 3: Test in the game against Kristall

**Files:**
- Modify: `vc/README.md` (new section "Reach the PC")
- Create, uncommitted: `$SCRATCH/clone-a/`, `$SCRATCH/clone-b/`, `$SCRATCH/movies/`, `$SCRATCH/shots/`

The Pokémon Center PC has no Pokémon Center near the room, so two test clones open it from the room's PC. Both are normal builds, so the README's room movie still fits. Each changes only `PlayersHousePC` in `maps/PlayersHouse2F.asm`:
- **Clone A:** `special Special_PlayersHousePC` → `special PokemonCenterPC`.
- **Clone B:** as A, plus before it `givepoke` (any species), `setflag ENGINE_POKEDEX`, `giveitem POTION, 12` and `givekeyitem` (any key item).

- [ ] **Step 1: Play clone A** from the room movie: PC → whose-PC menu (3 entries) → Bills PC (can't-use text) → PC von Aaaaaaa (own-PC text) → Item ablegen (empty Bag: "Du trägst keine Items!") → Item aufnehmen the Potion (how many, " 1 x Potion") → Item ablegen it → Item wegwerfen it (both halves of the toss question, the Ja/Nein question, the result) → Ausloggen twice. Expected: a screenshot of each text, both menus and the item list with Zurück.
- [ ] **Step 2: Play clone B:** whose-PC menu (4 entries, Eichs PC) → Bills PC ("Verbindung" text; leave the box screen with B) → Eichs PC ("Verbindung" text, then "… Verbindung beendet…" after the English rating) → PC von Aaaaaaa → Item ablegen the key item (can't-deposit text) → 10 Potions in and out ("10 x Potion").
- [ ] **Step 3: Play the title prompts** on this branch's build: Up+B+Select, Down+B (Ja, then the follow-up text), Left+B. Expected: each text in its box with Nein/Ja.
- [ ] **Step 4: Take Kristall's matching screens:** its room PC (withdraw, deposit and toss the Potion, the item list's last entry), Up+Select+B and Down+Select+B. Kristall's whose-PC menu needs a Pokémon Center; compare it by its menu header (Scope, "Box widths") and list it as not reached in Kristall.
- [ ] **Step 5: Compare by position** (CLAUDE.md, Testing in the game): against Kristall for the PC and the clear-save and clock prompts; against Polished's English for `_PasswordAskResetText`, the reset-options prompt and the can't-deposit text. Fix any overflow in Task 2's files and repeat that screen.
- [ ] **Step 6: Write "Reach the PC" in `vc/README.md`**: the room movie's PC taps, and the clone-A hook for the Pokémon Center PC. Commit: "Document reaching the PC".
- [ ] **Step 7: List the screens seen and not reached** in the PR body: at least the Hall of Fame entry (postgame), both "no room" texts (a full Bag or PC), and the Bag's own toss.
