#!/usr/bin/env python3
"""Write an Azahar input movie (.ctm) from a timed button schedule.

Usage: python3 -I vc/gen_ctm.py <out.ctm> <program_id_hex> <duration_s> "<schedule>" [--revision HEX]
  schedule: semicolon-separated BUTTON:start_s:hold_s entries, e.g. "A:12:0.15;START:30:0.15"
  buttons:  A B SELECT START RIGHT LEFT UP DOWN R L X Y
  program_id: the title's program ID, e.g. 0004000000172800 for a poke-cia build

Layout follows src/core/movie.cpp in Azahar 2126.2: a 256-byte CTMHeader, then 7-byte
ControllerState records. Each HID poll (234 Hz) reads one PadAndCircle record followed by one
Touch record (verified for the Crystal VC title: no "Expected to read type" errors in the log).
A different revision only logs a warning, so the default works for other Azahar builds too.
"""
import argparse
import struct

POLL_HZ = 234
BITS = {"A": 0, "B": 1, "SELECT": 2, "START": 3, "RIGHT": 4, "LEFT": 5, "UP": 6,
        "DOWN": 7, "R": 8, "L": 9, "X": 10, "Y": 11}
TYPE_PAD, TYPE_TOUCH = 0, 1
AZAHAR_2126_2_REVISION = "219d743a1e698101fe1ab8bef43e6563126c3c27"
CLOCK_INIT = 1794657600  # 2026-11-14 12:00:00 UTC; fixed so runs are reproducible
MOVIE_ID = 0x504F4C4953484544  # "POLISHED"


def main():
    p = argparse.ArgumentParser()
    p.add_argument("out")
    p.add_argument("program_id")
    p.add_argument("duration", type=float)
    p.add_argument("schedule")
    p.add_argument("--revision", default=AZAHAR_2126_2_REVISION)
    a = p.parse_args()

    polls = int(a.duration * POLL_HZ)
    pad = [0] * polls
    for entry in filter(None, a.schedule.split(";")):
        name, start, hold = entry.split(":")
        first, last = int(float(start) * POLL_HZ), int((float(start) + float(hold)) * POLL_HZ)
        for i in range(first, min(last, polls)):
            pad[i] |= 1 << BITS[name.upper()]

    body = bytearray()
    for buttons in pad:
        body += struct.pack("<BHhh", TYPE_PAD, buttons, 0, 0)  # buttons, circle pad x/y
        body += struct.pack("<BHHBx", TYPE_TOUCH, 0, 0, 0)     # x, y, valid, pad to 7 bytes

    header = struct.pack("<4sQ20sQQ32sIQq156s", b"CTM\x1b", int(a.program_id, 16),
                         bytes.fromhex(a.revision), CLOCK_INIT, MOVIE_ID,
                         b"polishedcrystal-de".ljust(32, b"\0"), 1, polls, 0, bytes(156))
    with open(a.out, "wb") as f:
        f.write(header + body)
    print(f"wrote {a.out}: {polls} polls ({a.duration}s)")


if __name__ == "__main__":
    main()
