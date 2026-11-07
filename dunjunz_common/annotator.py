"""Apply annotations keyed by runtime address to any Dunjunz version.

The resident game occupies the same runtime addresses in every release,
but each release stores it differently: the sideways RAM hack loads it in
place, Ole's crack stores its &0400-&2FFF image at &2400 (a dasmos move),
and the official disc release relocates parts of Dun1 with dasmos moves,
including two alternative images of &0400-&07FF. An Annotator hides that: each call names a runtime
address, and the version's `placements` function says which move(s) the
address lives in, and what suffix to give labels in each, so one set of
shared annotations can be applied to all versions.

A version whose code differs from the shared annotations' in places passes
a `skip` predicate: every call naming an address it accepts is ignored, so
the version's own driver can annotate those addresses instead. A
`default_group` function gives a memory-map group to labels that would
otherwise have none, for a version whose layout places them outside its
loaded images.
"""

from collections.abc import Callable, Iterable

import dasmos

INLINE = dasmos.Align.INLINE

# A placement is (move or None, label suffix). A suffix of None places
# comments, banners and entry points in that move but no labels.
Placement = tuple[object, str | None]


def identity_placements(addr: int) -> list[Placement]:
    return [(None, "")]


class Annotator:
    def __init__(
        self,
        d: dasmos.Disassembler,
        version: str,
        placements: Callable[[int], Iterable[Placement]] = identity_placements,
        skip: Callable[[int], bool] | None = None,
        default_group: Callable[[int], str | None] | None = None,
    ):
        self.d = d
        self.version = version
        self.placements = placements
        self.skip = skip
        self.default_group = default_group

    def _each(self, addr):
        if self.skip is not None and self.skip(addr):
            return []
        return list(self.placements(addr))

    # -- code -----------------------------------------------------------

    def entry(self, addr, name=None):
        for move, suffix in self._each(addr):
            label = name + suffix if name and suffix is not None else None
            if move is None:
                self.d.entry(addr, label)
            else:
                with move:
                    self.d.entry(addr, label)

    def sub(self, addr, name, title, description="", on_entry=None, on_exit=None):
        """A routine: label, banner and code entry point."""
        for move, suffix in self._each(addr):
            if suffix is None:
                self.d.banner(addr, title=title, description=description,
                              on_entry=on_entry, on_exit=on_exit, move=move)
                with move:
                    self.d.entry(addr)
                continue
            self.d.subroutine(
                addr, name + suffix, title=title, description=description,
                on_entry=on_entry, on_exit=on_exit, move=move,
            )

    def c(self, addr, text):
        """Inline comment on the instruction or data item at addr."""
        for move, _ in self._each(addr):
            self.d.comment(addr, text, align=INLINE, move=move)

    def expr(self, operand_addr, expression):
        """Render the operand whose first byte is at operand_addr as
        `expression` (a dasmos.expr expression)."""
        for move, _ in self._each(operand_addr):
            self.d.expr(operand_addr, expression, move=move)

    def block(self, addr, text):
        """Comment placed on its own line(s) before the item at addr."""
        for move, _ in self._each(addr):
            self.d.comment(addr, text, move=move)

    # -- names ----------------------------------------------------------

    def label(self, addr, name, **kwargs):
        """Name an address. Outside the loaded images (zero page, OS
        workspace) this is an ordinary label; inside, it follows the
        version's placements."""
        if self.skip is not None and self.skip(addr):
            return
        if self.default_group is not None and "group" not in kwargs:
            group = self.default_group(addr)
            if group is not None:
                kwargs["group"] = group
        if not self._loaded(addr):
            self.d.label(addr, name, **kwargs)
            return
        for move, suffix in self._each(addr):
            if suffix is not None:
                self.d.label(addr, name + suffix, move=move, **kwargs)
                self._describe_in_image(addr, kwargs.get("description"), move)

    def _describe_in_image(self, addr, description, move):
        """dasmos drops the description of a label inside an image
        (acornaeology/dasmos#61), so repeat it as a block comment there."""
        if not description:
            return
        if move is None:
            if not self.d.moves.is_loaded_in_place(addr):
                return
        elif not move.is_in_move_dest(addr, include_end_address=False):
            return
        self.d.comment(addr, description, move=move)

    def region(self, addr, name, window, **kwargs):
        """Name a table and render references within `window` (inclusive
        offsets) as name+k / name-k. Index regions cannot be declared in a
        dasmos move, so there each offset gets an expression label instead."""
        if self.skip is not None and self.skip(addr):
            return
        if self._each(addr) == [(None, "")]:
            self.d.index_region(addr, name, window=window, **kwargs)
            self._describe_in_image(addr, kwargs.get("description"), None)
            return
        self.label(addr, name, **kwargs)
        lo, hi = window
        for move, suffix in self._each(addr):
            if suffix is None:
                continue
            for k in range(lo, hi + 1):
                if k:
                    expression = f"{name}{suffix}{'+' if k > 0 else '-'}{abs(k)}"
                    self.d.expr_label(addr + k, expression, move=move)

    def optional_label(self, addr, name, **kwargs):
        if self.skip is None or not self.skip(addr):
            self.d.optional_label(addr, name, **kwargs)

    def index_base(self, addr, name, **kwargs):
        if self.skip is None or not self.skip(addr):
            self.d.index_base(addr, name, **kwargs)
            self._describe_in_image(addr, kwargs.get("description"), None)

    def banner(self, addr, title, description=""):
        for move, _ in self._each(addr):
            self.d.banner(addr, title=title, description=description, move=move)

    # -- data -----------------------------------------------------------

    def byte(self, addr, length=1, cols=None):
        for move, _ in self._each(addr):
            self.d.byte(addr, length, cols=cols, move=move)

    def inkey_number(self, addr, count=1):
        """Bytes holding negative INKEY numbers, shown as inkey_key_<name>."""
        for move, _ in self._each(addr):
            self.d.inkey_number(addr, count, move=move)

    def format_hint(self, addr, hint):
        for move, _ in self._each(addr):
            self.d.format_hint(addr, hint, move=move)

    def word(self, addr, length=2, cols=None):
        for move, _ in self._each(addr):
            self.d.word(addr, length, cols=cols, move=move)

    def stringcr(self, addr):
        """A string ended by a carriage return, which it includes."""
        for move, _ in self._each(addr):
            self.d.stringcr(addr, move=move)

    def stringz(self, addr):
        """A string ended by a zero byte, which it includes."""
        for move, _ in self._each(addr):
            self.d.stringz(addr, move=move)

    def string(self, addr, length):
        for move, _ in self._each(addr):
            self.d.string(addr, length, move=move)

    def byte_value(self, addr):
        """The byte at runtime address addr in its first placement, or None
        where this version skips the address."""
        for move, _ in self._each(addr):
            binary_addr = addr if move is None else move.convert_runtime_to_binary_addr(addr)
            return self.d.memory.get_u8(binary_addr)
        return None

    def word_value(self, addr):
        low, high = self.byte_value(addr), self.byte_value(addr + 1)
        return None if low is None or high is None else low + 256 * high

    def _loaded(self, addr):
        return any(lo <= addr < hi for lo, hi in RESIDENT_RANGES)


# The resident game's runtime ranges, common to all versions.
RESIDENT_RANGES = [(0x0400, 0x3000), (0x6E80, 0x8000)]
