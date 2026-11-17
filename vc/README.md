# vc/: 3DS Virtual Console packaging and playtests

These scripts turn a `make vc` build into an installable 3DS title (CIA) and playtest it in [Azahar](https://github.com/azahar-emu/azahar). Azahar runs Nintendo's own Virtual Console emulator from the base CIA. Why a 4 MB ROM needs the MBC30 patch is explained in `docs/adr/0001-4mb-rom-for-virtual-console.md`.

## Local setup (`vc/local/`, git-ignored)

| Path | Contents | Source |
|---|---|---|
| `local/azahar/` | Azahar 2126.2, macOS arm64 (`Azahar.app`, `scripting/`) | azahar-emu/azahar releases |
| `local/bin/ctrtool`, `local/bin/makerom` | ctrtool v1.3.0, makerom v0.19.0 | 3DSGuy/Project_CTR releases |
| `local/poke-cia/` | poke-cia at `bf8eb80`, plus `seeddb.bin` | vulcandth/poke-cia; ihaveamac/3DS-rom-tools |
| `local/dumps/kristall-vc-v0.1.0.standard.cia` | Base CIA: your own Kristall VC dump | GodMode9, see below |

You also need `brew install make coreutils`. poke-cia requires GNU Make 4 (installed as `gmake`) and GNU `env -C` / `cp -T`.

**Dumping the base CIA** (requires Luma3DS and GodMode9):
1. Hold START *before* pressing power to start GodMode9.
2. HOME → Title manager → `[A:] SYSNAND SD` → Pokémon Kristall → Build CIA (standard).

The file in `gm9/out/` is already decrypted. Kristall VC v0.1.0 contains an emulator byte-identical to the English release's, so poke-cia's MBC30 patch applies unchanged.

## Build a CIA

```sh
make vc
vc/build_cia.sh polishedcrystal-<version>.gbc [name]   # -> vc/local/out/<name>.cia and .game.cxi
```

The title installs as `0004000000172800` (from poke-cia's `game.rsf`), separate from Kristall's `0004000000172B00`. The CIA bytes vary from build to build, but the `.game.cxi` is reproducible.

## Playtest in Azahar

```sh
python3 -I vc/gen_ctm.py vc/local/movies/boot.ctm 0004000000172800 70 \
  "A:4:0.15;A:6:0.15;A:8:0.15;A:10:0.15;A:12:0.15;A:14:0.15;A:16:0.15;A:18:0.15;A:20:0.15;START:35:0.15;A:40:0.15;A:45:0.15"
python3 -I vc/playtest.py vc/local/out/<name>.game.cxi --movie vc/local/movies/boot.ctm --shots 18,34,62
```

- Azahar runs with `HOME=vc/local/azahar-home`, so nothing touches `~/Library`. A window opens for the duration of the run.
- On every start, Virtual Console shows a "Restore points / Suspension points not supported" notice that needs an A press. The sample schedule taps A every 2 s until 20 s, which also skips the intro.
- Under a movie the game plays deterministically (fixed clock), but screenshots are timed by wall clock. Early shots shift with boot speed, so compare later or static screens. In the sample run, 34 s shows the options screen and 62 s shows "Will you check the clock for me?".
- Azahar stops at a modal "run Azahar via the app bundle" warning whenever its parent isn't launchd. `playtest.py` therefore starts it through a shell that exits at once. Being detached, it reports no exit code: Azahar's console output is in `<out>/azahar_stdout.txt`, and after a full run the emulator log is copied to `<out>/azahar_log.txt`.
- Azahar ignores SIGTERM, so `playtest.py` kills it. That rules out recording movies with `-r` by script, because a recording is only saved on a clean exit.

## Reach the player's room

This movie plays a new game from power-on to the player's room, timed for the German new-game text. It taps A through the intro, leaves the options with START, keeps the clock at Tag 10:00 and taps A through Elm's speech and the photo choice. On the naming screen it types "Aaaaaaa" (7 letters, the longest name) and moves the cursor over Lösch and Umsch and back to Ende. In the room (at about 128 s) it reads the radio, the PC, the Pokémon Journal and the Town Map poster.

```sh
base="A:4:0.15;A:6:0.15;A:9:0.15;A:13:0.15;A:15:0.15;A:17:0.15;START:22:0.15"
speech=$(python3 -I -c "print(';'.join(f'A:{25+i*1.8:g}:0.12' for i in range(35)))")
name=$(python3 -I -c "print(';'.join(f'A:{t}:0.12' for t in range(90,97)))");name="$name;LEFT:98:0.12;LEFT:100:0.12;RIGHT:102:0.12;RIGHT:103:0.12;A:105:0.12"
tail=$(python3 -I -c "print(';'.join(f'A:{107+i*1.8:g}:0.12' for i in range(11)))")
room="UP:130:0.25;A:132:0.12;A:134:0.12;A:136:0.12;A:138:0.12;A:148:0.12;LEFT:156:0.25;UP:158:0.08;A:159.5:0.12;A:162:0.12;B:165:0.12;B:167:0.12;RIGHT:170:0.25;RIGHT:171.5:0.25;RIGHT:173:0.25;UP:175:0.08"
room="$room;$(python3 -I -c "print(';'.join(f'A:{t}:0.12' for t in range(177,193,2)))");RIGHT:195:0.25;UP:197:0.25;A:199:0.12;A:202:0.12"
python3 -I vc/gen_ctm.py vc/local/movies/room.ctm 0004000000172800 212 "$base;$speech;$name;$tail;$room"
python3 -I vc/playtest.py vc/local/out/<name>.game.cxi --movie vc/local/movies/room.ctm --shots 33,37,83,90,102,129,137,163,186,203
```

The shots show the clock, the Ja/Nein box, the photo choice, the naming screen, the room, the radio, the PC, the journal and the poster.

- **Timing.** Screenshots go by wall-clock time, inputs by emulated time, and the emulator falls 1–5 s behind as a run goes on. A shot can show the state of one or two steps back, or a scroll half done. Leave at least 2 s between inputs that wait for a text box to close.
- **Other clock responses.** Drop the A taps at 32.2 s and later in `speech`, then press DOWN or UP every 0.35 s from 33 s, and A one second later. The remaining A taps follow, shifted by the time the presses take. From 10, 4×DOWN gives 6 (Vormittag), 8×UP gives 18 (Abend) and 6×DOWN gives 4 (Nacht).
- **Each option description.** On the options screen (from about 20 s), A turns a description's pages and DOWN moves to the next option, one input every 1.5 s.

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

To read Kristall's radio instead, replace `kroom` with the room part above shifted by 70 s: the radio shows at 209–249 s.

## Reach the PC

The room movie turns on the player's PC with `A:159.5`, and `A:162` opens its menu. A new game's PC and Bag are both empty. When a sub-screen closes, the menu cursor goes back to the top entry. Item ablegen opens the Bag on its Items pocket, and RIGHT moves to Medicine.

**Pokémon Center PC.** There's no Pokémon Center near the room, so a test clone, never committed, opens it from the room's PC. In `PlayersHousePC` (`maps/PlayersHouse2F.asm`):
- replace `special Special_PlayersHousePC` / `iffalse_endtext` with `special PokemonCenterPC` / `endtext`
- before `opentext`, add `givepoke PIKACHU, 5`, because the PC refuses to open without a party Pokémon
- add `setflag ENGINE_POKEDEX` to show Eichs PC
- add items to move, such as `giveitems_unsafe POTION, 12` and `givekeyitem BICYCLE`

`givepoke` asks for a nickname, and the movie answers B. Played after the room movie's `base`, `speech`, `name` and `tail`, these taps deposit 10 Potions, try the Bicycle, withdraw one Potion, toss one and open Bills PC:

```sh
pcroom="UP:130:0.25;A:132:0.12;A:134:0.12;A:136:0.12;A:138:0.12;A:148:0.12;LEFT:156:0.25;UP:158:0.08;A:159.5:0.12"
pc="A:162;A:165;B:168;A:171;DOWN:174;A:176;A:179;A:182;A:185;A:188;DOWN:191;A:193;RIGHT:197;A:199;RIGHT:201.5;DOWN:203;A:205;A:208;LEFT:210;LEFT:211.5;A:213;A:216;B:218.5;A:221;A:224;A:227;A:230;B:233;DOWN:235;DOWN:236.5;A:238;A:241;A:244;A:247;A:250;A:253;B:256;B:259;A:262"
pc=$(python3 -I -c "import sys; print(';'.join(e + (':0.25' if e.split(':')[0] in ('UP','DOWN','LEFT','RIGHT') else ':0.12') for e in sys.argv[1].split(';')))" "$pc")
python3 -I vc/gen_ctm.py vc/local/movies/pc.ctm 0004000000172800 280 "$base;$speech;$name;$tail;$pcroom;$pc"
```

From the Pokémon Center menu, two DOWNs reach Eichs PC; B declines the rating and closes it. Three DOWNs reach Ausloggen.

**Title-screen prompts.** Hold a combo from 3 s for 12 s: `UP:3:12;B:3:12;SELECT:3:12` clears the save, `LEFT:3:12;B:3:12` resets the initial options, and `DOWN:3:12;B:3:12` resets the clock, where `DOWN:21:0.15;A:22.5:0.15` answers Ja. The prompts show from about 8 s. Kristall uses Up+Select+B and Down+Select+B, and its clock reset needs a save file.

## Reach the Pokémon screens

The debug build's radio fills the Pokédex and gives six Pokémon, then warps to Goldenrod. A test clone, never committed, changes three things in the `if DEF(DEBUG)` part of `PlayersHouseRadio` (`maps/PlayersHouse2F.asm`):
- `ABILITY_2` → `ABILITY_1` in `wPartyMon1Personality`, so the lead Mewtwo's Pressure pops up when it enters battle
- the Pupitar block (from `; evolve during battle` to `; fill pokedex`) → `giveegg TOGEPI`, an egg in the sixth slot
- `warpfacing DOWN, GOLDENROD_CITY, 13, 14` → `loadwildmon GYARADOS, 30`, `startbattle`, `reloadmapafterbattle`

Build it with `make debug vc` and package `polishedcrystal-debug-<version>.gbc`. After the room movie's `base`, `speech`, `name` and `tail`, these taps answer the radio's day question with A and tap B through the rest (its clock question, each "received" text and each nickname question), then fight the Gyarados. In battle they open the move list, run away, then open the Pokédex list. From there they search by name and turn through Abra's four pages, set a type and an egg group in the search, and open the party and the third Pokémon's summary pages:

```sh
radio="UP:130:0.25;A:132:0.12;A:135.5:0.12;A:138:0.12;$(python3 -I -c "print(';'.join(f'B:{140+i*1.5:g}:0.12' for i in range(18)))")"
tour="A:185:0.12;A:188:0.12;B:191:0.12;A:193:0.12;B:196:0.12;DOWN:198:0.2;RIGHT:199:0.2;A:200.5:0.12;A:203:0.12;START:207:0.12;A:208.5:0.12;START:212:0.12;RIGHT:214:0.2;START:216:0.12;A:220:0.12;RIGHT:222:0.2;RIGHT:224:0.2;RIGHT:226:0.2;B:228:0.12;B:230:0.12;DOWN:232:0.2;RIGHT:233:0.2;RIGHT:234:0.2;DOWN:235:0.2;DOWN:236:0.2;RIGHT:237.5:0.2;RIGHT:238.5:0.2;B:242:0.12;B:243.5:0.12;DOWN:246:0.2;A:247.5:0.12;DOWN:251:0.2;DOWN:252:0.2;A:253.5:0.12;A:255:0.12;RIGHT:258:0.2;RIGHT:260:0.2;RIGHT:262:0.2"
python3 -I vc/gen_ctm.py vc/local/movies/pokemon.ctm 0004000000172800 268 "$base;$speech;$name;$tail;$radio;$tour"
```

The debug build runs slower: on 2026-11-17 the screens showed about 18 s after their inputs, so take shots every 2 s from 190 s to 290 s. The Pokédex has no A–Z mode; START opens its search, RIGHT sets "by Name" and START runs it. The Bad Egg appears only after a box checksum error and isn't reached this way.

## Install on the 3DS

1. Copy the `.cia` into the SD card's `cia/` folder.
2. Run `dot_clean -m /Volumes/<card>` before ejecting. macOS writes `._*` files even with `cp -X`, and a `._*.firm` in `luma/payloads/` stops GodMode9 from starting.
3. Install with FBI.
