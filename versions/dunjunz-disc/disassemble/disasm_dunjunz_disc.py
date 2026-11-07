"""dasmos driver for the game code of the official Dunjunz disc (Model B side).

Coder (&5000) runs at the start of every level: it reloads Dun1, loads the
level, and builds the resident game from Dun1's contents:

    Dun1 &2000-&2FFF   runs in place
    Dun1 &3000-&473F   copied to &08C0-&1FFF
    Dun1 &5000-&59AF   Coder itself, which holds two &0400-&07FF images:
                         &51B0  keyboard only
                         &55B0  with a joystick handler on BYTEV
    Dun1 &6E80-&7FFF   runs in place

The two &0400 images are modelled as moves to the same run address. The
listing saves Dun1 and, from the same bytes, the separate Coder file.
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
from dunjunz_common.rendering import ExtraSavesBeebasmRenderer, SavedFile  # noqa: E402

BINARY_DIRPATH = VERSION_DIRPATH / "binary"
OUTPUT_DIRPATH = VERSION_DIRPATH / "output"

asm_filepath = Path(os.environ.get("FANTASM_ASM", OUTPUT_DIRPATH / "dunjunz-disc.asm"))
json_filepath = Path(os.environ.get("FANTASM_JSON", OUTPUT_DIRPATH / "dunjunz-disc.json"))

# Coder is the &5000-&59AF part of Dun1, saved as a file of its own.
CODER_FILE = SavedFile("Coder", start=0x5000, end=0x59B0, exec_addr=0x5000, load_addr=0x5000)

d = dasmos.Disassembler.create(cpu="6502")
d.load(BINARY_DIRPATH / "Dun1", 0x2000, name="Dun1", exec_addr=0x2000)
d.use_environment("acorn_mos")
d.use_environment("acorn_model_b_hardware")

game_core = d.add_move(0x08C0, 0x3000, 0x1740, name="game_core")
low_keyboard = d.add_move(0x0400, 0x51B0, 0x0400, name="low_keyboard")
low_joystick = d.add_move(0x0400, 0x55B0, 0x0400, name="low_joystick")

# Routines in the &0400-&07FF images, called from the rest of the game.
# With two images at the same run address, each entry must be declared
# within the move it belongs to.
LOW_ENTRIES = [0x0400, 0x0450, 0x0500, 0x06B0]
for move in (low_keyboard, low_joystick):
    with move:
        for addr in LOW_ENTRIES:
            d.entry(addr)

d.entry(0x5000, "coder_start")

# Coder copies &3000-&473F; the rest of the page before Coder is zeros.
d.banner(0x4740, title="Unused",
         description="Zeros between the stored game core (&3000-&473F) and Coder (&5000).")


def placements(addr):
    """Where runtime address addr lives in Dun1: which move(s), and the
    suffix for labels in each."""
    if 0x0400 <= addr < 0x0800:
        # Both images of &0400-&07FF get every annotation; the joystick
        # image's labels carry a suffix so that the names stay unique.
        return [(low_keyboard, ""), (low_joystick, "_joystick")]
    if 0x08C0 <= addr < 0x2000:
        return [(game_core, "")]
    return [(None, "")]


annotator = Annotator(d, "disc", placements)
game.annotate(annotator)
game.annotate_game_entry(annotator)
game.annotate_level_check(annotator)
game.annotate_start_level(annotator)
game.annotate_level_end(annotator)
game.annotate_menu_tables(annotator, 0x08B0)
game.declare_boot_osfile_block(d)
keyboard_only = Annotator(d, "disc", lambda addr: [(low_keyboard, "")])
joystick_image = Annotator(d, "disc", lambda addr: [(low_joystick, "_joystick")])
game.annotate_page7_leftovers(keyboard_only, "*SA. DANK 400+3FF 740")
game.annotate_boot_loader(keyboard_only)
game.annotate_page7_leftovers(joystick_image, "*SA. Control 400+3FF")
game.annotate_boot_loader(joystick_image, sets_bytev=True)
annotator.label(0x06F8, "page6_score_ten_thousands", length=4, group="game_state", description=(
    "Each hero's score ten-thousands digit where add_thousand_points still "
    "keeps it, at its cassette address. Every other routine uses "
    "hero_score_ten_thousands at &08B0, and Coder reloads this page for "
    "every level, so the digit is lost between levels."))

# ---------------------------------------------------------------------------
# Specific to the official disc release: Coder, and moving between levels
# by resetting the machine.

annotator.label(0x08BC, "levels_started", group="disc_state", description=(
    "Number of levels started, kept by Coder in page &08, which survives "
    "the reset between levels."))
annotator.label(0x08BD, "level_digits", length=2, group="disc_state",
                description=(
                    "The level number as ASCII digits for the level's "
                    "filename: one digit and a space, or two digits."))
annotator.region(0x0287, "os_break_intercept", (0, 2), group="os_workspace",
                 access="w", description=(
                    "MOS BREAK intercept: if &0287 holds a JMP opcode the "
                    "MOS jumps to &0287 twice during a reset, before and "
                    "after the filing system is initialised (carry clear, "
                    "then set)."))
annotator.label(0x008E, "level_count_copy", group="zero_page", description=(
    "Copy of levels_started that Coder leaves for game_entry."))

annotator.label(0x514C, "stones_command", description="\"LOAD STONES 6680\", for level 25.")
annotator.label(0x515D, "dun1_command", description="\"LOAD DUN1\".")
annotator.label(0x5167, "level_command", description=(
    "\"LOAD LEVEL nn 6B00\", with the digits written at level_command+10."))
annotator.label(0x5171, "level_command_digits", length=2)
annotator.stringcr(0x514C)
annotator.stringcr(0x515D)
annotator.stringcr(0x5167)

annotator.sub(0x5000, "coder_start", "Coder: load the game and the next level",
              "Run with *RUN CODER at the start of every level. Count the "
              "level, reload Dun1 (which contains this code, so the bytes "
              "being run are rewritten with identical ones), load the level "
              "file at &6B00 (level 25 comes from the end of Stones), copy "
              "one of the two &0400-&07FF images and the &08C0-&1FFF image "
              "into place, and enter the game.")
for addr, text in [
    (0x5000, "OSBYTE &C8: set the ESCAPE and BREAK effect..."),
    (0x5009, "VDU 6, 3: enable the screen, disable the printer"),
    (0x5013, "Cancel the BREAK intercept"),
    (0x5015, "...&0287 not a JMP, so BREAK now resets plainly"),
    (0x5018, "Count the level"),
    (0x501B, "Advance the ASCII level number..."),
    (0x504A, "VDU 23 commands that set up the 6845 for loading"),
    (0x5057, "VDU 21: disable the screen..."),
    (0x505C, "...and reload Dun1"),
    (0x5063, "Put the level number's digits in level_command"),
    (0x506F, "Leave the level count in level_count_copy for game_entry"),
    (0x5074, "level_number = levels started - 1 (game_entry counts it again)"),
    (0x507D, "Level 25?"),
    (0x5081, "Yes: load Stones, which ends with level 25..."),
    (0x5088, "...and skip the LEVELnn load"),
    (0x508B, "No: load LEVELnn"),
    (0x5092, "VDU 6: enable the screen"),
    (0x5097, "Copy to &0400..."),
    (0x509F, "...from &51B0 or &55B0"),
    (0x50A3, "Read the joystick's horizontal channel"),
    (0x50AA, "High byte &80 (a joystick at rest?)..."),
    (0x50AE, "...yes: copy the image with the joystick handler, at &55B0"),
    (0x50B4, "...no: copy the keyboard-only image at &51B0"),
]:
    annotator.c(addr, text)
annotator.c(0x5002, "...with X = 1: ESCAPE disabled")

annotator.label(0x0E14, "level_loop")
annotator.c(0x0D6B, "Recover the level count Coder left in level_count_copy")
annotator.c(0x0D6D, "...as level_number")
annotator.c(0x0D70, "...and level_bcd")
annotator.c(0x0D72, "...from the BCD copy Coder left in &8F")
annotator.c(0x0D75, "First level?")
annotator.c(0x0D7A, "Yes: the first level, so a new game")
annotator.c(0x0D7C, "No: carry on with the heroes as they were")
annotator.c(0x0D7F, "Yes: start a new game")
annotator.c(0x0E14, "Monster hit points = 6 + 2 x levels started...")
annotator.c(0x0E1E, "...and play the level")
annotator.c(0x0E45, "Next level: reset the machine and run Coder")
annotator.c(0x0EC3, "Wait up to &246 centiseconds for a key...")
annotator.c(0x0ECC, "...then restart the game by resetting the machine")

annotator.sub(0x1460, "next_level_by_reset", "Move on to the next level by resetting the machine",
              "Set the BREAK intercept to next_level_intercept and jump to "
              "the MOS 1.20 reset entry.")
annotator.c(0x1460, "BREAK intercept = JMP next_level_intercept...")
annotator.c(0x146F, "Reset the machine")
annotator.sub(0x144F, "restart_by_reset", "Restart the game by resetting the machine",
              "Set the BREAK intercept to restart_intercept and reset the "
              "machine.")
annotator.c(0x144F, "BREAK intercept = JMP restart_intercept...")
annotator.c(0x145E, "...and reset (always branches)")
annotator.entry(0x1472)
annotator.sub(0x1472, "restart_intercept", "BREAK intercept: reload the game",
              "Called by the MOS during the reset. On the second call (carry "
              "set) clear the screen and issue *DISC and *DUNJUNZ.",
              on_entry={"C": "set on the second call, after the filing "
                             "system is initialised"})
annotator.entry(0x15B5)
annotator.sub(0x15B5, "next_level_intercept", "BREAK intercept: run Coder for the next level",
              "Called by the MOS during the reset. On the second call (carry "
              "set) select MODE 2 and issue *DISC and *RUN CODER.",
              on_entry={"C": "set on the second call, after the filing "
                             "system is initialised"})
annotator.sub(0x1446, "check_level", "Check the level and set the text window",
              "Decrypt and check the level (Coder has already loaded it), and "
              "set the bottom row used by clear_text_area.",
               on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})

annotator.c(0x1ED7, "OSBYTE &7A: is a key pressed?")
annotator.c(0x1EDC, "P (internal key &37)?")
annotator.c(0x1EDE, "No: return")
annotator.c(0x1EE0, "Paused: wait for P to be released...")
annotator.c(0x1EE7, "...then pressed again")
annotator.c(0x1EEE, "Restart the frame timing")

for addr, text in [
    (0x0D78, "...only this one?"), (0x0D81, "...from new_game's second instruction"),
    (0x0E17, "...2 x levels started..."), (0x0E18, "...ready to add..."), (0x0E19, "...6"), (0x0E1B, "...for every monster on this level"),
    (0x0EC5, "...Y = &02: the time limit's high byte"), (0x0EC7, "...with OSBYTE &81, INKEY"),
    (0x1446, "Decrypt and check the level Coder loaded"),
    (0x1449, "Bottom row &18 for clear_text_area's window"),
    (0x144B, "...patched into clear_text_area's VDU 28"), (0x144E, "Return"),
    (0x1451, "...low byte of the intercept's JMP address"), (0x1454, "...high byte..."), (0x1456, "...into the JMP's high byte"), (0x1459, "...and a JMP opcode..."),
    (0x145B, "...at &0287 arms it for the reset"),
    (0x1462, "...at &0287 arms it..."), (0x1465, "...JMP to next_level_intercept: low byte..."), (0x1467, "...into the JMP's operand"), (0x146A, "...high byte..."),
    (0x146C, "...completes the jump"),
    (0x1472, "First call (before the filing system): nothing to do"),
    (0x1474, "Clear the screen"), (0x1476, "...VDU 12, so the reset shows a clear screen"),
    (0x1479, "*DISC"), (0x147B, "...high byte of the command"), (0x147D, "...back on the disc filing system"),
    (0x1480, "*DUNJUNZ: run the loader again"), (0x1482, "...high byte of the command"),
    (0x1484, "...the loader takes over; it never returns"), (0x1487, "Return to the MOS"),
    (0x15B1, "Clear the text area (Coder has shown the level number)"),
    (0x15B4, "Return"),
    (0x15B5, "First call (before the filing system): nothing to do"),
    (0x15B7, "MODE 2"), (0x15B9, "...VDU 22..."), (0x15BC, "...mode 2..."), (0x15BE, "...the game's mode, for Coder's screen"),
    (0x15C1, "*DISC"), (0x15C3, "...high byte of the command"), (0x15C5, "...back on the disc filing system"),
    (0x15C8, "*RUN CODER"), (0x15CA, "...high byte of the command"), (0x15CC, "...load the next level; it never returns"),
    (0x15CF, "Return to the MOS"),
    (0x1EE3, "...still P?"), (0x1EE5, "Yes: keep waiting"), (0x1EEA, "...P yet?"), (0x1EEC, "No: stay paused"),
    (0x1EF0, "...so play resumes with a full frame delay"), (0x1EF3, "Return"),
    (0x5004, "...Y = 0: X replaces the old setting"),
    (0x500B, "...VDU 6 lets text reach the screen..."), (0x500E, "...VDU 3..."), (0x5010, "...keeps output off any printer"),
    (0x501E, "Units digit a space (levels 1-9)?"),
    (0x5020, "Yes: advance the single digit"),
    (0x5022, "No: advance the units digit..."), (0x5023, "...add one to the units digit"),
    (0x5025, "...back into the filename digits"), (0x5028, "...past 9?"), (0x502A, "Still a digit: the number is ready"),
    (0x502C, "Yes: units 0 and carry into the tens"), (0x502E, "...units '0'..."),
    (0x5031, "...and one more tens"), (0x5034, "Always taken: the number is ready"),
    (0x5036, "Advance the single digit..."), (0x5039, "...to check it"),
    (0x503C, "...past 9?"), (0x503E, "1-9: the number is ready"),
    (0x5040, "Yes: level 10, \"10\""), (0x5042, "...tens '1'..."), (0x5045, "...units '0'..."),
    (0x5047, "...in place of the space"),
    (0x504C, "...the next byte of the 6845 set-up..."), (0x504F, "...to the VDU"), (0x5052, "...on to the next"), (0x5053, "...until all of loading_vdu is sent"),
    (0x5055, "More to send"),
    (0x5059, "...so the loads leave no trace on screen"), (0x505E, "...high byte of the command"), (0x5060, "...a fresh copy of the whole game image"),
    (0x5066, "...first digit..."), (0x5069, "...second digit, or a space..."), (0x506C, "...into the filename"),
    (0x5072, "...in &8E"),
    (0x5077, "...less one..."), (0x5078, "...for the 0-based level number"), (0x507A, "...as game_entry expects it"),
    (0x507F, "Not level 25: load its LEVELnn file"), (0x5083, "...high byte of the command"), (0x5085, "...level 25 is at the end of Stones"),
    (0x508D, "...high byte of the command"), (0x508F, "...*LOAD the level to &6B00"),
    (0x5094, "...so the game can print again"),
    (0x5099, "...destination pointer in coder_dest..."),
    (0x509B, "...high byte..."), (0x509D, "...destination &0400 complete"),
    (0x50A1, "...source pointer in coder_source"),
    (0x50A5, "...channel 1"),
    (0x50AC, "Not at rest: no joystick fitted"), (0x50B0, "...source &55B0"), (0x50B2, "Always taken: copy it"), (0x50B6, "...source &51B0"),
    (0x50B8, "Copy a kilobyte, up to &0800..."),
    (0x50BA, "...take the next byte..."), (0x50BC, "...into the game's &0400-&07FF"), (0x50BE, "Step the destination..."), (0x50C0, "...within the page"),
    (0x50C2, "...or on to the next page"), (0x50C4, "Step the source..."), (0x50C6, "...within the page"), (0x50C8, "...or on to the next page"),
    (0x50CA, "Destination page..."), (0x50CC, "...reached &08?"), (0x50CE, "No: copy more"),
    (0x50D0, "Joystick at rest again?"),
    (0x50D2, "...channel 1 again"), (0x50D7, "...high byte &80?"), (0x50D9, "No: set up screen for play"),
    (0x50DB, "Yes: point BYTEV at the joystick handler at &0780"),
    (0x50DD, "...low byte"), (0x50E0, "...high byte"), (0x50E2, "...so INKEY scans reach the joystick handler"),
    (0x50E5, "COLOUR 2"), (0x50E7, "...VDU 17..."), (0x50EA, "...text colour 2..."), (0x50EC, "...for the game's messages"),
    (0x50EF, "VDU commands to set up the screen for play"),
    (0x50F1, "...the next byte of the 6845 set-up..."), (0x50F4, "...to the VDU"), (0x50F7, "...on to the next"), (0x50F8, "...until all of play_vdu is sent"),
    (0x50FA, "More to send"),
    (0x50FC, "First level?"),
    (0x50FF, "...fewer than 2 levels started?"), (0x5101, "No: keep heroes"),
    (0x5103, "Yes: copy all of &3000-&473F to &08C0-&1FFF"),
    (0x5105, "...offset &0000: low byte..."), (0x5107, "...and high byte"), (0x5109, "Always taken: copy from the start"),
    (0x510B, "No: copy only &3440-&473F to &0D00-&1FFF, keeping the "
             "heroes' state in &08C0-&0CFF"),
    (0x510D, "...offset &0440: low byte..."), (0x510F, "...high byte &04..."), (0x5111, "...so &08C0-&0CFF is left as it is"),
    (0x5113, "Source = &3000 + offset..."), (0x5115, "...source low byte"),
    (0x5117, "...page &30..."), (0x5119, "...plus..."), (0x511A, "...the offset's high byte..."), (0x511C, "...source high byte"),
    (0x511E, "...destination = &08C0 + offset"), (0x5120, "...plus..."),
    (0x5121, "...the offset's low byte..."), (0x5123, "...destination low byte"), (0x5125, "...page &08..."), (0x5127, "...plus the offset's high byte and carry..."),
    (0x5129, "...destination high byte"),
    (0x512B, "Copy bytes up to &4740"),
    (0x512D, "...take the next byte..."), (0x512F, "...into the running game"), (0x5131, "Step the source..."), (0x5133, "...within the page"),
    (0x5135, "...or on to the next page"), (0x5137, "Step the destination..."), (0x5139, "...within the page"), (0x513B, "...or on to the next page"),
    (0x513D, "Source low byte..."), (0x513F, "...at &40?"), (0x5141, "No: copy more"), (0x5143, "...and high byte..."),
    (0x5145, "...at &47?"), (0x5147, "No: copy more"),
    (0x5149, "Start the game"),
]:
    annotator.c(addr, text)

# The handler exists only in the joystick image.
joystick_only = Annotator(d, "disc", lambda addr: [(low_joystick, "")])
joystick_only.sub(
    0x0780, "joystick_bytev", "BYTEV handler: read a joystick for the third player's keys",
    "Installed by Coder, in the joystick image of &0400-&07FF only. Answers "
    "OSBYTE &81 scans of the third player's keys from the analogue port: left "
    "(&98) and right (&97) from channel 1 at its extremes, up (&B9) and down "
    "(&99) from channel 2, and fire (&9D) from the fire buttons. Every other "
    "call goes to the MOS 1.20 OSBYTE routine at &E772 directly.",
    on_entry={"A": "OSBYTE number", "X": "OSBYTE X"},
    on_exit={"X": "&FF if the key is pressed, 0 if not"})
annotator.label(0xE772, "mos_osbyte_default", group="mos_internals",
                description="MOS 1.20 default OSBYTE routine, BYTEV's initial value.")
for addr, text in [
    (0x0780, "OSBYTE &81 (INKEY)?"),
    (0x0782, "No: pass it on"),
    (0x0784, "Left key (>)?"), (0x0786, "Yes: read the stick for left"),
    (0x0788, "Down key (<)?"), (0x078A, "Yes: read the stick for down"),
    (0x078C, "Up key (K)?"), (0x078E, "Yes: read the stick for up"),
    (0x0790, "Right key (?)?"), (0x0792, "Yes: read the stick for right"),
    (0x0794, "Fire key (SPACE)?"), (0x0796, "Yes: read the fire buttons"),
    (0x0798, "Another key: pass it on"),
    (0x079B, "Left: channel 1 high byte &FF?"),
    (0x079D, "...with OSBYTE &80, reading the ADC"), (0x07A2, "...high byte &FF: pushed fully left?"), (0x07A4, "No: not pressed"),
    (0x07A6, "Yes: pressed"), (0x07A8, "Return"),
    (0x07A9, "Right: channel 1 high byte 0?"),
    (0x07AB, "...with OSBYTE &80, reading the ADC"), (0x07B0, "...high byte 0: pushed fully right?"), (0x07B2, "No: not pressed"),
    (0x07B4, "Yes: pressed (Y = &FF)"), (0x07B5, "...X = Y = &FF, as INKEY reports a key held"), (0x07B7, "Return"),
    (0x07B8, "Up: channel 2 high byte &FF?"),
    (0x07BA, "...with OSBYTE &80, reading the ADC"), (0x07BF, "...high byte &FF: pushed fully up?"), (0x07C1, "No: not pressed"),
    (0x07C3, "Yes: pressed"), (0x07C5, "Return"),
    (0x07C6, "Down: channel 2 high byte 0?"),
    (0x07C8, "...with OSBYTE &80, reading the ADC"), (0x07CD, "...high byte 0: pushed fully down?"), (0x07CF, "No: not pressed"),
    (0x07D1, "Yes: pressed (Y = &FF)"), (0x07D2, "...X = Y = &FF, as INKEY reports a key held"), (0x07D4, "Return"),
    (0x07D5, "Fire: either fire button?"),
    (0x07D7, "...OSBYTE &80, X = 0: the fire buttons in X"), (0x07DC, "...the button bits..."), (0x07DD, "...bits 0-1: either button held?"),
    (0x07DF, "No: not pressed"),
    (0x07E1, "Yes: pressed"), (0x07E3, "...X = Y = &FF, as INKEY reports a key held"), (0x07E5, "Return"),
    (0x07E6, "Not pressed"), (0x07E8, "Return"),
    (0x07E9, "Pass the call on to the MOS 1.20 OSBYTE routine"),
]:
    joystick_only.c(addr, text)

# ---------------------------------------------------------------------------
# Coder's copies: its pointers (game zero page, used here before the game
# runs), the addresses it copies between, and its VDU tables.

for value, name, text in [
    (0x70, "coder_source", "Coder's copy source pointer (the game's plot_x, plot_y)"),
    (0x72, "coder_dest", "Coder's copy destination pointer (the game's sprite_width, sprite_height)"),
    (0x80, "core_offset", "Coder's offset into the game core, &0000 or &0440 (the game's ring_x, ring_y)"),
    (0x3000, "game_core_stored", "Where Dun1 stores the game core, &08C0-&1FFF at run time"),
    (0x4740, "game_core_stored_end", "The end of the stored game core"),
    (0x08C0, "game_core_start", "Where the game core runs"),
    (0x51B0, "keyboard_image_stored", "Where Dun1 stores the keyboard-only &0400-&07FF image"),
    (0x55B0, "joystick_image_stored", "Where Dun1 stores the &0400-&07FF image with the joystick handler"),
    (0x0400, "low_image_start", "Where either &0400-&07FF image runs"),
    (0x0800, "low_image_end", "The end of the &0400-&07FF image"),
]:
    d.constant(value, name, comment=text)
operand_exprs = [
    (0x5097 + 1, lo(sym("low_image_start"))), (0x509B + 1, hi(sym("low_image_start"))),
    (0x5099 + 1, sym("coder_dest")), (0x509D + 1, sym("coder_dest") + 1),
    (0x509F + 1, lo(sym("keyboard_image_stored"))), (0x50A1 + 1, sym("coder_source")),
    (0x50AE + 1, hi(sym("joystick_image_stored"))), (0x50B0 + 1, sym("coder_source") + 1),
    (0x50B4 + 1, hi(sym("keyboard_image_stored"))), (0x50B6 + 1, sym("coder_source") + 1),
    (0x50BA + 1, sym("coder_source")), (0x50BC + 1, sym("coder_dest")),
    (0x50BE + 1, sym("coder_dest")), (0x50C2 + 1, sym("coder_dest") + 1),
    (0x50C4 + 1, sym("coder_source")), (0x50C8 + 1, sym("coder_source") + 1),
    (0x50CA + 1, sym("coder_dest") + 1), (0x50CC + 1, hi(sym("low_image_end"))),
    (0x50DB + 1, lo(sym("joystick_bytev"))), (0x50E0 + 1, hi(sym("joystick_bytev"))),
    (0x5105 + 1, sym("core_offset")), (0x5107 + 1, sym("core_offset") + 1),
    (0x510D + 1, sym("core_offset")), (0x5111 + 1, sym("core_offset") + 1),
    (0x5113 + 1, sym("core_offset")), (0x5115 + 1, sym("coder_source")),
    (0x5117 + 1, hi(sym("game_core_stored"))), (0x511A + 1, sym("core_offset") + 1),
    (0x511C + 1, sym("coder_source") + 1), (0x511E + 1, lo(sym("game_core_start"))),
    (0x5121 + 1, sym("core_offset")), (0x5123 + 1, sym("coder_dest")),
    (0x5125 + 1, hi(sym("game_core_start"))), (0x5127 + 1, sym("core_offset") + 1),
    (0x5129 + 1, sym("coder_dest") + 1),
    (0x512D + 1, sym("coder_source")), (0x512F + 1, sym("coder_dest")),
    (0x5131 + 1, sym("coder_source")), (0x5135 + 1, sym("coder_source") + 1),
    (0x5137 + 1, sym("coder_dest")), (0x513B + 1, sym("coder_dest") + 1),
    (0x513D + 1, sym("coder_source")), (0x513F + 1, lo(sym("game_core_stored_end"))),
    (0x5143 + 1, sym("coder_source") + 1), (0x5145 + 1, hi(sym("game_core_stored_end"))),
    (0x505C + 1, lo(sym("dun1_command"))), (0x505E + 1, hi(sym("dun1_command"))),
    (0x5081 + 1, lo(sym("stones_command"))), (0x5083 + 1, hi(sym("stones_command"))),
    (0x508B + 1, lo(sym("level_command"))), (0x508D + 1, hi(sym("level_command"))),
    (0x5072 + 1, sym("level_count_copy")),
]
for operand_addr, expression in operand_exprs:
    d.expr(operand_addr, expression)
d.expr_label(0x08BE, "level_digits+1")
d.expr_label(0x5172, "level_command_digits+1")
for addr, name in [(0x5036, "advance_single_digit"), (0x504A, "set_up_6845_for_loading"),
                   (0x504C, "send_loading_vdu"), (0x508B, "load_level_file"),
                   (0x5092, "level_loaded"), (0x50B4, "use_keyboard_image"),
                   (0x50B8, "copy_low_image"), (0x50BA, "copy_low_byte"),
                   (0x50C4, "copy_low_next_source"), (0x50CA, "copy_low_check_end"),
                   (0x50E5, "set_up_screen_for_play"), (0x50F1, "send_play_vdu"),
                   (0x510B, "keep_heroes"), (0x5113, "copy_game_core"),
                   (0x512D, "copy_core_byte"), (0x5137, "copy_core_next_dest"),
                   (0x513D, "copy_core_check_end")]:
    annotator.label(addr, name)
annotator.banner(0x5179, "Coder's VDU tables",
                 "6845 set-ups sent with VDU 23,0: one while loading, one for play.")
annotator.label(0x5179, "loading_vdu", length=21, description=(
    "VDU 23,0,1,0 (no characters displayed: the screen goes blank) and "
    "VDU 23,0,10,&20 (no cursor), each padded to ten bytes, and one more "
    "byte sent."))
annotator.byte(0x5179, 10, cols=10)
annotator.byte(0x5183, 10, cols=10)
annotator.byte(0x518D, 1)
annotator.label(0x518E, "play_vdu", length=20, description=(
    "VDU 23,0,1,80 (80 characters displayed) and VDU 23,0,6,23 (23 rows "
    "displayed), for play."))
annotator.byte(0x518E, 10, cols=10)
annotator.byte(0x5198, 10, cols=10)
annotator.banner(0x51A2, "Unused", "Leftover bytes: stale code from an earlier assembly.")
annotator.label(0x51A2, "coder_leftovers")
annotator.byte(0x51A2, 0x51B0 - 0x51A2, cols=14)
for addr, text in [(0x5179, "VDU 23,0,1,0: 6845 register 1 = 0, no characters displayed"),
                   (0x5183, "VDU 23,0,10,&20: 6845 register 10 = &20, no cursor"),
                   (0x518D, "A further 0, sent too (21 bytes are sent)"),
                   (0x518E, "VDU 23,0,1,80: 6845 register 1 = 80 characters displayed"),
                   (0x5198, "VDU 23,0,6,23: 6845 register 6 = 23 character rows displayed")]:
    annotator.c(addr, text)
for operand_addr, name in [(0x504D, "loading_vdu"), (0x50F2, "play_vdu")]:
    d.expr(operand_addr, sym(name))
d.expr(0x5054, sym("play_vdu") - sym("loading_vdu"))
d.expr(0x50F9, sym("coder_leftovers") - sym("play_vdu"))

# ---------------------------------------------------------------------------
# The disc's own branch targets and patched operands.

annotator.sub(0x15B1, "show_level_number", "Clear the text area before a level",
              "Coder has already shown the level number, so this only clears "
              "the text area.",
              on_exit={"A": "corrupted"})
for addr, name in [(0x0D72, "store_level_bcd"), (0x0D7F, "start_new_game"),
                   (0x0E08, "new_game_reset_heroes"), (0x0E45, "to_next_level"),
                   (0x0E57, "play_this_level"), (0x146F, "reset_machine"),
                   (0x1624, "set_text_window_bottom"),
                   (0x1EE0, "wait_pause_release"), (0x1EE7, "wait_pause_press"),
                   (0x1EF3, "not_paused"), (0x1487, "restart_intercept_done"),
                   (0x15CF, "next_level_intercept_done")]:
    annotator.label(addr, name)
annotator.label(0x1625, "text_window_bottom", description=(
    "The bottom row of clear_text_area's text window, an operand that "
    "check_level sets to &18."))
for operand_addr, name in [(0x1450, "restart_intercept"), (0x1466, "next_level_intercept")]:
    annotator.expr(operand_addr, lo(sym(name)))
for operand_addr, name in [(0x1455, "restart_intercept"), (0x146B, "next_level_intercept")]:
    annotator.expr(operand_addr, hi(sym(name)))
for addr, name in [(0x079B, "joystick_left"), (0x07A9, "joystick_right"),
                   (0x07B8, "joystick_up"), (0x07C6, "joystick_down"),
                   (0x07D5, "joystick_fire"), (0x07E6, "joystick_not_pressed"),
                   (0x07E9, "joystick_pass_on")]:
    joystick_only.label(addr, name)
for operand_addr in (0x0785, 0x0789, 0x078D, 0x0791, 0x0795):
    joystick_only.inkey_number(operand_addr)


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

DISC_UNREFERENCED = [
    ('game_core', 0x08C0),
    ('game_core', 0x0D88),
    ('game_core', 0x0D8F),
    ('game_core', 0x0E21),
    ('game_core', 0x0E4C),
    ('game_core', 0x120F),
    ('game_core', 0x12D4),
    ('game_core', 0x148D),
    ('game_core', 0x1495),
    ('game_core', 0x149F),
    ('game_core', 0x15D0),
    ('game_core', 0x15DE),
    ('game_core', 0x15E4),
    ('game_core', 0x15EE),
    ('game_core', 0x15F4),
    ('game_core', 0x16D6),
    ('game_core', 0x1EF4),
    (None, 0x4740),
    ('low_keyboard', 0x06FC),
    ('low_keyboard', 0x0715),
    ('low_keyboard', 0x071A),
    ('low_keyboard', 0x0772),
    ('low_keyboard', 0x0776),
    ('low_keyboard', 0x0777),
    ('low_keyboard', 0x0778),
    ('low_keyboard', 0x0780),
    ('low_keyboard', 0x079B),
    ('low_keyboard', 0x07A9),
    ('low_keyboard', 0x07B8),
    ('low_keyboard', 0x07C6),
    ('low_keyboard', 0x07D5),
    ('low_keyboard', 0x07E6),
    ('low_keyboard', 0x07E9),
    ('low_keyboard', 0x07F4),
    ('low_joystick', 0x06FC),
    ('low_joystick', 0x0714),
    ('low_joystick', 0x071A),
    ('low_joystick', 0x077C),
    ('low_joystick', 0x07EC),
    ('low_joystick', 0x07F4),
    (None, 0x59B0),
]
DISC_TABLE_ENTRIES = [
    ('game_core', 0x0B2B),
    ('game_core', 0x0B2C),
    ('game_core', 0x0B2D),
    ('game_core', 0x0B2E),
    ('game_core', 0x0B8F),
    ('game_core', 0x0B91),
    ('game_core', 0x0B92),
    ('game_core', 0x0B93),
    ('game_core', 0x0B94),
    ('game_core', 0x0B95),
    ('game_core', 0x0B96),
    ('game_core', 0x0B97),
    ('game_core', 0x0B99),
    ('game_core', 0x0B9A),
    ('game_core', 0x0B9B),
    ('game_core', 0x0B9C),
    ('game_core', 0x0B9D),
    ('game_core', 0x0B9E),
    ('game_core', 0x0B9F),
    ('game_core', 0x0D19),
    ('game_core', 0x0D1B),
    ('game_core', 0x0D1C),
    ('game_core', 0x0D1D),
    ('game_core', 0x0D1F),
    ('game_core', 0x0D21),
    ('game_core', 0x0D22),
    ('game_core', 0x0D23),
    ('game_core', 0x0D91),
    ('game_core', 0x0D92),
    ('game_core', 0x0D93),
    ('game_core', 0x0DA1),
    ('game_core', 0x0DA2),
    ('game_core', 0x0DA3),
    ('game_core', 0x0DA4),
    ('game_core', 0x0DA5),
    ('game_core', 0x0DA6),
    ('game_core', 0x0DA7),
]
moves_by_name = {"game_core": game_core, "low_keyboard": low_keyboard,
                 "low_joystick": low_joystick, None: None}
for move_name, addr in DISC_UNREFERENCED:
    d.comment(addr, "Not referenced", align=dasmos.Align.INLINE, move=moves_by_name[move_name])
for move_name, addr in DISC_TABLE_ENTRIES:
    d.comment(addr, table_entry_comment(addr), align=dasmos.Align.INLINE,
              move=moves_by_name[move_name])

ir = d.disassemble()
asm_filepath.parent.mkdir(parents=True, exist_ok=True)
asm_filepath.write_text(str(ir.render(ExtraSavesBeebasmRenderer([CODER_FILE]))), encoding="utf-8")
json_filepath.write_text(str(ir.render("json")), encoding="utf-8")
