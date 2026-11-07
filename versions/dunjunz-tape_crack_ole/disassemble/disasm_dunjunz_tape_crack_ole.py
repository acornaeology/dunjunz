"""dasmos driver for the game code of Ole's crack of the Dunjunz cassette.

Both game files are disassembled together, each saved as its own file.
DUNJ4's game image is a dasmos move from &2400-&4FFF, where the file
stores it, to &0400-&2FFF, where it runs; the two ranges overlap.

## The files

| File | Load | Exec | Contents |
|---|---|---|---|
| `DUNJ3` | &6E80 | - | &2E80 bytes: the game's &6E80-&7FFF; the bytes past &7FFF fall in the paged ROM area and never reach RAM |
| `DUNJ4` | &2400 | &5000 | The game's &0400-&2FFF image, stored &2000 higher, then `start` at &5000 |

## Memory map in play

| Range | Contents |
|---|---|
| &0000-&03FF | Zero page, stack and MOS workspace; the game's zero page is &70-&8F |
| &0400-&0CFF | Score overflow, `save_game_pages` (at &0450), the hero menu, `plot_sprite`, `screen_address`, per-hero tables, `room_walls` at &0C00 |
| &0D00-&10FF | Page &0D's per-level workspace (holding the unused `game_entry` until the first level), `new_game` and `level_loop` at &0E00, the status panel, `check_for_victory` |
| &1100-&2FFF | The victory sequence's ring and Chalice, the font, `start_level`, `load_level` and `first_level`, sprites, `update_game`, `play_level` |
| &3000-&6E7F | Screen (25 character rows in play) |
| &4E00-&58FF | `saved_pages`: pages &0E-&18 while a level loads, in screen memory, with the copy of `load_level_from_copy` that runs there |
| &6B00-&6DAF | The level file, loaded into the screen's bottom rows |
| &6E80-&7FFF | `DUNJ3`: heroes, missiles, objects, monsters, `workspace_template`, `wrch_handler` |

## From power-on to play

1. `PLOAD` (BASIC) shows the cracker's picture `GIRL1`, unpacked by
   `*EXPAND`, scrolls the crack's message and chains `DUNJ`.
2. `DUNJ` (BASIC) loads the loading screen `DUNJ2` and waits for SPACE,
   or I for instructions, or @ for the start-level cheat, which pokes the
   start level less one into `cheat_start_level` (&5100). It sets the
   bell with *FX211-214 (as `game_entry` would), `*LOAD`s `DUNJ3` and
   `*RUN`s `DUNJ4`.
3. `start` (&5000) calls `select_tape_and_cheat`, which selects *TAPE
   and copies the cheat's level into the stored `first_level`, then copies
   the game image down to &0400-&2FFF, saves WRCHV in `saved_wrchv`,
   points WRCHV at `wrch_handler` and jumps to `new_game`. `game_entry`'s
   start-up at &0D31 is never run.
4. `new_game` sets `level_bcd` from `first_level` and `level_number` to
   0, gives each hero their starting attributes (`reset_hero`) and runs
   `hero_menu`.
5. `level_loop` sets `monster_start_hit_points`, counts the level in
   `level_bcd` and writes its digits into `level_command`, then calls
   `start_level`, which runs steps 6 to 8.
6. `show_level_number` clears the screen, counts `level_number` and shows
   LEVEL and the number.
7. `load_level` resets the page copies' operands and jumps to
   `save_game_pages`, which moves pages &0E-&18, where the disc filing
   system keeps its workspace, to `saved_pages` and zeroes them, puts the
   digits into the moved copy of `run_level_command` and jumps to the
   moved `load_level_from_copy`. That does `*DISC` and `*LOAD $.Ln` (to
   the file's load address, &6B00), reselects *TAPE, copies the pages
   back and returns to `start_level`. The level files are stored
   decrypted, and nothing checks them.
8. `unpack_level`, `reset_workspace` (which refills page &0D) and
   `reset_monsters` set up play; the screen is cleared and set to 25 rows,
   and `draw_view_frames` draws the frames and the four views.
9. `draw_status_panel` and `remove_absent_heroes` finish the screen, and
   `play_level` runs the level until no hero is left in play.
10. Every dead hero gets their starting attributes back. If any hero
   survived, `level_loop` starts the next level; if all four died, the
   game-over message is shown for up to 60 seconds or until a key, and
   `new_game` starts again. A hero reaching the Chalice on the 25th level
   played is caught by `check_for_victory`, which plays
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

asm_filepath = Path(os.environ.get("FANTASM_ASM", OUTPUT_DIRPATH / "dunjunz-tape_crack_ole.asm"))
json_filepath = Path(os.environ.get("FANTASM_JSON", OUTPUT_DIRPATH / "dunjunz-tape_crack_ole.json"))

# DUNJ4 = the &0400-&2FFF image (stored at &2400) + start-up code at &5000.
IMAGE_RUN_ADDR, IMAGE_STORED_ADDR, IMAGE_LENGTH = 0x0400, 0x2400, 0x2C00

d = dasmos.Disassembler.create(cpu="6502")
d.load(BINARY_DIRPATH / "DUNJ4", IMAGE_STORED_ADDR, name="DUNJ4", exec_addr=0x5000)
d.load(BINARY_DIRPATH / "DUNJ3", 0x6E80, name="DUNJ3", exec_addr=0x0000)
d.use_environment("acorn_mos")
d.use_environment("acorn_model_b_hardware")
d.set_file_header(
    title="Dunjunz, Ole's crack of the cassette: the game",
    description=("Annotated disassembly of the game files `DUNJ4` and `DUNJ3`.\n\n"
                 + __doc__.split("\n\n", 2)[2]),
)

game_image =d.add_move(IMAGE_RUN_ADDR, IMAGE_STORED_ADDR, IMAGE_LENGTH, name="game_image")

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
              "Put the game where it runs and start a new game. Run once, by "
              "DUNJ's */DUNJ4, after DUNJ3 has been loaded and the bell set; "
              "it stands in for game_entry, whose start-up at &0D31 is never "
              "run.\n\n"
              "select_tape_and_cheat selects the cassette filing system, so "
              "that the disc filing system is selected only while "
              "load_level_from_copy loads a level, and patches the cheat's "
              "start level into the stored first_level. The game image is "
              "then copied a page at a time from &2400-&4FFF down to "
              "&0400-&2FFF: the ranges overlap, but an ascending copy "
              "downwards reads each byte before it is overwritten. Last, "
              "WRCHV is saved in saved_wrchv, for start_level to put back "
              "while it sends the view frames' PLOT commands, and pointed at "
              "wrch_handler, so that the game's text is printed in its own "
              "font.")
annotator.block(0x5004, "Copy the game image, &2400-&4FFF, down by &2000 to "
                        "&0400-&2FFF, where it runs.")
annotator.block(0x501F, "Hand text output to the game's font.")
for addr, text in [
    (0x5000, "Select *TAPE and patch the cheat's start level in"),
    (0x5003, ""),
    (0x5004, "Destination pointer = &0400, the game's first page..."),
    (0x5006, "...as the destination pointer's page"),
    (0x5008, "...source &2400 (both low bytes 0)"),
    (0x500A, "...as the source pointer's page"),
    (0x500C, "...source low byte 0 (Y = 0)"),
    (0x500E, "Copy a page of the game..."),
    (0x5010, "...&2000 lower, to where it runs"),
    (0x5012, "...on through the page"),
    (0x5013, "Until the page is done"),
    (0x5015, "Next destination page..."),
    (0x5017, "...and the source's"),
    (0x5019, "Until the source reaches &5000, this code..."),
    (0x501B, "...source page &50?"),
    (0x501D, "No: copy the next page"),
    (0x501F, "Keep the MOS's WRCHV in saved_wrchv..."),
    (0x5022, "...the handler's low byte..."),
    (0x5025, "...and its page..."),
    (0x5028, "...in saved_wrchv, for draw_view_frames' PLOTs"),
    (0x502B, "Point WRCHV at wrch_handler..."),
    (0x502D, "...the handler's low byte into WRCHV..."),
    (0x5030, "...and its page, &7F..."),
    (0x5032, "...so text prints in the game's font"),
    (0x5035, "Start a new game: the hero menu, then the first level"),
]:
    if text:
        annotator.c(addr, text)
annotator.sub(0x5038, "select_tape_and_cheat", "Select *TAPE and apply the start-level cheat",
              "Called once, first thing in start. Select the cassette filing "
              "system at 1200 baud, the filing system the game plays on, and "
              "copy the start level chosen in DUNJ (cheat_start_level, the "
              "start level less one, or 0 without the cheat) into the stored "
              "copy of first_level's LDA operand, at &348C, where start's "
              "copy loop then moves it to &148C. Also zero Y and plot_x, the "
              "low bytes of the copy's pointers.",
               on_exit={"A": "corrupted", "X": "corrupted", "Y": "0", "plot_x": "0, for start's copy"})
annotator.c(0x5038, "OSBYTE &8C: *TAPE...")
annotator.c(0x503A, "...at 1200 baud")
annotator.c(0x503F, "Start level - 1, poked here by DUNJ's cheat...")
annotator.c(0x5042, "...into first_level's LDA operand, before the copy")
annotator.c(0x5045, "Y = 0 and plot_x = 0 for the copy")
annotator.c(0x5047, "...destination low byte 0")
annotator.c(0x5049, "Return to start with Y = 0, ready to copy")

annotator.sub(0x148B, "first_level", "Set the starting level",
              "Called by new_game. Set level_bcd to the level before the "
              "first one played; level_loop adds one before each level. The "
              "operand of the LDA is 0 unless the loader's start-level cheat "
              "has patched it. DUNJ pokes the start level less one in binary, "
              "while level_bcd is binary-coded decimal, so the value is right "
              "only for start levels 1-10: 11-16 give digits that are not "
              "decimal, and 17 gives &10, level 11. The cheat moves only "
              "level_bcd: new_game still sets level_number to 0, so it counts "
              "levels played, and it is level_number that decides whether "
              "the level's filename has two digits (from the tenth level "
              "played on) and whether the Chalice is checked for (on the "
              "25th level played).",
               on_exit={"A": "the level before the first to play (0, or the cheat's choice)", "X": "preserved", "Y": "preserved"})
annotator.c(0x148B, "Level before the first (patched by the cheat)")
annotator.c(0x148D, "...as level_bcd: level_loop adds one")
annotator.c(0x1490, "Return to new_game with A = that level")

annotator.label(0x16D0, "level_command", length=8, description=(
    "\"L.$.L\", then the level number in one or two ASCII digits "
    "(level_filename_digits, written by level_loop before each level) and "
    "a carriage return. Only the digits are read, by save_game_pages, "
    "which copies them into the moved run_level_command; this command "
    "itself is never passed to OSCLI."))
annotator.banner(0x1495, "The commands load_level_from_copy runs",
                 "Two OSCLI commands, run only from the copies that "
                 "save_game_pages' page move leaves at &5495 and &549D: "
                 "\"L.$.L\" with the level's digits (patched into the copy) "
                 "and \"D.\" (*DISC).")
annotator.label(0x1495, "run_level_command", description=(
    "\"L.$.Ln\": *LOAD the level file, to its own load address &6B00. "
    "Run from its copy, moved_level_command; save_game_pages writes the "
    "digits at moved_level_command_digits."))
annotator.label(0x149D, "disc_command", description=(
    "\"D.\": *DISC, run from its copy, moved_disc_command, to select the "
    "disc filing system for the level load."))
annotator.c(0x1495, "*L.$.L, the level's file, digits to follow")
annotator.c(0x149A, "Digits and CR: \"1\" as stored; each load leaves its own")
annotator.c(0x149D, "*D. (*DISC)")
annotator.sub(0x1446, "load_level", "Load the level file from disc",
              "Bring the next level's file, $.Ln, from disc into "
              "&6B00-&6DAF. Called by start_level once per level, after "
              "show_level_number has cleared the screen and counted "
              "level_number, and before unpack_level copies the level into "
              "play.\n\n"
              "The disc filing system keeps its workspace in pages &0E-&18, "
              "where the game lives, so the game is moved out of the way "
              "while the file loads and put back afterwards. The work is "
              "done in two halves: save_game_pages, in page &04 outside the "
              "pages it moves, and load_level_from_copy, which runs from "
              "the copy of it that the move leaves in screen memory at "
              "&545C. save_game_pages steps its own three page operands, "
              "leaving them at &19, &19 and &59 after each load, so this "
              "routine first sets them back to &0E, &0E and &4E. It also "
              "sets the restore loop's to &4E and &0E before the move "
              "copies them: the restore steps those in the running copy, and "
              "putting back page &14 from that copy leaves &54 and &14 here. "
              "Then it jumps to save_game_pages; the return to "
              "start_level comes from the copy at &545C.\n\n"
              "saved_pages lies in character rows 12-16 of the screen, so "
              "the moved game shows there, under the level number, while "
              "the file loads.\n\n"
              "The level is not decrypted or checked: the crack's level "
              "files are stored decrypted, and level_checksums is never "
              "read.",
               on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
annotator.sub(0x0450, "save_game_pages", "Move the game out of the way and load a level",
              "The first half of load_level, reached by its JMP. Move pages "
              "&0E-&18 of the game to saved_pages (&4E00-&58FF) so the disc "
              "filing system can use them, then continue in the copy of "
              "load_level_from_copy that the move has just put at &545C. "
              "This routine is in page &04, outside the pages it moves, so "
              "it can run throughout.\n\n"
              "The filename's digits, in page &16, would be lost with the "
              "page, so they go on the stack first. Each byte of the pages "
              "is copied up and its original zeroed. The digits are then "
              "written into moved_level_command (the copy of "
              "run_level_command), and the JMP to "
              "moved_load_level_from_copy leaves start_level's return "
              "address on the stack for it.",
               on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
annotator.block(0x0450, "Keep the filename's digits, from a page about to be "
                        "cleared, on the stack.")
annotator.block(0x0458, "Copy pages &0E-&18 up to &4E-&58, zeroing each "
                        "original byte. The three page operands start at "
                        "&0E, &0E and &4E, as load_level set them.")
annotator.block(0x047A, "Put the digits into the moved level command and "
                        "carry on in the moved code.")
annotator.entry(0x145C)
annotator.sub(0x145C, "load_level_from_copy", "Load a level, running from the copy at &545C",
              "The second half of load_level. It runs only from its copy at "
              "&545C, made by save_game_pages' page move, so its operands "
              "are the copy's addresses, outside the pages it restores. "
              "Select the disc filing system with *D., *LOAD the level with "
              "*L.$.Ln (to the file's own load address, &6B00), reselect "
              "*TAPE, and copy saved_pages back to &0E-&18. Return to "
              "start_level, whose return address the stack still holds. The "
              "copy at &4E00-&58FF is left in screen memory until "
              "start_level clears the screen.",
               on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
annotator.block(0x145C, "Load the level from disc, then go back to the "
                        "cassette filing system.")
annotator.block(0x1471, "Put the game's pages back: copy &4E-&58 down to "
                        "&0E-&18, stepping the copy's own page operands.")

for addr, text in [
    (0x5003, "Padding: does nothing"),
    (0x0E00, "New game: level_bcd = the level before the first played"),
    (0x0E03, "level_number = 0, even when the cheat has moved level_bcd"),
    (0x0E05, "...so it counts levels played, not the level"),
    (0x1446, "Reset the page numbers of the copy loops below to &0E and "
             "&4E..."),
    (0x1448, "...for save_game_pages' source..."), (0x144B, "...its cleared page..."), (0x144E, "...and the restore's destination"),
    (0x1451, "...then page &4E, the start of saved_pages..."), (0x1453, "...for save_game_pages' destination..."), (0x1456, "...and the restore's source"),
    (0x1459, "...and move the game out of the way"),
    (0x0450, "Filename's first digit, in page &16, about to be cleared..."),
    (0x0453, "...first digit pushed"), (0x0454, "...second digit, or the CR after one digit..."),
    (0x0457, "...pushed on top: it comes off first"),
    (0x0458, "Copy pages &0E-&18 to &4E-&58, clearing the originals"),
    (0x045A, "...take a byte of the game..."), (0x045D, "...held on the stack while..."),
    (0x045E, "...then 0, to clear the original with..."), (0x0460, "...replaces it in the game's page"),
    (0x0463, "...the byte again..."), (0x0464, "...saved above &4E00"),
    (0x0467, "...on through the page"), (0x0468, "Until the page is done"),
    (0x046A, "Next page: advance the three page operands"),
    (0x046D, "...the cleared page..."), (0x0470, "...and the save page"),
    (0x0473, "Until page &19"),
    (0x0476, "...page &19 reached?"), (0x0478, "No: the next page"),
    (0x047A, "Put the digits into the moved copy of the L.$.L command"),
    (0x047B, "...second digit or CR into the moved command"),
    (0x047E, "...then the first digit..."), (0x047F, "...into the moved command"),
    (0x0482, "Continue in the moved copy of load_level_from_copy"),
    (0x145C, "*D. (*DISC), from the moved copy of the command at &149D"),
    (0x145E, "...high byte of the command"), (0x1460, "...on the disc filing system"),
    (0x1463, "*L.$.Ln (*LOAD), from the moved command at &5495"),
    (0x1465, "...high byte of the command"), (0x1467, "...load the level file to &6B00"),
    (0x146A, "OSBYTE &8C: back to *TAPE..."),
    (0x146C, "...at 1200 baud"),
    (0x146E, "...the filing system the game began on"),
    (0x1471, "Copy pages &4E-&58 back to &0E-&18"),
    (0x1473, "...each saved byte..."), (0x1476, "...back into the game"),
    (0x1479, "...on through the page"), (0x147A, "Until the page is done"),
    (0x147C, "Next page: advance the page operands (in this copy)"),
    (0x147F, "...and the destination page"), (0x1482, "Until page &19"), (0x1485, "...page &19 reached?"),
    (0x1487, "No: the next page"),
    (0x1489, "Return to start_level, from the copy at &545C"),
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
    (0x1475, "restore_source_page", "Page that load_level_from_copy copies from, &4E-&58. It is stepped in "
                                    "the moved copy; restoring page &14 leaves &54 here, so load_level resets it."),
    (0x1478, "restore_dest_page", "Page that load_level_from_copy copies to, &0E-&18. It is stepped in "
                                  "the moved copy; restoring page &14 leaves &14 here, so load_level resets it."),
    (0x149A, "level_command_digits", "The level number's digits and CR in run_level_command. "
                                     "save_game_pages writes them in the moved copy, and the "
                                     "restore of page &14 brings them back here."),
]:
    annotator.label(addr, name, description=text)
# The page copies' operands are patched at run time; they start at these pages.
for operand_addr, page_addr in [(0x045B, 0x0E00), (0x0461, 0x0E00), (0x0465, 0x4E00),
                                (0x1474, 0x4E00), (0x1477, 0x0E00)]:
    d.expr(operand_addr, hexlit(page_addr), move=game_image)
d.label(0x4E00, "saved_pages", group="game_state", description=(
    "&4E00-&58FF, in screen memory: where save_game_pages keeps the "
    "game's pages &0E-&18 while a level loads, page for page (&0Exx at "
    "&4Exx). load_level_from_copy runs from its copy here, and copies the "
    "pages back; the bytes stay until start_level clears the screen."))
d.label(0x5100, "cheat_start_level", group="game_state", description=(
    "The start level less one, in binary, poked here by DUNJ (0 unless "
    "the @ cheat chose another level). Read once, by "
    "select_tape_and_cheat, which copies it into first_level."))
d.label(0x545C, "moved_load_level_from_copy", group="game_state", description=(
    "load_level_from_copy as save_game_pages moves it, where it runs."))
d.label(0x5475, "moved_restore_source_page", group="game_state", description=(
    "The restore loop's source page in the running copy, &4E-&58, "
    "stepped by load_level_from_copy."))
d.label(0x5478, "moved_restore_dest_page", group="game_state", description=(
    "The restore loop's destination page in the running copy, &0E-&18, "
    "stepped and tested for &19 by load_level_from_copy."))
d.label(0x5495, "moved_level_command", group="game_state", description=(
    "The copy of run_level_command that load_level_from_copy passes to "
    "OSCLI."))
d.label(0x549A, "moved_level_command_digits", group="game_state", description=(
    "The level's one or two digits and CR in moved_level_command, "
    "written by save_game_pages."))
d.expr_label(0x549B, "moved_level_command_digits+1")
d.label(0x549D, "moved_disc_command", group="game_state", description=(
    "The copy of disc_command (\"D.\") that load_level_from_copy passes "
    "to OSCLI."))
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
