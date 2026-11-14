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

## Install on the 3DS

1. Copy the `.cia` into the SD card's `cia/` folder.
2. Run `dot_clean -m /Volumes/<card>` before ejecting. macOS writes `._*` files even with `cp -X`, and a `._*.firm` in `luma/payloads/` stops GodMode9 from starting.
3. Install with FBI.
