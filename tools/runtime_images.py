"""Build each release's resident game image and compare them.

Reconstructs the bytes each release has in &0400-&2FFF and &6E80-&7FFF
when the game starts at &0D31, from the original files and the layouts
established in docs/history-and-provenance.md, then lists the address
ranges where the releases differ.

Usage: uv run python tools/runtime_images.py [--gap N]
"""

import argparse
from pathlib import Path

REPO_DIRPATH = Path(__file__).resolve().parent.parent
VERSIONS_DIRPATH = REPO_DIRPATH / "versions"

RESIDENT_RANGES = [(0x0400, 0x3000), (0x6E80, 0x8000)]


def _read(version_dirname, filename):
    return (VERSIONS_DIRPATH / version_dirname / "binary" / filename).read_bytes()


def swr_image() -> dict[int, int]:
    image = {}
    for name, addr in [("Dunjun4", 0x0400), ("Dunjun7", 0x0D00), ("Dunjun5", 0x1100), ("Dunjun6", 0x6E80)]:
        for i, b in enumerate(_read("dunjunz-swram_hack", name)):
            image[addr + i] = b
    return image


def tape_image() -> dict[int, int]:
    image = {}
    dunj4 = _read("dunjunz-tape_crack_ole", "DUNJ4")
    for i, b in enumerate(dunj4[:0x2C00]):
        image[0x0400 + i] = b
    for i, b in enumerate(_read("dunjunz-tape_crack_ole", "DUNJ3")[:0x1180]):
        image[0x6E80 + i] = b
    return image


def disc_image(joystick: bool = False) -> dict[int, int]:
    dun1 = _read("dunjunz-disc_nvg", "Dun1")

    def at(addr):
        return dun1[addr - 0x2000]

    image = {}
    low = 0x55B0 if joystick else 0x51B0
    for i in range(0x400):
        image[0x0400 + i] = at(low + i)
    for i in range(0x1880):
        image[0x08C0 + i] = at(0x3000 + i)
    for addr in range(0x2000, 0x3000):
        image[addr] = at(addr)
    for addr in range(0x6E80, 0x8000):
        image[addr] = at(addr)
    return image


def diff_ranges(a, b, gap):
    addrs = [addr for lo, hi in RESIDENT_RANGES for addr in range(lo, hi)
             if a.get(addr) != b.get(addr)]
    ranges = []
    for addr in addrs:
        if ranges and addr - ranges[-1][1] <= gap:
            ranges[-1][1] = addr
        else:
            ranges.append([addr, addr])
    return ranges


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--gap", type=int, default=4, help="merge differences this close")
    args = parser.parse_args()
    images = {"swr": swr_image(), "tape": tape_image(), "disc": disc_image()}
    for x, y in [("tape", "swr"), ("tape", "disc"), ("swr", "disc")]:
        ranges = diff_ranges(images[x], images[y], args.gap)
        total = sum(1 for lo, hi in RESIDENT_RANGES for a in range(lo, hi)
                    if images[x].get(a) != images[y].get(a))
        print(f"{x} vs {y}: {total} bytes differ in {len(ranges)} ranges")
        for lo, hi in ranges:
            print(f"  &{lo:04X}-&{hi:04X} ({hi - lo + 1})")


if __name__ == "__main__":
    main()
