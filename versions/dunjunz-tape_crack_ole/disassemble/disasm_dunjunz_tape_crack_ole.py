"""dasmos driver for the game code of Ole's crack of the Dunjunz cassette.

The crack's loader DUNJ loads two code files and runs the second:

    DUNJ3  load &6E80  &2E80 bytes: code for &6E80-&7FFF; the bytes past
                       &7FFF fall in the sideways ROM area and never reach RAM
    DUNJ4  load &2400  exec &5000: the game's &0400-&2FFF image, stored
                       &2000 higher, followed by a short start-up routine at
                       &5000 that copies it down and starts the game

Both files are disassembled together, each saved as its own file. DUNJ4's
game image is a dasmos move from &2400-&4FFF, where the file stores it,
to &0400-&2FFF, where it runs; the two ranges overlap.
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

asm_filepath = Path(os.environ.get("FANTASM_ASM", OUTPUT_DIRPATH / "dunjunz-tape_crack_ole.asm"))
json_filepath = Path(os.environ.get("FANTASM_JSON", OUTPUT_DIRPATH / "dunjunz-tape_crack_ole.json"))

# DUNJ4 = the &0400-&2FFF image (stored at &2400) + start-up code at &5000.
IMAGE_RUN_ADDR, IMAGE_STORED_ADDR, IMAGE_LENGTH = 0x0400, 0x2400, 0x2C00

d = dasmos.Disassembler.create(cpu="6502")
d.load(BINARY_DIRPATH / "DUNJ4", IMAGE_STORED_ADDR, name="DUNJ4", exec_addr=0x5000)
d.load(BINARY_DIRPATH / "DUNJ3", 0x6E80, name="DUNJ3", exec_addr=0x0000)
d.use_environment("acorn_mos")
d.use_environment("acorn_model_b_hardware")

game_image = d.add_move(IMAGE_RUN_ADDR, IMAGE_STORED_ADDR, IMAGE_LENGTH, name="game_image")

d.entry(0x5000, "start")


def placements(addr):
    """Where runtime address addr lives: &0400-&2FFF in the moved game
    image, everything else in place."""
    if IMAGE_RUN_ADDR <= addr < IMAGE_RUN_ADDR + IMAGE_LENGTH:
        return [(game_image, "")]
    return [(None, "")]


annotator = Annotator(d, "tape", placements)
game.annotate(annotator)
game.annotate_game_entry(annotator)
game.annotate_start_level(annotator)
game.annotate_level_end(annotator)
game.annotate_cassette_pause(annotator)
game.annotate_cassette_continuations(annotator)
game.annotate_menu_tables(annotator, 0x06F8)
game.declare_boot_osfile_block(d)
game.annotate_page7_leftovers(annotator, "*SAVE Dunjunz.K 400 7FF 740")
game.annotate_boot_loader(annotator)
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
    (0x5006, "...as the destination pointer's page"),
    (0x5008, "...source &2400 (both low bytes 0)"),
    (0x500A, "...as the source pointer's page"),
    (0x500C, "...source low byte 0 (Y = 0)"),
    (0x500E, "Copy a page..."),
    (0x5010, "...to where the game runs"),
    (0x5012, "...next byte"),
    (0x5013, "Until the page is done"),
    (0x5015, "Next page"),
    (0x5017, "...and the source's"),
    (0x5019, "Until the source reaches &5000..."),
    (0x501B, "...source page &50?"),
    (0x501D, "No: copy the next page"),
    (0x501F, "Save WRCHV..."),
    (0x5022, "...low byte"),
    (0x5025, "...high byte"),
    (0x5028, "...in saved_wrchv"),
    (0x502B, "Point WRCHV at wrch_handler..."),
    (0x502D, "...low byte"),
    (0x5030, "...high byte"),
    (0x5032, "...so text prints in the game's font"),
    (0x5035, "Start a new game"),
]:
    if text:
        annotator.c(addr, text)
annotator.sub(0x5038, "select_tape_and_cheat", "Select *TAPE and apply the start-level cheat",
              "Select the cassette filing system at 1200 baud, and copy the "
              "start level chosen in the loader (at &5100, poked there by "
              "DUNJ) into the stored copy of first_level's operand, where "
              "the copy loop then moves it.",
               on_exit={"A": "corrupted", "X": "corrupted", "Y": "0", "plot_x": "0, for start's copy"})
annotator.c(0x5038, "OSBYTE &8C: *TAPE...")
annotator.c(0x503A, "...at 1200 baud")
annotator.c(0x503F, "Start level chosen with the loader's cheat...")
annotator.c(0x5042, "...into the operand of first_level's LDA, at its stored address")
annotator.c(0x5045, "Y = 0 and plot_x = 0 for the copy")
annotator.c(0x5047, "...destination low byte 0")
annotator.c(0x5049, "Return")

annotator.sub(0x148B, "first_level", "Set the starting level",
              "Set level_bcd to the level before the first one played. The "
              "operand of the LDA is 0 unless the loader's start-level cheat "
              "has patched it.",
               on_exit={"A": "the level before the first to play (0, or the cheat's choice)", "X": "preserved", "Y": "preserved"})
annotator.c(0x148B, "Level before the first (patched by the cheat)")
annotator.c(0x148D, "...as level_bcd: new_game adds one")
annotator.c(0x1490, "Return")

annotator.label(0x16D0, "level_command", length=8, description=(
    "The command that loads a level, \"L.$.L\" followed by the level number "
    "and a carriage return; level_loop writes the number."))
annotator.sub(0x1446, "load_level", "Load the level file",
              "Reset the page numbers in the self-modifying copy loops, then "
              "move pages &0E-&18 out of the filing system's way and load the "
              "level from disc (save_game_pages, continuing in "
              "load_level_from_copy).",
               on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
annotator.sub(0x0450, "save_game_pages", "Move the game out of the way and load a level",
              "Keep the level number's digits on the stack, copy pages &0E-&18 "
              "to &4E-&58 and clear the originals for the filing system's use, "
              "put the digits into the moved copy of level_command, and jump "
              "to the moved copy of load_level_from_copy.",
               on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
annotator.entry(0x145C)
annotator.sub(0x145C, "load_level_from_copy", "Load a level, running from the copy at &545C",
              "Runs only from its copy at &545C, made by save_game_pages, so "
              "its addresses are those of the copy. Select the disc filing "
              "system, *LOAD the level, reselect *TAPE, and copy pages &4E-&58 "
              "back to &0E-&18 before returning to start_level.",
               on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})

for addr, text in [
    (0x5003, "(unused)"),
    (0x0E00, "New game: level_bcd = the level before the first played"),
    (0x0E03, "level_number = 0"),
    (0x0E05, "...counting from the first level played"),
    (0x1446, "Reset the page numbers of the copy loops below to &0E and "
             "&4E..."),
    (0x1448, "...for save_game_pages' source..."), (0x144B, "...its cleared page..."), (0x144E, "...(in the copy at &545C)"),
    (0x1451, "...and &4E..."), (0x1453, "...for save_game_pages' destination..."), (0x1456, "...(in the copy at &545C)"),
    (0x1459, "...and move the game out of the way"),
    (0x0450, "Keep the level number's digits, which are about to be "
             "cleared..."),
    (0x0453, "...tens digit pushed"), (0x0454, "...units digit..."), (0x0457, "...pushed"),
    (0x0458, "Copy pages &0E-&18 to &4E-&58, clearing the originals"),
    (0x045A, "...take a byte of the game..."), (0x045D, "...kept"), (0x045E, "...zero..."), (0x0460, "...cleared for the filing system"),
    (0x0463, "...the byte again..."), (0x0464, "...saved above &4E00"), (0x0467, "...next byte"), (0x0468, "Until the page is done"),
    (0x046A, "Next page: advance the three page operands"),
    (0x046D, "...the cleared page..."), (0x0470, "...and the save page"),
    (0x0473, "Until page &19"),
    (0x0476, "...page &19 reached?"), (0x0478, "No: the next page"),
    (0x047A, "Put the digits into the moved copy of level_command"),
    (0x047B, "...units digit into the moved command"), (0x047E, "...tens digit..."), (0x047F, "...into the moved command"),
    (0x0482, "Continue in the moved copy of load_level_from_copy"),
    (0x145C, "*D. (*DISC), from the moved copy of the command at &149D"),
    (0x145E, "...high byte of the command"), (0x1460, "...on the disc filing system"),
    (0x1463, "*L.$.Ln (*LOAD), from the moved copy of level_command"),
    (0x1465, "...high byte of the command"), (0x1467, "...load the level file to &6B00"),
    (0x146A, "OSBYTE &8C: back to *TAPE..."),
    (0x146C, "...at 1200 baud"),
    (0x146E, "...the filing system the game began on"),
    (0x1471, "Copy pages &4E-&58 back to &0E-&18"),
    (0x1473, "...each saved byte..."), (0x1476, "...back into the game"), (0x1479, "...next byte"), (0x147A, "Until the page is done"),
    (0x147C, "Next page: advance the page operands (in this copy)"),
    (0x147F, "...and the destination page"), (0x1482, "Until page &19"), (0x1485, "...page &19 reached?"),
    (0x1487, "No: the next page"),
    (0x1489, "Return to start_level"),
]:
    annotator.c(addr, text)

# ---------------------------------------------------------------------------
# The self-modifying page copies, and the moved copies they run from.

d.constant(IMAGE_STORED_ADDR - IMAGE_RUN_ADDR, "image_offset",
           comment="How far above its run address DUNJ4 stores the game image")
for addr, name in [(0x045A, "save_page_byte"), (0x0460, "clear_page_byte"),
                   (0x0464, "store_saved_byte"), (0x1473, "restore_page_byte"),
                   (0x1476, "put_back_byte"), (0x500E, "copy_image_page")]:
    annotator.label(addr, name)
for addr, name, text in [
    (0x045C, "save_source_page", "Page that save_game_pages copies from, &0E-&18."),
    (0x0462, "save_clear_page", "Page that save_game_pages clears, &0E-&18."),
    (0x0466, "save_dest_page", "Page that save_game_pages copies to, &4E-&58."),
    (0x1475, "restore_source_page", "Page that load_level_from_copy copies from, &4E-&58 (patched in its moved copy)."),
    (0x1478, "restore_dest_page", "Page that load_level_from_copy copies to, &0E-&18 (patched in its moved copy)."),
    (0x149A, "level_command_digits", "The level number's digits in the crack's level command."),
]:
    annotator.label(addr, name, description=text)
# The page copies' operands are patched at run time; they start at these pages.
for operand_addr, page_addr in [(0x045B, 0x0E00), (0x0461, 0x0E00), (0x0465, 0x4E00),
                                (0x1474, 0x4E00), (0x1477, 0x0E00)]:
    d.expr(operand_addr, hexlit(page_addr), move=game_image)
d.label(0x4E00, "saved_pages", group="game_state", description=(
    "Where save_game_pages keeps pages &0E-&18 while a level loads, "
    "&4E00-&58FF."))
d.label(0x5100, "cheat_start_level", group="game_state", description=(
    "The level less one that DUNJ's @ cheat asks for and pokes here."))
d.label(0x545C, "moved_load_level_from_copy", group="game_state", description=(
    "load_level_from_copy as save_game_pages moves it, where it runs."))
d.label(0x5475, "moved_restore_source_page", group="game_state")
d.label(0x5478, "moved_restore_dest_page", group="game_state")
d.label(0x5495, "moved_level_command", group="game_state")
d.label(0x549A, "moved_level_command_digits", group="game_state")
d.expr_label(0x549B, "moved_level_command_digits+1")
d.label(0x549D, "moved_disc_command", group="game_state")
for operand_addr, name in [(0x145D, "moved_disc_command"), (0x1464, "moved_level_command")]:
    d.expr(operand_addr, lo(sym(name)), move=game_image)
    d.expr(operand_addr + 2, hi(sym(name)), move=game_image)
d.expr(0x5043, sym("first_level") + 1 + sym("image_offset"))
d.expr(0x502C, lo(sym("wrch_handler")))
d.expr(0x5031, hi(sym("wrch_handler")))

annotator.c(0x0D6E, "Not referenced")  # after game_entry
annotator.c(0x0772, "Not referenced")
annotator.c(0x07F8, "Not referenced")


def table_entry_comment(addr):
    """What a split-off entry of one of the moved tables holds."""
    tables = [(0x0B2A, "returning_hero_queue", 5), (0x0B80, "missile_damage", 12),
              (0x0B90, "trapdoor_x", 8), (0x0B98, "trapdoor_y", 8),
              (0x0D15, "hero_y", 4), (0x0D1A, "hero_direction", 4),
              (0x0D20, "hero_frame", 4), (0x0D90, "hero_health_tens", 4),
              (0x0DA0, "view_room", 8)]
    base, name, length = max(t for t in tables if t[0] <= addr)
    k = addr - base
    if k >= length:
        return ("Not read: page &0D is refreshed from workspace_template"
                if 0x0D00 <= addr < 0x0E00 else "Not referenced")
    if name.startswith("trapdoor"):
        return f"Trapdoor {k + 1}'s {name[-1]}"
    if name == "view_room":
        return f"Hero {k // 2}'s view room, {'high' if k % 2 else 'low'} byte"
    if name == "missile_damage":
        return f"Missile slot {k}'s damage"
    if name == "returning_hero_queue":
        return f"Queue entry {k}"
    return f"Hero {k}'s {name[5:].replace('_', ' ')}"

# ---------------------------------------------------------------------------
# Data no instruction refers to, and the entries of moved tables that the
# tables' expression labels split into items of their own
# (acornaeology/dasmos#60): (move name or None, runtime address).

TAPE_UNREFERENCED = [
    ('game_image', 0x0858),
    ('game_image', 0x08B8),
    ('game_image', 0x0D88),
    ('game_image', 0x0D8F),
    ('game_image', 0x120F),
    ('game_image', 0x12D4),
    ('game_image', 0x148A),
    ('game_image', 0x1491),
    ('game_image', 0x16D6),
    (None, 0x504A),
]
TAPE_TABLE_ENTRIES = [
    ('game_image', 0x0B2B),
    ('game_image', 0x0B2C),
    ('game_image', 0x0B2D),
    ('game_image', 0x0B2E),
    ('game_image', 0x0B8F),
    ('game_image', 0x0B91),
    ('game_image', 0x0B92),
    ('game_image', 0x0B93),
    ('game_image', 0x0B94),
    ('game_image', 0x0B95),
    ('game_image', 0x0B96),
    ('game_image', 0x0B97),
    ('game_image', 0x0B99),
    ('game_image', 0x0B9A),
    ('game_image', 0x0B9B),
    ('game_image', 0x0B9C),
    ('game_image', 0x0B9D),
    ('game_image', 0x0B9E),
    ('game_image', 0x0B9F),
    ('game_image', 0x0D19),
    ('game_image', 0x0D1B),
    ('game_image', 0x0D1C),
    ('game_image', 0x0D1D),
    ('game_image', 0x0D1F),
    ('game_image', 0x0D21),
    ('game_image', 0x0D22),
    ('game_image', 0x0D23),
    ('game_image', 0x0D91),
    ('game_image', 0x0D92),
    ('game_image', 0x0D93),
    ('game_image', 0x0DA1),
    ('game_image', 0x0DA2),
    ('game_image', 0x0DA3),
    ('game_image', 0x0DA4),
    ('game_image', 0x0DA5),
    ('game_image', 0x0DA6),
    ('game_image', 0x0DA7),
]
moves_by_name = {"game_image": game_image, None: None}
for move_name, addr in TAPE_UNREFERENCED:
    d.comment(addr, "Not referenced", align=dasmos.Align.INLINE, move=moves_by_name[move_name])
for move_name, addr in TAPE_TABLE_ENTRIES:
    d.comment(addr, table_entry_comment(addr), align=dasmos.Align.INLINE,
              move=moves_by_name[move_name])
# The checksum table survives, but the crack's level loader never reads it.
for row, text in [(0x0490, "Level checksums (entry 0, levels 1-7), never read"),
                  (0x0498, "...levels 8-15"), (0x04A0, "...levels 16-23"),
                  (0x04A8, "...levels 24-25")]:
    d.byte(row, 2 if row == 0x04A8 else 8, cols=8, move=game_image, override=True)
    d.comment(row, text, align=dasmos.Align.INLINE, move=game_image)

# DUNJ3 past &7FFF: loaded into the sideways ROM area, so never in RAM.
d.banner(0x8000, title="DUNJ3 beyond the game",
         description="&8000-&9CFF, loaded into the paged ROM area, where "
         "it never reaches RAM. From &869A to the end it is byte for byte "
         "the loading screen DUNJ2's &381A-&4E7F: memory as it lay when the "
         "file was saved.")
for row in range(0x8000, 0x9D00, 0x100):
    d.byte(row, 0x100, cols=16, override=True)
    d.comment(row, f"&{row:04X}-&{row + 0xFF:04X}: never in RAM", align=dasmos.Align.INLINE)

ir = d.disassemble()
asm_filepath.parent.mkdir(parents=True, exist_ok=True)
asm_filepath.write_text(str(ir.render("beebasm")), encoding="utf-8")
json_filepath.write_text(str(ir.render("json")), encoding="utf-8")
