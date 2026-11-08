"""dasmos driver for the game code of the official Dunjunz disc (Model B side).

The two &0400 images are modelled as dasmos moves to the same run
address, and the game core as a move from &3000 to &08C0. The listing
saves Dun1 and, from the same bytes, the separate Coder file.

## How Dun1 is laid out

| In Dun1 | Runs at | Contents |
|---|---|---|
| &2000-&2FFF | in place | The exit animation, `drop_key`, `object_free_map`, doors and keys, sprites |
| &3000-&473F | &08C0-&1FFF | The game core, copied down by Coder |
| &5000-&51AF | in place | `coder_start` (Coder), its commands and VDU tables |
| &51B0-&55AF | &0400-&07FF | The keyboard-only image of page &04-&07 |
| &55B0-&59AF | &0400-&07FF | The same with `joystick_bytev` at &0780 |
| &6E80-&7FFF | in place | Heroes, missiles, objects, monsters, `workspace_template`, `wrch_handler` |

Coder is also a file of its own, `Coder` (&5000-&59AF), identical to
those bytes of Dun1.

## Memory map in play

| Range | Contents |
|---|---|
| &0000-&03FF | Zero page, stack and MOS workspace; the game's zero page is &70-&8F; &0287 is the MOS BREAK intercept |
| &0400-&07FF | One of the two images: score overflow, `decrypt_level`, the hero menu, `remove_absent_heroes` (and `joystick_bytev`) |
| &08B0-&08BF | Page &08 state that survives the reset between levels: `hero_score_ten_thousands`, `hero_absent`, `levels_started`, `level_digits` |
| &08C0-&0CFF | `plot_sprite`, `screen_address`, per-hero tables and scores, `room_walls` at &0C00; copied only for the first level, so the heroes carry over |
| &0D00-&1FFF | Page &0D's per-level workspace, `game_entry`, the level loop, the status panel, the victory sequence, `start_level`, `check_level`, the BREAK intercepts, the font, sprites, `update_game`, `play_level` |
| &2000-&2FFF | The exit animation, doors and keys, sprites |
| &3000-&6E7F | Screen (25 character rows in play); Dun1's stored copies lie here until the screen is cleared |
| &6B00-&6DAF | The level file, in the screen's bottom rows |
| &6E80-&7FFF | Heroes, missiles, objects, monsters, `workspace_template`, `wrch_handler` |

## From power-on to play

1. Booted on a Model B, the other side's BOOT asks for the disc to be
   turned over and runs `*DUNJUNZ` (its own listing). That sets page &08
   (`levels_started` 0, `level_digits` "0 ", every hero playing), shows
   the title screen, arms the BREAK intercept with a JMP to &15B5 and runs
   `*CODER` with VDU output disabled.
2. `coder_start` (&5000) disables ESCAPE, cancels the BREAK intercept,
   counts the level in `levels_started` and `level_digits`, and blanks
   the display. It `*LOAD`s Dun1 (over itself), then `LEVELnn` to &6B00,
   or for level 25 `STONES`, whose end is level 25. It copies the
   keyboard image, or the joystick image if ADC channel 1 reads &80, to
   &0400, and points BYTEV at `joystick_bytev` if a second read says so.
   It shows 23 rows, copies the game core (from &0D00 only, after the
   first level) and jumps to `game_entry` at &0D31, leaving
   `levels_started` in `level_count_copy` (&8E).
3. `game_entry` sets the bell, saves WRCHV in `saved_wrchv` and points it
   at `wrch_handler`, and sets `level_number` from &8E. On the first level
   it resets the heroes and runs `hero_menu`; on later ones it goes
   straight to `level_loop`.
4. `level_loop` sets `monster_start_hit_points` from `levels_started` and
   calls `start_level`, which runs steps 5 to 7.
5. `clear_text_for_level` clears rows 0-22 only, so the level file in rows
   23-24 survives.
6. `check_level` decrypts the level and checks it against
   `level_checksums` (`decrypt_level` resets the machine on a mismatch),
   then widens `clear_text_area`'s window to all 25 rows.
7. `unpack_level`, `reset_workspace` and `reset_monsters` set up play; the
   screen is cleared and set to 25 rows, and `draw_view_frames` draws the
   frames and the four views.
8. `draw_status_panel` and `remove_absent_heroes` finish the screen, and
   `play_level` runs the level until no hero is left in play.
9. Every dead hero gets their starting attributes back. If any hero
   survived, `next_level_by_reset` arms the BREAK intercept with a JMP to
   `next_level_intercept` and resets the machine; on the intercept's
   second call, once the filing system is back, it selects MODE 2 and runs
   `*CODER` again, which loads the next level (step 2). If all four died,
   the game-over message is shown for up to 5.8 seconds or until a key,
   and `restart_by_reset` resets the machine into `restart_intercept`,
   which runs `*DUNJUNZ` (step 1). A hero reaching the Chalice on level 25
   is caught by `check_for_victory`, which plays `victory_sequence`,
   prints the ending message, waits for a key and resets the machine
   through the RESET vector.
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
d.set_file_header(
    title="Dunjunz, official disc (Model B side): the game",
    description=("Annotated disassembly of the game file `Dun1`, which contains "
                 "the level loader `Coder`.\n\n" + __doc__.split("\n\n", 2)[2]),
)

game_core =d.add_move(0x08C0, 0x3000, 0x1740, name="game_core")
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
    "The level being played, 1-25, counted as levels started in this game. "
    "It lives in page &08, which survives the reset between levels: "
    "*DUNJUNZ sets it to 0 for a new game and coder_start adds one before "
    "loading each level. coder_start also reads it to choose Stones for "
    "level 25, to copy the whole game core only for level 1, and to pass "
    "it to game_entry in level_count_copy; game_entry and level_loop read "
    "it for the first-level test and the monsters' hit points."))
annotator.label(0x08BD, "level_digits", length=2, group="disc_state",
                description=(
                    "The level number as ASCII digits for the level's "
                    "filename: one digit and a space (\"1 \"-\"9 \"), or two "
                    "digits (\"10\"-\"25\"). *DUNJUNZ sets \"0 \"; "
                    "coder_start advances it before each level, in page "
                    "&08 across the reset, and copies it into "
                    "level_command_digits."))
annotator.region(0x0287, "os_break_intercept", (0, 2), group="os_workspace",
                 access="w", description=(
                    "MOS BREAK intercept: if &0287 holds a JMP opcode the "
                    "MOS jumps to &0287 twice during a reset, before and "
                    "after the filing system is initialised (carry clear, "
                    "then set)."))
annotator.label(0x008E, "level_count_copy", group="zero_page", description=(
    "Copy of levels_started that coder_start leaves for game_entry, which "
    "makes it level_number. In play the game uses &8E for its own "
    "victory_steps_left."))

annotator.banner(0x514C, "Coder's commands",
                 "Three OSCLI command lines, each ended by a CR.")
annotator.label(0x514C, "stones_command", description=(
    "\"LOAD STONES 6680\": for level 25, load Stones at &6680, so that its "
    "last &2B0 bytes, level 25, land at &6B00."))
annotator.label(0x515D, "dun1_command", description=(
    "\"LOAD DUN1\": reload the whole game, &2000-&7FFF, at its own load "
    "address."))
annotator.label(0x5167, "level_command", description=(
    "\"LOAD LEVELnn 6B00\", for levels 1-24. coder_start writes the "
    "digits at level_command_digits (level_command+10) after reloading "
    "Dun1; DFS ignores the case, so this loads Level1-Level24."))
annotator.c(0x514C, "*LOAD STONES 6680, for level 25")
annotator.c(0x515D, "*LOAD DUN1")
annotator.c(0x5167, "*LOAD LEVELnn 6B00, the digits at +10")
annotator.label(0x5171, "level_command_digits", length=2)
annotator.stringcr(0x514C)
annotator.stringcr(0x515D)
annotator.stringcr(0x5167)

annotator.sub(0x5000, "coder_start", "Coder: load the game and the next level",
              "Build the game afresh from disc for the next level and start "
              "it. Run once per level as *CODER: for the first level by "
              "*DUNJUNZ, and for each later one by next_level_intercept "
              "during the reset that ends the level before. It never "
              "returns.\n\n"
              "Count the level: levels_started and level_digits, the "
              "filename's number (\"1 \" to \"25\"), live in page &08, which "
              "the reset leaves alone and *DUNJUNZ resets for a new game. "
              "Blank the display (6845 register 1 = 0) and silence the VDU, "
              "then *LOAD DUN1, which holds this code, so the bytes being run "
              "are rewritten with identical ones; the reload also restores "
              "level_command, so the digits go into it only afterwards. Load "
              "the level file to &6B00, which is screen memory: LEVELnn, or "
              "for level 25 STONES at &6680, whose last &2B0 bytes are level "
              "25.\n\n"
              "Copy one of the two &0400-&07FF images into place: the one "
              "with joystick_bytev only if ADC channel 1 reads with a high "
              "byte of exactly &80. The channel is read again to decide "
              "whether to point BYTEV at &0780, so if the two reads disagree "
              "the image and the vector do not match: the joystick image "
              "with the MOS's BYTEV, or BYTEV at the keyboard image's &0780, "
              "which holds zeros (BRK). Show 80 columns and 23 "
              "rows again (the level file's rows 23-24 stay hidden), then "
              "copy the game core: all of &3000-&473F to &08C0-&1FFF for the "
              "first level, but only from &3440, to &0D00-&1FFF, for later "
              "ones, so that the heroes' scores and attributes in "
              "&08C0-&0CFF carry over. Leave levels_started in &8E for "
              "game_entry, and jump to it.\n\n"
              "Coder uses the game's zero page &70-&73 and &80-&81 for its "
              "pointers; nothing there is needed until game_entry.")
annotator.block(0x5000, "Set up the machine: ESCAPE off, VDU output on to the "
                        "screen only, and the BREAK intercept cancelled.")
annotator.block(0x5018, "Count the level and advance its filename digits in "
                        "page &08: \"0 \" to \"9 \" step by the single digit, "
                        "then \"10\" on in two.")
annotator.block(0x504A, "Blank the display and silence the VDU, then reload "
                        "Dun1 and the level file.")
annotator.block(0x5092, "Turn the VDU back on and copy the keyboard or "
                        "joystick image of &0400-&07FF into place.")
annotator.block(0x50D0, "Point BYTEV at the joystick handler if channel 1 "
                        "still reads &80.")
annotator.block(0x50E5, "Set the text colour and show the display, 23 rows.")
annotator.block(0x50FC, "Copy the game core down, keeping &08C0-&0CFF after "
                        "the first level, and start the game.")
for addr, text in [
    (0x5000, "Disable ESCAPE for the whole game..."),
    (0x5009, "VDU 6, 3: text to the screen, none to a printer"),
    (0x5013, "Cancel the BREAK intercept *DUNJUNZ armed..."),
    (0x5015, "...so a BREAK now resets plainly until a level ends"),
    (0x5018, "One more level started (1 for the first)"),
    (0x501B, "Advance level_digits, the filename's level number..."),
    (0x504A, "Blank the display while the files load"),
    (0x5057, "VDU 21: stop all VDU output..."),
    (0x505C, "Reload Dun1: a fresh game, and this code over itself"),
    (0x5063, "Copy the level's digits into level_command"),
    (0x506F, "Hand levels_started to game_entry in &8E..."),
    (0x5074, "A = levels started - 1, to pick the level's file"),
    (0x507D, "Levels started 25: the last level?"),
    (0x5081, "Yes: *LOAD STONES 6680, whose end is level 25..."),
    (0x5088, "...and skip the LEVELnn load"),
    (0x508B, "No: *LOAD LEVELnn 6B00"),
    (0x5092, "VDU 6: VDU output on again"),
    (0x5097, "Copy one &0400-&07FF image into place..."),
    (0x509F, "...source low byte &B0, for &51B0 or &55B0"),
    (0x50A3, "Is a joystick there? Read ADC channel 1..."),
    (0x50AA, "...high byte exactly &80?"),
    (0x50AE, "Yes: the image with the joystick handler, &55B0"),
    (0x50B4, "No: the keyboard-only image, &51B0"),
]:
    annotator.c(addr, text)
annotator.c(0x5002, "...X = 1: ESCAPE disabled, BREAK as normal")

annotator.label(0x0E14, "level_loop")
annotator.block(0x0D6B, "Take the level number from Coder, and start a new "
                        "game on the first level, or go straight to the "
                        "level on later ones, the heroes having carried "
                        "over in &08C0-&0CFF.")
annotator.block(0x0E14, "The level loop: Coder has already loaded this "
                        "level, so set the monsters' strength and start it. "
                        "The leftover code after the JMP, which would count "
                        "the level and build a filename, is never run.")
annotator.c(0x0D6B, "levels_started, which Coder left in &8E...")
annotator.c(0x0D6D, "...is level_number, 1-25, for the checksum and Chalice")
annotator.c(0x0D70, "Copy &8F, which Coder does not set...")
annotator.c(0x0D72, "...into level_bcd, which nothing here reads")
annotator.c(0x0D75, "First level of a game?")
annotator.c(0x0D7A, "Yes: reset the heroes and run the hero menu")
annotator.c(0x0D7C, "No: the heroes carry over; straight to the level")
annotator.c(0x0D7F, "A = 0, for new_game_reset_heroes' first hero")
annotator.c(0x0E14, "Monster hit points = 6 + 2 x levels started...")
annotator.c(0x0E1E, "Start the level Coder has loaded")
annotator.c(0x0E45, "A hero survived: reset the machine and run Coder")
annotator.c(0x0EC3, "Game over: wait up to &246 cs (5.8 s) for a key...")
annotator.c(0x0ECC, "...then reset and reload the game with *DUNJUNZ")

annotator.sub(0x1460, "next_level_by_reset", "Move on to the next level by resetting the machine",
              "End a level that at least one hero survived, by having the "
              "machine reset itself into Coder. Reached through "
              "to_next_level, after level_loop's end has given the dead "
              "heroes their starting attributes back. Arm the MOS BREAK "
              "intercept (&0287-&0289) with a JMP to next_level_intercept "
              "and jump to the MOS 1.20 reset entry at &D9CD; the MOS calls "
              "the intercept during the reset, and its second call runs "
              "*CODER, which reloads the game and the next level. Page &08 "
              "(levels_started, level_digits and the menu's tables) and "
              "&08C0-&0CFF (the heroes' attributes and scores) survive the "
              "reset and Coder's copy. Never returns.")
annotator.c(0x1460, "Arm the BREAK intercept: a JMP opcode...")
annotator.c(0x146F, "Reset: the MOS calls the intercept on the way")
annotator.sub(0x144F, "restart_by_reset", "Restart the game by resetting the machine",
              "End the game after all four heroes have died. Reached from "
              "level_loop's end once the game-over message has been shown "
              "for up to 5.8 seconds. Arm the BREAK intercept with a JMP to "
              "restart_intercept and branch to reset_machine, so that the "
              "reset runs *DUNJUNZ, which resets page &08, shows the title "
              "screen and runs Coder for a new game. Never returns.")
annotator.c(0x144F, "Arm the BREAK intercept: JMP restart_intercept...")
annotator.c(0x145E, "...and reset (always taken: A = &4C)")
annotator.entry(0x1472)
annotator.sub(0x1472, "restart_intercept", "BREAK intercept: reload the game",
              "Called twice by the MOS during the reset that restart_by_reset "
              "makes. The first call (carry clear) comes before the filing "
              "system is initialised and does nothing. On the second, clear "
              "the screen of the game-over message, select the disc filing "
              "system and *DUNJUNZ, which takes over and never returns.",
              on_entry={"C": "set on the second call, after the filing "
                             "system is initialised"})
annotator.entry(0x15B5)
annotator.sub(0x15B5, "next_level_intercept", "BREAK intercept: run Coder for the next level",
              "Called twice by the MOS during the reset that "
              "next_level_by_reset makes. The first call (carry clear) comes "
              "before the filing system is initialised and does nothing. On "
              "the second, select MODE 2, the disc filing system and *RUN "
              "CODER, which loads the next level and never returns. "
              "*DUNJUNZ also points the intercept at &15B5 while *CODER "
              "loads, so a BREAK then lands here too, but &15B5 holds this "
              "routine only if Coder has copied the game core there since "
              "power-on.",
              on_entry={"C": "set on the second call, after the filing "
                             "system is initialised"})
annotator.sub(0x1446, "check_level", "Check the level and set the text window",
              "Make the level Coder loaded ready for unpack_level. Called by "
              "start_level after clear_text_for_level: Coder has already put the "
              "file at &6B00-&6DAF. Decrypt it and check its checksum "
              "(decrypt_level resets the machine on a mismatch).\n\n"
              "Then set the bottom row of clear_text_area's text window from "
              "22 to 24. Dun1 stores it as 22, so that "
              "clear_text_for_level's clear stops at row 22, above the level "
              "file in rows 23-24; from here on the whole screen is cleared. "
              "Coder reloads Dun1 for each level, so the window is 22 again "
              "at the next level's start.",
               on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})

annotator.block(0x1ED7, "The pause key, last in each frame's update. OSBYTE &7A "
                        "reports a single key, so P is seen only when the "
                        "scan finds it rather than another key held with "
                        "it. Play resumes as soon as P is pressed again; if "
                        "it is still held at the next frame's check, the "
                        "game pauses again.")
annotator.c(0x1ED7, "OSBYTE &7A: which key is held, if any?")
annotator.c(0x1EDC, "P (internal key &37)?")
annotator.c(0x1EDE, "No: on with play")
annotator.c(0x1EE0, "Paused: wait for P to be released...")
annotator.c(0x1EE7, "...then pressed again")
annotator.c(0x1EEE, "Next frame in 17 vsyncs, not the usual 3...")

for addr, text in [
    (0x0D78, "...levels_started 1, the first level of a game?"), (0x0D81, "...past the stores that zero the level counts"),
    (0x0E17, "...2 x levels started..."), (0x0E18, "...ready to add..."), (0x0E19, "...+ 6: 8 on level 1, 56 on level 25"), (0x0E1B, "...for every monster on this level"),
    (0x0EC5, "...Y = &02: the time limit's high byte"), (0x0EC7, "...OSBYTE &81: INKEY with a time limit"),
    (0x1446, "Decrypt and check the level Coder loaded at &6B00"),
    (0x1449, "Bottom row 24 for clear_text_area's window..."),
    (0x144B, "...over the &16 in its VDU 28: the full 25 rows"),
    (0x144E, "Return to start_level: the level is ready to unpack"),
    (0x1451, "...address low byte into &0288..."), (0x1454, "...then the routine's page..."),
    (0x1456, "...into &0289, the JMP's high byte"), (0x1459, "...then the JMP opcode..."),
    (0x145B, "...into &0287, which arms the intercept"),
    (0x1462, "...into &0287, the intercept's first byte..."), (0x1465, "...JMP to next_level_intercept: low byte..."),
    (0x1467, "...into &0288, the JMP's low byte"), (0x146A, "...then the routine's page..."),
    (0x146C, "...into &0289: the intercept is armed"),
    (0x1472, "First call (before the filing system): nothing to do"),
    (0x1474, "VDU 12: clear the screen..."), (0x1476, "...of the game-over message"),
    (0x1479, "*DISC: X, Y = &1489, the \"DISC\" after the C..."), (0x147B, "...high byte of the command"),
    (0x147D, "...so that *DUNJUNZ comes from the disc"),
    (0x1480, "*DUNJUNZ (at &148E): load the game afresh..."), (0x1482, "...high byte of the command"),
    (0x1484, "...which takes over and never returns"), (0x1487, "Return to the MOS"),
    (0x15B1, "Clear rows 0-22: the level file in rows 23-24 is kept"),
    (0x15B4, "Return to start_level, which checks the level next"),
    (0x15B5, "First call (before the filing system): nothing to do"),
    (0x15B7, "MODE 2, the game's mode, for Coder..."), (0x15B9, "...send VDU 22, select a mode..."),
    (0x15BC, "...then the mode number, 2..."), (0x15BE, "...sent: MODE 2 is selected"),
    (0x15C1, "*DISC: X, Y = &15E0, \"DISC\"..."), (0x15C3, "...high byte of the command"),
    (0x15C5, "...so that Coder comes from the disc"),
    (0x15C8, "*RUN CODER (at &15E5): the game and next level..."), (0x15CA, "...high byte of the command"),
    (0x15CC, "...which never returns"),
    (0x15CF, "Return to the MOS"),
    (0x1EE3, "...is P still the key held?"), (0x1EE5, "Yes: keep waiting"),
    (0x1EEA, "...is P held again yet?"), (0x1EEC, "No: stay paused"),
    (0x1EF0, "...about a third of a second before play resumes"),
    (0x1EF3, "Return to play_level: this frame's update is done"),
    (0x5004, "...Y = 0: X replaces the old setting"),
    (0x500B, "...VDU 6 undoes the VDU 21 *DUNJUNZ sends..."),
    (0x500E, "...then 3 (VDU 3: printer off)..."), (0x5010, "...keeps output off any printer"),
    (0x501E, "Second digit a space (levels 1-9)?"),
    (0x5020, "Yes: advance the single digit"),
    (0x5022, "No: advance the units digit..."), (0x5023, "...+1, the next units digit"),
    (0x5025, "...back into level_digits"), (0x5028, "...past '9': does it carry?"), (0x502A, "No: the number is ready"),
    (0x502C, "Yes: units '0' and carry into the tens"), (0x502E, "...units digit back to '0'..."),
    (0x5031, "...and one more tens"), (0x5034, "Always taken: the number is ready"),
    (0x5036, "Advance the single digit ('0 ' becomes '1 ')..."), (0x5039, "...to check it"),
    (0x503C, "...past '9': level 10, two digits now?"), (0x503E, "No: levels 1-9 are ready"),
    (0x5040, "Yes: level 10, \"10\""), (0x5042, "...'1' as the tens digit..."),
    (0x5045, "...and '0' as the units digit..."),
    (0x5047, "...in place of the space"),
    (0x504C, "...the next byte of loading_vdu..."), (0x504F, "...to the VDU"), (0x5052, "...on to the next"), (0x5053, "...until all 21 are sent"),
    (0x5055, "More to send"),
    (0x5059, "...so the *LOADs print nothing"), (0x505E, "...high byte of the command"), (0x5060, "...*LOAD DUN1 to &2000-&7FFF"),
    (0x5066, "...the tens digit, or the only one..."), (0x5069, "...second digit, or a space..."), (0x506C, "...at level_command+10"),
    (0x5072, "...which game_entry makes level_number"),
    (0x5077, "...minus 1 (carry set for the subtract)..."), (0x5078, "...24 for level 25"), (0x507A, "...in level_number (the core copy overwrites it)"),
    (0x507F, "Not level 25: load its LEVELnn file"), (0x5083, "...high byte of the command"), (0x5085, "...putting level 25 at &6B00"),
    (0x508D, "...high byte of the command"), (0x508F, "...to &6B00, where check_level decrypts it"),
    (0x5094, "...so the game's text can appear"),
    (0x5099, "...destination pointer in coder_dest..."),
    (0x509B, "...high byte &04, the image's first page..."), (0x509D, "...destination &0400 complete"),
    (0x50A1, "...source pointer in coder_source"),
    (0x50A5, "...channel 1: the joystick's left-right axis"),
    (0x50AC, "Not &80: use the keyboard-only image"),
    (0x50B0, "...source page &55: copy from &55B0"), (0x50B2, "Always taken: copy it"),
    (0x50B6, "...source page &51: copy from &51B0"),
    (0x50B8, "Copy a kilobyte, up to &0800..."),
    (0x50BA, "...take the next byte..."), (0x50BC, "...into the game's &0400-&07FF"), (0x50BE, "Step the destination..."), (0x50C0, "...within the page"),
    (0x50C2, "...or on to the next page"), (0x50C4, "Step the source..."), (0x50C6, "...within the page"), (0x50C8, "...or on to the next page"),
    (0x50CA, "Stop when the destination reaches &0800..."),
    (0x50CC, "...page &08: past the image's end?"), (0x50CE, "No: copy more"),
    (0x50D0, "Read channel 1 again: install the handler?"),
    (0x50D2, "...channel 1 again"), (0x50D7, "...high byte exactly &80?"), (0x50D9, "No: keep the MOS's BYTEV"),
    (0x50DB, "Yes: point BYTEV at joystick_bytev (&0780)"),
    (0x50DD, "...the handler's low byte into BYTEV..."), (0x50E0, "...and its page, &07..."),
    (0x50E2, "...so the Barbarian's key scans read the joystick"),
    (0x50E5, "COLOUR 2: VDU 17, then the colour..."), (0x50E7, "...send VDU 17, set the text colour..."), (0x50EA, "...text colour 2..."), (0x50EC, "...for the game's messages"),
    (0x50EF, "Show the display again, 23 rows, for play"),
    (0x50F1, "...the next byte of play_vdu..."), (0x50F4, "...to the VDU"), (0x50F7, "...on to the next"), (0x50F8, "...until all 20 are sent"),
    (0x50FA, "More to send"),
    (0x50FC, "First level of a game?"),
    (0x50FF, "...fewer than 2 levels started?"), (0x5101, "No: keep the heroes"),
    (0x5103, "Yes: copy all of &3000-&473F to &08C0-&1FFF"),
    (0x5105, "...offset &0000: low byte..."), (0x5107, "...and high byte: no offset"), (0x5109, "Always taken: copy from the start"),
    (0x510B, "No: copy &3440-&473F to &0D00, keeping the heroes' state"),
    (0x510D, "...offset &0440: low byte..."), (0x510F, "...high byte &04..."), (0x5111, "...so &08C0-&0CFF is left as it is"),
    (0x5113, "Source = &3000 + offset..."), (0x5115, "...source low byte"),
    (0x5117, "...page &30, where Dun1 stores the core..."), (0x5119, "...(carry clear for the add)..."),
    (0x511A, "...plus the offset's high byte..."), (0x511C, "...source high byte"),
    (0x511E, "...destination = &08C0 + offset"), (0x5120, "...(carry clear for the add)..."),
    (0x5121, "...the offset's low byte..."), (0x5123, "...destination low byte"),
    (0x5125, "...page &08, where the core runs..."), (0x5127, "...plus the offset's high byte and carry..."),
    (0x5129, "...destination high byte"),
    (0x512B, "Copy bytes up to &4740"),
    (0x512D, "...take the next byte..."), (0x512F, "...into the running game"), (0x5131, "Step the source..."), (0x5133, "...within the page"),
    (0x5135, "...or on to the next page"), (0x5137, "Step the destination..."), (0x5139, "...within the page"), (0x513B, "...or on to the next page"),
    (0x513D, "Stop at the core's end, &4740: source low byte..."),
    (0x513F, "...&40, the end's low byte?"), (0x5141, "No: copy more"),
    (0x5143, "...then the source's page..."),
    (0x5145, "...&47: the source at &4740, the core's end?"), (0x5147, "No: copy more"),
    (0x5149, "Enter the game at game_entry"),
]:
    annotator.c(addr, text)

# The handler exists only in the joystick image.
joystick_only = Annotator(d, "disc", lambda addr: [(low_joystick, "")])
joystick_only.sub(
    0x0780, "joystick_bytev", "BYTEV handler: read a joystick for the Barbarian's keys",
    "Installed on BYTEV by Coder, in the joystick image of &0400-&07FF "
    "only. Answers test_key's OSBYTE &81 scans of the Barbarian's (hero "
    "2's) keys from the analogue port, so that a joystick plays the "
    "Barbarian: left (. &98) and right (/ &97) from channel 1, up (K &B9) "
    "and down (, &99) from channel 2, and fire (SPACE &9D) from either fire "
    "button. A direction counts only at the stick's extreme, when the "
    "channel's high byte is &FF or 0, so the stick works as a switch. Every "
    "other call goes to the MOS 1.20 OSBYTE routine at &E772 directly, "
    "skipping any other BYTEV claimant. The handler's own OSBYTE &80 reads "
    "come back through BYTEV into it and are passed on the same way. The "
    "Barbarian's five keys are never scanned while it is installed, so "
    "that hero can be played only with the joystick. test_key counts a key "
    "as held only when X and Y both come back &FF, so a not-pressed answer "
    "needs only X = 0.",
    on_entry={"A": "OSBYTE number", "X": "OSBYTE X"},
    on_exit={"X": "&FF if the key is pressed, 0 if not",
             "Y": "&FF if the key is pressed"})
annotator.label(0xE772, "mos_osbyte_default", group="mos_internals",
                description="MOS 1.20 default OSBYTE routine, BYTEV's initial value.")
for addr, text in [
    (0x0780, "OSBYTE &81 (INKEY)?"),
    (0x0782, "No: let the MOS handle it"),
    (0x0784, "The Barbarian's left key (.)?"), (0x0786, "Yes: read the stick for left"),
    (0x0788, "The Barbarian's down key (,)?"), (0x078A, "Yes: read the stick for down"),
    (0x078C, "The Barbarian's up key (K)?"), (0x078E, "Yes: read the stick for up"),
    (0x0790, "The Barbarian's right key (/)?"), (0x0792, "Yes: read the stick for right"),
    (0x0794, "The Barbarian's fire key (SPACE)?"), (0x0796, "Yes: read the fire buttons"),
    (0x0798, "Any other key: scan the keyboard as usual"),
    (0x079B, "Left: channel 1 high byte &FF?"),
    (0x079D, "...with OSBYTE &80, reading the ADC"), (0x07A2, "...high byte &FF: pushed fully left?"), (0x07A4, "No: not pressed"),
    (0x07A6, "Yes: pressed (Y is already &FF)"), (0x07A8, "Return X = Y = &FF: left is pressed"),
    (0x07A9, "Right: channel 1 high byte 0?"),
    (0x07AB, "...with OSBYTE &80, reading the ADC"), (0x07B0, "...high byte 0: pushed fully right?"), (0x07B2, "No: not pressed"),
    (0x07B4, "Yes: pressed (Y = &FF)"), (0x07B5, "...X = Y = &FF, as INKEY reports a key held"),
    (0x07B7, "Return X = Y = &FF: right is pressed"),
    (0x07B8, "Up: channel 2 high byte &FF?"),
    (0x07BA, "...with OSBYTE &80, reading the ADC"), (0x07BF, "...high byte &FF: pushed fully up?"), (0x07C1, "No: not pressed"),
    (0x07C3, "Yes: pressed (Y is already &FF)"), (0x07C5, "Return X = Y = &FF: up is pressed"),
    (0x07C6, "Down: channel 2 high byte 0?"),
    (0x07C8, "...with OSBYTE &80, reading the ADC"), (0x07CD, "...high byte 0: pushed fully down?"), (0x07CF, "No: not pressed"),
    (0x07D1, "Yes: pressed (Y = &FF)"), (0x07D2, "...X = Y = &FF, as INKEY reports a key held"),
    (0x07D4, "Return X = Y = &FF: down is pressed"),
    (0x07D5, "Fire: either fire button?"),
    (0x07D7, "...OSBYTE &80, X = 0: the fire buttons in X"), (0x07DC, "...the button bits..."), (0x07DD, "...bits 0-1: either button held?"),
    (0x07DF, "No: not pressed"),
    (0x07E1, "Yes: X = &FF, fire pressed..."), (0x07E3, "...X = Y = &FF, as INKEY reports a key held"),
    (0x07E5, "Return X = Y = &FF: fire is pressed"),
    (0x07E6, "Not pressed: X = 0, which test_key reads as not held"),
    (0x07E8, "Return X = 0: the key is not pressed"),
    (0x07E9, "Not INKEY: on to the MOS 1.20 OSBYTE routine"),
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
annotator.expr(0x0D6B + 1, sym("level_count_copy"))
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

annotator.sub(0x15B1, "clear_text_for_level", "Clear the text area before a level",
              "start_level's first call. Only clears the screen: no level number is shown, and "
              "level_number is not counted here (game_entry sets it from "
              "levels_started). At this point clear_text_area's window still "
              "ends at row 22, as Dun1 stores it, so the level file Coder "
              "loaded into rows 23-24 is kept for check_level; Dun1's other "
              "stored bytes in rows 0-22 are wiped.",
              on_exit={"A": "corrupted"})
for addr, name in [(0x0D72, "store_level_bcd"), (0x0D7F, "start_new_game"),
                   (0x0E08, "new_game_reset_heroes"), (0x0E45, "to_next_level"),
                   (0x0E57, "play_this_level"), (0x146F, "reset_machine"),
                   (0x1624, "set_text_window_bottom"),
                   (0x1EE0, "wait_pause_release"), (0x1EE7, "wait_pause_press"),
                   (0x1EF3, "not_paused"), (0x1487, "restart_intercept_done"),
                   (0x15CF, "next_level_intercept_done")]:
    annotator.label(addr, name)
annotator.banner(0x1488, "restart_intercept's commands",
                 "The *DISC and *DUNJUNZ command lines, read from &1489 and "
                 "&148E (the C before DISC is not read). After them come "
                 "stale bytes: STA &149C, LDA #&FF, JSR &3000, JMP &0450, "
                 "the end of a level loader that calls FILEV's routine "
                 "through a patched JSR.")
annotator.banner(0x15D0, "Unused, then next_level_intercept's commands",
                 "Stale bytes, never run: &15D2-&15D8 repeat "
                 "next_level_intercept's LDX #&E5, LDY #&15, JSR OSCLI, and "
                 "an RTS and \"ODER\" follow. Then the *DISC and *RUN CODER "
                 "command lines read from &15E0 and &15E5, and more unused "
                 "bytes.")
for addr, text in [
    (0x1488, "\"C\" (not read), then \"DISC\" from &1489: *DISC"),
    (0x148D, "...the CR ending *DISC"),
    (0x148E, "\"DUNJUNZ\": *DUNJUNZ, for restart_intercept"),
    (0x1495, "CR ending *DUNJUNZ; then stale STA &149C, LDA #&FF..."),
    (0x149C, "...JSR &3000, JMP &0450: never run"),
    (0x149F, "...the JMP's high byte; not referenced"),
    (0x15D0, "Not referenced: stale code"),
    (0x15D9, "Not referenced: RTS, then \"ODER\""),
    (0x15DE, "Not referenced"),
    (0x15E0, "\"DISC\": *DISC, for next_level_intercept"),
    (0x15E4, "...the CR ending *DISC"),
    (0x15E5, "\"RUN CODER\": *RUN CODER, for next_level_intercept"),
    (0x15EE, "CR ending *RUN CODER; then two bytes not referenced"),
    (0x15F1, "Not referenced"),
]:
    annotator.c(addr, text)
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
