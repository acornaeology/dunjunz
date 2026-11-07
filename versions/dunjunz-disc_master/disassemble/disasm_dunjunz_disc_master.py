"""dasmos driver for the game on the Master 128 side of the official
Dunjunz disc.

*DUNJUNZ (its own listing) loads the game's code that lives in the
Master's private RAM (HAZEL, &C000-&DFFF) and runs `Coder`, directly or
through `Coder2` (also its own listing), which installs the joystick
handler. Coder's loader at &0740 saves the MOS's page &0D in HAZEL, loads
the rest of the game and starts it at &0E00. The game is nine files:

    Coder   &0400-&07FE   the game's &0400-&07FF (the loader at &0740)
    Dunj3   &08C0-&0CFE
    Dunj4   &0E00-&1FFF
    Dunj5   &2000-&2FFF
    Dunj2   &6E80-&7FFF
    Code    &C500-&C56B   joystick handler for BYTEV          (HAZEL)
    Table   &C5A0-&C6F7   level 25, game over, row offsets, pause (HAZEL)
    Code2   &C700-&D759   music                               (HAZEL)
    Code3   &D800-&D8FE   copy of the sprite plotter          (HAZEL)

The game stays resident from level to level, as on cassette.

MOS 3.20 starts *RUN programs with HAZEL paged in (ACCCON bit 3 set), and
the game never changes ACCCON, so its reads and calls of &C000-&DFFF reach
these files rather than the MOS ROM.
"""

import os
import sys
from pathlib import Path

import dasmos
from dasmos.expr import hi, lo, sym

VERSION_DIRPATH = Path(__file__).resolve().parent.parent
REPO_DIRPATH = VERSION_DIRPATH.parent.parent
sys.path.insert(0, str(REPO_DIRPATH))

from dunjunz_common import game  # noqa: E402
from dunjunz_common.annotator import Annotator  # noqa: E402

BINARY_DIRPATH = VERSION_DIRPATH / "binary"
OUTPUT_DIRPATH = VERSION_DIRPATH / "output"

asm_filepath = Path(os.environ.get("FANTASM_ASM", OUTPUT_DIRPATH / "dunjunz-disc_master.asm"))
json_filepath = Path(os.environ.get("FANTASM_JSON", OUTPUT_DIRPATH / "dunjunz-disc_master.json"))

# (DFS name, load address, exec address), in address order. Each loads
# at its run address.
FILES = [
    ("Coder", 0x0400, 0x0740),
    ("Dunj3", 0x08C0, 0x08C0),
    ("Dunj4", 0x0E00, 0x0E00),
    ("Dunj5", 0x2000, 0x2000),
    ("Dunj2", 0x6E80, 0x6E80),
    ("Code", 0xC500, 0xC500),
    ("Table", 0xC5A0, 0xC5A0),
    ("Code2", 0xC700, 0xC700),
    ("Code3", 0xD800, 0xD800),
]

d = dasmos.Disassembler.create(cpu="6502")
for name, addr, exec_addr in FILES:
    d.load(BINARY_DIRPATH / name, addr, name=name, exec_addr=exec_addr)
d.use_environment("acorn_mos")
d.use_environment("acorn_master_hardware")


# Runtime addresses where the Master game's code differs from the
# cassette-derived game the shared annotations describe. The shared
# annotations skip them, and this driver annotates them itself.
DIFFERENT_RANGES = [
    (0x0481, 0x0484),  # the failed-checksum call: not a reset on a Master
    (0x0700, 0x0800),  # Coder's leftovers and the loader at &0740
    (0x0967, 0x0968),  # screen_address: its banner names the MOS 1.20 table
    (0x096E, 0x0970),  # row offsets read from Table, not the MOS
    (0x0976, 0x0978),
    (0x0E86, 0x0E8B),  # game over: stop the music
    (0x0EC3, 0x0EC7),  # a shorter wait after game over
    (0x1400, 0x163A),  # starting a level: rewritten for DFS loading
    (0x1ED7, 0x1EF7),  # the pause key, moved to Table
    (0x6F45, 0x6F4A),  # the bell, removed
    (0x7F8F, 0x7F93),  # WRCHV handler: straight to the MOS
    (0xC375, 0xC377),  # MOS 1.20 addresses this side does not use
    (0xD9CD, 0xD9CE),
    (0xE0A4, 0xE0A5),
]


def differs(addr):
    return any(lo <= addr < hi for lo, hi in DIFFERENT_RANGES)


def placements(addr):
    return [(None, "")]


def memory_group(addr):
    """Groups for labels in page &0D, which no file loads."""
    if 0x0D00 <= addr < 0x0E00:
        return "game_state"
    return None


annotator = Annotator(d, "disc_master", placements, skip=differs,
                      default_group=memory_group)
game.annotate(annotator)
game.annotate_level_check(annotator)
game.annotate_start_level(annotator)
game.annotate_level_end(annotator)
game.annotate_hack_continuations(annotator)
game.annotate_menu_tables(annotator, 0x06F8)
game.annotate_cassette_level_loop(annotator)
for addr, text in [(0x0E32, "...(always branches)"), (0x0E49, "..."),
                   (0x0E4A, "..."), (0x0E4B, "...")]:
    annotator.c(addr, text)

def comments(a, pairs):
    for addr, text in pairs:
        a.c(addr, text)



# ---------------------------------------------------------------------------
# Routines that this side has at other addresses, byte for byte as in the
# cassette-derived game: the shared annotations are applied to them through
# an address shift.


class Shifted:
    """A view of the disassembler that adds `offset` to the address each
    annotation names."""

    ADDRESSED = {
        "entry", "banner", "subroutine", "comment", "expr", "label",
        "index_region", "expr_label", "optional_label", "index_base",
        "byte", "string", "stringcr", "stringz", "word", "format_hint",
        "inkey_number",
    }

    def __init__(self, disassembler, offset):
        self._d = disassembler
        self._offset = offset

    def __getattr__(self, name):
        attr = getattr(self._d, name)
        if name not in self.ADDRESSED:
            return attr

        def shifted(addr, *args, **kwargs):
            return attr(addr + self._offset, *args, **kwargs)

        return shifted


def apply_shifted(lo, hi, new_lo, suffix="", exclude=()):
    """Apply the shared annotations for cassette-lineage addresses lo-hi
    (end exclusive) to the same bytes at new_lo."""
    shifted = Annotator(
        Shifted(d, new_lo - lo), "disc_master", lambda addr: [(None, suffix)],
        skip=lambda addr: not lo <= addr < hi or addr in exclude,
        default_group=memory_group)
    game.annotate(shifted)
    game.annotate_start_level(shifted)
    game.annotate_cassette_level_loop(shifted)
    game.annotate_cassette_continuations(shifted)
    game.annotate_hack_continuations(shifted)


apply_shifted(0x14A0, 0x14D7, 0x150D)                  # reset_workspace
apply_shifted(0x14E3, 0x1505, 0x1544)                  # draw_view_frames
apply_shifted(0x1510, 0x1583, 0x1571)                  # unpack_level
apply_shifted(0x1583, 0x15B1, 0x15E4)                  # reset_monsters
apply_shifted(0x161A, 0x1639, 0x1619)                  # clear_text_area
# Code3: the sprite plotter and screen_address, copied into private RAM.
apply_shifted(0x0900, 0x09A0, 0xD800, suffix="_hazel",
              exclude={0x0967, 0x096E, 0x0976})

master = Annotator(d, "disc_master", placements, default_group=memory_group)

master.sub(0x1544, "draw_view_frames", "Draw the frames round the four views",
           "Send the twenty PLOT commands of view_frame_plots, draw the four "
           "views, then point WRCHV at &7F8F, which on this side passes "
           "every character straight to the MOS.",
           on_entry={"plot_x": "address of view_frame_plots, low byte",
                     "plot_y": "address of view_frame_plots, high byte"})
master.c(0x1566, "Point WRCHV at &7F8F...")
master.c(0x1568, "...")
master.c(0x156B, "...")
master.c(0x156D, "...")
master.c(0x1570, "Return")

# ---------------------------------------------------------------------------
# Coder: the game's &0400-&07FF, with a loader at &0740.

master.label(0x0700, "line_buffer_leftovers", group="leftovers", description=(
    "Leftover contents of the MOS line-input buffer (&0700) from the "
    "machine this file was saved on."))
master.banner(0x0700, "Leftovers in the line-input buffer",
              "Not used by the game. &0700 is the MOS line-input buffer, and "
              "these bytes are what it held when Coder was saved: the command "
              "*SA. CODER 400+3FF 740, then the ends of shorter earlier lines "
              "and the fragment of BBC BASIC assembler "
              "(label+2:LDA#255:.label JSR&30) that the Model B images and the "
              "cassette lineage's &0400 images also hold.")
master.string(0x0700, 22)
master.byte(0x0716)
master.string(0x0717, 4)
master.byte(0x071B, 7, cols=7)
master.string(0x0722, 30)

master.sub(0x0740, "coder_start", "Coder: save the MOS's page &0D, load the game and start it",
           "Run with *RUN CODER (or from Coder2). Set the bell sound, copy "
           "page &0D, which the MOS and the filing system use for their NMI "
           "code and workspace, to &C400 in private RAM so that start_level "
           "can put it back before each level is loaded, *LOAD the four "
           "other game files, restore the display that *DUNJUNZ blanked, "
           "select COLOUR 2 and start a new game at &0E00.")
comments(master, [
    (0x0740, "Set the bell sound"),
    (0x0743, "Copy page &0D..."),
    (0x0745, "..."),
    (0x0748, "...to &C400 in private RAM"),
    (0x074B, "..."), (0x074C, "..."),
    (0x074E, "*L. DUNJ2 (&6E80-&7FFF)"),
    (0x0750, "..."), (0x0752, "..."),
    (0x0755, "*L. DUNJ3 (&08C0-&0CFE)"),
    (0x0757, "..."), (0x0759, "..."),
    (0x075C, "*L. DUNJ4 (&0E00-&1FFF)"),
    (0x075E, "..."), (0x0760, "..."),
    (0x0763, "*L. DUNJ5 (&2000-&2FFF)"),
    (0x0765, "..."), (0x0767, "..."),
    (0x076A, "Send the 21 bytes of coder_display_vdu"),
    (0x076C, "..."), (0x076F, "..."), (0x0772, "..."), (0x0773, "..."),
    (0x0775, "..."),
    (0x0777, "..."),
])
for addr in (0x077A, 0x0783, 0x078C, 0x0795):
    master.string(addr, 8)
    master.byte(addr + 8)
for addr, name in [(0x077A, "load_dunj2_command"), (0x0783, "load_dunj3_command"),
                   (0x078C, "load_dunj4_command"), (0x0795, "load_dunj5_command")]:
    master.label(addr, name, description=(
        f"\"L. {name[5:10].upper()}\", ended by a carriage return."))
master.label(0x079E, "coder_display_vdu", length=21, description=(
    "VDU 6, then VDU 23,0,6,25,0,0,0,0,0,0 (25 character rows displayed) "
    "and VDU 23,0,1,80,0,0,0,0,0,0 (80 characters per row, undoing "
    "blank_display)."))
master.byte(0x079E, 1)
master.byte(0x079F, 10, cols=10)
master.byte(0x07A9, 10, cols=10)
master.banner(0x07B3, "Unused", "Leftover bytes, all zero.")
master.byte(0x07B3, 13, cols=13)
for addr, text in [(0x079E, "VDU 6: enable VDU output"),
                   (0x079F, "VDU 23,0,6,25: 6845 register 6 = 25 character rows displayed"),
                   (0x07A9, "VDU 23,0,1,80: 6845 register 1 = 80 characters per row")]:
    master.c(addr, text)
master.label(0x07B3, "coder_leftovers")
master.expr(0x0774, sym("coder_leftovers") - sym("coder_display_vdu"))
comments(master, [
    (0x07C0, "COLOUR 2..."),
    (0x07C2, "..."), (0x07C5, "..."), (0x07C7, "..."),
    (0x07CA, "...and start a new game"),
])
master.byte(0x07CD, 3, cols=3)
master.sub(0x07D0, "set_bell", "Set the bell sound",
           "OSBYTEs &D3-&D6: the BEL character's sound on channel &13, "
           "envelope 0 (fixed amplitude), pitch &64, duration 1. The "
           "cassette game's start-up sets the same sound on channel &11.",
            on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
comments(master, [
    (0x07D0, "OSBYTE &D3: bell channel..."),
    (0x07D2, "...&13"), (0x07D4, "..."), (0x07D6, "..."),
    (0x07D9, "OSBYTE &D4: bell envelope..."),
    (0x07DB, "...0, a fixed amplitude"), (0x07DD, "..."), (0x07DF, "..."),
    (0x07E2, "OSBYTE &D5: bell pitch..."),
    (0x07E4, "...&64"), (0x07E6, "..."), (0x07E8, "..."),
    (0x07EB, "OSBYTE &D6: bell duration..."),
    (0x07ED, "...1"), (0x07EF, "..."), (0x07F1, "..."),
    (0x07F4, "Return"),
])
master.banner(0x07F5, "Leftover filename",
              "The end of \"Dunjunz1\", the name the cassette lineage's "
              "&0400 images hold at &07F0, part overwritten by set_bell.")
master.string(0x07F5, 3)
master.byte(0x07F8, 7, cols=7)

# ---------------------------------------------------------------------------
# Changes inside the game.

master.block(0x0900, "On this side start_music overwrites the first three bytes "
                     "with JMP &D800, so from the first level on every sprite is "
                     "plotted by the identical copy in Code3, plot_sprite_hazel. "
                     "The menu, before start_music first runs, uses this one.")
master.block(0xD800, "Code3's copy of plot_sprite, reached by the JMP &D800 that "
                     "start_music writes at &0900. It differs from the original "
                     "only in its JSR to screen_address_hazel.")
for addr, suffix in [(0x0967, ""), (0xD867, "_hazel")]:
    master.sub(addr, "screen_address" + suffix, "Calculate a screen address",
               "Set screen_ptr to the screen address of byte column plot_x on "
               "pixel row plot_y: &3000 + 640 x (plot_y DIV 8) + (plot_y MOD "
               "8) + 8 x plot_x. The multiplication by 640 uses row_offsets "
               "in Table, this side's copy of the MOS 1.20 table, in private "
               "RAM.",
               on_entry={"plot_x": "screen byte column (0-79)", "plot_y": "pixel row"},
               on_exit={"screen_ptr": "screen address", "A": "corrupted",
                        "Y": "corrupted", "X": "preserved"})
    master.c(addr, "Character row = plot_y DIV 8...")
master.c(0x096E, "High byte of row x 640, from Table's copy of the MOS 1.20 "
                 "table in private RAM...")
master.c(0x0976, "Low byte of row x 640")
master.c(0xD86E, "High byte of row x 640, from Table's copy of the MOS 1.20 "
                 "table...")
master.c(0xD876, "Low byte of row x 640")
master.banner(0xD8A0, "Copied data",
              "The rest of the copy of the game's &0900-&09FE: the bytes "
              "that follow screen_address there, including the exit "
              "workspace's initial values. Not used here.")
master.byte(0xD8A0, 0x5F, cols=8)

master.c(0x0481, "No match: call &D9CD, the MOS 1.20 reset entry; on a Master "
                 "it is private RAM that no file of this side fills")

master.c(0x0E86, "All dead: stop the music and start VDU 28,0,24,16,0, a text "
                 "window on the left...")
master.c(0x0E89, "Padding")
master.c(0x0E8A, "...")
master.c(0x0EC3, "Wait up to &1F4 centiseconds (5 s) for a key...")
master.c(0x0EC5, "...")

master.c(0x1ED7, "Check the pause key (the routine is in Table)")
master.banner(0x1EDA, "Unused",
              "The rest of the cassette game's f1 pause routine, never run "
              "since check_pause jumps to pause_check in Table.")
master.byte(0x1EDA, 0x1D, cols=8)

for addr in range(0x6F45, 0x6F4A):
    master.c(addr, "Padding where the cassette game sounds the bell (VDU 7)"
             if addr == 0x6F45 else "...")

master.c(0x7F8F, "Pass every character straight to MOS 3.20's OSWRCH (&E822)")
master.banner(0x7F92, "The game-font WRCHV handler, unused",
              "The rest of the cassette game's wrch_handler, which prints "
              "letters and digits in the game's own font. On this side "
              "WRCHV's entry at &7F8F jumps straight to the MOS, so none of "
              "this runs and text appears in the MOS font.")
master.entry(0x7F92)  # never run, but decoded: the Model B side's code
master.c(0x7F92, "Save X (the TXA before it is now the JMP's operand)...")
master.label(0xE0A4, "mos120_oswrch_default", group="mos_internals", description=(
    "MOS 1.20's default OSWRCH routine, where the unused handler would pass "
    "characters on; MOS 3.20's is elsewhere."))
master.label(0xD9CD, "mos120_reset_entry", group="mos_internals", description=(
    "The MOS 1.20 reset entry, which decrypt_level calls on a failed "
    "checksum. On a Master, with private RAM paged in, it is HAZEL."))
master.region(0x0287, "os_break_intercept", (0, 2), group="os_workspace",
             access="w", description=(
                 "MOS BREAK intercept: a JMP here is called during a reset. "
                 "*DUNJUNZ sets its address but leaves it disabled."))
for addr, name, text in [
    (0x08B0, "modelb_hero_score_ten_thousands", "the Model B side's per-hero ten-thousands digits"),
    (0x08B4, "modelb_hero_absent", "the Model B side's per-hero absent flags"),
    (0x08BC, "modelb_levels_started", "the Model B side's count of levels started"),
    (0x08BD, "modelb_level_digits", "the Model B side's ASCII level digits"),
]:
    declare = master.region if addr == 0x08BD else master.label
    window = {"window": (0, 1)} if addr == 0x08BD else {}
    declare(addr, name, group="loader", **window, description=(
        f"Where *DUNJUNZ sets up {text}, as the Model B loader does; this "
        "side's game does not read it."))
master.label(0xC400, "saved_page_0d", length=256, group="private_ram", description=(
    "The MOS's page &0D (the filing system's NMI code and workspace), "
    "saved here by Coder and copied back by load_level before each level "
    "is loaded."))
d.expr_label(0x0901, "plot_sprite+1")
d.expr_label(0x0902, "plot_sprite+2")
master.label(0xE822, "mos320_oswrch_default", group="mos_internals", description=(
    "MOS 3.20's default OSWRCH routine, WRCHV's initial value."))
master.label(0xEEB1, "mos320_osbyte_default", group="mos_internals", description=(
    "MOS 3.20's default OSBYTE routine, BYTEV's initial value."))

# ---------------------------------------------------------------------------
# Starting a level: the game stays resident, and the level is loaded
# through the filing system with the MOS's page &0D put back first.

master.sub(0x1400, "start_level", "Set up and draw a new level",
           "Stop the music (saving its place after the first level), count "
           "the level, put the MOS's page &0D back and load the level, "
           "unpack it, reset the workspace and monsters, clear the text "
           "area, show 25 rows, draw the view frames and views, and restart "
           "the music, from where it was after the first level.",
            on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
comments(master, [
    (0x1400, "First level?"),
    (0x1403, "..."), (0x1405, "..."),
    (0x1407, "No: keep the music's place on the stack: its step..."),
    (0x140A, "..."),
    (0x140B, "...transposition..."),
    (0x140E, "..."),
    (0x140F, "...section..."),
    (0x1412, "..."),
    (0x1413, "...and tune pointer (zero page &00-&01)"),
    (0x1415, "..."), (0x1416, "..."), (0x1418, "..."),
    (0x1419, "Stop the music"),
    (0x141C, "Clear the text area and count the level"),
    (0x141F, "Put page &0D back and load the level"),
    (0x1422, "Copy it into the game's tables"),
    (0x1425, "Reset page &0D for play"),
    (0x1428, "Reset the monsters and keys"),
    (0x142B, "Clear the text area"),
    (0x142E, "VDU 23,0,6,25,0,0,0,0,0,0: set 6845 register 6..."),
    (0x1430, "..."), (0x1433, "..."), (0x1435, "..."), (0x1438, "..."),
    (0x143A, "..."),
    (0x143D, "...to 25 character rows displayed"),
    (0x143F, "..."), (0x1442, "..."), (0x1444, "..."), (0x1447, "..."),
    (0x144A, "..."), (0x144D, "..."), (0x1450, "..."), (0x1453, "..."),
    (0x1456, "Point at view_frame_plots..."),
    (0x1458, "..."), (0x145A, "..."), (0x145C, "..."),
    (0x145E, "...and draw the frames and the views"),
    (0x1461, "Start the music"),
    (0x1464, "First level?"),
    (0x1467, "..."), (0x1469, "..."),
    (0x146B, "No: put the music's place back: tune pointer..."),
    (0x146C, "..."), (0x146E, "..."), (0x146F, "..."),
    (0x1471, "...section..."),
    (0x1472, "..."),
    (0x1475, "...transposition..."),
    (0x1476, "..."),
    (0x1479, "...and rhythm step"),
    (0x147A, "..."),
    (0x147D, "Mark the first level done"),
    (0x147F, "..."),
    (0x1482, "Return"),
])
master.label(0x1638, "first_level_flag", description=(
    "&7B once start_level has run; until then the &EA it is loaded with."))
master.byte(0x1638)
master.byte(0x1639)

master.sub(0x1483, "load_level", "Put the MOS's page &0D back and load the level",
           "Copy the MOS's page &0D back from &C400 (Coder saved it there), "
           "so that the filing system's NMI code and workspace are intact, "
           "write the level number's digits into level_command, show 15 "
           "rows while loading, and *LOAD LEVELnn 6B00 (level 25 comes from "
           "Stones, via load_stones in Table). Then decrypt and check it.",
            on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
comments(master, [
    (0x1483, "Copy &C400-&C4FF back to page &0D..."),
    (0x1485, "..."), (0x1488, "..."), (0x148B, "..."), (0x148C, "..."),
    (0x148E, "Level 10 or more (in BCD)?"),
    (0x1491, "..."), (0x1493, "..."),
    (0x1495, "No: units digit then a space"),
    (0x1497, "..."),
    (0x149A, "..."), (0x149D, "..."), (0x149F, "..."), (0x14A0, "..."),
    (0x14A2, "..."),
    (0x14A5, "...(always branches)"),
    (0x14A7, "Yes: tens digit..."),
    (0x14AA, "..."), (0x14AB, "..."), (0x14AC, "..."), (0x14AD, "..."),
    (0x14AE, "..."), (0x14AF, "..."), (0x14B1, "..."),
    (0x14B4, "...then units digit"),
    (0x14B7, "..."), (0x14B9, "..."), (0x14BA, "..."), (0x14BC, "..."),
    (0x14BF, "VDU 23,0,6,15,0,0,0,0,0,0: show 15 character rows while "
             "loading..."),
    (0x14C1, "..."), (0x14C4, "..."), (0x14C6, "..."), (0x14C9, "..."),
    (0x14CB, "..."), (0x14CE, "..."), (0x14D0, "..."), (0x14D3, "..."),
    (0x14D5, "..."), (0x14D8, "..."), (0x14DB, "..."), (0x14DE, "..."),
    (0x14E1, "..."), (0x14E4, "..."),
    (0x14E7, "Level 25?"),
    (0x14EA, "..."), (0x14EC, "..."),
    (0x14EE, "Yes: load it from Stones (and check it there)"),
    (0x14F1, "No: *LOAD LEVELnn 6B00"),
    (0x14F3, "..."), (0x14F5, "..."),
    (0x14F8, "Decrypt and check it, and return from there"),
])
master.label(0x14FB, "level_command", description=(
    "\"LOAD LEVELnn 6B00\", with the level's digits written at "
    "level_command+10."))
master.region(0x1505, "level_command_digits", (0, 1))
master.string(0x14FB, 17)
master.byte(0x150C)
master.sub(0x1612, "count_level", "Clear the text area and count the level",
           "The cassette game's show_level_number also plots LEVEL and the "
           "number; this side shows no level number.",
            on_exit={"A": "corrupted", "X": "preserved", "Y": "preserved"})
comments(master, [
    (0x1612, "Clear the text area"),
    (0x1615, "Count the level"),
    (0x1618, "Return"),
])

master.label(0x16D5, "level_filename_digits", description=(
    "Where level_loop writes the level number's digits, as the cassette "
    "game does for its filename. This side builds level_command instead, "
    "so these are not used."))

# ---------------------------------------------------------------------------
# Code, &C500: the joystick handler, in private RAM.

master.sub(0xC500, "joystick_bytev", "BYTEV handler: read a joystick for the Barbarian's keys",
           "Installed by Coder2. Answers OSBYTE &81 scans of the third "
           "hero's keys from the analogue port: N (&AA) and M (&9A) from "
           "channel 1 at its extremes, B (&9B) and G (&AC) from channel 2, "
           "and fire (SPACE, &9D) from the fire buttons. Every other call "
           "goes to the MOS 3.20 OSBYTE routine at &EEB1 directly. It is the "
           "Model B side's handler with this side's keys and MOS.",
           on_entry={"A": "OSBYTE number", "X": "OSBYTE X"},
           on_exit={"X": "&FF if the key is pressed, 0 if not"})
comments(master, [
    (0xC500, "OSBYTE &81 (INKEY)?"),
    (0xC502, "No: pass it on"),
    (0xC504, "N (left)?"), (0xC506, "..."),
    (0xC508, "B (down)?"), (0xC50A, "..."),
    (0xC50C, "G (up)?"), (0xC50E, "..."),
    (0xC510, "M (right)?"), (0xC512, "..."),
    (0xC514, "SPACE (fire)?"), (0xC516, "..."),
    (0xC518, "Another key: pass it on"),
    (0xC51B, "N: channel 1 high byte &FF?"),
    (0xC51D, "..."), (0xC520, "..."), (0xC522, "..."),
    (0xC524, "No: not pressed"),
    (0xC526, "Yes: pressed"), (0xC528, "Return"),
    (0xC529, "M: channel 1 high byte 0?"),
    (0xC52B, "..."), (0xC52E, "..."), (0xC530, "..."),
    (0xC532, "No: not pressed"),
    (0xC534, "Yes: pressed (Y = &FF)"), (0xC535, "..."), (0xC537, "Return"),
    (0xC538, "G: channel 2 high byte &FF?"),
    (0xC53A, "..."), (0xC53D, "..."), (0xC53F, "..."),
    (0xC541, "No: not pressed"),
    (0xC543, "Yes: pressed"), (0xC545, "Return"),
    (0xC546, "B: channel 2 high byte 0?"),
    (0xC548, "..."), (0xC54B, "..."), (0xC54D, "..."),
    (0xC54F, "No: not pressed"),
    (0xC551, "Yes: pressed (Y = &FF)"), (0xC552, "..."), (0xC554, "Return"),
    (0xC555, "Fire: either fire button?"),
    (0xC557, "..."), (0xC559, "..."), (0xC55C, "..."), (0xC55D, "..."),
    (0xC55F, "No: not pressed"),
    (0xC561, "Yes: pressed"), (0xC563, "..."), (0xC565, "Return"),
    (0xC566, "Not pressed"), (0xC568, "Return"),
    (0xC569, "Pass the call on to the MOS 3.20 OSBYTE routine"),
])

# ---------------------------------------------------------------------------
# Table, &C5A0: level 25, game over, the row offsets and the pause key.

master.sub(0xC5A0, "load_stones", "Load level 25 from Stones",
           "Level 25 has no file of its own: Stones ends with its data, so "
           "*LOAD STONES 6680 puts it at &6B00. Then decrypt and check it.",
            on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
comments(master, [
    (0xC5A0, "*LOAD STONES 6680"),
    (0xC5A2, "..."), (0xC5A4, "..."),
    (0xC5A7, "Decrypt and check it, and return from there"),
])
master.label(0xC5AA, "stones_command")
master.string(0xC5AA, 16)
master.byte(0xC5BA, 0x46, cols=8)
master.sub(0xC600, "game_over_music", "Stop the music for the game-over message",
           "Stop the music, send the VDU 28 that the game-over code's text "
           "window begins with, and set the top row in clear_text_area's "
           "window to 0.",
            on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
comments(master, [
    (0xC600, "Stop the music"),
    (0xC603, "VDU 28: the game-over text window..."),
    (0xC605, "..."),
    (0xC608, "Top row 0 in clear_text_area's window"),
    (0xC60A, "..."),
    (0xC60D, "Return"),
])
master.label(0x162E, "clear_text_area_top", description=(
    "The top-row operand of clear_text_area's VDU 28."))
master.banner(0xC60E, "Unused",
              "Leftover bytes: the end of a routine that selects COLOUR 2 "
              "and runs *DUNJUNZ (its command follows), and zeros.")
master.byte(0xC60E, 14, cols=7)
master.string(0xC61C, 7)
master.byte(0xC623, 0x52, cols=8)
master.label(0xC675, "row_offsets", length=50, group="game_data", description=(
    "Screen row offsets, row x 640, as high/low byte pairs for the 25 "
    "character rows: a copy of the MOS 1.20 table at &C375, which MOS 3.20 "
    "does not have."))
master.label(0xC676, "row_offsets_lo")
master.banner(0xC675, "Screen row offsets",
              "Row x 640 for character rows 0-24, high byte first: the table "
              "screen_address and the title's star plotter read here instead "
              "of in MOS 1.20.")
master.byte(0xC675, 50, cols=10)
master.byte(0xC6A7, 0x19, cols=8)
master.sub(0xC6C0, "show_free_space", "*FREE",
           "Show the disc's free space. The game never calls it: [*EDITOR](address:23F7@/editor) "
           "does, after cataloguing the disc, relying on Table being in "
           "private RAM.",
            on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
comments(master, [
    (0xC6C0, "*FREE..."),
    (0xC6C2, "..."), (0xC6C4, "..."),
    (0xC6C7, "Return"),
])
master.label(0xC6C8, "free_command")
master.string(0xC6C8, 4)
master.byte(0xC6CC)
master.byte(0xC6CD, 3, cols=3)
d.expr(0xC6C1, lo(sym("free_command")))
d.expr(0xC6C3, hi(sym("free_command")))

master.label(0x1ED7, "check_pause")
master.sub(0xC6D0, "pause_check", "Pause while P is pressed",
           "Called from check_pause in the game's update. If P (internal "
           "key &37) is held, wait for it to be released, pressed again and "
           "released, then restart the frame timing. The Model B side uses "
           "the same key.",
            on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
comments(master, [
    (0xC6D0, "OSBYTE &7A: which key is pressed?"),
    (0xC6D2, "..."),
    (0xC6D5, "P?"),
    (0xC6D7, "No: return"),
    (0xC6D9, "Paused: wait for P to be released..."),
    (0xC6DC, "...pressed again..."),
    (0xC6DE, "..."), (0xC6E1, "..."), (0xC6E3, "..."),
    (0xC6E5, "...and released"),
    (0xC6E8, "Restart the frame timing"),
    (0xC6EA, "..."),
    (0xC6ED, "Return"),
])
master.sub(0xC6EE, "wait_p_released", "Wait until P is not pressed",
           "Scan the keyboard with OSBYTE &7A until the key found is no "
           "longer P (internal key &37).",
            on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
comments(master, [
    (0xC6EE, "OSBYTE &7A: which key is pressed?"),
    (0xC6F0, "..."),
    (0xC6F3, "Still P?"),
    (0xC6F5, "Yes: keep waiting"),
    (0xC6F7, "Return"),
])

# ---------------------------------------------------------------------------
# Code2, &C700: the music.

master.sub(0xC700, "start_music", "Start the music",
           "Define envelopes 6-9, redirect the game's plot_sprite to the "
           "copy in Code3, point the tune at its first section, and play it "
           "on the interval timer: EVNTV is pointed at music_event and the "
           "interval timer event enabled. Then play the first step.",
            on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
comments(master, [
    (0xC700, "ENVELOPE 6..."),
    (0xC702, "..."), (0xC704, "..."), (0xC706, "..."),
    (0xC709, "ENVELOPE 7..."),
    (0xC70B, "..."), (0xC70D, "..."), (0xC70F, "..."),
    (0xC712, "ENVELOPE 8..."),
    (0xC714, "..."), (0xC716, "..."), (0xC718, "..."),
    (0xC71B, "ENVELOPE 9"),
    (0xC71D, "..."), (0xC71F, "..."), (0xC721, "..."),
    (0xC724, "Make plot_sprite JMP &D800, the copy in Code3..."),
    (0xC726, "..."), (0xC729, "..."), (0xC72B, "..."), (0xC72E, "..."),
    (0xC730, "..."),
    (0xC733, "Tune pointer (zero page &00-&01) = the first section..."),
    (0xC735, "..."), (0xC737, "..."), (0xC739, "..."),
    (0xC73B, "Section 0"),
    (0xC73D, "..."),
    (0xC740, "Rhythm step -1, so the first step plays step 0"),
    (0xC742, "..."),
    (0xC745, "No transposition"),
    (0xC747, "..."),
    (0xC74A, "EVNTV = music_event..."),
    (0xC74C, "..."), (0xC74F, "..."), (0xC751, "..."),
    (0xC754, "OSBYTE 14, 5: enable the interval timer event"),
    (0xC756, "..."), (0xC758, "..."), (0xC75A, "..."),
    (0xC75D, "Play the first step, and return from there"),
])
master.sub(0xC760, "stop_music", "Stop the music",
           "OSBYTE 13, 5: disable the interval timer event.",
            on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
comments(master, [
    (0xC760, "OSBYTE 13, 5: disable the interval timer event"),
    (0xC762, "..."), (0xC764, "..."), (0xC766, "..."),
])
master.label(0xC769, "music_rhythm_step", description=(
    "Step in the 32-step rhythm pattern, 0-31."))
master.label(0xC76A, "music_transpose", description=(
    "Added to the rhythm pattern's pitches; set by a tune step's first "
    "byte when non-zero."))
master.label(0xC76B, "music_section", description=(
    "The section of the tune playing, 1-24 (0 for the first)."))
master.byte(0xC769)
master.byte(0xC76A)
master.byte(0xC76B)
master.region(0x0000, "tune_ptr", (0, 1), group="zero_page", description=(
    "The music's place in the tune: the current three-byte step."))

master.sub(0xC76C, "music_event", "Event handler: play one step of the music",
           "Called through EVNTV for the interval timer event, which "
           "start_music sets to recur every 12 centiseconds. A tune step is "
           "three bytes: a transposition for the rhythm (0 for no change) "
           "or &FF to end the section, a pitch for channel 2 and a pitch "
           "for channel 3 (0 for silence). Each step also plays the next of "
           "the 32 steps of rhythm_pattern on channel 1 and the noise "
           "channel. At the end of a section the next byte sets channel 3's "
           "envelope and the next section starts; after section 24 the tune "
           "goes back to section 1. The interval timer is then reset.",
           on_exit={"A": "preserved", "X": "preserved", "Y": "preserved"})
comments(master, [
    (0xC76C, "Save the flags and registers"),
    (0xC76D, "..."), (0xC76E, "..."), (0xC76F, "..."), (0xC770, "..."),
    (0xC771, "..."),
    (0xC772, "First byte of the step..."),
    (0xC774, "..."),
    (0xC776, "...&FF?"),
    (0xC778, "Yes: end of the section"),
    (0xC77A, "Non-zero: a new transposition"),
    (0xC77C, "..."), (0xC77E, "..."),
    (0xC781, "Second byte: channel 2's pitch..."),
    (0xC783, "..."),
    (0xC785, "...0 for none"),
    (0xC787, "..."),
    (0xC78A, "SOUND channel_2_sound..."),
    (0xC78C, "..."), (0xC78E, "..."), (0xC790, "..."),
    (0xC793, "Third byte: channel 3's pitch..."),
    (0xC795, "..."),
    (0xC797, "...0 for none"),
    (0xC799, "..."),
    (0xC79C, "SOUND channel_3_sound..."),
    (0xC79E, "..."), (0xC7A0, "..."), (0xC7A2, "..."),
    (0xC7A5, "Next step: tune_ptr += 3..."),
    (0xC7A7, "..."), (0xC7A8, "..."), (0xC7AA, "..."), (0xC7AC, "..."),
    (0xC7AE, "..."), (0xC7B0, "..."),
    (0xC7B2, "Next rhythm step, 0-31..."),
    (0xC7B5, "..."), (0xC7B6, "..."), (0xC7B8, "..."), (0xC7BA, "..."),
    (0xC7BC, "..."), (0xC7BE, "..."),
    (0xC7C1, "Its pitch, 0 for a rest..."),
    (0xC7C2, "..."), (0xC7C5, "..."),
    (0xC7C7, "...transposed..."),
    (0xC7C8, "..."), (0xC7CB, "..."),
    (0xC7CE, "...on channel 1..."),
    (0xC7D0, "..."), (0xC7D2, "..."), (0xC7D4, "..."),
    (0xC7D7, "...with the noise channel"),
    (0xC7D9, "..."), (0xC7DB, "..."), (0xC7DD, "..."),
    (0xC7E0, "OSWORD 4: interval timer = -12 centiseconds, for the next step"),
    (0xC7E2, "..."), (0xC7E4, "..."), (0xC7E6, "..."),
    (0xC7E9, "Restore the registers and flags"),
    (0xC7EA, "..."), (0xC7EB, "..."), (0xC7EC, "..."), (0xC7ED, "..."),
    (0xC7EE, "..."),
    (0xC7EF, "Return"),
    (0xC7F0, "End of section: the next byte is channel 3's envelope"),
    (0xC7F2, "..."), (0xC7F4, "..."),
    (0xC7F7, "Next section..."),
    (0xC7FA, "..."), (0xC7FD, "..."),
    (0xC7FF, "...past 24?"),
    (0xC801, "Yes: back to section 1, with the rhythm restarting"),
    (0xC803, "..."), (0xC806, "..."), (0xC808, "..."),
    (0xC80B, "Point tune_ptr at the section..."),
    (0xC80C, "..."), (0xC80F, "..."), (0xC811, "..."), (0xC814, "..."),
    (0xC816, "...and play its first step"),
    (0xC818, "..."), (0xC81A, "..."),
])
for addr, name, text in [
    (0xC81D, "channel_1_sound", "SOUND &11, -9 (envelope 9), pitch, 1: the rhythm"),
    (0xC825, "noise_sound", "SOUND &10, envelope 7, 3, 3: noise with the rhythm"),
    (0xC82D, "channel_2_sound", "SOUND &12, envelope 8, pitch, 10"),
    (0xC835, "channel_3_sound", "SOUND &13, envelope (set per section), pitch, 8"),
]:
    master.region(addr, name, (0, 7), description=f"OSWORD 7 block: {text}.")
    master.byte(addr, 8, cols=8)
master.label(0xC83D, "section_ptrs_lo", length=25, description=(
    "Low bytes of the tune's sections, 0-24."))
master.byte(0xC83D, 25, cols=13)
master.label(0xC856, "section_ptrs_hi", length=25, description=(
    "High bytes of the tune's sections, 0-24."))
master.byte(0xC856, 25, cols=13)
for addr, n in [(0xC86F, 6), (0xC87D, 7), (0xC88B, 8), (0xC899, 9)]:
    master.label(addr, f"envelope_{n}", length=14,
                 description=f"OSWORD 8 block: ENVELOPE {n}.")
    master.byte(addr, 14, cols=14)
master.label(0xC8A7, "music_interval", length=5, description=(
    "OSWORD 4 block: the interval timer value, -12 centiseconds."))
master.byte(0xC8A7, 5, cols=5)
master.label(0xC8AC, "rhythm_pattern", length=32, description=(
    "The 32-step rhythm: a pitch for channel 1 for each step, or 0 for a "
    "rest."))
master.byte(0xC8AC, 32, cols=16)
master.byte(0xC8CC, 1)
master.label(0xC8CD, "tune", description=(
    "The tune, in sections of three-byte steps, each ended by &FF and an "
    "envelope number for channel 3."))
master.banner(0xC8CC, "The tune",
              "The music's data: sections of three-byte steps (transposition "
              "or &FF, channel 2 pitch, channel 3 pitch), reached through "
              "section_ptrs_lo and section_ptrs_hi.")
master.byte(0xC8CD, 0xD75A - 0xC8CD, cols=12)

# ---------------------------------------------------------------------------
# Branch targets in the Master's own code.

for addr, name in [
    (0x0745, "save_page_0d_byte"), (0x076C, "send_coder_vdu"),
    (0x07C0, "select_colour_2"), (0x1419, "stop_music_and_load"),
    (0x147D, "mark_first_level_done"), (0x1485, "restore_page_0d_byte"),
    (0x14A7, "level_command_two_digits"), (0x14BF, "shrink_display_for_loading"),
    (0x14F1, "load_level_file"), (0x162D, "set_text_window_top"),
    (0xC51B, "joystick_left"), (0xC529, "joystick_right"),
    (0xC538, "joystick_up"), (0xC546, "joystick_down"),
    (0xC555, "joystick_fire"), (0xC566, "joystick_not_pressed"),
    (0xC569, "joystick_pass_on"), (0xC6DC, "wait_p_pressed"),
    (0xC6ED, "not_paused"), (0xC77A, "play_step"), (0xC781, "play_channel_2"),
    (0xC793, "play_channel_3"), (0xC7A5, "next_step"),
    (0xC7BE, "store_rhythm_step"), (0xC7E0, "set_step_timer"),
    (0xC7F0, "end_of_section"), (0xC80B, "start_section"),
]:
    master.label(addr, name)
master.label(0x7F92, "unused_font_handler")
for operand_addr in (0xC505, 0xC509, 0xC50D, 0xC511, 0xC515):
    master.inkey_number(operand_addr)

# Addresses passed as immediate halves.
for lo_addr, hi_addr, name in [
    (0x074F, 0x0751, "load_dunj2_command"), (0x0756, 0x0758, "load_dunj3_command"),
    (0x075D, 0x075F, "load_dunj4_command"), (0x0764, 0x0766, "load_dunj5_command"),
    (0x1457, 0x145B, "view_frame_plots"), (0x14F2, 0x14F4, "level_command"),
    (0xC5A1, 0xC5A3, "stones_command"), (0xC72A, 0xC72F, "plot_sprite_hazel"),
    (0xC734, 0xC738, "tune"), (0xC74B, 0xC750, "music_event"),
]:
    master.expr(lo_addr, lo(sym(name)))
    master.expr(hi_addr, hi(sym(name)))

ir = d.disassemble()
asm_filepath.parent.mkdir(parents=True, exist_ok=True)
asm_filepath.write_text(str(ir.render("beebasm")), encoding="utf-8")
json_filepath.write_text(str(ir.render("json")), encoding="utf-8")
