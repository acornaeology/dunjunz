"""Decode Dunjunz level files and draw their maps as text.

Reads the decrypted level data (the crack's L1-L25 files are stored
decrypted) and prints the wall map, with objects, doors, keys and
trapdoors marked, using the layout established in dunjunz_common/game.py
(annotate_level_file).

Usage: uv run python tools/levels.py LEVEL_NUMBER [--rooms-high N]
"""

import argparse
import io
import zipfile
from pathlib import Path

REPO_DIRPATH = Path(__file__).resolve().parent.parent
TAPE_ZIP_FILEPATH = REPO_DIRPATH / "versions" / "nvg-dunjunz-tape" / "Dunjunz-tape.zip"
BASE = 0x6B00

OBJECT_SYMBOLS = {0x28: "$", 0x29: "f", 0x2A: "+", 0x2B: "T", 0x51: "E",
                  0x5F: "b", 0x60: "h", 0x61: "p", 0x62: "w", 0x63: "s"}


def level_bytes(number: int) -> bytes:
    with zipfile.ZipFile(TAPE_ZIP_FILEPATH) as z:
        return z.read(f"L{number}")


def field(data, addr, length):
    return data[addr - BASE:addr - BASE + length]


def decode(data):
    objects = [(field(data, 0x6B00, 0x20)[i], field(data, 0x6B20, 0x20)[i],
                field(data, 0x6B40, 0x20)[i]) for i in range(1, 31)]
    doors = [(field(data, 0x6B60, 0x15)[i], field(data, 0x6B75, 0x15)[i],
              field(data, 0x6B8A, 0x15)[i]) for i in range(1, 21)]
    keys = [(field(data, 0x6BA0, 0x15)[i], field(data, 0x6BB5, 0x15)[i]) for i in range(1, 21)]
    trapdoors = list(zip(field(data, 0x6BD0, 8), field(data, 0x6BD8, 8)))
    walls = field(data, 0x6BE0, 0xC9)
    object_free_map = field(data, 0x6CB0, 0xC9)
    return objects, doors, keys, trapdoors, walls, object_free_map


def bit(bitmap, x, y):
    offset = (y & 0xF8) * 4 + (x & 0xF8) + (y & 7)
    if offset >= len(bitmap):
        return None
    return bitmap[offset] & (0x80 >> (x & 7))


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("level", type=int)
    parser.add_argument("--rooms-high", type=int, default=4)
    args = parser.parse_args()
    objects, doors, keys, trapdoors, walls, object_free_map = decode(level_bytes(args.level))
    marks = {}
    for x, y, t in objects:
        if x != 0xFF:
            marks[(x, y)] = OBJECT_SYMBOLS.get(t, "d" if 0x53 <= t <= 0x5E else "?")
    for n, (x, y, s) in enumerate(doors, 1):
        if x not in (0, 0xFF):
            marks[(x, y)] = "D"
    for n, (x, y) in enumerate(keys, 1):
        if x not in (0, 0xFF):
            marks[(x, y)] = "k"
    for x, y in trapdoors:
        marks[(x, y)] = "o"
    for y in range(args.rooms_high * 8):
        if y % 8 == 0:
            print("+" + ("-" * 8 + "+") * 4)
        row = "|"
        for x in range(32):
            b = bit(walls, x, y)
            row += marks.get((x, y), "#" if b else ("." if b is not None else " "))
            if x % 8 == 7:
                row += "|"
        print(row)
    print("+" + ("-" * 8 + "+") * 4)
    print("objects:", [(x, y, f"&{t:02X}") for x, y, t in objects])
    print("doors:", doors)
    print("keys:", keys)
    print("trapdoors:", trapdoors)
    object_cells = {(x, y) for x, y, _ in objects}
    print("floor cells marked as possible object cells, with no object:",
          sum(1 for y in range(32) for x in range(32)
              if not bit(object_free_map, x, y) and not bit(walls, x, y)
              and (x, y) not in object_cells))


if __name__ == "__main__":
    main()
