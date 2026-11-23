# Build a 4 MB ROM and patch Virtual Console to run it

German text doesn't fit in 2 MB, which is MBC3's maximum. On 2026-11-14 the ROM had about 24 KB free, and German needs an estimated 67–100 KB more. So the translation is a 4 MB MBC3 ROM ("MBC30"), packaged with poke-cia's MBC30 patch, which widens the Virtual Console emulator's ROM bank mask from 7 to 8 bits. This was verified in Azahar and on a New 3DS, using the Kristall VC v0.1.0 Base CIA, and verified again in Azahar on 2026-11-23 after the restart.

## Considered Options

- **Stay at 2 MB by cutting content:** the 40–75 KB shortfall is far beyond what upstream's space optimisations free up.
- **Write German no longer than the English:** across about 108,000 words of source text, this would visibly hurt the translation.
- **MBC5 at 4 MB:** it has no real-time clock, and there's no documented route for it on Virtual Console.

## Consequences

- `layout.link` pins the `"Title"` section to bank `$FF`, so every build is 4 MB, and floating sections fill the banks below it. `tools/bankends.c` counts 256 banks instead of 128.
- Virtual Console runs the translation only from a CIA built with the MBC30 patch (`vc/build_cia.sh` always applies it). Unpatched, the game crashes when the title screen should appear (Polished's crash screen, "Error: 001", `rst 38h`).
- Map setup commands (`engine/overworld/map_setup.asm`) and the script stack (`CallCallback` and `ExitScriptSubroutine` in `engine/overworld/scripting.asm`) kept a flag in bit 7 of a bank byte, which broke code above bank `$7F`. Nothing read either flag, and both are gone. New code keeps flags out of bank bytes too: the linker can place any floating section above `$7F`.
- Emulators without MBC30 support (e.g. VBA, GameYob, Goomba Color) can't run it. mGBA, SameBoy, BGB and PyBoy 2.9 can.
