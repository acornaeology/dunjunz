"""dasmos driver for the game code of Ole's crack of the Dunjunz cassette.

The crack's loader DUNJ loads two code files and runs the second:

    DUNJ3  load &6E80  &2E80 bytes: code for &6E80-&7FFF; the bytes past
                       &7FFF fall in the sideways ROM area and never reach RAM
    DUNJ4  load &2400  exec &5000: the game's &0400-&2FFF image, stored
                       &2000 higher, followed by a short start-up routine at
                       &5000 that copies it down and starts the game

Both files are disassembled together. DUNJ4's game image is disassembled
at its run address, &0400, and its start-up code at &5000; before saving,
the listing copies the assembled image up to &2400, where the file stores
it. (Modelling the image as a dasmos move instead trips over the overlap
between &0400-&2FFF and &2400-&4FFF: acornaeology/dasmos#51, #52.)
"""

import os
import sys
import tempfile
from pathlib import Path

import dasmos

VERSION_DIRPATH = Path(__file__).resolve().parent.parent
REPO_DIRPATH = VERSION_DIRPATH.parent.parent
sys.path.insert(0, str(REPO_DIRPATH))

from dunjunz_common import game  # noqa: E402
from dunjunz_common.annotator import Annotator  # noqa: E402
from dunjunz_common.rendering import MultiFileBeebasmRenderer, SavedFile  # noqa: E402

BINARY_DIRPATH = VERSION_DIRPATH / "binary"
OUTPUT_DIRPATH = VERSION_DIRPATH / "output"

asm_filepath = Path(os.environ.get("FANTASM_ASM", OUTPUT_DIRPATH / "dunjunz-tape.asm"))
json_filepath = Path(os.environ.get("FANTASM_JSON", OUTPUT_DIRPATH / "dunjunz-tape.json"))

SAVED_FILES = [
    SavedFile("DUNJ4", start=0x2400, end=0x5050, exec_addr=0x5000, load_addr=0x2400),
    SavedFile("DUNJ3", start=0x6E80, end=0x9D00, exec_addr=0x0000, load_addr=0x6E80),
]

# DUNJ4 = the &0400-&2FFF image (stored at &2400) + start-up code at &5000.
IMAGE_RUN_ADDR, IMAGE_STORED_ADDR, IMAGE_LENGTH = 0x0400, 0x2400, 0x2C00
START_UP_ADDR = IMAGE_STORED_ADDR + IMAGE_LENGTH

d = dasmos.Disassembler.create(cpu="6502")
dunj4 = (BINARY_DIRPATH / "DUNJ4").read_bytes()
with tempfile.TemporaryDirectory(prefix="dunjunz-tape-") as split_dirname:
    split_dirpath = Path(split_dirname)
    (split_dirpath / "image").write_bytes(dunj4[:IMAGE_LENGTH])
    (split_dirpath / "start_up").write_bytes(dunj4[IMAGE_LENGTH:])
    d.load(split_dirpath / "image", IMAGE_RUN_ADDR)
    d.load(split_dirpath / "start_up", START_UP_ADDR)
d.load(BINARY_DIRPATH / "DUNJ3", 0x6E80)
d.use_environment("acorn_mos")
d.use_environment("acorn_model_b_hardware")

d.entry(0x5000, "start")

annotator = Annotator(d, "tape")
game.annotate(annotator)
game.annotate_game_entry(annotator)
game.annotate_start_level(annotator)
game.annotate_level_end(annotator)
game.annotate_cassette_pause(annotator)
game.annotate_cassette_continuations(annotator)
game.annotate_menu_tables(annotator, 0x06F8)
game.annotate_cassette_level_loop(annotator)

# ---------------------------------------------------------------------------
# Specific to Ole's crack: start-up and loading a level from disc.

annotator.sub(0x5000, "start", "Start the game (DUNJ4's execution address)",
              "Select the cassette filing system and apply the start-level "
              "cheat, copy the game image from &2400-&4FFF down to "
              "&0400-&2FFF, point WRCHV at wrch_handler and start a new game.")
for addr, text in [
    (0x5000, "Select *TAPE and apply the cheat"),
    (0x5003, ""),
    (0x5004, "Destination &0400..."),
    (0x5006, "..."),
    (0x5008, "...source &2400 (both low bytes 0)"),
    (0x500A, "..."),
    (0x500C, "..."),
    (0x500E, "Copy a page..."),
    (0x5010, "..."),
    (0x5012, "..."),
    (0x5013, "..."),
    (0x5015, "Next page"),
    (0x5017, "..."),
    (0x5019, "Until the source reaches &5000..."),
    (0x501B, "..."),
    (0x501D, "..."),
    (0x501F, "Save WRCHV..."),
    (0x5022, "..."),
    (0x5025, "..."),
    (0x5028, "...in saved_wrchv"),
    (0x502B, "Point WRCHV at wrch_handler..."),
    (0x502D, "..."),
    (0x5030, "..."),
    (0x5032, "..."),
    (0x5035, "Start a new game"),
]:
    if text:
        annotator.c(addr, text)
annotator.sub(0x5038, "select_tape_and_cheat", "Select *TAPE and apply the start-level cheat",
              "Select the cassette filing system at 1200 baud, and copy the "
              "start level chosen in the loader (at &5100, poked there by "
              "DUNJ) into the stored copy of first_level's operand, where "
              "the copy loop then moves it.")
annotator.c(0x5038, "OSBYTE &8C: *TAPE...")
annotator.c(0x503A, "...at 1200 baud")
annotator.c(0x503F, "Start level chosen with the loader's cheat...")
annotator.c(0x5042, "...into the operand of first_level's LDA, at its stored address")
annotator.c(0x5045, "Y = 0 and plot_x = 0 for the copy")
annotator.c(0x5047, "...")
annotator.c(0x5049, "Return")

annotator.sub(0x148B, "first_level", "Set the starting level",
              "Set level_bcd to the level before the first one played. The "
              "operand of the LDA is 0 unless the loader's start-level cheat "
              "has patched it.")
annotator.c(0x148B, "Level before the first (patched by the cheat)")
annotator.c(0x148D, "...")
annotator.c(0x1490, "Return")

annotator.label(0x16D0, "level_command", length=8, description=(
    "The command that loads a level, \"L.$.L\" followed by the level number "
    "and a carriage return; level_loop writes the number."))
annotator.sub(0x1446, "load_level", "Load the level file",
              "Reset the page numbers in the self-modifying copy loops, then "
              "move pages &0E-&18 out of the filing system's way and load the "
              "level from disc (save_game_pages, continuing in "
              "load_level_from_copy).")
annotator.sub(0x0450, "save_game_pages", "Move the game out of the way and load a level",
              "Keep the level number's digits on the stack, copy pages &0E-&18 "
              "to &4E-&58 and clear the originals for the filing system's use, "
              "put the digits into the moved copy of level_command, and jump "
              "to the moved copy of load_level_from_copy.")
annotator.entry(0x145C)
annotator.sub(0x145C, "load_level_from_copy", "Load a level, running from the copy at &545C",
              "Runs only from its copy at &545C, made by save_game_pages, so "
              "its addresses are those of the copy. Select the disc filing "
              "system, *LOAD the level, reselect *TAPE, and copy pages &4E-&58 "
              "back to &0E-&18 before returning to start_level.")

for addr, text in [
    (0x5003, "(unused)"),
    (0x0E00, "New game: level_bcd = the level before the first played"),
    (0x0E03, "level_number = 0"),
    (0x0E05, "..."),
    (0x1446, "Reset the page numbers of the copy loops below to &0E and "
             "&4E..."),
    (0x1448, "..."), (0x144B, "..."), (0x144E, "...(in the copy at &545C)"),
    (0x1451, "..."), (0x1453, "..."), (0x1456, "...(in the copy at &545C)"),
    (0x1459, "...and move the game out of the way"),
    (0x0450, "Keep the level number's digits, which are about to be "
             "cleared..."),
    (0x0453, "..."), (0x0454, "..."), (0x0457, "..."),
    (0x0458, "Copy pages &0E-&18 to &4E-&58, clearing the originals"),
    (0x045A, "..."), (0x045D, "..."), (0x045E, "..."), (0x0460, "..."),
    (0x0463, "..."), (0x0464, "..."), (0x0467, "..."), (0x0468, "..."),
    (0x046A, "Next page: advance the three page operands"),
    (0x046D, "..."), (0x0470, "..."),
    (0x0473, "Until page &19"),
    (0x0476, "..."), (0x0478, "..."),
    (0x047A, "Put the digits into the moved copy of level_command"),
    (0x047B, "..."), (0x047E, "..."), (0x047F, "..."),
    (0x0482, "Continue in the moved copy of load_level_from_copy"),
    (0x145C, "*D. (*DISC), from the moved copy of the command at &149D"),
    (0x145E, "..."), (0x1460, "..."),
    (0x1463, "*L.$.Ln (*LOAD), from the moved copy of level_command"),
    (0x1465, "..."), (0x1467, "..."),
    (0x146A, "OSBYTE &8C: back to *TAPE..."),
    (0x146C, "...at 1200 baud"),
    (0x146E, "..."),
    (0x1471, "Copy pages &4E-&58 back to &0E-&18"),
    (0x1473, "..."), (0x1476, "..."), (0x1479, "..."), (0x147A, "..."),
    (0x147C, "Next page: advance the page operands (in this copy)"),
    (0x147F, "..."), (0x1482, "Until page &19"), (0x1485, "..."),
    (0x1487, "..."),
    (0x1489, "Return to start_level"),
]:
    annotator.c(addr, text)

ir = d.disassemble()
asm_filepath.parent.mkdir(parents=True, exist_ok=True)
asm_filepath.write_text(str(ir.render(MultiFileBeebasmRenderer(
    SAVED_FILES,
    pre_save_lines=[
        "",
        "; DUNJ4 stores the game image &2000 above its run address.",
        f"copyblock &{IMAGE_RUN_ADDR:04x}, &{IMAGE_RUN_ADDR + IMAGE_LENGTH:04x}, &{IMAGE_STORED_ADDR:04x}",
    ],
))), encoding="utf-8")
json_filepath.write_text(str(ir.render("json")), encoding="utf-8")
