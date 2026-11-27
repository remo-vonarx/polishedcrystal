# vc/: 3DS Virtual Console packaging and checks

These scripts turn a `make vc` build into an installable 3DS title (CIA) and run it in [Azahar](https://github.com/azahar-emu/azahar). Azahar runs Nintendo's own Virtual Console emulator from the Base CIA, so it shows whether a build holds on the Virtual Console. It has no RAM access and no save states. Each chunk's screens are therefore checked in PyBoy (`utils/pyboy_play.py`, see its docstring), and Azahar boots the chunk's CIA and shows one of its screens.

## Local setup (`vc/local/`, git-ignored)

| Path | Contents | Source |
|---|---|---|
| `local/azahar/` | Azahar 2126.2, macOS arm64 (`Azahar.app`, `scripting/`) | azahar-emu/azahar releases |
| `local/bin/ctrtool`, `local/bin/makerom` | ctrtool v1.3.0, makerom v0.19.0 | 3DSGuy/Project_CTR releases |
| `local/poke-cia/` | poke-cia at `bf8eb80`, plus `seeddb.bin` | vulcandth/poke-cia; ihaveamac/3DS-rom-tools |
| `local/dumps/kristall-vc-v0.1.0.standard.cia` | Base CIA: your own Kristall VC dump | GodMode9, see below |
| `local/saves/` | Virtual Console saves (`sav.dat`, `SecureValue`) kept from earlier runs | Azahar's sandbox |

You also need `brew install make coreutils`. poke-cia requires GNU Make 4 (installed as `gmake`) and GNU `env -C` / `cp -T`.

**Dumping the Base CIA** (requires Luma3DS and GodMode9):
1. Hold START *before* pressing power to start GodMode9.
2. HOME → Title manager → `[A:] SYSNAND SD` → Pokémon Kristall → Build CIA (standard).

The file in `gm9/out/` is already decrypted. Kristall VC v0.1.0 contains an emulator byte-identical to the English release's, so poke-cia's MBC30 patch applies unchanged.

## Build a CIA

```sh
make vc
vc/build_cia.sh polishedcrystal-<version>.gbc [name]   # -> vc/local/out/<name>.cia and .game.cxi
```

The script always applies poke-cia's MBC30 patch: stock Virtual Console reaches only 2 MB, and the 4 MB ROM crashes at its title screen without it. It stops unless the patched byte is in place. The title installs as `0004000000172800` (from poke-cia's `game.rsf`), separate from Kristall's `0004000000172B00`. The CIA bytes vary from build to build, but the `.game.cxi` is reproducible.

## Run in Azahar

```sh
python3 -I vc/gen_ctm.py vc/local/movies/<movie>.ctm 0004000000172800 <seconds> "A:4:0.15;START:22:0.15"
python3 -I vc/playtest.py vc/local/out/<name>.game.cxi --movie vc/local/movies/<movie>.ctm --shots 20,40,60 --out <dir>
```

- A movie is a list of `BUTTON:start_s:hold_s` presses. Generate it from this file's commands before a run: `vc/local/movies/` keeps older movies under the same names (on 2026-11-23 its `kristall.ctm` was a 90 s draft).
- When a movie ends, Azahar pauses the game, and every later screenshot fails with a timeout.
- Azahar runs with `HOME=vc/local/azahar-home`, so nothing touches `~/Library`. A window opens for the duration of the run.
- On every start, Virtual Console shows a "Restore points / Suspension points not supported" notice that needs an A press. From an empty save two more dialogs follow, a few seconds apart: "The save data is corrupted and will be reset" (A: Yes) and "The save data has been reset" (A: OK). Until they are answered the top screen stays black.
- Under a movie the game plays deterministically (fixed clock), but screenshots are timed by wall clock, and the emulator falls 1–5 s behind as a run goes on. A shot can show the state of one or two steps back, or a scroll half done. Leave at least 2 s between inputs that wait for a text box to close.
- Azahar stops at a modal "run Azahar via the app bundle" warning whenever its parent isn't launchd. `playtest.py` therefore starts it through a shell that exits at once. Being detached, it reports no exit code: Azahar's console output is in `<out>/azahar_stdout.txt`, and after a full run the emulator log is copied to `<out>/azahar_log.txt`.
- Azahar ignores SIGTERM, so `playtest.py` kills it. That rules out recording movies with `-r` by script, because a recording is only saved on a clean exit.
- Screenshots fail once the movie has played to its end, so each movie runs a few seconds past its last screen.

**The save.** Virtual Console keeps the game's save in the sandbox and writes it on exit, so the next run continues from it:

```sh
data="vc/local/azahar-home/Library/Application Support/Azahar/sdmc/Nintendo 3DS/00000000000000000000000000000000/00000000000000000000000000000000/title/00040000/00172800/data/00000001"
mkdir -p vc/local/saves/<name> && cp -p "$data/sav.dat" "$data/SecureValue" vc/local/saves/<name>/   # keep it
rm "$data/sav.dat" "$data/SecureValue"                                                              # new game
cp -p vc/local/saves/<name>/sav.dat vc/local/saves/<name>/SecureValue "$data/"                      # go back to it
```

Kristall's save is under `00172b00` instead; `vc/local/saves/empty/` holds Kristall's save before a game. A `sav.dat` is the 32 KB SRAM followed by a 16-byte footer, so `utils/pyboy_play.py --save` reads it too.

## Reach the player's room

From an empty save, this movie taps A through a new game; its first taps answer the dialogs above. START, every 3 s until 70 s, leaves the initial options. With the German text the naming screen comes at about 100 s, after the last START, so the A taps type the name `Aaaaaaa`. The room shows from about 135 s (the debug build: about 100 s).

```sh
base="A:4:0.15;A:6:0.15;A:9:0.15;A:13:0.15;A:15:0.15;A:17:0.15"
starts=$(python3 -I -c "print(';'.join(f'START:{22.75+i*3:g}:0.12' for i in range(17)))")
mash=$(python3 -I -c "print(';'.join(f'A:{22+i*1.5:g}:0.12' for i in range(135)))")
python3 -I vc/gen_ctm.py vc/local/movies/room.ctm 0004000000172800 230 "$base;$starts;$mash"
python3 -I vc/playtest.py vc/local/out/<name>.game.cxi --movie vc/local/movies/room.ctm --shots 28,55,85,100,115,135
```

The shots show the initial options' last box, Elm's speech, the choice of the player's picture, the naming screen, the end of the speech and the room. To act in the room, cut the mash at 140 s (`range(80)`) and go on after it: `LEFT:146:0.25;UP:148:0.25;UP:150:0.1;A:152:0.12` faces and switches on the PC.

**Kristall, for comparison.** Azahar doesn't launch a `.cia` directly, so extract the Base CIA's game content once, then play it with a movie for Kristall's program ID. Kristall asks Junge or Mädchen first, confirms the hour and the minutes separately, and prints text more slowly. These taps reach the main menu (20 s), the clock (44–58 s), Oak's speech (64–108 s), the naming screen (112 s) and the room (about 184 s). From the room they read the PC (213 s) and the poster (233 s):

```sh
vc/local/bin/ctrtool --contents=vc/local/out/kristall vc/local/dumps/kristall-vc-v0.1.0.standard.cia
mv vc/local/out/kristall.0000.00000002 vc/local/out/kristall.game.cxi
kbase="A:4:0.15;A:6:0.15;A:9:0.15;A:13:0.15;A:15:0.15;START:20:0.15;$(python3 -I -c "print(';'.join(f'A:{t}:0.15' for t in range(24,53,4)))")"
ktaps=$(python3 -I -c "print(';'.join(f'A:{56+i*1.8:g}:0.12' for i in range(75)))")
kroom="UP:200:0.25;LEFT:202:0.25;UP:204:0.08;A:205.5:0.12;A:208:0.12;B:211:0.12;B:213:0.12;RIGHT:216:0.25;RIGHT:217.5:0.25;RIGHT:219:0.25;RIGHT:220.5:0.25;UP:222.5:0.25;A:224.5:0.12;A:227.5:0.12"
python3 -I vc/gen_ctm.py vc/local/movies/kristall.ctm 0004000000172B00 234 "$kbase;$ktaps;$kroom"
python3 -I vc/playtest.py vc/local/out/kristall.game.cxi --movie vc/local/movies/kristall.ctm --shots 20,44,50,58,64,76,112,190,213,233
```

## Watch the intro

Any button during the intro skips to the title, so this movie answers only the three dialogs of an empty save. The Unown spell KRISTALL at about 63 s, and the title follows at about 69 s:

```sh
python3 -I vc/gen_ctm.py vc/local/movies/intro.ctm 0004000000172800 95 "A:4:0.15;A:7:0.15;A:12.5:0.15"
python3 -I vc/playtest.py vc/local/out/<name>.game.cxi --movie vc/local/movies/intro.ctm --shots 21,33,51,63,69
```

## Debug build: walk to the Cable Club

In the debug build (`make debug vc`) the radio in the player's room hands out the debug items and warps to Goldenrod City. Holding A+B walks through walls, and it also runs: a running step takes 8 frames, so a 0.13 s tap sometimes moves two tiles. Under A+B tap for 0.07 s, with one more tap whenever the direction changes, because a short tap in a new direction only turns the player. Plain walking needs 0.2 s taps; at 0.13 s a tap can still only turn.

This movie walks from the warp through the PokéCom Center to the trade receptionist upstairs, answers Ja twice (trade, then save), reaches the console's own wireless menu, invites a partner, cancels, and picks End communication:

```sh
base="A:4:0.15;A:6:0.15;A:9:0.15;A:13:0.15;A:15:0.15;A:17:0.15"
starts=$(python3 -I -c "print(';'.join(f'START:{22.75+i*3:g}:0.12' for i in range(17)))")
mash=$(python3 -I -c "print(';'.join(f'A:{22+i*1.5:g}:0.12' for i in range(80)))")
radio="UP:146:0.25;UP:148.5:0.1;A:150.5:0.12;$(python3 -I -c "print(';'.join(f'A:{153+i*1.5:g}:0.12' for i in range(40)))")"
walk=$(python3 -I -c "
t = ['A:215.5:9.4', 'B:215.5:9.4']
t += [f'DOWN:{216+0.4*i:.2f}:0.07' for i in range(14)] + [f'RIGHT:{222+0.4*i:.2f}:0.07' for i in range(6)]
t += ['UP:225.5:0.2'] + [f'LEFT:{229+0.45*i:.2f}:0.2' for i in range(7)]
t += [f'RIGHT:{235+0.45*i:.2f}:0.2' for i in range(5)] + [f'UP:{237.6+0.45*i:.2f}:0.2' for i in range(4)] + ['UP:239.6:0.2']
t += [f'A:{241+2.5*i:g}:0.12' for i in range(10)] + ['A:270:0.12', 'A:275:0.12', 'B:290:0.12', 'DOWN:294:0.12', 'DOWN:296:0.12', 'A:298.5:0.12']
t += ['A:340:0.12', 'A:350:0.12', 'A:360:0.12']
print(';'.join(t))")
python3 -I vc/gen_ctm.py vc/local/movies/link.ctm 0004000000172800 385 "$base;$starts;$mash;$radio;$walk"
python3 -I vc/playtest.py vc/local/out/<name>.game.cxi --movie vc/local/movies/link.ctm --shots 213,244,254,270,292,297,318,343,363
```

The shots show Goldenrod City, the receptionist, the trade question, the wireless menu, "Waiting for a partner to join", the menu again, and after End communication "Bitte warten!" for 15–20 s, then the timeout text "Die Verbindung wurde aufgrund fehlender Aktionen abgebrochen."

The first attempt's longer Azahar recipes (the PC, the Pokémon screens, Kristall played in stages over several saves) are in this file on the branch `archive/first-attempt`.

## Install on the 3DS

1. Copy the `.cia` into the SD card's `cia/` folder.
2. Run `dot_clean -m /Volumes/<card>` before ejecting. macOS writes `._*` files even with `cp -X`, and a `._*.firm` in `luma/payloads/` stops GodMode9 from starting.
3. Install with FBI.
