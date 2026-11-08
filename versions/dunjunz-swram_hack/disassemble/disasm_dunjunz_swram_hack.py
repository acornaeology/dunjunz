"""dasmos driver for the game of the sideways RAM hack of Dunjunz.

The game is four DFS files, disassembled together as one memory image so
that references between them are traced and labelled directly. The
listing saves each file separately, and fantasm verifies each one against
its original.

## Memory map in play

| Range | Contents |
|---|---|
| &0000-&03FF | Zero page, stack and MOS workspace; the game's zero page is &70-&8F |
| &0400-&0CFF | `Dunjun4`: score overflow, `decrypt_level` and `level_checksums`, the hero menu, `plot_sprite`, `screen_address`, per-hero tables, `room_walls` at &0C00 |
| &0D00-&10FF | `Dunjun7`: `game_entry` (&0D31, run once, then reused as page &0D's per-level workspace), `new_game` and `level_loop` at &0E00, the status panel, `check_for_victory` |
| &1100-&2FFF | `Dunjun5`: the victory sequence's ring and Chalice, the font, `start_level` and `load_level`, sprites, `update_game`, `play_level` |
| &3000-&6E7F | Screen (25 character rows in play) |
| &6B00-&6DAF | The level file, loaded into the screen's bottom rows |
| &6E60-&6E71 | `level_osfile_block`, also in screen memory |
| &6E80-&7FFF | `Dunjun6`: heroes, missiles, objects, monsters, `workspace_template`, `wrch_handler` |
| Sideways RAM | Two Beebug ROMFS images: `Dunjun1` (`LEVEL22`-`LEVEL25`) and, in the next bank up, `Dunjun2` (`LEVEL1`-`LEVEL21`) |

## From power-on to play

1. `!BOOT` sets PAGE=&1900 and chains `DUNJUNZ`, the BASIC instructions
   and intro, which runs `*/TITLE` and then chains `DUNK`.
2. `DUNK` refuses a Master 128, copies `Dunjun1` and `Dunjun2` into the
   first two sideways RAM banks it finds above bank 3, makes BREAK rerun
   its game loading, and assembles a loader at &6480. That loader shows
   the loading screen (`Dunjun3`), `*LOAD`s `Dunjun4`, `Dunjun5` and
   `Dunjun6` in place and `Dunjun7` at &3000, selects `*TAPE`, copies
   &3000-&33FF to &0D00, clears the screen, selects `*ROM` and jumps to
   `game_entry` at &0D31.
3. `game_entry` sets the bell (the firing sound), saves WRCHV in
   `saved_wrchv`, points WRCHV at `wrch_handler`, and jumps to `new_game`.
4. `new_game` zeroes `level_number` and `level_bcd`, gives each hero
   their starting attributes (`reset_hero`) and runs `hero_menu`.
5. `level_loop` sets `monster_start_hit_points`, counts the level in
   `level_bcd` and writes it into `level_filename` ("LEVELn"), then calls
   `start_level`, which runs steps 6 to 8.
6. `show_level_number` clears the screen, counts `level_number` and shows
   LEVEL and the number.
7. `load_level` hides the two bottom rows, builds `level_osfile_block` and
   calls FILEV's routine (the MOS's cassette and ROM filing system
   handler) to load `LEVELn` from ROMFS to &6B00. `decrypt_level` decrypts
   it and checks it against `level_checksums`, resetting the machine on a
   mismatch.
8. `unpack_level`, `reset_workspace` and `reset_monsters` set up play; the
   screen is cleared and set to 25 rows, and `draw_view_frames` draws the
   frames and the four views.
9. `draw_status_panel` and `remove_absent_heroes` finish the screen, and
   `play_level` runs the level until no hero is left in play.
10. Every dead hero gets their starting attributes back. If any hero
   survived, `level_loop` starts the next level, with no reloading of the
   game; if all four died, the game-over message is shown for up to 60
   seconds or until a key, and `new_game` starts again. A hero reaching
   the Chalice on level 25 is caught by `check_for_victory`, which plays
   `victory_sequence`, prints the ending message, waits for a key and
   resets the machine through the RESET vector.
"""

import os
import sys
from pathlib import Path

import dasmos
from dasmos.expr import hexlit, hi, lo, sym

VERSION_DIRPATH = Path(__file__).resolve().parent.parent
REPO_DIRPATH = VERSION_DIRPATH.parent.parent
sys.path.insert(0, str(REPO_DIRPATH))

from dunjunz_common import game  # noqa: E402
from dunjunz_common.annotator import Annotator  # noqa: E402

BINARY_DIRPATH = VERSION_DIRPATH / "binary"
OUTPUT_DIRPATH = VERSION_DIRPATH / "output"

asm_filepath = Path(os.environ.get("FANTASM_ASM", OUTPUT_DIRPATH / "dunjunz-swram_hack.asm"))
json_filepath = Path(os.environ.get("FANTASM_JSON", OUTPUT_DIRPATH / "dunjunz-swram_hack.json"))

# (DFS name, load address, length), in address order.
GAME_FILES = [
    ("Dunjun4", 0x0400, 0x0900),
    ("Dunjun7", 0x0D00, 0x0400),
    ("Dunjun5", 0x1100, 0x1F00),
    ("Dunjun6", 0x6E80, 0x1180),
]

GAME_ENTRY = 0x0D31

d = dasmos.Disassembler.create(cpu="6502")
for name, addr, length in GAME_FILES:
    d.load(BINARY_DIRPATH / name, addr, name=name, exec_addr=addr)
d.use_environment("acorn_mos")
d.use_environment("acorn_model_b_hardware")
d.set_file_header(
    title="Dunjunz, sideways RAM hack: the game",
    description=("Annotated disassembly of the game files `Dunjun4`, `Dunjun7`, "
                 "`Dunjun5` and `Dunjun6`.\n\n" + __doc__.split("\n\n", 2)[2]),
)


annotator = Annotator(d, "swr")
game.annotate(annotator)
game.annotate_game_entry(annotator)
game.annotate_level_check(annotator)
game.annotate_start_level(annotator)
game.annotate_level_end(annotator)
game.annotate_cassette_pause(annotator)
game.annotate_cassette_continuations(annotator)
game.annotate_hack_continuations(annotator)
game.annotate_menu_tables(annotator, 0x06F8)
game.declare_boot_osfile_block(d)
game.annotate_page7_leftovers(annotator, "*SAVE Dunjunz.K 400 7FF 740")
game.annotate_boot_loader(annotator, stored_call=0xF27D, operand_note=(" The JSR's stored operand is &F27D, the MOS 1.20 FILEV handler for the cassette and ROM filing systems, so the image was saved after this loader had run with one of them selected."))
game.annotate_cassette_level_loop(annotator)

game.annotate_filev_level_loader(annotator, "romfs")
game.annotate_load_core(annotator, used=False, stored_call=0xF27D)
annotator.byte(0x0D80, 6)
annotator.byte(0x0D86, 10, cols=10)
annotator.c(0x0D80, "core_osfile_block as load_core left it: core_filename (&0D70) and &00002000")
annotator.c(0x0D86, "Leftover: the end of \"Dungeon5\", a CR and a fragment of code")

annotator.c(0x0D6E, "Not referenced")  # after game_entry
annotator.c(0x0772, "Not referenced")
annotator.c(0x07F8, "Not referenced")

ir = d.disassemble()
asm_filepath.parent.mkdir(parents=True, exist_ok=True)
asm_filepath.write_text(str(ir.render("beebasm")), encoding="utf-8")
json_filepath.write_text(str(ir.render("json")), encoding="utf-8")
