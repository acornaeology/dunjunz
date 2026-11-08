"""List or export the files on a UEF cassette image.

    uv run python tools/read_uef.py UEF_FILEPATH            # catalogue
    uv run python tools/read_uef.py UEF_FILEPATH OUT_DIRPATH  # export

A UEF file (optionally gzipped) is a sequence of chunks: a 2-byte id and
a 4-byte length, little-endian, then the body. Chunk &0100 carries the
bytes of one stretch of tape data (8N1); the others are carrier tone
(&0110), gaps (&0112) and the like, which carry no file data. Each
Acorn cassette block starts with the sync byte &2A, then the filename
(up to 10 characters, zero-terminated), load and exec addresses (4 bytes
each), block number and data length (2 each), a flag byte (bit 7: last
block), 4 spare bytes, and a CRC of the header; then the data and its
CRC. Both CRCs are CRC-16/XMODEM (polynomial &1021), high byte first.

Exported files are written with a `.inf` sidecar (name, load, exec,
length), as `oaknut-disc export` writes them. A file whose blocks are
missing, out of order or fail a CRC is reported and not exported.
"""

import argparse
import gzip
import struct
from dataclasses import dataclass, field
from pathlib import Path

SYNC = 0x2A
LAST_BLOCK = 0x80


def crc16(data: bytes) -> int:
    crc = 0
    for byte in data:
        crc ^= byte << 8
        for _ in range(8):
            crc = ((crc << 1) ^ 0x1021) & 0xFFFF if crc & 0x8000 else (crc << 1) & 0xFFFF
    return crc


@dataclass
class TapeFile:
    name: str
    load_addr: int
    exec_addr: int
    data: bytearray = field(default_factory=bytearray)
    next_block: int = 0
    problems: list[str] = field(default_factory=list)
    complete: bool = False


def chunks(uef: bytes):
    if uef[:2] == b"\x1f\x8b":
        uef = gzip.decompress(uef)
    if not uef.startswith(b"UEF File!\0"):
        raise ValueError("not a UEF file")
    pos = 12
    while pos + 6 <= len(uef):
        chunk_id, length = struct.unpack_from("<HI", uef, pos)
        yield chunk_id, uef[pos + 6:pos + 6 + length]
        pos += 6 + length


def read_files(uef: bytes) -> list[TapeFile]:
    files: list[TapeFile] = []
    for chunk_id, body in chunks(uef):
        if chunk_id != 0x0100 or not body or body[0] != SYNC:
            continue
        end = body.index(0, 1)
        name = body[1:end].decode("latin-1")
        header = body[end + 1:end + 18]
        load_addr, exec_addr, number, length, flag = struct.unpack_from("<IIHHB", header)
        (header_crc,) = struct.unpack_from(">H", body, end + 18)
        data = body[end + 20:end + 20 + length]
        current = files[-1] if files and not files[-1].complete and files[-1].name == name else None
        if number == 0 or current is None:
            current = TapeFile(name, load_addr, exec_addr)
            files.append(current)
        if header_crc != crc16(body[1:end + 18]):
            current.problems.append(f"block {number}: header CRC")
        if length:
            (data_crc,) = struct.unpack_from(">H", body, end + 20 + length)
            if data_crc != crc16(data):
                current.problems.append(f"block {number}: data CRC")
        if number != current.next_block:
            current.problems.append(f"block {number}: expected {current.next_block}")
        current.next_block = number + 1
        current.data += data
        if flag & LAST_BLOCK:
            current.complete = True
    return files


def main():
    parser = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    parser.add_argument("uef_filepath")
    parser.add_argument("out_dirpath", nargs="?")
    args = parser.parse_args()
    files = read_files(Path(args.uef_filepath).read_bytes())
    out_dirpath = Path(args.out_dirpath) if args.out_dirpath else None
    if out_dirpath:
        out_dirpath.mkdir(parents=True, exist_ok=True)
    for f in files:
        status = "; ".join(f.problems + ([] if f.complete else ["no last block"])) or "ok"
        print(f"{f.name:10s} {f.load_addr:08X} {f.exec_addr:08X} {len(f.data):06X}  {status}")
        if out_dirpath and status == "ok":
            (out_dirpath / f.name).write_bytes(f.data)
            (out_dirpath / f"{f.name}.inf").write_text(
                f"{f.name} {f.load_addr:08X} {f.exec_addr:08X} {len(f.data):08X}\n")


if __name__ == "__main__":
    main()
