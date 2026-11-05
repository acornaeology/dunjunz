"""Read the files out of a ROM filing system (ROMFS) sideways image.

The Dunjunz level images (Dunjun1, Dunjun2) are Beebug ROMFS ROMs: a
service-ROM header followed by files in cassette block format. Every block
starts with '*' and a full header, except that blocks other than the first
and last of a file may be abbreviated to a single '#', followed directly by
256 data bytes and their CRC. The image ends with '+'.

Usage: uv run python tools/romfs.py IMAGE_FILEPATH [EXTRACT_DIRPATH]
"""

import sys
from dataclasses import dataclass
from pathlib import Path

ROM_BASE = 0x8000


@dataclass
class RomfsFile:
    name: str
    load_addr: int
    exec_addr: int
    data: bytes
    block_addrs: list


def crc16(data: bytes) -> int:
    """Acorn cassette/ROMFS CRC (XMODEM polynomial, as in the MOS)."""
    crc = 0
    for byte in data:
        crc ^= byte << 8
        for _ in range(8):
            crc = ((crc << 1) ^ 0x1021) if crc & 0x8000 else (crc << 1)
            crc &= 0xFFFF
    return crc


def read_files(image: bytes) -> list[RomfsFile]:
    # The ROMFS data starts after the service-ROM code; the first file block
    # is the first '*' that is followed by a well-formed header.
    pos = image.index(b"*", 0x10)
    while not _is_header(image, pos):
        pos = image.index(b"*", pos + 1)
    files: list[RomfsFile] = []
    current = None
    while image[pos] != ord("+"):
        marker = image[pos]
        if marker == ord("#"):
            data = image[pos + 1 : pos + 1 + 256]
            stored = int.from_bytes(image[pos + 257 : pos + 259], "big")
            assert crc16(data) == stored, f"data CRC at &{ROM_BASE + pos:04X}"
            current.data += data
            current.block_addrs.append(ROM_BASE + pos)
            pos += 259
            continue
        assert marker == ord("*"), f"unexpected &{marker:02X} at &{ROM_BASE + pos:04X}"
        name_end = image.index(0, pos + 1)
        name = image[pos + 1 : name_end].decode("ascii")
        header = image[name_end + 1 : name_end + 18]
        load_addr = int.from_bytes(header[0:4], "little")
        exec_addr = int.from_bytes(header[4:8], "little")
        block_number = int.from_bytes(header[8:10], "little")
        length = int.from_bytes(header[10:12], "little")
        stored_header_crc = int.from_bytes(image[name_end + 18 : name_end + 20], "big")
        assert crc16(image[pos + 1 : name_end + 18]) == stored_header_crc, (
            f"header CRC at &{ROM_BASE + pos:04X}")
        data_start = name_end + 20
        data = image[data_start : data_start + length]
        if length:
            stored = int.from_bytes(image[data_start + length : data_start + length + 2], "big")
            assert crc16(data) == stored, f"data CRC at &{ROM_BASE + pos:04X}"
        if block_number == 0:
            current = RomfsFile(name, load_addr, exec_addr, b"", [])
            files.append(current)
        current.data += data
        current.block_addrs.append(ROM_BASE + pos)
        pos = data_start + length + (2 if length else 0)
    return files


def _is_header(image: bytes, pos: int) -> bool:
    try:
        name_end = image.index(0, pos + 1, pos + 12)
    except ValueError:
        return False
    name = image[pos + 1 : name_end]
    return bool(name) and all(0x21 <= c < 0x7F for c in name)


def main() -> None:
    image_filepath = Path(sys.argv[1])
    extract_dirpath = Path(sys.argv[2]) if len(sys.argv) > 2 else None
    for f in read_files(image_filepath.read_bytes()):
        blocks = " ".join(f"&{a:04X}" for a in f.block_addrs)
        print(f"{f.name:10} load=&{f.load_addr:08X} exec=&{f.exec_addr:08X} "
              f"length=&{len(f.data):04X} blocks: {blocks}")
        if extract_dirpath:
            extract_dirpath.mkdir(parents=True, exist_ok=True)
            (extract_dirpath / f.name).write_bytes(f.data)


if __name__ == "__main__":
    main()
