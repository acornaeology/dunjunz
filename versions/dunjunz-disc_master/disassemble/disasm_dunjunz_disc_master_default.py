"""dasmos driver for *DEFAULT (`Default`, &0E00), the Master 128 side's
level restorer.

*DEFAULT asks for a level number, copies that level's original file from
the copies it carries (all 25 levels, encrypted, at &12B0) to &6B00, and
saves it as `LevelN`, so undoing the level editor's changes. The README
says to run it with the levels' side of the disc in the drive.

Between the code and the levels lie leftovers: the end of the program's
own BBC BASIC assembler source, tokenised, as it lay in memory when the
file was saved.
"""

import os
import sys
from pathlib import Path

import dasmos
INLINE = dasmos.Align.INLINE
from dasmos.expr import char, hi, lo, sym

VERSION_DIRPATH = Path(__file__).resolve().parent.parent
BINARY_DIRPATH = VERSION_DIRPATH / "binary"
OUTPUT_DIRPATH = VERSION_DIRPATH / "output"

asm_filepath = Path(os.environ.get("FANTASM_ASM", OUTPUT_DIRPATH / "dunjunz-disc_master-default.asm"))
json_filepath = Path(os.environ.get("FANTASM_JSON", OUTPUT_DIRPATH / "dunjunz-disc_master-default.json"))

LOAD_ADDR = 0x0E00
LEVELS_ADDR = 0x12B0
LEVEL_LENGTH = 0x2B0
END_ADDR = 0x55E0

d = dasmos.Disassembler.create(cpu="6502")
d.load(BINARY_DIRPATH / "Default", LOAD_ADDR, name="Default", exec_addr=LOAD_ADDR)
d.use_environment("acorn_mos")
image = (BINARY_DIRPATH / "Default").read_bytes()


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
d.subroutine(0x0E00, "default_start", title="*DEFAULT: restore a level file",
             description=(
                 "Disable ESCAPE, clear the screen, ask which level to reset "
                 "and read one or two digits. Accept 1-25, copy that level's "
                 "original (still encrypted) from the copies at &12B0 to "
                 "&6B00 and *SAVE it as LevelN. Then offer another level, or "
                 "quit through the reset vector. Level 25 is accepted and "
                 "saved as Level25, although the game reads level 25 from "
                 "Stones; and a leading zero (05) is kept in the filename "
                 "(Level05), which the game does not read either."))
comments([
    (0x0E00, "OSBYTE &C8 with X=1, Y=0: disable ESCAPE..."),
    (0x0E02, "..."), (0x0E04, "..."), (0x0E06, "..."),
    (0x0E09, "OSBYTE &0F: flush buffers (X is the old &C8 setting, normally 0: all)"),
    (0x0E0B, "..."),
    (0x0E0E, "VDU 12: clear the screen"),
    (0x0E10, "..."),
    (0x0E13, "Print the prompt, up to and including its zero..."),
    (0x0E15, "..."), (0x0E18, "..."), (0x0E1B, "..."), (0x0E1C, "..."),
    (0x0E1E, "..."),
    (0x0E20, "Point XY at read_level_block..."),
    (0x0E22, "..."),
    (0x0E24, "...and fill it in: the buffer is level_digits..."),
    (0x0E26, "..."), (0x0E29, "..."), (0x0E2B, "..."),
    (0x0E2E, "...at most two characters..."),
    (0x0E30, "..."),
    (0x0E33, "...from '0'..."),
    (0x0E35, "..."),
    (0x0E38, "...to '9'"),
    (0x0E3A, "..."),
    (0x0E3D, "OSWORD 0: read the level number"),
    (0x0E3F, "..."),
    (0x0E42, "Nothing typed (or ESCAPE)?"),
    (0x0E44, "Yes: ask again"),
    (0x0E46, "One digit?"),
    (0x0E48, "Yes"),
    (0x0E4A, "Two: tens digit..."),
    (0x0E4D, "..."), (0x0E4E, "..."),
    (0x0E50, "...x 2..."),
    (0x0E51, "..."),
    (0x0E53, "...x 8..."),
    (0x0E54, "..."), (0x0E55, "..."),
    (0x0E56, "...+ x 2 = x 10..."),
    (0x0E58, "..."),
    (0x0E5A, "...plus the units digit"),
    (0x0E5D, "..."), (0x0E5E, "..."), (0x0E60, "..."), (0x0E61, "..."),
    (0x0E63, "Check it (falls through only for 00)"),
    (0x0E65, "One digit: blank the second, for the filename..."),
    (0x0E67, "..."),
    (0x0E6A, "...and the level is the digit"),
    (0x0E6D, "..."), (0x0E6E, "..."),
    (0x0E70, "26 or more: ask again"),
    (0x0E72, "..."),
    (0x0E74, "0: ask again"),
    (0x0E76, "..."),
    (0x0E78, "X = level"),
    (0x0E79, "read_ptr = &1000..."),
    (0x0E7B, "..."), (0x0E7D, "..."), (0x0E7F, "..."),
    (0x0E81, "...plus &2B0 for each level: level N's copy..."),
    (0x0E83, "..."), (0x0E84, "..."), (0x0E86, "..."), (0x0E88, "..."),
    (0x0E8A, "..."), (0x0E8C, "..."), (0x0E8E, "..."),
    (0x0E8F, "...at &1000 + N x &2B0"),
    (0x0E91, "put_ptr = &6B00"),
    (0x0E93, "..."), (0x0E95, "..."), (0x0E97, "..."),
    (0x0E99, "Y = 0: both pointers step instead"),
    (0x0E9B, "Copy a byte"),
    (0x0E9D, "..."),
    (0x0E9F, "Next byte to read"),
    (0x0EA1, "..."), (0x0EA3, "..."),
    (0x0EA5, "Next byte to write"),
    (0x0EA7, "..."), (0x0EA9, "..."),
    (0x0EAB, "Until put_ptr reaches &6DB0"),
    (0x0EAD, "..."), (0x0EAF, "..."), (0x0EB1, "..."), (0x0EB3, "..."),
    (0x0EB5, "..."),
    (0x0EB7, "Put the digits into the SAVE command"),
    (0x0EBA, "..."), (0x0EBD, "..."), (0x0EC0, "..."),
    (0x0EC3, "*SAVE LevelN 6B00+2B0"),
    (0x0EC5, "..."), (0x0EC7, "..."),
    (0x0ECA, "New line"),
    (0x0ECC, "..."), (0x0ECF, "..."), (0x0ED1, "..."),
    (0x0ED4, "Print the question, up to and including its zero"),
    (0x0ED6, "..."), (0x0ED9, "..."), (0x0EDC, "..."), (0x0EDD, "..."),
    (0x0EDF, "..."),
    (0x0EE1, "OSBYTE &0F: flush the input buffer (X is non-zero)"),
    (0x0EE3, "..."),
    (0x0EE6, "Wait for a key"),
    (0x0EE9, "A: another level"),
    (0x0EEB, "..."),
    (0x0EED, "Q?"),
    (0x0EEF, "No: wait again"),
    (0x0EF1, "Yes: quit through the reset vector"),
    (0x0EF4, "Another level"),
])
for addr, name in [(0x0E15, "print_prompt"), (0x0E65, "one_digit"),
                   (0x0E70, "check_level"), (0x0E81, "find_copy"),
                   (0x0E9B, "copy_level"), (0x0EA5, "copy_put_next"),
                   (0x0EAB, "copy_check_end"), (0x0ED6, "print_question"),
                   (0x0EE6, "wait_for_answer"), (0x0EF4, "another_level")]:
    d.label(addr, name)
d.label(0x0E9F, "copy_read_next")

d.banner(0x0EF7, title="Prompts, the input block and the SAVE command")
d.label(0x0EF7, "level_prompt")
d.stringz(0x0EF7)
d.label(0x0F1B, "read_level_block", length=5, description=(
    "OSWORD 0 block: buffer address, maximum length, lowest and highest "
    "character; *DEFAULT fills it in before each call."))
d.byte(0x0F1B, 5, cols=5)
for k in range(1, 5):
    d.expr_label(0x0F1B + k, f"read_level_block+{k}")
d.label(0x0F20, "level_digits", length=3, description=(
    "The digits typed, and the CR that ends them."))
d.byte(0x0F20, 3, cols=3)
d.expr_label(0x0F21, "level_digits+1")
d.label(0x0F23, "another_question")
d.stringz(0x0F23)
d.label(0x0F48, "save_command", description=(
    "*SAVE LevelN 6B00+2B0, with the digits at +10 and +11."))
d.stringcr(0x0F48)
d.expr_label(0x0F52, "save_command+10")
d.expr_label(0x0F53, "save_command+11")

for operand_addr, name in [(0x0E21, "read_level_block"),
                           (0x0EC4, "save_command")]:
    d.expr(operand_addr, lo(sym(name)))
for operand_addr, name in [(0x0E23, "read_level_block"),
                           (0x0EC6, "save_command")]:
    d.expr(operand_addr, hi(sym(name)))
d.expr(0x0E25, lo(sym("level_digits")))
d.expr(0x0E2A, hi(sym("level_digits")))

# ---------------------------------------------------------------------------
# Leftovers: the end of the BBC BASIC assembler source, lines 1160-1370.

TOKENS = {0x81: "DIV", 0x83: "MOD", 0x97: "ASC"}


def detokenise(data):
    return "".join(TOKENS.get(byte, chr(byte)) for byte in data)


LEFTOVER_ADDR = 0x0F5E
d.banner(LEFTOVER_ADDR, title="Leftovers: the end of the assembler source",
         description="Never used. The rest of the tokenised BBC BASIC program that "
         "assembled *DEFAULT, as it lay in memory when the file was saved: "
         "the end of one line, then lines 1150-1370, with the levels' copies "
         "written over its last bytes. Its labels name this program's "
         "variables: store is level_digits, read and put are read_ptr and "
         "put_ptr, save is save_command and again is another_question. "
         "Each line is shown below as it reads when listed.")
d.label(LEFTOVER_ADDR, "source_leftovers")
first_cr = image.index(b"\r", LEFTOVER_ADDR - LOAD_ADDR) + LOAD_ADDR
d.byte(LEFTOVER_ADDR, first_cr - LEFTOVER_ADDR, cols=16)
fragment = detokenise(image[LEFTOVER_ADDR - LOAD_ADDR:first_cr - LOAD_ADDR])
d.comment(LEFTOVER_ADDR, f"...{fragment} (the end of a line)")
cr = first_cr
while cr + 4 <= LEVELS_ADDR:
    hi_byte, lo_byte, length = image[cr + 1 - LOAD_ADDR:cr + 4 - LOAD_ADDR]
    number = hi_byte * 256 + lo_byte
    text_addr = cr + 4
    text_end = min(cr + length, LEVELS_ADDR)
    d.byte(cr, 4, cols=4)
    d.comment(cr, f"Line {number}: CR, line number, length", align=INLINE)
    text = detokenise(image[text_addr - LOAD_ADDR:text_end - LOAD_ADDR])
    cut = " (cut off by level 1's copy)" if cr + length > LEVELS_ADDR else ""
    d.comment(text_addr, f"{number}{text}{cut}")
    d.byte(text_addr, text_end - text_addr, cols=16)
    cr = cr + length

# ---------------------------------------------------------------------------
# The levels' original files.

d.banner(LEVELS_ADDR, title="The original levels",
         description="Levels 1 to 25 as the game loads them: &2B0 bytes each, encrypted "
         "(each byte XORed with the low byte of its address at &6B00). They "
         "are byte for byte the Model B side's Level1-Level24 and the end of "
         "Stones, except level 6, which is the cassette's (see findings.md). "
         "*DEFAULT finds level N at &1000 + N x &2B0.")
for n in range(1, 26):
    level_addr = LEVELS_ADDR + (n - 1) * LEVEL_LENGTH
    d.label(level_addr, f"level_{n}_original", length=LEVEL_LENGTH,
            description=f"Level {n}'s file, encrypted.")
    d.byte(level_addr, LEVEL_LENGTH, cols=16)
assert LEVELS_ADDR + 25 * LEVEL_LENGTH == END_ADDR

# Values written from names: the level copies' base and length, the
# level buffer's end, the number of levels and the characters typed.
d.constant(LEVEL_LENGTH, "level_length", comment="The length of a level file")
d.constant(0x6DB0, "level_buffer_end", comment="The end of the level file at &6B00")
d.constant(25, "level_count", comment="The levels *DEFAULT carries")
d.expr(0x0E7A, lo(sym("level_1_original") - sym("level_length")))
d.expr(0x0E7E, hi(sym("level_1_original") - sym("level_length")))
d.expr(0x0E85, lo(sym("level_length")))
d.expr(0x0E8B, hi(sym("level_length")))
d.expr(0x0E96, hi(sym("level_buffer")))
d.expr(0x0EAE, lo(sym("level_buffer_end")))
d.expr(0x0EB4, hi(sym("level_buffer_end")))
d.expr(0x0E71, sym("level_count") + 1)
for operand_addr in (0x0E34, 0x0E39, 0x0E4F, 0x0E5F, 0x0E6F, 0x0E66, 0x0EEA, 0x0EEE):
    d.expr(operand_addr, char(d.memory.get_u8(operand_addr)))

ir = d.disassemble()
asm_filepath.parent.mkdir(parents=True, exist_ok=True)
asm_filepath.write_text(str(ir.render("beebasm")), encoding="utf-8")
json_filepath.write_text(str(ir.render("json")), encoding="utf-8")
