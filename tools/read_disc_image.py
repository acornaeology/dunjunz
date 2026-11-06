"""Read a disc image sector by sector through an emulated 8271 and write an SSD.

For images oaknut cannot open (HFE captures), this inserts the image in
drive 0 of a beebium Model B with the 8271 controller and DFS, and drives
the controller with OSWORD &7F through a small machine-code stub at &2E00
(the parameter block is at &2F00 and the data buffer at &3000). For each
track it reads the sector IDs (8271 Read ID). A track holding sectors 0-9
of 256 bytes, numbered with its own track number, is read whole into the
SSD. Any other track is reported: each sector it does have is read
individually, and the SSD gets zeros in its place.

Writes OUT.ssd (tracks 0-39) and OUT.json (per track: the IDs found in
one revolution, the 8271 result codes, and the data of any non-standard
sectors).

Usage: uv run python tools/read_disc_image.py IMAGE_FILEPATH OUT_FILEPATH_STEM [TRACKS]
"""

import json
import sys
from pathlib import Path

from beebium.client import Beebium

STUB_ADDR = 0x2E00
DONE_ADDR = 0x2EFF
BLOCK_ADDR = 0x2F00
BUFFER_ADDR = 0x3000

# LDA #&7F : LDX #<BLOCK : LDY #>BLOCK : JSR OSWORD : LDA #1 : STA DONE : RTS
STUB = bytes([
    0xA9, 0x7F,
    0xA2, BLOCK_ADDR & 0xFF,
    0xA0, BLOCK_ADDR >> 8,
    0x20, 0xF1, 0xFF,
    0xA9, 0x01,
    0x8D, DONE_ADDR & 0xFF, DONE_ADDR >> 8,
    0x60,
])

READ_DATA = 0x53  # 8271 read data (multi-sector), drive 0
READ_ID = 0x5B    # 8271 read ID, drive 0
SECTORS_PER_TRACK = 10
SSD_TRACKS = 40


class Controller:
    """OSWORD &7F calls made by typing CALL at the BASIC prompt."""

    def __init__(self, bbc):
        self.bbc = bbc
        address_space = bbc.memory.address
        self._write = address_space.bus.write
        self._read = address_space.peek.read
        self._write(STUB_ADDR, STUB)

    def osword(self, command, params, buffer_length=0):
        if buffer_length:
            self._write(BUFFER_ADDR, bytes(buffer_length))
        block = (
            bytes([0])
            + (0xFFFF0000 | BUFFER_ADDR).to_bytes(4, "little")
            + bytes([len(params), command])
            + bytes(params)
            + b"\xff"
        )
        self._write(BLOCK_ADDR, block)
        self._write(DONE_ADDR, b"\0")
        self.bbc.keyboard.type(f"CALL&{STUB_ADDR:X}\r")
        if not self.bbc.run_until_or_timeout(
            lambda: self._read(DONE_ADDR, 1)[0] == 1, 30.0
        ):
            raise RuntimeError("OSWORD &7F did not return")
        self.bbc.debugger.run()
        result = self._read(BLOCK_ADDR + 7 + len(params), 1)[0]
        return result, self._read(BUFFER_ADDR, buffer_length) if buffer_length else b""

    def read_ids(self, track, count=20):
        result, data = self.osword(READ_ID, [track, 0, count], 4 * count)
        return result, [tuple(data[i:i + 4]) for i in range(0, len(data), 4)]

    def read_sectors(self, track, sector, count, size_code=1):
        length = count * (128 << size_code)
        return self.osword(READ_DATA, [track, sector, (size_code << 5) | count], length)


def one_revolution(ids):
    """The IDs up to the point where the first one comes round again."""
    first = ids[0]
    if first in ids[1:]:
        return ids[: ids[1:].index(first) + 1]
    return ids


def hex_id(sector_id):
    return "".join(f"{b:02X}" for b in sector_id)


def main() -> None:
    image_filepath = Path(sys.argv[1])
    out_stem = Path(sys.argv[2])
    tracks = int(sys.argv[3]) if len(sys.argv) > 3 else 42
    report, ssd = [], bytearray()
    with Beebium.launch(variant="model-b", preset="model-b-8271-disc") as bbc:
        bbc.system.set_speed_multiplier(0.0)
        bbc.wait_until_ready()
        bbc.basic.wait_for_prompt()
        bbc.disc.drive0.insert(image_filepath, write_protect=True)
        fdc = Controller(bbc)
        for track in range(tracks):
            id_result, ids = fdc.read_ids(track)
            ids = one_revolution(ids)
            standard = sorted(ids) == [(track, 0, s, 1) for s in range(SECTORS_PER_TRACK)]
            entry = {
                "track": track,
                "id_result": id_result,
                "ids": [hex_id(i) for i in ids],
                "standard": standard,
            }
            if standard:
                read_result, data = fdc.read_sectors(track, 0, SECTORS_PER_TRACK)
                entry["read_result"] = read_result
            else:
                data = bytes(SECTORS_PER_TRACK * 256)
                entry["sectors"] = []
                if id_result == 0:
                    for c, _, r, n in ids:
                        read_result, sector = fdc.read_sectors(c, r, 1, n)
                        entry["sectors"].append(
                            {"id": hex_id((c, _, r, n)), "result": read_result, "data": sector.hex()}
                        )
            if track < SSD_TRACKS:
                ssd += data
            report.append(entry)
            status = "standard" if standard else f"non-standard, IDs {' '.join(entry['ids'])}"
            print(f"track {track:2}: ID result &{id_result:02X}, {status}", flush=True)
    out_stem.with_suffix(".ssd").write_bytes(ssd)
    out_stem.with_suffix(".json").write_text(json.dumps(report, indent=1) + "\n")


if __name__ == "__main__":
    main()
