"""Report annotation-quality metrics for dasmos JSON listings.

    uv run python tools/quality.py LISTING_JSON_FILEPATH [...] [--list KIND]

For each listing, counts what the comment-coverage figure does not show:
auto-generated labels (dasmos's code_/loop_/data_/sub_ names), subroutines
without a calling convention (on_entry/on_exit), data items other than strings and
binary rows (pictures) with no inline comment, and code whose operand is a raw address or a hex
immediate, and symbols whose high byte an instruction loads (`#>label`)
but whose low byte none does (`#<label`): code that assumes the symbol
starts a page, which must stay true if it moves. Data tables holding
both halves of an address do not count as a pairing. `--list KIND` prints the
addresses of one kind: auto, conv, data, rawaddr, hexconst or hionly.
"""

import argparse
import json
import re
from pathlib import Path

AUTO_RE = re.compile(r"\b((code|loop|data|sub)_[0-9a-f]{4}|return_[0-9]+)\b")
RAW_ADDR_RE = re.compile(r"^\(?&[0-9a-f]{3,4}\b")
HEX_IMM_RE = re.compile(r"^#&[0-9a-f]+$")
BYTE_OF_RE = re.compile(r"([<>])\(?([A-Za-z_][A-Za-z0-9_]*)")


def analyse(json_filepath):
    listing = json.loads(Path(json_filepath).read_text())
    images = listing["meta"]["images"]
    ranges = [(i["load_addr"], i["end_addr"]) for i in images] if images and "load_addr" in images[0] else [
        (listing["meta"]["load_addr"], listing["meta"]["end_addr"])]
    found = {"auto": [], "conv": [], "data": [], "rawaddr": [], "hexconst": [], "hionly": []}
    auto_names = set()
    byte_uses = {"<": set(), ">": []}
    for item in listing["items"]:
        for label in item.get("labels", []):
            if AUTO_RE.search(label):
                auto_names.add(label)
                found["auto"].append((item["addr"], label))
        operand = item.get("operand", "")
        if item["type"] == "code" and operand.startswith("#"):
            for half, name in BYTE_OF_RE.findall(operand):
                if half == "<":
                    byte_uses["<"].add(name)
                else:
                    byte_uses[">"].append((item["addr"], name, operand))
        for match in AUTO_RE.finditer(operand):
            auto_names.add(match.group(0))
        if item["type"] == "code":
            mnemonic = item.get("mnemonic", "")
            if RAW_ADDR_RE.match(operand) and mnemonic not in ("brk",):
                found["rawaddr"].append((item["addr"], f"{mnemonic} {operand}"))
            if HEX_IMM_RE.match(operand):
                found["hexconst"].append((item["addr"], f"{mnemonic} {operand}"))
        elif (item["type"] != "string" and "binary" not in item.get("format_hints", [])
              and not item.get("comment_inline") and not item.get("labels")):
            found["data"].append((item["addr"], f"{item['type']} x{len(item['bytes'])}"))
    for sub in listing["subroutines"]:
        if "title" not in sub:
            continue  # environment entry points
        if not sub.get("on_entry") and not sub.get("on_exit"):
            found["conv"].append((sub["addr"], sub["name"]))
    for addr, name, text in byte_uses[">"]:
        if name not in byte_uses["<"]:
            found["hionly"].append((addr, f"{name}\t{text}"))
    subs = [s for s in listing["subroutines"] if "title" in s]
    return {
        "subroutines": len(subs),
        "auto": len(auto_names),
        "conv": len(found["conv"]),
        "data": len(found["data"]),
        "rawaddr": len(found["rawaddr"]),
        "hexconst": len(found["hexconst"]),
        "hionly": len({text.split("\t")[0] for _, text in found["hionly"]}),
    }, found


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("json_filepaths", nargs="+")
    parser.add_argument("--list", choices=["auto", "conv", "data", "rawaddr", "hexconst", "hionly"])
    args = parser.parse_args()
    print("listing\tsubs\tauto_labels\tsubs_without_convention\tbare_data\traw_addr_operands\thex_immediates\thigh_byte_only")
    for json_filepath in args.json_filepaths:
        counts, found = analyse(json_filepath)
        print("\t".join([Path(json_filepath).stem] + [str(counts[k]) for k in
                        ("subroutines", "auto", "conv", "data", "rawaddr", "hexconst", "hionly")]))
        if args.list:
            for addr, text in found[args.list]:
                print(f"  &{addr:04X}\t{text}")


if __name__ == "__main__":
    main()
