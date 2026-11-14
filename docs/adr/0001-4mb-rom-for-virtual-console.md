# Build a 4 MB ROM and patch Virtual Console to run it

German text doesn't fit in 2 MB, which is MBC3's maximum. On 2026-11-14 the ROM had about 24 KB free, and German needs an estimated 67–100 KB more. So the translation is a 4 MB MBC3 ROM ("MBC30"), packaged with poke-cia's MBC30 patch, which widens the Virtual Console emulator's ROM bank mask from 7 to 8 bits. This was verified in Azahar and on a New 3DS, using the Kristall VC v0.1.0 base CIA.

## Considered Options

- **Stay at 2 MB by cutting content:** the 40–75 KB shortfall is far beyond what upstream's space optimisations free up.
- **Write German no longer than the English:** across about 108,000 words of source text, this would visibly hurt the translation.
- **MBC5 at 4 MB:** it has no real-time clock, and there's no documented route for it on Virtual Console.

## Consequences

- Virtual Console runs the translation only from a CIA built with the MBC30 patch. On an unpatched emulator it crashes at boot.
- Emulators without MBC30 support (e.g. VBA, GameYob, Goomba Color) can't run it. mGBA, SameBoy and BGB can.
- `tools/bankends.c` must count 256 banks instead of 128.
