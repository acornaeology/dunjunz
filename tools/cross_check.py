"""Check that operands written symbolically agree across versions.

    uv run python tools/cross_check.py REFERENCE_JSON OTHER_JSON ...

For every code item in the reference listing whose operand is an
expression, report the other listings' items at the same runtime address
that render the same operand but whose instruction or inline comment
differs: a sign that a shared annotation has landed on code that only
happens to hold the same value.
"""

import json
import sys
from pathlib import Path


def code_by_addr(json_filepath):
    listing = json.loads(Path(json_filepath).read_text())
    return {i["addr"]: i for i in listing["items"] if i["type"] == "code"}


def main():
    reference = code_by_addr(sys.argv[1])
    for other_filepath in sys.argv[2:]:
        other = code_by_addr(other_filepath)
        problems = 0
        for addr, ref in sorted(reference.items()):
            if "expr" not in ref:
                continue
            item = other.get(addr)
            if item is None or item.get("operand") != ref.get("operand"):
                continue
            if (item["mnemonic"], item.get("comment_inline")) != (ref["mnemonic"], ref.get("comment_inline")):
                problems += 1
                print(f"{Path(other_filepath).stem} &{addr:04X}: {item['mnemonic']} {item['operand']} "
                      f"; {item.get('comment_inline', '')[:50]!r} vs {ref.get('comment_inline', '')[:50]!r}")
        print(f"{Path(other_filepath).stem}: {problems} differing")


if __name__ == "__main__":
    main()
