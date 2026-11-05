"""Apply annotations keyed by runtime address to any Dunjunz version.

The resident game occupies the same runtime addresses in every release,
but each release stores it differently: the sideways RAM hack loads it in
place, Ole's crack loads its &0400-&2FFF image in place too (its driver
loads the image at the run address), and the official disc release
relocates parts of Dun1 with dasmos moves, including two alternative
images of &0400-&07FF. An Annotator hides that: each call names a runtime
address, and the version's `placements` function says which move(s) the
address lives in, and what suffix to give labels in each, so one set of
shared annotations can be applied to all versions.
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
    ):
        self.d = d
        self.version = version
        self.placements = placements

    def _each(self, addr):
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

    def block(self, addr, text):
        """Comment placed on its own line(s) before the item at addr."""
        for move, _ in self._each(addr):
            self.d.comment(addr, text, move=move)

    # -- names ----------------------------------------------------------

    def label(self, addr, name, **kwargs):
        """Name an address. Outside the loaded images (zero page, OS
        workspace) this is an ordinary label; inside, it follows the
        version's placements."""
        if not self._loaded(addr):
            self.d.label(addr, name, **kwargs)
            return
        for move, suffix in self._each(addr):
            if suffix is not None:
                self.d.label(addr, name + suffix, move=move, **kwargs)

    def region(self, addr, name, window, **kwargs):
        """Name a table and render references within `window` (inclusive
        offsets) as name+k / name-k. Where the address lies in a dasmos
        move, index regions are not available, so only the name is given."""
        if self._each(addr) == [(None, "")]:
            self.d.index_region(addr, name, window=window, **kwargs)
        else:
            self.label(addr, name, **kwargs)

    def optional_label(self, addr, name, **kwargs):
        self.d.optional_label(addr, name, **kwargs)

    def index_base(self, addr, name, **kwargs):
        self.d.index_base(addr, name, **kwargs)

    def banner(self, addr, title, description=""):
        for move, _ in self._each(addr):
            self.d.banner(addr, title=title, description=description, move=move)

    # -- data -----------------------------------------------------------

    def byte(self, addr, length=1, cols=None):
        for move, _ in self._each(addr):
            self.d.byte(addr, length, cols=cols, move=move)

    def string(self, addr, length):
        for move, _ in self._each(addr):
            self.d.string(addr, length, move=move)

    def _loaded(self, addr):
        return any(lo <= addr < hi for lo, hi in RESIDENT_RANGES)


# The resident game's runtime ranges, common to all versions.
RESIDENT_RANGES = [(0x0400, 0x3000), (0x6E80, 0x8000)]
