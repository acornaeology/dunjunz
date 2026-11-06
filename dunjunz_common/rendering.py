"""Rendering helpers for a disassembly that saves extra files."""

from dataclasses import dataclass

from dasmos.ext.renderers.beebasm.renderer import BeebasmRenderer


@dataclass(frozen=True)
class SavedFile:
    """A file saved from part of a loaded image: its DFS name, the
    assembled address range it covers (end exclusive), and its DFS exec
    and load addresses."""

    name: str
    start: int
    end: int
    exec_addr: int
    load_addr: int


class ExtraSavesBeebasmRenderer(BeebasmRenderer):
    """beebasm renderer that also saves files cut from a loaded image.

    dasmos saves each loaded image as its own file. A file whose bytes are
    a part of another loaded file (the disc release's `Coder` is the
    &5000-&59AF part of `Dun1`) cannot be loaded as a second image over the
    same addresses, so its `save` is added after the images' saves.
    """

    def __init__(self, extra_saves, **kwargs):
        super().__init__(**kwargs)
        self.extra_saves = list(extra_saves)

    def disassembly_end(self) -> list[str]:
        return super().disassembly_end() + [
            f'save "{f.name}", {self.hex4(f.start)}, {self.hex4(f.end)}, '
            f"{self.hex4(f.exec_addr)}, {self.hex4(f.load_addr)}"
            for f in self.extra_saves
        ]
