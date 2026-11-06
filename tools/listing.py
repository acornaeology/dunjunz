"""Print an address-keyed listing of a range from a version's dasmos JSON.

Usage: uv run python tools/listing.py VERSION START END
  VERSION is swr, tape or disc; START and END are hex runtime addresses.
"""

import json
import sys
from pathlib import Path

REPO_DIRPATH = Path(__file__).resolve().parent.parent
JSON_FILEPATHS = {
    "swr": "versions/dunjunz-swram_hack/output/dunjunz-swram_hack.json",
    "tape": "versions/dunjunz-tape_crack_ole/output/dunjunz-tape_crack_ole.json",
    "disc": "versions/dunjunz-disc/output/dunjunz-disc.json",
}


def main():
    version, start, end = sys.argv[1], int(sys.argv[2], 16), int(sys.argv[3], 16)
    listing = json.loads((REPO_DIRPATH / JSON_FILEPATHS[version]).read_text())
    for item in listing["items"]:
        addr = item["addr"]
        if not start <= addr < end:
            continue
        for label in item.get("labels", []):
            print(f"{'':6}.{label}")
        raw = " ".join(f"{b:02x}" for b in item["bytes"][:3])
        if item["type"] == "code":
            text = f"{item['mnemonic']} {item.get('operand') or ''}".rstrip()
        else:
            text = f"{item['type']} {' '.join(f'{b:02x}' for b in item['bytes'][:16])}"
        comment = item.get("comment_inline") or ""
        print(f"&{addr:04X}  {raw:9} {text:32} {comment}")


if __name__ == "__main__":
    main()
