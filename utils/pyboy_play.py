#!/usr/bin/env python3
"""Play a ROM in PyBoy for play-tests: inputs, screen text, screenshots, save states.

Needs PyBoy 2.9 and Pillow in a venv (CLAUDE.md, profile row "Emulator"):
    python3 -m venv <scratchpad>/venv && <scratchpad>/venv/bin/pip install pyboy==2.9.0 pillow

It knows two kinds of ROM:
- a Polished build: RAM addresses from the .sym next to the ROM, letters from constants/charmap.asm;
- Pokémon Kristall-Edition (SHA-1 accb5842...): pret's WRAM addresses, which the German ROM keeps,
  and Kristall's letters.

The save goes in as a stream and is never written back. The clock starts at day 0, 00:00:00 and
runs on emulated time, so the same inputs give the same frames.

Library (run with the venv's python, utils/ on sys.path):
    from pyboy_play import Game
    g = Game("polishedcrystal-3.2.3.gbc")   # save= a 32 KB SRAM image or a VC sav.dat
    g.new_game()                           # through a new game to the player's room
    g.press("up"); g.press("a"); g.wait(120)
    print(g.text())                        # the 20x18 tilemap as text
    g.shot("radio.png"); g.save_state("room.state")
    g.close()
Game.compare(a.cells(), b.cells()) lists the positions where two screens differ by glyph.

CLI (with the venv's python):
    <venv>/bin/python -I utils/pyboy_play.py ROM [--save F] [--state F | --new-game]
        [--inputs "up,a,wait 120"] [--shot F] [--save-state F]
"""
import argparse
import hashlib
import io
import os
import re
import sys

from pyboy import PyBoy

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRAM_SIZE = 0x8000  # 4 banks of 8 KB
SCREEN_W, SCREEN_H = 20, 18
BUTTONS = ("a", "b", "start", "select", "up", "down", "left", "right")
KRISTALL_SHA1 = "accb5842"

# Kristall's letters (pret's charmap plus the German ROM's ß at $be and decimal point at $f2)
KRISTALL_CHARS = {
    0x6D: "<COLON>", 0x6E: "<LV>", 0x70: "<PO>", 0x71: "<KE>", 0x72: "“", 0x73: "”", 0x74: "·", 0x75: "…",
    0x79: "┌", 0x7A: "─", 0x7B: "┐", 0x7C: "│", 0x7D: "└", 0x7E: "┘", 0x7F: " ",
    0x9A: "(", 0x9B: ")", 0x9C: ":", 0x9D: ";", 0x9E: "[", 0x9F: "]",
    0xBA: "à", 0xBB: "è", 0xBC: "é", 0xBD: "ù", 0xBE: "ß", 0xBF: "ç",
    0xC0: "Ä", 0xC1: "Ö", 0xC2: "Ü", 0xC3: "ä", 0xC4: "ö", 0xC5: "ü", 0xC6: "ë", 0xC7: "ï",
    0xC8: "â", 0xC9: "ô", 0xCA: "û", 0xCB: "ê", 0xCC: "î",
    0xD0: "'d", 0xD1: "'l", 0xD2: "'m", 0xD3: "'r", 0xD4: "'s", 0xD5: "'t", 0xD6: "'v",
    0xE0: "'", 0xE1: "<PK>", 0xE2: "<MN>", 0xE3: "-", 0xE6: "?", 0xE7: "!", 0xE8: ".", 0xE9: "&",
    0xEA: "é", 0xEB: "→", 0xEC: "▷", 0xED: "▶", 0xEE: "▼", 0xEF: "♂",
    0xF0: "¥", 0xF1: "×", 0xF2: "<DOT>", 0xF3: "/", 0xF4: ",", 0xF5: "♀",
    **{0x80 + i: chr(65 + i) for i in range(26)},
    **{0xA0 + i: chr(97 + i) for i in range(26)},
    **{0xF6 + i: str(i) for i in range(10)},
}
KRISTALL_RAM = {"wTilemap": 0xC4A0, "wMapGroup": 0xDCB5, "wMapNumber": 0xDCB6,
                "wYCoord": 0xDCB7, "wXCoord": 0xDCB8}
KRISTALL_ROOM = (24, 7)  # PLAYERS_HOUSE_2F in pret

# Different tiles that draw the same glyph, for comparing the two ROMs' screens
SAME_GLYPH = {"┃": "│", "━": "─", "<DOT>": "."}


def polished_chars():
    """Tile id -> glyph from the first charmap in constants/charmap.asm (the one without n-grams)."""
    chars = {}
    with open(os.path.join(ROOT, "constants", "charmap.asm"), encoding="utf-8") as f:
        block = f.read().split("newcharmap")[1]
    for name, value in re.findall(r'^\s*charmap "(.+?)",\s*\$([0-9a-f]{2})', block, re.M | re.I):
        chars.setdefault(int(value, 16), name)
    return {k: v for k, v in chars.items() if k >= 0x5E}  # lower ids are text commands


def polished_map(name):
    """(group, number) of a map, counted as constants/map_constants.asm counts them."""
    group = number = 0
    with open(os.path.join(ROOT, "constants", "map_constants.asm"), encoding="utf-8") as f:
        for line in f:
            if re.match(r"\s*newgroup\b", line):
                group, number = group + 1, 0
            elif m := re.match(r"\s*map_const (\w+),", line):
                number += 1
                if m.group(1) == name:
                    return group, number
    raise KeyError(name)


def read_sym(path):
    sym = {}
    with open(path, encoding="utf-8") as f:
        for line in f:
            if m := re.match(r"([0-9a-f]{2}):([0-9a-f]{4}) (\S+)", line, re.I):
                sym[m.group(3)] = int(m.group(2), 16)
    return sym


class Game:
    def __init__(self, rom, save=None):
        with open(rom, "rb") as f:
            self.kristall = hashlib.sha1(f.read()).hexdigest().startswith(KRISTALL_SHA1)
        if self.kristall:
            self.ram, self.chars, self.room = KRISTALL_RAM, KRISTALL_CHARS, KRISTALL_ROOM
        else:
            self.ram = read_sym(os.path.splitext(rom)[0] + ".sym")
            self.chars, self.room = polished_chars(), polished_map("PLAYERS_HOUSE_2F")
        sram = open(save, "rb").read()[:SRAM_SIZE] if save else bytes(SRAM_SIZE)  # a VC sav.dat adds 16 bytes
        self.pb = PyBoy(rom, window="null", ram_file=io.BytesIO(sram), sound_emulated=False, log_level="ERROR")
        self.pb.set_emulation_speed(0)
        self.frame = 0

    def close(self):
        self.pb.stop(save=False)

    def __getitem__(self, name):
        """The byte at a RAM label, e.g. g["wMapGroup"]."""
        return self.pb.memory[self.ram[name]]

    def wait(self, frames):
        self.pb.tick(frames, True)
        self.frame += frames

    def press(self, button, hold=4, after=16):
        """Press a button for `hold` frames, then let `after` more frames pass."""
        self.pb.button(button, hold)
        self.wait(hold + after)

    def hold(self, button, frames):
        self.pb.button_press(button)
        self.wait(frames)
        self.pb.button_release(button)
        self.wait(1)

    def map(self):
        return self["wMapGroup"], self["wMapNumber"]

    def new_game(self, limit=30000):
        """From power-on: START through the intro and title, then A until the player's room loads.

        On the naming screen A types the first letter until the name is full: AAAAAAA in Kristall,
        Aaaaaaa in Polished. Returns the frame the room loaded at."""
        if self.frame:
            raise RuntimeError("new_game() starts from power-on")
        self.wait(2400)
        while self.map() != self.room:
            if self.frame > limit:
                raise RuntimeError(f"no player's room after {limit} frames; screen:\n{self.text()}")
            early = self.frame < 3500 and self.frame % 200 == 0
            self.press("start" if early else "a")
        loaded = self.frame
        self.wait(60)  # let the map fade in
        return loaded

    def tiles(self):
        base = self.ram["wTilemap"]
        return [[self.pb.memory[base + r * SCREEN_W + c] for c in range(SCREEN_W)] for r in range(SCREEN_H)]

    def cells(self):
        """The tilemap as glyphs: one letter, a <TOKEN> or $xx for a tile the charmap doesn't name."""
        return [[self.chars.get(t, f"${t:02x}") for t in row] for row in self.tiles()]

    def text(self):
        """The tilemap as 18 lines of 20 characters; ◆ for a token or graphics tile."""
        return "\n".join("".join(c if len(c) == 1 else "◆" for c in row) for row in self.cells())

    @staticmethod
    def compare(a, b):
        """Positions where two cells() screens draw different glyphs: [(row, col, a, b)]."""
        return [(r, c, a[r][c], b[r][c]) for r in range(SCREEN_H) for c in range(SCREEN_W)
                if SAME_GLYPH.get(a[r][c], a[r][c]) != SAME_GLYPH.get(b[r][c], b[r][c])]

    def shot(self, path, scale=3):
        image = self.pb.screen.image.convert("RGB")
        image.resize((image.width * scale, image.height * scale), 0).save(path)  # 0: nearest

    def save_state(self, path):
        with open(path, "wb") as f:
            self.pb.save_state(f)

    def load_state(self, path):
        with open(path, "rb") as f:
            self.pb.load_state(f)


def run_inputs(game, inputs):
    """Comma-separated steps: a button name, "hold <button> <frames>" or "wait <frames>"."""
    for step in filter(None, (s.strip() for s in inputs.split(","))):
        words = step.split()
        if words[0] == "wait":
            game.wait(int(words[1]))
        elif words[0] == "hold" and words[1] in BUTTONS:
            game.hold(words[1], int(words[2]))
        elif words[0] in BUTTONS and len(words) == 1:
            game.press(words[0])
        else:
            raise ValueError(f"unknown input step: {step!r}")


def main():
    p = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    p.add_argument("rom")
    p.add_argument("--save", help="32 KB SRAM image or VC sav.dat to load; never written back")
    start = p.add_mutually_exclusive_group()
    start.add_argument("--state", help="PyBoy save state to load first")
    start.add_argument("--new-game", action="store_true", help="play a new game to the player's room first")
    p.add_argument("--inputs", default="", help='e.g. "up,a,wait 120,hold left 31"')
    p.add_argument("--shot", help="save a screenshot (3x) at the end")
    p.add_argument("--save-state", help="save a PyBoy state at the end")
    a = p.parse_args()

    g = Game(a.rom, a.save)
    try:
        if a.state:
            g.load_state(a.state)
        elif a.new_game:
            print(f"player's room {g.room[0]}:{g.room[1]} at frame {g.new_game()}")
        run_inputs(g, a.inputs)
        print(f"frame {g.frame}, map {g.map()[0]}:{g.map()[1]}")
        print(g.text())
        if a.shot:
            g.shot(a.shot)
        if a.save_state:
            g.save_state(a.save_state)
    finally:
        g.close()


if __name__ == "__main__":
    sys.exit(main())
