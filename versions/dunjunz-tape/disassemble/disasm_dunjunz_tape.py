"""dasmos driver for the game of the 1986 cassette of Dunjunz.

The game is four cassette files, disassembled together as one memory image
so that references between them are traced and labelled directly. The
listing saves each file separately, and fantasm verifies each one against
its original.

## Memory map in play

| Range | Contents |
|---|---|
| &0000-&03FF | Zero page, stack and MOS workspace; the game's zero page is &70-&8F |
| &0400-&07FE | `DUNK`: score overflow, `decrypt_level` and `level_checksums`, the hero menu, `boot_loader` (&0740) |
| &07FF-&08BF | Not loaded |
| &08C0-&1FFF | `Dunjunz4`: `plot_sprite`, `screen_address`, per-hero tables, `room_walls` at &0C00; `load_core` (&0D00) and `game_entry` (&0D31), run once, then reused as page &0D's per-level workspace; `new_game` and `level_loop` at &0E00, the status panel, `check_for_victory`, the victory sequence's ring and Chalice, the font, `start_level` and `load_level`, sprites |
| &2000-&2FFF | `Dunjunz5`: `update_game`, `play_level`, sprites |
| &3000-&6E7F | Screen (25 character rows in play) |
| &6B00-&6DAF | The level file, loaded into the screen's bottom rows |
| &6E60-&6E71 | `level_osfile_block`, also in screen memory |
| &6E80-&7FFF | `Dunjunz3`: heroes, missiles, objects, monsters, `workspace_template`, `wrch_handler` |

## From the tape to play

1. `CHAIN""` loads `DUNJUNZ`, which stops on a machine it does not
   expect and chains `PLOAD`, the intro: the picture `PIC` with its text
   scrolling down the middle of the screen. `PLOAD` ends in MODE 4 with
   "Please Start Tape...." and runs the next file, `TITLE`, with `*/`.
2. `TITLE` shows the title page, selects `*TAPE` and runs the next file,
   `DUNK`, with `*/`.
3. `DUNK` loads to &0400-&07FE, the game's first part, and is entered at
   `boot_loader` (&0740), which loads `Dunjunz1` to &2000 through FILEV
   and jumps to it.
4. `Dunjunz1` does `*FX 200,3`, selects MODE 2 with 25 rows and every
   colour black, loads the loading screen (`Dunjunz2`) and shows it, loads
   `Dunjunz3` to &6E80 and `Dunjunz4` to &08C0, and jumps to `load_core`
   (&0D00).
5. `load_core` loads `Dunjunz5` to &2000, over `Dunjunz1`, and falls into
   `game_entry` (&0D31).
6. `game_entry` sets the bell (the firing sound), saves WRCHV in
   `saved_wrchv`, points WRCHV at `wrch_handler`, and jumps to `new_game`.
7. `new_game` zeroes `level_number` and `level_bcd`, gives each hero
   their starting attributes (`reset_hero`) and runs `hero_menu`.
8. `level_loop` sets `monster_start_hit_points`, counts the level in
   `level_bcd` and writes it into `level_filename` ("LEVELn"), then calls
   `start_level`, which shows LEVEL and the number and calls
   `load_level`.
9. `load_level` hides the two bottom rows, builds `level_osfile_block` and
   calls FILEV's routine to load `LEVELn` from the tape, which follows the
   game's files, to &6B00. `decrypt_level` decrypts it and checks it
   against `level_checksums`, resetting the machine on a mismatch.
10. `unpack_level`, `reset_workspace` and `reset_monsters` set up play; the
   screen is cleared and set to 25 rows, and `draw_view_frames` draws the
   frames and the four views. `draw_status_panel` and
   `remove_absent_heroes` finish the screen, and `play_level` runs the
   level until no hero is left in play.
11. Every dead hero gets their starting attributes back. If any hero
   survived, `level_loop` starts the next level, reading on through the
   tape; if all four died, the game-over message is shown for up to 60
   seconds or until a key, and `new_game` starts again. A
   hero reaching the Chalice on level 25 is caught by
   `check_for_victory`, which plays `victory_sequence`, prints the ending
   message, waits for a key and resets the machine through the RESET
   vector.
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

asm_filepath = Path(os.environ.get("FANTASM_ASM", OUTPUT_DIRPATH / "dunjunz-tape.asm"))
json_filepath = Path(os.environ.get("FANTASM_JSON", OUTPUT_DIRPATH / "dunjunz-tape.json"))

# (cassette name, load address, exec address), in address order.
GAME_FILES = [
    ("DUNK", 0x0400, 0x0740),
    ("Dunjunz4", 0x08C0, 0x08C0),
    ("Dunjunz5", 0x2000, 0x2000),
    ("Dunjunz3", 0x6E80, 0x6E80),
]

d = dasmos.Disassembler.create(cpu="6502")
for name, addr, exec_addr in GAME_FILES:
    d.load(BINARY_DIRPATH / name, addr, name=name, exec_addr=exec_addr)
d.use_environment("acorn_mos")
d.use_environment("acorn_model_b_hardware")
d.set_file_header(
    title="Dunjunz, 1986 cassette: the game",
    description=("Annotated disassembly of the game files `DUNK`, `Dunjunz4`, "
                 "`Dunjunz5` and `Dunjunz3`.\n\n" + __doc__.split("\n\n", 2)[2]),
)


def memory_group(addr):
    """Groups for labels in the range no file loads."""
    if 0x07FF <= addr < 0x08C0:
        return "game_state"
    return None


annotator = Annotator(d, "tape", default_group=memory_group)
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
game.annotate_page7_leftovers(annotator, '*SAVE"DUNK" 400 +3FF 740')
game.annotate_boot_loader(annotator, used=True)
game.annotate_cassette_level_loop(annotator)
game.annotate_filev_level_loader(annotator, "tape")
game.annotate_load_core(annotator)

annotator.c(0x0D6E, "Not referenced")  # after game_entry
annotator.c(0x0718, "Leftover: the CR ending the *SAVE command, then \"40\"")
annotator.byte(0x08C0, 0x40, cols=8)
annotator.c(0x08C0, "Not referenced")
annotator.c(0x0D80, "Leftover text, \"Dungeon5\", which load_core builds core_osfile_block over")
annotator.c(0x0D88, "Leftover bytes: a CR and a fragment of code")
annotator.c(0x0772, "Not referenced")
annotator.c(0x07F8, "Not referenced")

ir = d.disassemble()
asm_filepath.parent.mkdir(parents=True, exist_ok=True)
asm_filepath.write_text(str(ir.render("beebasm")), encoding="utf-8")
json_filepath.write_text(str(ir.render("json")), encoding="utf-8")
