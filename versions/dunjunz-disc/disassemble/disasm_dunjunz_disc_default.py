"""dasmos driver for *DEFAULT (`Default`, &1900), the Model B side's level
restorer.

*DEFAULT asks for a level number, copies that level's original file from
the copies it carries (levels 1-24, encrypted, at &1DB0) to &6B00, and
saves it as `LevelN`, so undoing the level editor's changes. It does the
same job as the Master side's Default, written differently: it asks with
"Which level do you wish to reset ?", accepts 1-24 only, and sets *TV255 1
and MODE 7 first.

Between the code and the levels lie leftovers from memory as it was when
the file was saved: a few bytes of text, most of an encrypted copy of
level 4, and lines of text reading SEG n and ENDSEG.
"""

import os
from pathlib import Path

import dasmos
from dasmos.expr import char, hi, lo, sym

INLINE = dasmos.Align.INLINE

VERSION_DIRPATH = Path(__file__).resolve().parent.parent
BINARY_DIRPATH = VERSION_DIRPATH / "binary"
OUTPUT_DIRPATH = VERSION_DIRPATH / "output"

asm_filepath = Path(os.environ.get("FANTASM_ASM", OUTPUT_DIRPATH / "dunjunz-disc-default.asm"))
json_filepath = Path(os.environ.get("FANTASM_JSON", OUTPUT_DIRPATH / "dunjunz-disc-default.json"))

LOAD_ADDR = 0x1900
LEVELS_ADDR = 0x1DB0
LEVEL_LENGTH = 0x2B0
LEVEL_COUNT = 24
END_ADDR = 0x5E30

d = dasmos.Disassembler.create(cpu="6502")
d.load(BINARY_DIRPATH / "Default", LOAD_ADDR, name="Default", exec_addr=LOAD_ADDR)
d.use_environment("acorn_mos")


def comments(pairs):
    for addr, text in pairs:
        d.comment(addr, text, align=INLINE)


# ---------------------------------------------------------------------------
# Zero page and the level buffer.

zp = dict(group="zero_page", access="rw")
d.label(0x70, "tens_times_ten", description=(
    "Scratch: twice, then ten times, the tens digit of the level number."), **zp)
d.label(0x71, "read_ptr", description=(
    "The level's copy within *DEFAULT, low byte (high byte at &72)."), **zp)
d.label(0x72, "read_ptr_hi", **zp)
d.label(0x73, "put_ptr", description=(
    "Where the level is copied to, from &6B00, low byte (high byte at "
    "&74)."), **zp)
d.label(0x74, "put_ptr_hi", **zp)
d.label(0x6B00, "level_buffer", group="level_file", description=(
    "Where the game loads a level file, and where *DEFAULT puts the level "
    "it saves (&6B00-&6DAF)."))
d.label(0xFFFC, "reset_vector", group="os_entry_points", description=(
    "The 6502 reset vector: the MOS's reset entry."))

# ---------------------------------------------------------------------------

d.entry(LOAD_ADDR)
d.subroutine(0x1900, "default_start", title="*DEFAULT: restore a level file",
             description=(
                 "Set *TV255 1, MODE 7 and printer off; then, for each level, "
                 "disable ESCAPE, clear the screen, ask which level to reset "
                 "and read one or two digits. Accept 1-24, copy that level's "
                 "original (still encrypted) from the copies at &1DB0 to "
                 "&6B00 and *SAVE it as LevelN. Then offer another level, or "
                 "quit through the reset vector. A leading zero (05) is kept "
                 "in the filename (Level05), which the game does not read."))
comments([
    (0x1900, "*TV255 1: move the picture down a line, interlace off"),
    (0x1902, "..."), (0x1904, "..."),
    (0x1907, "VDU 22,7: MODE 7"),
    (0x1909, "..."), (0x190C, "..."), (0x190E, "..."),
    (0x1911, "VDU 3: printer off"),
    (0x1913, "..."),
    (0x1916, "OSBYTE &C8 with X=1, Y=0: disable ESCAPE..."),
    (0x1918, "..."), (0x191A, "..."), (0x191C, "..."),
    (0x191F, "OSBYTE &0F: flush buffers (X is the old &C8 setting, normally 0: all)"),
    (0x1921, "..."),
    (0x1924, "VDU 12: clear the screen"),
    (0x1926, "..."),
    (0x1929, "Print the prompt, up to and including its zero..."),
    (0x192B, "..."), (0x192E, "..."), (0x1931, "..."), (0x1932, "..."),
    (0x1934, "..."),
    (0x1936, "Point XY at read_level_block..."),
    (0x1938, "..."),
    (0x193A, "...and fill it in: the buffer is level_digits..."),
    (0x193C, "..."), (0x193F, "..."), (0x1941, "..."),
    (0x1944, "...at most two characters..."),
    (0x1946, "..."),
    (0x1949, "...from '0'..."),
    (0x194B, "..."),
    (0x194E, "...to '9'"),
    (0x1950, "..."),
    (0x1953, "OSWORD 0: read the level number"),
    (0x1955, "..."),
    (0x1958, "Nothing typed (or ESCAPE)?"),
    (0x195A, "Yes: ask again"),
    (0x195C, "One digit?"),
    (0x195E, "Yes"),
    (0x1960, "Two: tens digit..."),
    (0x1963, "..."), (0x1964, "..."),
    (0x1966, "...x 2..."),
    (0x1967, "..."),
    (0x1969, "...x 8..."),
    (0x196A, "..."), (0x196B, "..."),
    (0x196C, "...+ x 2 = x 10..."),
    (0x196E, "..."),
    (0x1970, "...plus the units digit"),
    (0x1973, "..."), (0x1974, "..."), (0x1976, "..."), (0x1977, "..."),
    (0x1979, "Check it (falls through only for 00)"),
    (0x197B, "One digit: blank the second, for the filename..."),
    (0x197D, "..."),
    (0x1980, "...and the level is the digit"),
    (0x1983, "..."), (0x1984, "..."),
    (0x1986, "25 or more: ask again"),
    (0x1988, "..."),
    (0x198A, "0: ask again"),
    (0x198C, "..."),
    (0x198E, "X = level"),
    (0x198F, "read_ptr = &1B00..."),
    (0x1991, "..."), (0x1993, "..."), (0x1995, "..."),
    (0x1997, "...plus &2B0 for each level: level N's copy..."),
    (0x1999, "..."), (0x199A, "..."), (0x199C, "..."), (0x199E, "..."),
    (0x19A0, "..."), (0x19A2, "..."), (0x19A4, "..."),
    (0x19A5, "...at &1B00 + N x &2B0"),
    (0x19A7, "put_ptr = &6B00"),
    (0x19A9, "..."), (0x19AB, "..."), (0x19AD, "..."),
    (0x19AF, "Y = 0: both pointers step instead"),
    (0x19B1, "Copy a byte"),
    (0x19B3, "..."),
    (0x19B5, "Next byte to read"),
    (0x19B7, "..."), (0x19B9, "..."),
    (0x19BB, "Next byte to write"),
    (0x19BD, "..."), (0x19BF, "..."),
    (0x19C1, "Until put_ptr reaches &6DB0"),
    (0x19C3, "..."), (0x19C5, "..."), (0x19C7, "..."), (0x19C9, "..."),
    (0x19CB, "..."),
    (0x19CD, "Put the digits into the SAVE command"),
    (0x19D0, "..."), (0x19D3, "..."), (0x19D6, "..."),
    (0x19D9, "*SAVE LevelN 6B00+2B0"),
    (0x19DB, "..."), (0x19DD, "..."),
    (0x19E0, "New line"),
    (0x19E2, "..."), (0x19E5, "..."), (0x19E7, "..."),
    (0x19EA, "Print the question, up to and including its zero"),
    (0x19EC, "..."), (0x19EF, "..."), (0x19F2, "..."), (0x19F3, "..."),
    (0x19F5, "..."),
    (0x19F7, "OSBYTE &0F: flush the input buffer (X is non-zero)"),
    (0x19F9, "..."),
    (0x19FC, "Wait for a key"),
    (0x19FF, "A: another level"),
    (0x1A01, "..."),
    (0x1A03, "Q?"),
    (0x1A05, "No: wait again"),
    (0x1A07, "Yes: quit through the reset vector"),
    (0x1A0A, "Another level"),
])
for addr, name in [(0x1916, "ask_level"), (0x192B, "print_prompt"),
                   (0x197B, "one_digit"), (0x1986, "check_level"),
                   (0x1997, "find_copy"), (0x19B1, "copy_level"),
                   (0x19BB, "copy_put_next"), (0x19C1, "copy_check_end"),
                   (0x19EC, "print_question"), (0x19FC, "wait_for_answer"),
                   (0x1A0A, "another_level")]:
    d.label(addr, name)

d.banner(0x1A0D, title="Prompts, the input block and the commands")
d.label(0x1A0D, "level_prompt")
d.stringz(0x1A0D)
d.label(0x1A31, "read_level_block", length=5, description=(
    "OSWORD 0 block: buffer address, maximum length, lowest and highest "
    "character; *DEFAULT fills it in before each call."))
d.byte(0x1A31, 5, cols=5)
for k in range(1, 5):
    d.expr_label(0x1A31 + k, f"read_level_block+{k}")
d.label(0x1A36, "level_digits", length=3, description=(
    "The digits typed, and the CR that ends them."))
d.byte(0x1A36, 3, cols=3)
d.expr_label(0x1A37, "level_digits+1")
d.label(0x1A39, "another_question")
d.stringz(0x1A39)
d.label(0x1A5E, "save_command", description=(
    "*SAVE LevelN 6B00+2B0, with the digits at +10 and +11."))
d.stringcr(0x1A5E)
d.expr_label(0x1A68, "save_command+10")
d.expr_label(0x1A69, "save_command+11")
d.label(0x1A74, "tv_command")
d.stringcr(0x1A74)

for operand_addr, name in [(0x1901, "tv_command"), (0x1937, "read_level_block"),
                           (0x19DA, "save_command")]:
    d.expr(operand_addr, lo(sym(name)))
for operand_addr, name in [(0x1903, "tv_command"), (0x1939, "read_level_block"),
                           (0x19DC, "save_command")]:
    d.expr(operand_addr, hi(sym(name)))
d.expr(0x193B, lo(sym("level_digits")))
d.expr(0x1940, hi(sym("level_digits")))

# ---------------------------------------------------------------------------
# Leftovers from memory.

d.banner(0x1A7C, title="Leftovers",
         description="Never used: memory as it lay when the file was saved. A "
         "few bytes of text (among them PAGE), the end of an encrypted copy "
         "of level 3 and most of one of level 4, laid out as the Master "
         "side's Default holds them (level N at &1000 + N x &2B0), with "
         "other bytes written over parts of it, then lines of text reading "
         "SEG 0 to SEG 8 and ENDSEG.")
d.label(0x1A7C, "leftovers")
d.byte(0x1A7C, 0x1D00 - 0x1A7C, cols=16)
d.label(0x1D00, "seg_text_leftover")
d.byte(0x1D00, LEVELS_ADDR - 0x1D00, cols=16)

# ---------------------------------------------------------------------------
# The levels' original files.

d.banner(LEVELS_ADDR, title="The original levels",
         description="Levels 1 to 24 as the game loads them: &2B0 bytes each, "
         "encrypted (each byte XORed with the low byte of its address at "
         "&6B00). They are byte for byte this side's Level1-Level24. "
         "*DEFAULT finds level N at &1B00 + N x &2B0.")
for n in range(1, LEVEL_COUNT + 1):
    level_addr = LEVELS_ADDR + (n - 1) * LEVEL_LENGTH
    d.label(level_addr, f"level_{n}_original", length=LEVEL_LENGTH,
            description=f"Level {n}'s file, encrypted.")
    d.byte(level_addr, LEVEL_LENGTH, cols=16)
assert LEVELS_ADDR + LEVEL_COUNT * LEVEL_LENGTH == END_ADDR

# Values written from names: the level copies' base and length, the
# level buffer's end, the number of levels and the characters typed.
d.constant(LEVEL_LENGTH, "level_length", comment="The length of a level file")
d.constant(0x6DB0, "level_buffer_end", comment="The end of the level file at &6B00")
d.constant(24, "level_count", comment="The levels *DEFAULT carries")
d.expr(0x1990, lo(sym("level_1_original") - sym("level_length")))
d.expr(0x1994, hi(sym("level_1_original") - sym("level_length")))
d.expr(0x199B, lo(sym("level_length")))
d.expr(0x19A1, hi(sym("level_length")))
d.expr(0x19AC, hi(sym("level_buffer")))
d.expr(0x19C4, lo(sym("level_buffer_end")))
d.expr(0x19CA, hi(sym("level_buffer_end")))
d.expr(0x1987, sym("level_count") + 1)
for operand_addr in (0x194A, 0x194F, 0x1965, 0x1975, 0x1985, 0x197C, 0x1A00, 0x1A04):
    d.expr(operand_addr, char(d.memory.get_u8(operand_addr)))

ir = d.disassemble()
asm_filepath.parent.mkdir(parents=True, exist_ok=True)
asm_filepath.write_text(str(ir.render("beebasm")), encoding="utf-8")
json_filepath.write_text(str(ir.render("json")), encoding="utf-8")
