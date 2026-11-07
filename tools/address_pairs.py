"""Find immediate operands that are the halves of a labelled address.

    uv run python tools/address_pairs.py LISTING_JSON_FILEPATH

Looks for a hex immediate low byte and high byte loaded close together
(LDX #lo then LDY #hi, as for OSCLI and OSWORD; or LDA #lo / STA v then
LDA #hi / STA v+1), whose address is a label in the listing, and prints
the operand addresses with the label so that a driver can make them
lo()/hi() expressions.
"""

import json
import re
import sys
from pathlib import Path

HEX_IMM = re.compile(r"^#(&[0-9a-f]{1,2}|[0-9]{1,3})(?: |$)")


def parse(text):
    return int(text[1:], 16) if text.startswith("&") else int(text)


def labels_of(listing):
    names = {}
    for item in listing["items"]:
        for label in item.get("labels", []):
            names.setdefault(item["addr"], label)
    for entry in listing["memory_map"]:
        names.setdefault(entry["addr"], entry["name"])
    return names


def main():
    listing = json.loads(Path(sys.argv[1]).read_text())
    names = labels_of(listing)
    code = [i for i in sorted(listing["items"], key=lambda i: i["addr"]) if i["type"] == "code"]
    used = set()
    for i, item in enumerate(code):
        m = HEX_IMM.match(item.get("operand", ""))
        if not m or item["addr"] in used:
            continue
        low = parse(m.group(1))
        for other in code[i + 1:i + 6]:
            n = HEX_IMM.match(other.get("operand", ""))
            if not n:
                continue
            high = parse(n.group(1))
            pair_ok = (item["mnemonic"], other["mnemonic"]) in (("ldx", "ldy"), ("lda", "lda"), ("ldy", "ldx"))
            addr = high * 256 + low
            if pair_ok and addr in names and addr >= 0x100:
                print(f"&{item['addr'] + 1:04X} lo, &{other['addr'] + 1:04X} hi: "
                      f"{names[addr]} (&{addr:04X})  ; {item.get('comment_inline', '')[:50]}")
                used.update((item["addr"], other["addr"]))
                break


if __name__ == "__main__":
    main()
