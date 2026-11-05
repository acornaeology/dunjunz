"""Rendering helpers for disassemblies made of several saved files."""

from dataclasses import dataclass

from dasmos.ext.renderers.beebasm.renderer import BeebasmRenderer


@dataclass(frozen=True)
class SavedFile:
    """One file the listing saves: its DFS name, the assembled address
    range it covers (end exclusive), and its DFS load and exec addresses."""

    name: str
    start: int
    end: int
    exec_addr: int
    load_addr: int


class MultiFileBeebasmRenderer(BeebasmRenderer):
    """beebasm renderer that saves each original file under its own name.

    dasmos renders a single save of the whole loaded range, which cannot
    reproduce several files with gaps between them or with their own DFS
    addresses (acornaeology/dasmos#49).
    """

    def __init__(self, saved_files, pre_save_lines=(), **kwargs):
        """`pre_save_lines` are emitted before the save directives, e.g. a
        copyblock that moves code assembled at its run address to where the
        file stores it."""
        super().__init__(**kwargs)
        self.saved_files = list(saved_files)
        self.pre_save_lines = list(pre_save_lines)

    def _save_directive(self, load_start, load_end, program=None) -> str:
        return "\n".join(self.pre_save_lines + [
            f'save "{f.name}", {self.hex4(f.start)}, {self.hex4(f.end)}, '
            f"{self.hex4(f.exec_addr)}, {self.hex4(f.load_addr)}"
            for f in self.saved_files
        ])
