"""dasmos driver for the game on the Master 128 side of the official
Dunjunz disc.

The nine files are disassembled together, each saved as its own file.
Routines that this side has byte for byte as in the cassette-derived
game, but at other addresses, get the shared annotations through an
address shift (`apply_shifted`).

## The files

| File | Range | Contents |
|---|---|---|
| `Coder` | &0400-&07FE | The game's &0400-&07FF, with `coder_start` at &0740 (its exec address) |
| `Dunj3` | &08C0-&0CFE | Sprite plotting, per-hero tables and scores, `room_walls` |
| `Dunj4` | &0E00-&1FFF | `new_game` and `level_loop`, the status panel, the victory sequence, `start_level` and `load_level`, sprites, `update_game`, `play_level` |
| `Dunj5` | &2000-&2FFF | The exit animation, doors and keys, sprites |
| `Dunj2` | &6E80-&7FFF | Heroes, missiles, objects, monsters, `workspace_template`, the WRCHV handler |
| `Code` | &C500-&C56B | `joystick_bytev`, the BYTEV handler (HAZEL) |
| `Table` | &C5A0-&C6F7 | `load_stones`, `game_over_music`, `row_offsets`, `pause_check` (HAZEL) |
| `Code2` | &C700-&D759 | The music: `start_music`, `stop_music`, `music_event` and the tune (HAZEL) |
| `Code3` | &D800-&D8FE | `plot_sprite_hazel`, the copy of the sprite plotter (HAZEL) |

## Memory map in play

| Range | Contents |
|---|---|
| &0000-&0001 | `tune_ptr`, the music's place in the tune |
| &0070-&008F | The game's zero page |
| &0287 | The MOS BREAK intercept, left disabled |
| &0400-&2FFF | `Coder`, `Dunj3`, page &0D (the game's per-level workspace, loaded by no file), `Dunj4`, `Dunj5` |
| &3000-&6E7F | Screen (25 character rows in play) |
| &6B00-&6DAF | The level file, in the screen's bottom rows |
| &6E80-&7FFF | `Dunj2` |
| &C400-&C4FF | `saved_page_0d`, the MOS's page &0D (HAZEL) |
| &C500-&D8FE | `Code`, `Table`, `Code2`, `Code3` (HAZEL) |

MOS 3.20 starts *RUN programs with HAZEL, the Master's private RAM at
&C000-&DFFF, paged in (ACCCON bit 3 set), and the game never changes
ACCCON, so its reads and calls of &C000-&DFFF reach these files rather
than the MOS ROM.

## From power-on to play

1. `!BOOT` chains `BOOT`, which on a Master shows `README` and runs
   `*DUNJUNZ` (its own listing). That loads `Code2`, `Code3` and `Table`
   into HAZEL, shows the title screen, and runs `CODER2` (its own
   listing), which loads `Code` and points BYTEV at `joystick_bytev`, if
   ADC channel 1 reads as a joystick at rest, or else `CODER`.
2. `coder_start` (&0740) calls `set_bell`, copies the MOS's page &0D to
   `saved_page_0d`, `*LOAD`s `Dunj2`-`Dunj5`, shows the display again,
   selects COLOUR 2 and jumps to `new_game` at &0E00.
3. `new_game` zeroes `level_number` and `level_bcd`, gives each hero
   their starting attributes (`reset_hero`) and runs `hero_menu`.
   `README` tells the players to turn the disc over then: only level 1 is
   on this side, and the levels are loaded from the Model B side.
4. `level_loop` sets `monster_start_hit_points` and counts the level in
   `level_bcd`, then calls `start_level`, which runs steps 5 to 9.
5. After the first level, the music's place is kept on the stack, and
   `stop_music` silences it.
6. `count_level` clears the screen and counts `level_number`.
7. `load_level` copies `saved_page_0d` back to page &0D for the disc
   filing system, writes the digits into `level_command`, shows 15 rows,
   and `*LOAD`s `LEVELnn` to &6B00, or for level 25 `Stones` through
   `load_stones`; `decrypt_level` decrypts and checks it.
8. `unpack_level`, `reset_workspace` (which gives page &0D back to the
   game) and `reset_monsters` set up play; the screen is cleared and set
   to 25 rows, and `draw_view_frames` draws the frames and the four views
   and points WRCHV at the game's handler, which passes text to the MOS.
9. `start_music` starts the tune, which then resumes from its kept place
   after the first level.
10. `draw_status_panel` and `remove_absent_heroes` finish the screen, and
   `play_level` runs the level until no hero is left in play, with the
   music playing on the interval timer event and `pause_check` last in
   each frame's update.
11. Every dead hero gets their starting attributes back. If any hero
   survived, `level_loop` starts the next level, with the game resident;
   if all four died, `game_over_music` stops the music, the game-over
   message is shown for up to 5 seconds or until a key, and `new_game`
   starts again. A hero reaching the Chalice on level 25 is caught by
   `check_for_victory`, which plays `victory_sequence`, prints the ending
   message, waits for a key and resets the machine through the RESET
   vector.
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
d.set_file_header(
    title="Dunjunz, official disc (Master 128 side): the game",
    description=("Annotated disassembly of the game's nine files: `Coder`, "
                 "`Dunj2`-`Dunj5`, and `Code`, `Table`, `Code2` and `Code3` "
                 "in private RAM.\n\n" + __doc__.split("\n\n", 2)[2]),
)


# Runtime addresses where the Master game's code differs from the
# cassette-derived game the shared annotations describe. The shared
# annotations skip them, and this driver annotates them itself.
DIFFERENT_RANGES = [
    (0x0481, 0x0484),  # the failed-checksum call: not a reset on a Master
    (0x0700, 0x0800),  # Coder's leftovers and the loader at &0740
    (0x0967, 0x0968),  # screen_address: its banner names the MOS 1.20 table
    (0x096E, 0x0970),  # row offsets read from Table, not the MOS
    (0x0976, 0x0978),
    (0x0E02, 0x0E03),  # new game: level_number is counted by count_level
    (0x0E86, 0x0E8B),  # game over: stop the music
    (0x0EC3, 0x0EC7),  # a shorter wait after game over
    (0x12D3, 0x12D5),  # saved_wrchv: this side never saves WRCHV
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
for addr, text in [(0x0E32, "...(always branches)"), (0x0E49, "...shifting the tens digit..."),
                   (0x0E4A, "...down four bits..."), (0x0E4B, "...to the low nibble")]:
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
           "Called by start_level once per level, after the screen has been "
           "cleared and set to 25 rows. Send the twenty PLOT commands of "
           "view_frame_plots (five per view: a move and four lines), draw "
           "the room in each hero's view with draw_all_views, then point "
           "WRCHV at wrch_handler (&7F8F), which passes every character "
           "straight to the MOS. Until the first level is drawn, WRCHV is "
           "the MOS's own, so the hero menu prints through it directly.",
           on_entry={"plot_x": "address of view_frame_plots, low byte",
                     "plot_y": "address of view_frame_plots, high byte"})
master.c(0x1566, "Point WRCHV at &7F8F...")
master.c(0x1568, "...the handler's low byte into WRCHV...")
master.c(0x156B, "...and its page, &7F...")
master.c(0x156D, "...the WRCHV entry again, for text")
master.c(0x1570, "Return to start_level, which starts the music")

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
              "(label+2:LDA#255:.label JSR&30).")
master.string(0x0700, 22)
master.byte(0x0716)
master.c(0x0716, "CR: the end of that line")
master.string(0x0717, 4)
master.byte(0x071B, 7, cols=7)
master.c(0x071B, "Ends of shorter lines")
master.string(0x0722, 30)

master.sub(0x0740, "coder_start", "Coder: save the MOS's page &0D, load the game and start it",
           "Load the rest of the game and start a new game. Run once per "
           "session, as *RUN CODER by *DUNJUNZ or by Coder2 (which first "
           "installs the joystick handler); the game then stays resident "
           "and loads each level itself, and never comes back here.\n\n"
           "Set the bell sound (set_bell). Copy page &0D, which holds the "
           "disc filing system's NMI code and workspace, to saved_page_0d "
           "at &C400 in private RAM: the game's per-level workspace lives "
           "in page &0D, so load_level puts the saved copy back before "
           "each level is loaded. The copy is made before any file is "
           "loaded, while the page still holds the filing system's own "
           "contents. Then *LOAD Dunj2, Dunj3, Dunj4 and Dunj5 at their "
           "own load addresses, send coder_display_vdu to show the "
           "display that *DUNJUNZ blanked (25 rows of 80 characters), and "
           "continue at select_colour_2, past the leftovers, to select "
           "COLOUR 2 and jump to new_game at &0E00.",
           on_entry={"ACCCON": "HAZEL paged in, as MOS 3.20 leaves it"})
master.block(0x0743, "Keep the filing system's page &0D in private RAM, for "
                     "load_level to put back before each level's *LOAD.")
master.block(0x074E, "Load the rest of the game, each file at its own load "
                     "address.")
master.block(0x076A, "Show the display again and go on to start the game.")
comments(master, [
    (0x0740, "BEL's sound, used by the game's VDU 7s"),
    (0x0743, "Save the MOS's page &0D..."),
    (0x0745, "...each byte the filing system uses..."),
    (0x0748, "...to &C400 in private RAM, for load_level"),
    (0x074B, "...next byte (X wraps from 0)"), (0x074C, "Until all 256 are saved"),
    (0x074E, "*L. DUNJ2: heroes, monsters, views (&6E80-&7FFF)"),
    (0x0750, "...high byte of the command"), (0x0752, "...loaded at &6E80"),
    (0x0755, "*L. DUNJ3: hero attributes, room_walls (&08C0-&0CFE)"),
    (0x0757, "...high byte of the command"), (0x0759, "...loaded at &08C0"),
    (0x075C, "*L. DUNJ4: level loop to frame update (&0E00-&1FFF)"),
    (0x075E, "...high byte of the command"), (0x0760, "...loaded at &0E00"),
    (0x0763, "*L. DUNJ5: object_free_map, sprites (&2000-&2FFF)"),
    (0x0765, "...high byte of the command"), (0x0767, "...loaded at &2000"),
    (0x076A, "Show the display again: coder_display_vdu's 21 bytes"),
    (0x076C, "...the next VDU byte..."), (0x076F, "...to the VDU"), (0x0772, "...on to the next"), (0x0773, "...until all of coder_display_vdu is sent"),
    (0x0775, "More to send"),
    (0x0777, "Over the leftovers to colour 2 and a new game"),
])
for addr in (0x077A, 0x0783, 0x078C, 0x0795):
    master.stringcr(addr)
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
master.banner(0x07C0, "Select COLOUR 2 and start a new game",
              "The end of coder_start, reached by its JMP over the "
              "leftovers: the game's messages print in colour 2.")
comments(master, [
    (0x07C0, "COLOUR 2: VDU 17, then the colour..."),
    (0x07C2, "...send VDU 17, set the text colour..."), (0x07C5, "...text colour 2..."),
    (0x07C7, "...for the game's messages"),
    (0x07CA, "...and start a new game: the hero menu, then level 1"),
])
master.byte(0x07CD, 3, cols=3)
master.sub(0x07D0, "set_bell", "Set the bell sound",
           "Called once, first thing in coder_start. OSBYTEs &D3-&D6 set "
           "the sound the BEL character (VDU 7) makes: channel &13 "
           "(channel 3), envelope 0 (a fixed amplitude), pitch &64 and "
           "duration 1, a twentieth of a second.",
            on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
comments(master, [
    (0x07D0, "OSBYTE &D3: bell channel..."),
    (0x07D2, "...&13: channel 3 in its low bits"), (0x07D4, "...Y = 0: X replaces the old setting"),
    (0x07D6, "...the bell's sound channel"),
    (0x07D9, "OSBYTE &D4: bell envelope..."),
    (0x07DB, "...0, a fixed amplitude"), (0x07DD, "...Y = 0: X replaces the old setting"), (0x07DF, "...the bell's envelope"),
    (0x07E2, "OSBYTE &D5: bell pitch..."),
    (0x07E4, "...&64, the pitch the bell plays at"), (0x07E6, "...Y = 0: X replaces the old setting"),
    (0x07E8, "...the bell's pitch"),
    (0x07EB, "OSBYTE &D6: bell duration..."),
    (0x07ED, "...1, a twentieth of a second"), (0x07EF, "...Y = 0: X replaces the old setting"),
    (0x07F1, "...the bell's duration"),
    (0x07F4, "Return to coder_start with the bell set"),
])
master.banner(0x07F5, "Leftover filename",
              "The end of the filename \"Dunjunz1\", whose start set_bell "
              "overwrites.")
master.string(0x07F5, 3)
master.byte(0x07F8, 7, cols=7)

# ---------------------------------------------------------------------------
# Changes inside the game.

master.block(0x0900, "start_music overwrites the first three bytes "
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
               "in Table, a copy of the MOS 1.20 table, in private RAM.",
               on_entry={"plot_x": "screen byte column (0-79)", "plot_y": "pixel row"},
               on_exit={"screen_ptr": "screen address", "A": "corrupted",
                        "Y": "corrupted", "X": "preserved"})
    master.c(addr, "Character row = plot_y DIV 8...")
master.c(0x096E, "High byte of row x 640, from Table's copy in HAZEL...")
master.c(0x0976, "Low byte of row x 640")
master.c(0xD86E, "High byte of row x 640, from Table's copy...")
master.c(0xD876, "Low byte of row x 640")
master.banner(0xD8A0, "Copied data",
              "The rest of the copy of the game's &0900-&09FE: the bytes "
              "that follow screen_address there, including the exit "
              "workspace's initial values. Not used here.")
master.byte(0xD8A0, 0x5F, cols=8)
master.c(0xD8A0, "Not used")

master.c(0x0481, "No match: call &D9CD, private RAM that no file fills")
master.c(0x0E02, "...level_number 0, counted up by count_level...")

master.c(0x0E86, "All dead: stop the music; VDU 28,0,24,16,0 on the left...")
master.c(0x0E89, "Padding where the VDU 28 was sent: does nothing")
master.c(0x0E8A, "...a second padding byte")
master.c(0x0EC3, "Game over: wait up to &1F4 cs (5 s) for a key...")
master.c(0x0EC5, "...Y = &01: the time limit's high byte")

master.c(0x1ED7, "Check the pause key (the routine is in Table)")
master.banner(0x1EDA, "Unused",
              "The rest of an f1 pause routine, never run since check_pause "
              "jumps to pause_check in Table.")
master.byte(0x1EDA, 0x1D, cols=8)

for addr in range(0x6F45, 0x6F4A):
    master.c(addr, "Padding: no bell when a missile is fired"
             if addr == 0x6F45 else "Padding: does nothing")

master.sub(0x7F8F, "wrch_handler", "WRCHV handler: pass every character to the MOS",
           "The game points WRCHV here; it jumps straight to MOS 3.20's OSWRCH, "
           "so text appears in the MOS font.",
           on_entry={"A": "the character"}, on_exit={"A": "preserved"})
master.c(0x7F8F, "Pass every character straight to MOS 3.20's OSWRCH (&E822)")
master.banner(0x7F92, "The game-font WRCHV handler, unused",
              "The rest of a WRCHV handler that prints letters and digits in "
              "the game's own font (font_letters, font_digits). WRCHV's entry "
              "at &7F8F jumps straight to the MOS, so none of this runs and "
              "text appears in the MOS font.")
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
    (0x08B0, "unread_digit_table", "four bytes *DUNJUNZ sets to &69"),
    (0x08B4, "unread_hero_table", "four bytes *DUNJUNZ sets to 0"),
    (0x08BC, "unread_level_count", "a byte *DUNJUNZ sets to 0"),
    (0x08BD, "unread_level_digits", "two bytes *DUNJUNZ sets to \"0 \""),
]:
    declare = master.region if addr == 0x08BD else master.label
    window = {"window": (0, 1)} if addr == 0x08BD else {}
    declare(addr, name, group="loader", **window, description=(
        f"In Dunj3: {text}, which the game never reads."))
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
           "Load the next level and draw it, with the music carrying on "
           "across levels. Called by level_loop once per level, after it "
           "has counted the level in level_bcd; level_loop then draws the "
           "status panel and plays the level.\n\n"
           "The music plays on the interval timer event, and is stopped "
           "while the level loads and is drawn. After the first level of "
           "the session its place (rhythm step, transposition, section "
           "and tune_ptr) is pushed on the stack first, since start_music "
           "resets it. Then count the level (count_level), put the MOS's "
           "page &0D back and load and check the level (load_level), "
           "unpack it, give page &0D back to the game (reset_workspace), "
           "reset the monsters, clear the screen, show 25 rows, and draw "
           "the view frames and views. Last, restart the music: "
           "start_music always plays the tune's first step, after which "
           "the saved place, if any, is put back, so that the tune "
           "carries on from where the last level left it. "
           "first_level_flag tells the two cases apart; it is set after "
           "the first level and never cleared, so the first level of a "
           "later game resumes the tune where game_over_music stopped it.",
            on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
master.block(0x1400, "After the first level, keep the music's place on the "
                     "stack, as start_music will reset it.")
master.block(0x1419, "Load and set up the level with the music silent.")
master.block(0x142E, "Show all 25 rows and draw the play screen.")
master.block(0x1461, "Restart the music, then put its kept place back.")
comments(master, [
    (0x1400, "First level of the session?"),
    (0x1403, "...&7B once the first level is done"), (0x1405, "Yes: no music playing to save"),
    (0x1407, "No: keep the music's place on the stack: its step..."),
    (0x140A, "...pushed first, so it comes off last"),
    (0x140B, "...then the transposition..."),
    (0x140E, "...pushed second..."),
    (0x140F, "...then the section..."),
    (0x1412, "...pushed third..."),
    (0x1413, "...and tune pointer (zero page &00-&01)"),
    (0x1415, "...low byte pushed"), (0x1416, "...then its page..."), (0x1418, "...pushed last, to come off first"),
    (0x1419, "Silence the music while the level loads"),
    (0x141C, "Clear the text area and count the level"),
    (0x141F, "Put the MOS's page &0D back and load the level"),
    (0x1422, "Copy it into the game's tables"),
    (0x1425, "Page &0D back to the game's workspace"),
    (0x1428, "Reset the monsters and keys"),
    (0x142B, "Clear the text area"),
    (0x142E, "VDU 23,0,6,25,0,0,0,0,0,0: set 6845 register 6..."),
    (0x1430, "...send VDU 23, the 6845 command..."), (0x1433, "...0: write a 6845 register..."),
    (0x1435, "...sent: a register setting follows"), (0x1438, "...register 6, rows displayed..."),
    (0x143A, "...sent: the register number"),
    (0x143D, "...to 25 character rows displayed"),
    (0x143F, "...so play uses all 25 rows"), (0x1442, "...then six zeros to finish the command"), (0x1444, "...zero 1 of 6 ending the VDU 23"), (0x1447, "...zero 2 of 6 ending the VDU 23"),
    (0x144A, "...zero 3 of 6 ending the VDU 23"), (0x144D, "...zero 4 of 6 ending the VDU 23"), (0x1450, "...zero 5 of 6 ending the VDU 23"), (0x1453, "...zero 6 of 6: the VDU 23 is complete"),
    (0x1456, "Point at view_frame_plots..."),
    (0x1458, "...low byte in plot_x"), (0x145A, "...and its page..."), (0x145C, "...in plot_y, as draw_view_frames expects"),
    (0x145E, "...and draw the frames and the views"),
    (0x1461, "Start the music from the top (plays its first step)"),
    (0x1464, "First level of the session?"),
    (0x1467, "...&7B once the first level is done"), (0x1469, "Yes: nothing saved; the tune plays from the top"),
    (0x146B, "No: put the music's place back: tune pointer..."),
    (0x146C, "...its page into tune_ptr's high byte..."), (0x146E, "...then the low byte..."),
    (0x146F, "...into tune_ptr: the step to play next"),
    (0x1471, "...then the section..."),
    (0x1472, "...back in music_section"),
    (0x1475, "...then the transposition..."),
    (0x1476, "...back in music_transpose"),
    (0x1479, "...and rhythm step"),
    (0x147A, "...restored: the tune resumes where it was"),
    (0x147D, "Mark the first level done..."),
    (0x147F, "...so later levels, and later games, keep the music's place"),
    (0x1482, "Return to level_loop to draw the panel and play"),
])
master.label(0x1638, "first_level_flag", description=(
    "Whether start_level has run this session: &EA as loaded, &7B once "
    "the first level is drawn. start_level reads it twice per level, to "
    "decide whether the music's place is to be kept and put back, and "
    "writes &7B at its end; nothing clears it."))
master.byte(0x1638)
master.byte(0x1639)

master.sub(0x1483, "load_level", "Put the MOS's page &0D back and load the level",
           "Bring the next level's file from disc into &6B00-&6DAF, then "
           "decrypt and check it. Called by start_level once per level, "
           "after count_level has counted level_number and with the music "
           "stopped, and before unpack_level copies the level into "
           "play.\n\n"
           "Copy the MOS's page &0D back from saved_page_0d (coder_start "
           "saved it there), over the game's workspace, so that the disc "
           "filing system's NMI code and workspace are intact for the "
           "load; reset_workspace gives the page back to the game "
           "afterwards. Write level_bcd's digits into level_command: one "
           "digit and a space for levels 1-9, two digits from 10. Show "
           "only 15 character rows, so that the level file arriving at "
           "&6B00 (rows 23-24 of the screen) is not seen. Then *LOAD "
           "LEVELnn 6B00 and jump to decrypt_level, which returns to "
           "start_level; level 25 has no file of its own and comes from "
           "Stones, through load_stones in Table. A level that fails its "
           "checksum makes decrypt_level call &D9CD, which on a Master is "
           "private RAM, not a reset.",
            on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
master.block(0x1483, "Give page &0D back to the filing system for the load.")
master.block(0x148E, "Write the level's number, from level_bcd, into "
                     "level_command as one digit and a space, or two digits.")
master.block(0x14BF, "Show only 15 rows, hiding the screen rows the level "
                     "file is loaded into.")
master.block(0x14E7, "Load the level: Stones for level 25, LEVELnn for the "
                     "rest, then decrypt and check it.")
comments(master, [
    (0x1483, "Copy &C400-&C4FF back to page &0D..."),
    (0x1485, "...each byte saved at &C400..."), (0x1488, "...back where the filing system needs it"), (0x148B, "...next byte (X wraps from 0)"), (0x148C, "Until all 256 are back"),
    (0x148E, "Level 10 or more? (level_bcd &01-&09 or &10-&25)"),
    (0x1491, "...&0A or more means two digits"), (0x1493, "Yes: two digits"),
    (0x1495, "No: units digit then a space"),
    (0x1497, "...second digit a space"),
    (0x149A, "...the units digit..."), (0x149D, "...from the low nibble..."),
    (0x149F, "...made ASCII (carry clear for the add)..."), (0x14A0, "...'0' plus the digit"),
    (0x14A2, "...is the first digit"),
    (0x14A5, "...(always branches: the digit is not 0)"),
    (0x14A7, "Yes: tens digit..."),
    (0x14AA, "...shifting the tens digit..."), (0x14AB, "...down four bits..."),
    (0x14AC, "...from the high nibble..."), (0x14AD, "...into the low nibble: 1 or 2"),
    (0x14AE, "...made ASCII (carry clear for the add)..."), (0x14AF, "...'0' plus the digit"), (0x14B1, "...is the first digit"),
    (0x14B4, "...then units digit"),
    (0x14B7, "...from the low nibble..."), (0x14B9, "...made ASCII (carry clear for the add)..."),
    (0x14BA, "...'0' plus the digit"), (0x14BC, "...is the second digit"),
    (0x14BF, "VDU 23,0,6,15,0,0,0,0,0,0: show 15 character rows while "
             "loading..."),
    (0x14C1, "...send VDU 23, the 6845 command..."), (0x14C4, "...0: write a 6845 register..."),
    (0x14C6, "...sent: a register setting follows"), (0x14C9, "...register 6, rows displayed..."),
    (0x14CB, "...sent: the register number"), (0x14CE, "...15 rows, the new setting..."),
    (0x14D0, "...hiding rows 15-24, where &6B00 lies"), (0x14D3, "...then six zeros to finish the command"),
    (0x14D5, "...zero 1 of 6 ending the VDU 23"), (0x14D8, "...zero 2 of 6 ending the VDU 23"), (0x14DB, "...zero 3 of 6 ending the VDU 23"), (0x14DE, "...zero 4 of 6 ending the VDU 23"),
    (0x14E1, "...zero 5 of 6 ending the VDU 23"), (0x14E4, "...zero 6 of 6: the VDU 23 is complete"),
    (0x14E7, "Level 25, the last, with no file of its own?"),
    (0x14EA, "...level_number &19 (counted by count_level)?"), (0x14EC, "No: load its LEVELnn file"),
    (0x14EE, "Yes: load it from Stones (and check it there)"),
    (0x14F1, "No: *LOAD LEVELnn 6B00"),
    (0x14F3, "...high byte of the command"), (0x14F5, "...the level file to &6B00, for decrypt_level"),
    (0x14F8, "Decrypt and check it, and return from there"),
])
master.label(0x14FB, "level_command", description=(
    "\"LOAD LEVELnn 6B00\", passed to OSCLI by load_level for levels "
    "1-24, with the level's digits written at level_command_digits "
    "(level_command+10) before each load. It is stored with the digits "
    "\"11\"."))
master.region(0x1505, "level_command_digits", (0, 1))
master.stringcr(0x14FB)
master.c(0x14FB, "*LOAD LEVELnn 6B00, the digits at +10")
master.sub(0x1612, "count_level", "Clear the text area and count the level",
           "start_level's first call after the music stops. Clear the "
           "screen and count "
           "the level in level_number (1-25), which picks the level's "
           "checksum, Stones for level 25 and the Chalice. No level number "
           "is shown.",
            on_exit={"A": "corrupted", "X": "preserved", "Y": "preserved"})
comments(master, [
    (0x1612, "Clear the text area"),
    (0x1615, "level_number + 1: the level about to load"),
    (0x1618, "Return to start_level to load that level"),
])

master.label(0x16D5, "level_filename_digits", description=(
    "Where level_loop writes the level number's digits. load_level builds "
    "level_command instead, so they are not used."))

# ---------------------------------------------------------------------------
# Code, &C500: the joystick handler, in private RAM.

master.sub(0xC500, "joystick_bytev", "BYTEV handler: read a joystick for the Barbarian's keys",
           "Installed on BYTEV by Coder2. Answers test_key's OSBYTE &81 "
           "scans of the Barbarian's (hero 2's) keys from the analogue port, "
           "so that a joystick plays the Barbarian: left (N &AA) and right "
           "(M &9A) from channel 1, up (G &AC) and down (B &9B) from "
           "channel 2, and fire (SPACE &9D) from either fire button. A "
           "direction counts only at the stick's extreme, when the channel's "
           "high byte is &FF or 0. Every other call goes to the MOS 3.20 "
           "OSBYTE routine at &EEB1 directly, skipping any other BYTEV "
           "claimant; the handler's own OSBYTE &80 reads come back through "
           "BYTEV into it and are passed on the same way. The Barbarian's "
           "five keys are never scanned while it is installed, so that "
           "hero can be played only with the joystick. test_key counts a "
           "key as held only when X and Y both come back &FF, so a "
           "not-pressed answer needs only X = 0. It lives in private RAM "
           "and so works only while HAZEL is paged in.",
           on_entry={"A": "OSBYTE number", "X": "OSBYTE X"},
           on_exit={"X": "&FF if the key is pressed, 0 if not",
                    "Y": "&FF if the key is pressed"})
comments(master, [
    (0xC500, "OSBYTE &81 (INKEY)?"),
    (0xC502, "No: let the MOS handle it"),
    (0xC504, "The Barbarian's left key (N)?"), (0xC506, "Yes: read the stick for left"),
    (0xC508, "The Barbarian's down key (B)?"), (0xC50A, "Yes: read the stick for down"),
    (0xC50C, "The Barbarian's up key (G)?"), (0xC50E, "Yes: read the stick for up"),
    (0xC510, "The Barbarian's right key (M)?"), (0xC512, "Yes: read the stick for right"),
    (0xC514, "The Barbarian's fire key (SPACE)?"), (0xC516, "Yes: read the fire buttons"),
    (0xC518, "Any other key: scan the keyboard as usual"),
    (0xC51B, "N: channel 1 high byte &FF?"),
    (0xC51D, "...with OSBYTE &80, reading the ADC"), (0xC51F, "...the stick's left-right position"), (0xC522, "...high byte &FF: pushed fully left?"),
    (0xC524, "No: not pressed"),
    (0xC526, "Yes: pressed (Y is already &FF)"), (0xC528, "Return X = Y = &FF: left is pressed"),
    (0xC529, "M: channel 1 high byte 0?"),
    (0xC52B, "...with OSBYTE &80, reading the ADC"), (0xC52D, "...the stick's left-right position"), (0xC530, "...high byte 0: pushed fully right?"),
    (0xC532, "No: not pressed"),
    (0xC534, "Yes: pressed (Y = &FF)"), (0xC535, "...X = Y = &FF, as INKEY reports a key held"),
    (0xC537, "Return X = Y = &FF: right is pressed"),
    (0xC538, "G: channel 2 high byte &FF?"),
    (0xC53A, "...with OSBYTE &80, reading the ADC"), (0xC53C, "...the stick's up-down position"), (0xC53F, "...high byte &FF: pushed fully up?"),
    (0xC541, "No: not pressed"),
    (0xC543, "Yes: pressed (Y is already &FF)"), (0xC545, "Return X = Y = &FF: up is pressed"),
    (0xC546, "B: channel 2 high byte 0?"),
    (0xC548, "...with OSBYTE &80, reading the ADC"), (0xC54A, "...the stick's up-down position"), (0xC54D, "...high byte 0: pushed fully down?"),
    (0xC54F, "No: not pressed"),
    (0xC551, "Yes: pressed (Y = &FF)"), (0xC552, "...X = Y = &FF, as INKEY reports a key held"),
    (0xC554, "Return X = Y = &FF: down is pressed"),
    (0xC555, "Fire: either fire button?"),
    (0xC557, "...OSBYTE &80, X = 0: the fire buttons in X"), (0xC559, "...read them"), (0xC55C, "...the button bits..."), (0xC55D, "...bits 0-1: either button held?"),
    (0xC55F, "No: not pressed"),
    (0xC561, "Yes: X = &FF, fire pressed..."), (0xC563, "...X = Y = &FF, as INKEY reports a key held"),
    (0xC565, "Return X = Y = &FF: fire is pressed"),
    (0xC566, "Not pressed: X = 0, which test_key reads as not held"),
    (0xC568, "Return X = 0: the key is not pressed"),
    (0xC569, "Not INKEY: on to the MOS 3.20 OSBYTE routine"),
])

# ---------------------------------------------------------------------------
# Table, &C5A0: level 25, game over, the row offsets and the pause key.

master.sub(0xC5A0, "load_stones", "Load level 25 from Stones",
           "load_level's way to level 25, reached by its JMP when "
           "level_number is 25, with page &0D already given back to the "
           "filing system. Level 25 has no file of its own: Stones (&730 "
           "bytes) ends with its data, so *LOAD STONES 6680 puts it at "
           "&6B00-&6DAF. Then jump to decrypt_level, which returns to "
           "start_level. stones_command is ended by a zero byte, not a "
           "carriage return; the first CR after it is at &C623, the end "
           "of the leftover DUNJUNZ.",
            on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
comments(master, [
    (0xC5A0, "*LOAD STONES 6680"),
    (0xC5A2, "...high byte of the command"), (0xC5A4, "...level 25 is at the end of Stones"),
    (0xC5A7, "Decrypt and check it; it returns to start_level"),
])
master.label(0xC5AA, "stones_command", description=(
    "\"LOAD STONES 6680\", passed to OSCLI by load_stones. The byte after "
    "it is 0, not the carriage return that ends the game's other "
    "commands."))
master.string(0xC5AA, 16)
master.c(0xC5AA, "*LOAD STONES 6680, with no CR after it")
master.byte(0xC5BA, 0x46, cols=8)
master.c(0xC5BA, "0, where a CR would end stones_command; unused zeros")
master.sub(0xC600, "game_over_music", "Stop the music for the game-over message",
           "Called by level_loop's game-over code when all four heroes are "
           "dead. Stop the music, "
           "send the VDU 28 that the game-over text window begins with "
           "(the caller sends its four edges), and write 0 into the top-row "
           "operand of clear_text_area's VDU 28. That operand already holds "
           "0 and nothing else writes it, so the store changes nothing.",
            on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
comments(master, [
    (0xC600, "Silence the music for the game-over message"),
    (0xC603, "VDU 28: the game-over text window..."),
    (0xC605, "...whose four edges the caller sends next"),
    (0xC608, "Top row 0 in clear_text_area's window..."),
    (0xC60A, "...where it is already 0"),
    (0xC60D, "Return to send the window's edges"),
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
    (0xC6C0, "*FREE: X, Y = free_command..."),
    (0xC6C2, "...high byte of the command"), (0xC6C4, "...print the disc's free space"),
    (0xC6C7, "Return to the editor"),
])
master.label(0xC6C8, "free_command")
master.stringcr(0xC6C8)
master.byte(0xC6CD, 3, cols=3)
d.expr(0xC6C1, lo(sym("free_command")))
d.expr(0xC6C3, hi(sym("free_command")))

master.label(0x1ED7, "check_pause")
master.sub(0xC6D0, "pause_check", "Pause while P is pressed",
           "Reached by check_pause's JMP, last in each frame's update, so "
           "its RTS returns from update_game to play_level. If P (internal "
           "key &37) is held, wait for it to be released, pressed again and "
           "released, then give the next frame its usual three vertical "
           "syncs. Waiting for the second release means a P still held "
           "cannot pause the game again at the next frame. The music plays "
           "on through the pause, on its timer event. OSBYTE &7A reports a "
           "single key, so P is seen only when the scan finds it rather "
           "than another key held with it.",
            on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
comments(master, [
    (0xC6D0, "OSBYTE &7A: which key is pressed?"),
    (0xC6D2, "...X = the key held, if any"),
    (0xC6D5, "Is it P (internal key &37)?"),
    (0xC6D7, "No: on with play"),
    (0xC6D9, "Paused: wait for P to be released..."),
    (0xC6DC, "...then scan again until P is pressed again..."),
    (0xC6DE, "...X = the key held"), (0xC6E1, "...is it P yet?"), (0xC6E3, "No: stay paused"),
    (0xC6E5, "...and released, so the next frame cannot re-pause"),
    (0xC6E8, "Restart the frame timing: 2..."),
    (0xC6EA, "...gives the next frame the usual three vsyncs"),
    (0xC6ED, "Return to play_level: this frame's update is done"),
])
master.sub(0xC6EE, "wait_p_released", "Wait until P is not pressed",
           "Called twice by pause_check, once for each release of P. Scan "
           "the keyboard with OSBYTE &7A until the key found is no longer "
           "P (internal key &37).",
            on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
comments(master, [
    (0xC6EE, "OSBYTE &7A: which key is pressed?"),
    (0xC6F0, "...X = the key held"),
    (0xC6F3, "Is it still P?"),
    (0xC6F5, "Yes: keep waiting"),
    (0xC6F7, "Return to pause_check: P is released"),
])

# ---------------------------------------------------------------------------
# Code2, &C700: the music.

master.sub(0xC700, "start_music", "Start the music",
           "Start the in-game music from the top of the tune. Called by "
           "start_level once each level is drawn; start_level then puts "
           "back the music's place from the last level, if there was one.\n\n"
           "Define envelopes 6-9 for the tune's sounds. Redirect the game's "
           "plot_sprite to plot_sprite_hazel, the copy in Code3, by writing "
           "a JMP over its first three bytes: this happens from the first "
           "level on, so the hero menu before it uses the original. Point "
           "tune_ptr at the tune's first section (section 0, which plays "
           "only once), set the rhythm step to -1 and the transposition to "
           "0. Then hand the music to the interval timer: EVNTV is pointed "
           "at music_event and the interval timer event enabled. Last, jump "
           "to music_event to play the first step, which also sets the "
           "timer for the next and returns to start_level.",
            on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
master.block(0xC700, "Define the four envelopes the tune uses.")
master.block(0xC724, "Send every sprite plot to the copy in private RAM.")
master.block(0xC733, "Start the tune from its first section.")
master.block(0xC74A, "Play a step at each interval timer event, starting "
                     "with one now.")
comments(master, [
    (0xC700, "ENVELOPE 6: X, Y = envelope_6's block..."),
    (0xC702, "...Y = the block's page"),(0xC704, "...OSWORD 8 defines it"), (0xC706, "...for the tune's notes"),
    (0xC709, "ENVELOPE 7: X, Y = envelope_7's block..."),
    (0xC70B, "...Y = the block's page"),(0xC70D, "...OSWORD 8 defines it"), (0xC70F, "...for the tune's notes"),
    (0xC712, "ENVELOPE 8: X, Y = envelope_8's block..."),
    (0xC714, "...Y = the block's page"),(0xC716, "...OSWORD 8 defines it"), (0xC718, "...for the tune's notes"),
    (0xC71B, "ENVELOPE 9: X, Y = envelope_9's block..."),
    (0xC71D, "...Y = the block's page"),(0xC71F, "...OSWORD 8 defines it"), (0xC721, "...for the tune's notes"),
    (0xC724, "Make plot_sprite JMP &D800, the copy in Code3..."),
    (0xC726, "...over plot_sprite's first byte"), (0xC729, "...JMP to the copy: address low byte..."),
    (0xC72B, "...as the JMP's operand low byte"), (0xC72E, "...then the copy's page, &D8..."),
    (0xC730, "...stored: sprites now plot from HAZEL"),
    (0xC733, "Tune pointer (zero page &00-&01) = the first section..."),
    (0xC735, "...low byte stored"), (0xC737, "...then the tune's page..."),
    (0xC739, "...into tune_ptr's high byte"),
    (0xC73B, "Section 0, the opening, played only once"),
    (0xC73D, "...in music_section: the opening plays first"),
    (0xC740, "Rhythm step -1, so the first step plays step 0"),
    (0xC742, "...in music_rhythm_step, the pattern's index"),
    (0xC745, "Transposition 0: the rhythm at its written pitch"),
    (0xC747, "...in music_transpose, for channel 1's notes"),
    (0xC74A, "Point EVNTV at music_event..."),
    (0xC74C, "...the handler's low byte into EVNTV..."), (0xC74F, "...and its page, &C7..."),
    (0xC751, "...so each timer event plays a step"),
    (0xC754, "OSBYTE 14, 5: enable the interval timer event"),
    (0xC756, "...event 5, the interval timer..."), (0xC758, "...Y = 0, as OSBYTE 14 expects"),
    (0xC75A, "...enabled"),
    (0xC75D, "Play the first step, and return from there"),
])
master.sub(0xC760, "stop_music", "Stop the music",
           "Silence the tune by disabling the interval timer event "
           "(OSBYTE 13, 5), so music_event is no longer called. Called by "
           "start_level before each level loads and by game_over_music. "
           "The sound queues are not flushed, and the music's place "
           "(tune_ptr, music_section and so on) is left as it was.",
            on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
comments(master, [
    (0xC760, "OSBYTE 13, 5: disable the interval timer event"),
    (0xC762, "...event 5, the interval timer..."), (0xC764, "...Y = 0, as OSBYTE 13 expects"),
    (0xC766, "...disabled, returning from there"),
])
master.label(0xC769, "music_rhythm_step", description=(
    "Step in the 32-step rhythm_pattern, 0-31; -1 (&FF) before the first "
    "step of the tune. music_event advances it each step and wraps it "
    "from 31 to 0; start_level keeps it across a level load."))
master.label(0xC76A, "music_transpose", description=(
    "Added to rhythm_pattern's pitches on channel 1. Set to 0 by "
    "start_music and replaced by a tune step's first byte whenever that "
    "is non-zero; start_level keeps it across a level load."))
master.label(0xC76B, "music_section", description=(
    "The section of the tune playing: 0 for the opening, then 1-24 over "
    "and over. Indexes section_ptrs_lo and section_ptrs_hi; start_level "
    "keeps it across a level load."))
master.byte(0xC769)
master.byte(0xC76A)
master.byte(0xC76B)
master.region(0x0000, "tune_ptr", (0, 1), group="zero_page", description=(
    "The music's place in the tune: the address of the three-byte step to "
    "play next. Set to the tune's start by start_music, advanced by "
    "music_event, and kept on the stack by start_level across a level "
    "load."))

master.sub(0xC76C, "music_event", "Event handler: play one step of the music",
           "Called through EVNTV for the interval timer event, and once "
           "directly by start_music. Each call sets the interval timer to "
           "fire again 12 centiseconds later, so a step plays every 12 cs "
           "until stop_music disables the event. The event number in A is "
           "not checked: the game enables no other event. A tune step is "
           "three bytes: a transposition for the rhythm (0 for no change) "
           "or &FF to end the section, a pitch for channel 2 and a pitch "
           "for channel 3 (0 for silence). Each step also plays the next of "
           "the 32 steps of rhythm_pattern on channel 1 and the noise "
           "channel. At the end of a section the next byte sets channel 3's "
           "envelope and the next section starts; after section 24 the tune "
           "goes back to section 1. The interval timer is then reset. It "
           "runs in private RAM, so it relies on HAZEL being paged in when "
           "the event is raised.",
           on_exit={"A": "preserved", "X": "preserved", "Y": "preserved"})
master.block(0xC76C, "Save the interrupted code's registers, then read the "
                     "step's first byte: &FF ends the section.")
master.block(0xC77A, "Play the step: take a new transposition, and sound "
                     "channels 2 and 3.")
master.block(0xC7A5, "Move on to the next step, and play the next step of "
                     "the rhythm, transposed, with a beat on the noise "
                     "channel.")
master.block(0xC7E0, "Set the timer for the next step and return.")
master.block(0xC7F0, "End of a section: set channel 3's envelope, move to "
                     "the next section (looping 24 back to 1), and play its "
                     "first step.")
comments(master, [
    (0xC76C, "Save the flags and registers"),
    (0xC76D, "...A, pushed first..."), (0xC76E, "...Y, via A..."), (0xC76F, "...Y's copy pushed second"),
    (0xC770, "...X, via A..."),
    (0xC771, "...pushed: the interrupted code keeps them"),
    (0xC772, "First byte of the step..."),
    (0xC774, "...the step's transposition byte"),
    (0xC776, "...&FF, the end of the section?"),
    (0xC778, "Yes: end of the section"),
    (0xC77A, "Non-zero: a new transposition"),
    (0xC77C, "Zero: keep the transposition"), (0xC77E, "...as the new transposition"),
    (0xC781, "Second byte: channel 2's pitch..."),
    (0xC783, "...read from the step"),
    (0xC785, "...0 for none"),
    (0xC787, "...into its SOUND block's pitch"),
    (0xC78A, "SOUND channel_2_sound: X, Y = its block..."),
    (0xC78C, "...Y = the block's page"),(0xC78E, "...OSWORD 7: SOUND"), (0xC790, "...play the note"),
    (0xC793, "Third byte: channel 3's pitch..."),
    (0xC795, "...read from the step"),
    (0xC797, "...0 for none"),
    (0xC799, "...into its SOUND block's pitch"),
    (0xC79C, "SOUND channel_3_sound: X, Y = its block..."),
    (0xC79E, "...Y = the block's page"),(0xC7A0, "...OSWORD 7: SOUND"), (0xC7A2, "...play the note"),
    (0xC7A5, "Next step: tune_ptr += 3..."),
    (0xC7A7, "...(carry clear for the add)..."), (0xC7A8, "...past this step"),
    (0xC7AA, "...into tune_ptr's low byte"), (0xC7AC, "...and the page..."),
    (0xC7AE, "...with the carry"), (0xC7B0, "...into tune_ptr's high byte"),
    (0xC7B2, "Next rhythm step, 0-31..."),
    (0xC7B5, "...(carry clear for the add)..."), (0xC7B6, "...plus 1, the next step"),
    (0xC7B8, "...32, past the pattern's last step?"), (0xC7BA, "No: keep it"),
    (0xC7BC, "Yes: back to step 0"), (0xC7BE, "...the step to play"),
    (0xC7C1, "Its pitch, 0 for a rest..."),
    (0xC7C2, "...the bass pitch for this step"), (0xC7C5, "Zero: a rest, no note"),
    (0xC7C7, "...transposed (carry clear for the add)..."),
    (0xC7C8, "...plus the transposition"), (0xC7CB, "...into channel 1's SOUND block"),
    (0xC7CE, "...on channel 1..."),
    (0xC7D0, "...Y = the block's page"),(0xC7D2, "...OSWORD 7: SOUND"), (0xC7D4, "...play the bass note"),
    (0xC7D7, "...with the noise channel"),
    (0xC7D9, "...Y = the block's page"),(0xC7DB, "...OSWORD 7: SOUND"), (0xC7DD, "...play the beat"),
    (0xC7E0, "OSWORD 4: interval timer = -12 centiseconds, for the next step"),
    (0xC7E2, "...Y = the block's page"),(0xC7E4, "...OSWORD 4: write the interval timer"), (0xC7E6, "...so the next event comes 12 cs on"),
    (0xC7E9, "Restore the registers and flags"),
    (0xC7EA, "...X from the last push..."), (0xC7EB, "...then Y's byte..."),
    (0xC7EC, "...back into Y..."), (0xC7ED, "...then A, pushed first..."),
    (0xC7EE, "...and the flags"),
    (0xC7EF, "Return to the MOS's event code (or start_level)"),
    (0xC7F0, "End of section: the next byte is channel 3's envelope"),
    (0xC7F2, "...read from after the &FF"), (0xC7F4, "...into its SOUND block"),
    (0xC7F7, "Count on to the next section..."),
    (0xC7FA, "...the new section..."), (0xC7FD, "...25, past the last?"),
    (0xC7FF, "No: start it"),
    (0xC801, "Yes: loop to section 1 (0 plays only once), rhythm too"),
    (0xC803, "...rhythm step -1 again..."), (0xC806, "...section 1, where the loop starts..."),
    (0xC808, "...in music_section"),
    (0xC80B, "Point tune_ptr at the section..."),
    (0xC80C, "...address low byte..."), (0xC80F, "...into tune_ptr's low byte"),
    (0xC811, "...then its page..."), (0xC814, "...into tune_ptr's high byte"),
    (0xC816, "...and play its first step"),
    (0xC818, "...its first byte, the transposition"), (0xC81A, "...played as any other step"),
])
for addr, name, text in [
    (0xC81D, "channel_1_sound", "SOUND &11, 9 (envelope 9), pitch, 1: the rhythm"),
    (0xC825, "noise_sound", "SOUND &10, envelope 7, 3, 3: noise with the rhythm"),
    (0xC82D, "channel_2_sound", "SOUND &12, envelope 8, pitch, 10"),
    (0xC835, "channel_3_sound", "SOUND &13, envelope (set per section), pitch, 8"),
]:
    master.region(addr, name, (0, 7), description=f"OSWORD 7 block: {text}.")
    master.byte(addr, 8, cols=8)
master.label(0xC83D, "section_ptrs_lo", length=25, description=(
    "Low bytes of the addresses of the tune's sections, indexed by "
    "music_section (0-24); read by music_event at a section's start."))
master.byte(0xC83D, 25, cols=13)
master.label(0xC856, "section_ptrs_hi", length=25, description=(
    "High bytes of the addresses of the tune's sections, indexed by "
    "music_section (0-24)."))
master.byte(0xC856, 25, cols=13)
for addr, n in [(0xC86F, 6), (0xC87D, 7), (0xC88B, 8), (0xC899, 9)]:
    master.label(addr, f"envelope_{n}", length=14,
                 description=f"OSWORD 8 block: ENVELOPE {n}.")
    master.byte(addr, 14, cols=14)
master.label(0xC8A7, "music_interval", length=5, description=(
    "OSWORD 4 block: the interval timer value, -12 centiseconds."))
master.byte(0xC8A7, 5, cols=5)
master.label(0xC8AC, "rhythm_pattern", length=32, description=(
    "The 32-step rhythm, indexed by music_rhythm_step: a pitch for "
    "channel 1 for each step, to which music_transpose is added, or 0 for "
    "a rest (no bass note and no beat)."))
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
    (0x1567, 0x156C, "wrch_handler"),
    (0x074F, 0x0751, "load_dunj2_command"), (0x0756, 0x0758, "load_dunj3_command"),
    (0x075D, 0x075F, "load_dunj4_command"), (0x0764, 0x0766, "load_dunj5_command"),
    (0x1457, 0x145B, "view_frame_plots"), (0x14F2, 0x14F4, "level_command"),
    (0xC5A1, 0xC5A3, "stones_command"), (0xC72A, 0xC72F, "plot_sprite_hazel"),
    (0xC734, 0xC738, "tune"), (0xC74B, 0xC750, "music_event"),
]:
    master.expr(lo_addr, lo(sym(name)))
    master.expr(hi_addr, hi(sym(name)))

master.c(0x0D6E, "Not referenced")  # after game_entry
master.byte(0x12D3, 2)
master.c(0x12D3, "Not referenced: WRCHV is never saved on this side")

# Bytes no instruction refers to.
master.byte(0x08C0, 0x40, cols=8)
for addr in (0x07CD, 0x07F8, 0x08C0, 0x1639, 0x1EF7, 0xC623, 0xC6A7,
             0xC6CD, 0xC8CC):
    master.c(addr, "Not referenced")
for addr in (0x1EDA, 0xC60E):
    master.c(addr, "Not used")

ir = d.disassemble()
asm_filepath.parent.mkdir(parents=True, exist_ok=True)
asm_filepath.write_text(str(ir.render("beebasm")), encoding="utf-8")
json_filepath.write_text(str(ir.render("json")), encoding="utf-8")
