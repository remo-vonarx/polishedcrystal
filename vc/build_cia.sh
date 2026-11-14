#!/bin/bash
# Package a built ROM into a 3DS Virtual Console CIA (and a .game.cxi for Azahar) with poke-cia.
#
# Usage: vc/build_cia.sh <path/to/rom.gbc> [name]
#   Expects the matching VC patch next to the ROM (<rom>.patch, from `make vc`).
#   [name] defaults to the ROM's basename; outputs land in vc/local/out/<name>.{cia,game.cxi}.
#
# The MBC30 patch is always applied, so 4 MB ROMs work on Virtual Console. The script stops
# unless the emulator byte at 0xaa488 really is 0xff afterwards.
set -euo pipefail

VC=$(cd "$(dirname "$0")" && pwd)
L=$VC/local
ROM=$(cd "$(dirname "$1")" && pwd)/$(basename "$1")
NAME=${2:-$(basename "$ROM" .gbc)}
PATCH=${ROM%.gbc}.patch
BASE_CIA=$L/dumps/kristall-vc-v0.1.0.standard.cia
GNU_PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"  # poke-cia uses `env -C`, `cp -T`

[ -f "$ROM" ] && [ -f "$PATCH" ] || { echo "need $ROM and $PATCH (run 'make vc')" >&2; exit 1; }
[ -f "$BASE_CIA" ] || { echo "missing base CIA: $BASE_CIA (see vc/README.md)" >&2; exit 1; }

# poke-cia copies <repo_path>/<name>.{gbc,patch} after running `make <rom_targets>` there,
# so stage the files under a no-op Makefile instead of letting it rebuild the repo.
STAGE=$L/stage
mkdir -p "$STAGE" "$L/out"
cp "$ROM" "$STAGE/$NAME.gbc"
cp "$PATCH" "$STAGE/$NAME.patch"
printf '.PHONY: crystal vc\ncrystal vc:\n\t@true\n' > "$STAGE/Makefile"

cat > "$L/poke-cia/config.mk" <<EOF
repo_path   := $STAGE
rom_names   := $NAME
rom_targets := crystal vc
build_mbc30 := true
CTRTOOL     := $L/bin/ctrtool
MAKEROM     := $L/bin/makerom
EOF
[ -f "$L/poke-cia/$NAME.orig.cia" ] || cp "$BASE_CIA" "$L/poke-cia/$NAME.orig.cia"
chmod u+w "$L/poke-cia/$NAME.orig.cia"

(cd "$L/poke-cia" && PATH="$GNU_PATH" gmake cia)

byte=$(xxd -s 0xaa488 -l 1 -p "$L/poke-cia/$NAME/exefs/code.bin")
[ "$byte" = "ff" ] || { echo "MBC30 patch missing (byte 0xaa488 = $byte)" >&2; exit 1; }

cp "$L/poke-cia/$NAME.cia" "$L/poke-cia/$NAME.game.cxi" "$L/out/"
echo "built $L/out/$NAME.cia and $L/out/$NAME.game.cxi (MBC30 patch applied)"
