"""Annotations for *EDITOR, the level editor, on both sides of the disc.

The Model B side's `Editor` (exec &239D) and the Master 128 side's (exec
&23B2) are one program. The Master's loads Table (the screen's row offsets
and *FREE) into private RAM at start-up, follows *CAT with *FREE, uses MOS
3.20's reset entry and the shorter DFS commands; the Model B's reads MOS
1.20's row offsets and resets through MOS 1.20's entry. The Master's code
from &1C4D on sits &13 bytes higher, and from &1DA1 &15 higher.

The annotations name the Master side's addresses. For the Model B side,
`annotate` sees the disassembler through `Remapped`, which moves each
address to the Model B's and drops those the Model B lacks.
"""

import dasmos
from dasmos.expr import char, hi, lo, sym

from dunjunz_common import game
from dunjunz_common.annotator import Annotator

INLINE = dasmos.Align.INLINE

# Master address ranges (end exclusive) and the offset to the Model B
# side's address; None where the Model B side has no counterpart.
MASTER_TO_MODEL_B = [
    (0x1C3A, 0x1C4D, None),     # loading Table
    (0x1C4D, 0x1D82, -0x13),
    (0x1D82, 0x1DA1, None),     # the commands, declared per side
    (0x1DA1, 0x23F7, -0x15),
    (0x23F7, 0x23FA, None),     # *FREE after *CAT
    (0x23FA, 0x2400, -0x18),
]


def master_to_model_b(addr):
    for lo_addr, hi_addr, offset in MASTER_TO_MODEL_B:
        if lo_addr <= addr < hi_addr:
            return None if offset is None else addr + offset
    return addr


class Remapped:
    """A view of the disassembler that moves the address each annotation
    names through `remap`, and drops annotations it maps to None."""

    ADDRESSED = {
        "entry", "banner", "subroutine", "comment", "expr", "label",
        "index_region", "expr_label", "optional_label", "index_base",
        "byte", "string", "hook_subroutine", "inkey_number",
        "stringcr", "stringz", "word", "format_hint",
    }

    def __init__(self, disassembler, remap):
        self._d = disassembler
        self._remap = remap

    def __getattr__(self, name):
        attr = getattr(self._d, name)
        if name not in self.ADDRESSED:
            return attr

        def remapped(addr, *args, **kwargs):
            new_addr = self._remap(addr)
            if new_addr is None:
                return None
            return attr(new_addr, *args, **kwargs)

        return remapped


# The editor's own sprite numbers (its sprite tables at &0A00).
EDITOR_SPRITES = [
    (0x00, "wall"), (0x01, "exit"), (0x02, "drainer"), (0x03, "trapdoor"),
    (0x04, "treasure"), (0x05, "food"), (0x06, "teleporter"),
    (0x07, "magic_sword"), (0x08, "helmet"), (0x09, "potion"),
    (0x0A, "weapons"), (0x0B, "cross"), (0x0C, "boots"),
    (0x0D, "door_vertical"), (0x0E, "door_horizontal"), (0x0F, "key"),
    (0x10, "blank"), (0x11, "waiting_door"), (0x12, "wall_block_0"),
    (0x2A, "chooser_frame"), (0x2B, "chooser_blank"), (0x2C, "cursor"),
]
EDITOR_CONSTANTS = [
    (0x4F, "max_slot", "Item slots are numbered 0 to &4F"),
    (0x13, "max_link", "Door-key links are numbered 0 to 19"),
    (30, "max_object", "The level file's objects are numbered 1 to 30; the exit is 30"),
    (20, "max_door", "Doors are numbered 1 to 20"),
    (0x20, "map_width", "The map is 32 cells wide..."),
    (0x30, "map_height", "...and 48 cells high"),
    (0x4C, "opcode_jmp", "The JMP opcode, which arms the MOS BREAK intercept"),
    (0x29B0, "level_file_end", "The end of the level file at &2700"),
    (0x73, "game_chalice_type", "The game's object type for the Chalice"),
    (0x3000, "screen_start", "The start of MODE 2 screen memory"),
    (0xC9, "map_bytes", "The length of the wall and object-free maps"),
    (0xFF, "off_map", "A map x or y that leaves an object out of the level"),
    (0xFF, "no_link", "A free door-key link, or no door waiting"),
    (24, "max_level", "The highest level number the editor saves"),
    (24, "wall_block_count", "The wall blocks in Stones"),
    (0x30, "wall_block_bytes", "The length of a wall block, 4 bytes by 12 rows"),
    (0x51, "game_exit_type", "The game's object type for the exit"),
]
# The Master side's marker in table_loaded_flag.
MASTER_CONSTANTS = [(0x6F, "table_loaded_mark", "table_loaded_flag once Table has been loaded")]
# (operand address, expression); Master addresses.
def _sp(name, offset=0):
    expression = sym(f"spr_{name}")
    return expression + offset if offset > 0 else (expression - (-offset) if offset else expression)


EDITOR_OPERANDS = [
    (0x2036, _sp("cursor")), (0x2418, _sp("chooser_frame")), (0x248C, _sp("chooser_frame")),
    (0x2483, _sp("chooser_blank")), (0x2499, _sp("wall_block_0")), (0x2548, _sp("wall_block_0")),
    (0x261B, _sp("door_vertical")), (0x2665, _sp("key")), (0x2B06, _sp("blank")),
    (0x2C02, _sp("key")), (0x2C31, _sp("door_vertical")), (0x2C35, _sp("door_horizontal")),
    (0x2C46, _sp("door_vertical")), (0x2C4A, _sp("door_horizontal")), (0x2C4E, _sp("key")),
    (0x2CA6, _sp("key")), (0x2CD2, _sp("waiting_door")), (0x2D19, _sp("waiting_door")),
    (0x2D28, _sp("door_vertical")), (0x2D2C, _sp("door_horizontal")), (0x2D30, _sp("key")),
    (0x2D57, _sp("blank")), (0x2D8D, _sp("blank")), (0x7B84, _sp("key")),
    (0x2091, _sp("blank")),
    (0x1C5E, sym("max_slot")), (0x260C, sym("max_slot")), (0x7B0D, sym("max_slot")),
    (0x20FC, sym("max_link")), (0x2684, sym("max_link")), (0x2CAC, sym("max_link")),
    (0x2CF8, sym("max_link")), (0x2D44, sym("max_link")), (0x2D73, sym("max_link")),
    (0x2E37, sym("max_link")), (0x7B12, sym("max_link")), (0x1F04, sym("max_link") + 1),
    (0x1F38, sym("max_object") - 1), (0x1F7F, sym("max_object") - 1),
    (0x2C56, sym("max_object")), (0x263E, sym("max_object")), (0x7B17, sym("max_object")),
    (0x1F8A, sym("max_door")), (0x7B3E, sym("max_door")), (0x2C7E, sym("max_door") + 1),
    (0x1F6D, sym("map_width")), (0x1F75, sym("map_height")),
    (0x20AC, sym("map_width") - 1), (0x20B4, sym("map_height") - 1),
    (0x222A, sym("map_height") - 1), (0x2235, sym("map_width") - 1),
    (0x2240, sym("map_width") - 1), (0x224B, sym("map_height") - 1),
    (0x2B4B, sym("map_width")), (0x2B4F, sym("map_width") - 1),
    (0x2B55, sym("map_height")), (0x2B59, sym("map_height") - 1),
    (0x1C1D, sym("opcode_jmp")), (0x225A, sym("opcode_jmp")),
    (0x2168, hi(sym("level_object_x"))), (0x2322, hi(sym("level_object_x"))),
    (0x217D, lo(sym("level_file_end"))), (0x2183, hi(sym("level_file_end"))),
    (0x2335, lo(sym("level_file_end"))), (0x233B, hi(sym("level_file_end"))),
    (0x1F3D, sym("game_chalice_type")),
    (0x2BB7, hi(sym("wall_map"))), (0x7D9B, hi(sym("object_free_map"))),
    (0x26BC, sym("map_bytes")), (0x7BBA, sym("map_bytes")),
    (0x1F46, sym("off_map")), (0x1F7D, sym("off_map")),
    (0x2C99, sym("no_link")), (0x2D4D, sym("no_link")), (0x2D9B, sym("no_link")),
    (0x22F2, sym("max_level") + 1),
    (0x2494, sym("wall_block_count") - 1), (0x24BD, sym("wall_block_count")),
    (0x24E1, sym("wall_block_count")),
    (0x1EA6, sym("wall_block_bytes") - 1), (0x2461, sym("wall_block_bytes") - 1),
    (0x263C, sym("game_exit_type")),
]
EDITOR_CHAR_OPERANDS = [
    0x1CD6, 0x1CF8, 0x1E71, 0x1E76, 0x1E95, 0x1C97, 0x1CAB, 0x2368,
    0x221A, 0x2220, 0x2297, 0x22AE, 0x22B3, 0x22CF, 0x22DB, 0x22E9,
    0x23D9, 0x23DE, 0x23E3,
]
EDITOR_KEY_OPERANDS = [
    0x1FCD, 0x1FDC, 0x1FE3, 0x1FEA, 0x203B, 0x2052, 0x2059, 0x206B, 0x2075,
    0x2086, 0x2097, 0x20BE, 0x20C9, 0x20D6, 0x20E1, 0x20EB, 0x242A,
]


def comments(a, pairs):
    for addr, text in pairs:
        a.c(addr, text)


def ellipses(a, *addrs):
    for addr in addrs:
        a.c(addr, "...")


def annotate(d, model_b=False):
    """Annotate the Editor loaded at &1910 in `d`: the Master side's, or
    with `model_b` the Model B side's."""
    version = "disc" if model_b else "disc_master"
    raw_d = d
    if model_b:
        d = Remapped(d, master_to_model_b)
    mos = "MOS 1.20" if model_b else "MOS 3.20"
    reset_entry = "mos120_reset_entry" if model_b else "mos320_reset_entry"
    plotter = d.add_move(0x0900, 0x2700, 0x0200, name="plotter")
    unpack = d.add_move(0x7B00, 0x1910, 0xCE, name="unpack")
    mark_object_cell = d.add_move(0x7D80, 0x1A00, 0x43, name="mark_object_cell")

    main = Annotator(d, version, lambda addr: [(None, "")])
    in_plotter = Annotator(d, version, lambda addr: [(plotter, "")])
    in_unpack = Annotator(d, version, lambda addr: [(unpack, "")])
    in_mark_object_cell = Annotator(d, version, lambda addr: [(mark_object_cell, "")])

    # -----------------------------------------------------------------------
    # The plotter and screen_address at &0900: the game's code, but reading the
    # editor's own sprite tables. The game's annotations apply.

    PLOTTER_DIFFERS = {0x0902, 0x0907, 0x090C, 0x0911}
    if not model_b:
        PLOTTER_DIFFERS |= {0x0967, 0x096E, 0x0976}
    shared = Annotator(d, version, lambda addr: [(plotter, "")],
                       skip=lambda addr: not 0x0900 <= addr < 0x09A0 or addr in PLOTTER_DIFFERS)
    game.annotate(shared)
    comments(in_plotter, [
        (0x0902, "Point sprite_data_ptr at the editor sprite's data..."),
        (0x0907, "...high byte, from the editor's sprite tables..."),
        (0x090C, "Width in screen bytes, from sprite_widths..."),
        (0x0911, "Height in pixel rows, from sprite_heights..."),
    ])
    if model_b:
        # game.annotate's label for the MOS table lies outside the plotter.
        main.label(0xC375, "mos_row_offsets", group="mos_internals", description=(
            "MOS 1.20's table of the screen's character row offsets, high "
            "byte then low byte."))
        main.label(0xC376, "mos_row_offsets_lo", group="mos_internals")
    else:
        in_plotter.sub(0x0967, "screen_address", "Calculate the screen address of plot_x, plot_y",
                       "The game's screen_address, reading the screen's row offsets "
                       "from Table (row_offsets, &C675), which BOOT's *DUNJUNZ or "
                       "this editor's *L. TABLE puts in private RAM.",
                       on_entry={"plot_x": "screen byte column (0-79)", "plot_y": "pixel row"},
                       on_exit={"screen_ptr": "screen address"})
        comments(in_plotter, [
            (0x0967, "Character row = plot_y / 8..."),
            (0x096E, "High byte of row x 640, from Table's copy..."),
            (0x0976, "Low byte of row x 640"),
        ])

    for addr, name in [(0x091D, "plot_row"), (0x0929, "plot_byte"),
                       (0x0938, "plot_next_data"), (0x093E, "plot_count_byte"),
                       (0x0961, "plot_next_row"), (0x099F, "screen_address_done")]:
        in_plotter.label(addr, name)
    if not model_b:
        main.label(0xC675, "row_offsets", group="private_ram", description=(
            "In Table: the screen's character row offsets, high byte then low "
            "byte (a copy of MOS 1.20's table at &C375)."))
        main.label(0xC676, "row_offsets_lo", group="private_ram")
    main.label(0x1910, "unpack_level_image", description=(
        "unpack_level as stored, copied to &7B00 by start_editing."))
    main.label(0x1A00, "mark_object_cell_image", description=(
        "mark_object_cell as stored, copied to &7D80 by start_editing."))
    main.label(0x2700, "plotter_image", description=(
        "The plotter page as stored, copied to &0900 by editor_start; the "
        "level file is loaded over it."))
    # The level file's first table shares &2700 with the stored plotter page.
    for operand_addr in (0x1F48, 0x1F81, 0x231B, 0x235A, 0x262F, 0x2646):
        d.expr(operand_addr, sym("level_object_x"))
    d.expr(0x7B19, sym("level_object_x"), move=unpack)
    main.label(0x2800, "plotter_image_page_2", description=(
        "The second page of the stored plotter page, copied to &0A00."))
    main.label(0x23B4, "copy_plotter_lo")
    main.label(0x23BD, "copy_plotter_hi")

    # The rest of the plotter page: the editor's tables.
    in_plotter.banner(0x09A0, "Unused", "Leftover bytes.")
    in_plotter.byte(0x09A0, 0x10, cols=8)
    in_plotter.c(0x09A0, "Not used")
    for addr, name, text in [
        (0x09B0, "packed_objects", "save_level's count of objects packed so far."),
        (0x09B1, "packed_trapdoors", "save_level's count of trapdoors packed so far."),
        (0x09B2, "packed_doors", "save_level's count of doors (and keys) packed so far."),
    ]:
        in_plotter.label(addr, name, description=text)
        in_plotter.byte(addr)
    in_plotter.byte(0x09B3, 0x0D, cols=8)
    in_plotter.c(0x09B3, "Not used: leftover spaces and Ds")
    in_plotter.label(0x09C0, "item_types", length=16, description=(
        "The level type of each editor item (its sprite number, 0-&0F): 1 "
        "exit &51; 2 energy drainer &53; 4-&0C treasure &28, food &29, "
        "teleporter &2B, magic sword &63, magic helmet &60, potion &61, "
        "weapons &62, Cross &2A, boots &5F; &0D and &0E the door sprites "
        "&1C and &1D. Entries 0 (wall), 3 (trapdoor) and &0F (key) are not "
        "used as types."))
    in_plotter.banner(0x09C0, "Item types and checksums",
                      "The level type for each of the editor's items, and a copy "
                      "of the game's level checksum table.")
    in_plotter.byte(0x09C0, 16, cols=16)
    in_plotter.label(0x09D0, "level_checksums", length=25, description=(
        "The game's checksum table (level_checksums, &0491): the sum, modulo "
        "256, of each level's decrypted bytes. Indexed from &09CF by level "
        "number."))
    in_plotter.byte(0x09D0, 25, cols=13)
    d.expr_label(0x09CF, "level_checksums-1", move=plotter)
    in_plotter.banner(0x09E9, "Unused", "Leftover bytes.")
    in_plotter.byte(0x09E9, 0x17, cols=8)
    in_plotter.c(0x09E9, "Not used")
    in_plotter.banner(0x0A00, "Sprite tables",
                      "Each of the editor's 51 sprites' data address (low and "
                      "high bytes), width in bytes and height in pixel rows. "
                      "0-&0F are the items (two bytes by five rows, at &2A00), "
                      "&10 is blank (zeros at &7FF0), &11 a door waiting for its "
                      "key, &12-&29 the 24 wall blocks in Stones (&6E80), &2A the "
                      "wall-block chooser's frame and &2B a blank part of the "
                      "screen that erases it, and &2C the cursor. Entries "
                      "&2D-&32 are not used.")
    for addr, name, text in [
        (0x0A00, "sprite_addr_lo", "Each sprite's data address, low byte."),
        (0x0A33, "sprite_addr_hi", "Each sprite's data address, high byte."),
        (0x0A66, "sprite_widths", "Each sprite's width in screen bytes."),
        (0x0A99, "sprite_heights", "Each sprite's height in pixel rows."),
    ]:
        in_plotter.label(addr, name, length=51, description=text)
        in_plotter.byte(addr, 51, cols=17)
    in_plotter.banner(0x0ACC, "Unused", "Leftover bytes.")
    in_plotter.byte(0x0ACC, 0x34, cols=8)
    in_plotter.c(0x0ACC, "Not used")

    # -----------------------------------------------------------------------
    # Workspace.

    zp = dict(group="zero_page", access="rw")
    for addr, name, text in [
        (0x70, "plot_x", "Sprite position for plot_sprite: screen byte column. Also a pointer's low byte."),
        (0x71, "plot_y", "Sprite position for plot_sprite: pixel row. Also a pointer's high byte."),
        (0x72, "scratch", "Scratch: a pointer's low byte, a key number, a count or a length."),
        (0x73, "scratch_hi", "Scratch: a pointer's high byte or a second key number."),
        (0x74, "screen_ptr", "plot_sprite's screen address, low byte; also a running sum."),
        (0x75, "screen_ptr_hi", "plot_sprite's screen address, high byte."),
        (0x76, "row_start_ptr", "plot_sprite: start of the sprite row, low byte."),
        (0x77, "row_start_ptr_hi", "plot_sprite: start of the sprite row, high byte."),
        (0x78, "sprite_data_ptr", "plot_sprite: next sprite data byte, low byte."),
        (0x79, "sprite_data_ptr_hi", "plot_sprite: next sprite data byte, high byte."),
        (0x7A, "sprite_number", "The sprite plot_sprite plots."),
        (0x80, "cursor_x", "The cursor's cell, x (0-31)."),
        (0x81, "cursor_y", "The cursor's cell, y (0-47)."),
        (0x82, "current_item", "The item SPACE places (0-&0F): 0 a wall, 1 the exit, 3 a trapdoor, &0D/&0E doors, &0F a key, the rest objects."),
        (0x83, "last_slot", "The highest item slot, &4F: 80 slots."),
        (0x84, "bit_mask", "A map bit's mask; also scratch, such as a slot number."),
        (0x85, "map_ptr", "Address of a map byte, low byte."),
        (0x86, "map_ptr_hi", "Address of a map byte, high byte."),
        (0x87, "key_left", "INKEY number of the cursor-left key: ',' (&99)."),
        (0x88, "key_right", "INKEY number of the cursor-right key: '.' (&98)."),
        (0x89, "key_up", "INKEY number of the cursor-up key: 'A' (&BE)."),
        (0x8A, "key_down", "INKEY number of the cursor-down key: 'Z' (&9E)."),
        (0x8B, "object_count", "Objects placed (at most 29)."),
        (0x8C, "trapdoor_count", "Trapdoors placed (8 are needed to save)."),
        (0x8D, "exit_placed", "Non-zero once the exit is placed (needed to save)."),
        (0x8E, "door_count", "Doors placed (at most 20)."),
    ]:
        main.label(addr, name, description=text, **zp)

    for addr, name, text in [
        (0x0C00, "slot_x", "Each item slot's x (80 slots)."),
        (0x0C60, "slot_y", "Each item slot's y."),
        (0x0CB0, "slot_item", "Each item slot's editor sprite (0: free)."),
        (0x0DD0, "line_x", "The cell a link line is drawn from or to, x; also where delete_item keeps the cursor."),
        (0x0DD1, "line_y", "The cell a link line is drawn from or to, y."),
        (0x0DD2, "line_gx", "That cell's graphics x, low byte (high byte at &0DD3)."),
        (0x0DD3, "line_gx_hi", "That cell's graphics x, high byte."),
        (0x0DD4, "line_gy", "That cell's graphics y, low byte (high byte at &0DD5)."),
        (0x0DD5, "line_gy_hi", "That cell's graphics y, high byte."),
        (0x0DD6, "pending_door_item", "The sprite of the door waiting for its key, or &FF if none."),
        (0x0DD7, "pending_door_slot", "The slot of the door waiting for its key."),
        (0x0DD8, "link_index", "The door-key link being made: an index into link_door and link_key."),
        (0x2EA0, "link_door", "Each of 20 door-key links' door slot, or &FF if unused."),
        (0x2EC0, "link_key", "Each door-key link's key slot."),
        (0x2F00, "wall_map", "The wall map being edited (the level's &C9 bytes, laid out as in the game)."),
        (0x2FF0, "unpack_slot", "unpack_level's next free slot, counting down."),
        (0x2FF1, "unpack_link", "unpack_level's next free link, counting down."),
        (0x7E00, "object_free_map", "The object-free map being edited (&C9 bytes): a clear bit marks a cell where an object may lie."),
        (0x7FF0, "blank_sprite", "Zeros, plotted as the blank sprite &10."),
    ]:
        main.label(addr, name, group="editor_workspace", description=text)

    # The level file, loaded and saved at &2700 (its layout is the game's at
    # &6B00). The code at &2700-&28FF has been copied to &0900 by then.
    for addr, name, text in [
        (0x2700, "level_object_x", "The level file at &2700: objects' x (entries 1-30). Entry 0, unused by the game, is set on saving so that the level's sum matches its checksum."),
        (0x2720, "level_object_y", "The level file: objects' y."),
        (0x2740, "level_object_type", "The level file: objects' types."),
        (0x2760, "level_door_x", "The level file: doors' x (entries 1-20)."),
        (0x2775, "level_door_y", "The level file: doors' y."),
        (0x278A, "level_door_sprite", "The level file: doors' sprites."),
        (0x27A0, "level_key_x", "The level file: keys' x."),
        (0x27B5, "level_key_y", "The level file: keys' y."),
        (0x27D0, "level_trapdoor_x", "The level file: trapdoors' x (entries 0-7)."),
        (0x27D8, "level_trapdoor_y", "The level file: trapdoors' y."),
        (0x27E0, "level_walls", "The level file: the wall map."),
        (0x28B0, "level_object_free", "The level file: the object-free map."),
        (0x2980, "level_wall_block", "The level file: the level's wall block (sprite 0 in the game, &30 bytes)."),
    ]:
        main.label(addr, name, group="level_file", description=text)
    d.expr_label(0x2701, "level_object_x+1")
    main.label(0x6E80, "wall_blocks", group="editor_workspace", description=(
        "Stones, loaded here by choose_wall_block: the 24 wall blocks (&30 "
        "bytes each) that a level can use."))
    main.label(0x0287, "os_break_intercept", group="os_workspace", description=(
        "MOS BREAK intercept: a JMP here is called twice during a reset, "
        "with C clear and then set."))
    main.label(0x0288, "os_break_intercept_lo", group="os_workspace")
    main.label(0x0289, "os_break_intercept_hi", group="os_workspace")
    if model_b:
        main.label(0xD9CD, "mos120_reset_entry", group="mos_internals", description=(
            "MOS 1.20's reset entry, the target of the 6502 reset vector."))
    else:
        main.label(0xC6C0, "show_free_space", group="private_ram", description=(
            "In Table: the routine that *CAT is followed by, which prints the "
            "disc's free space (*FREE)."))
        main.label(0xE364, "mos320_reset_entry", group="mos_internals", description=(
            "MOS 3.20's reset entry, the target of the 6502 reset vector."))
        main.label(0xFFFC, "reset_vector", group="os_entry_points")

    # -----------------------------------------------------------------------
    # Start-up.

    main.sub(0x23B2, "editor_start", "*EDITOR: copy the plotter page and start",
             "Copy &2700-&28FF to &0900-&0AFF (the plotter, screen_address, "
             "the item types and checksums, and the sprite tables), freeing "
             "&2700 for the level file, then start.")
    comments(main, [
        (0x23B2, "Copy &2700-&27FF to &0900..."),
        (0x23B4, "Next byte of the stored plotter page..."), (0x23B7, "...to its run address"), (0x23BA, "...on to the next"), (0x23BB, "...until all 256 are copied"),
        (0x23BD, "...and &2800-&28FF to &0A00"),
        (0x23C0, "...to its run address"), (0x23C3, "...on to the next"), (0x23C4, "...until all 256 are copied"),
        (0x23C6, "Start"),
    ])

    main.label(0x1C10, "break_to_start", description=(
        "BREAK intercept while choosing a level: on the second call (C set) "
        "start again."))
    main.banner(0x1C10, "BREAK intercept: start again",
                "Called twice during a reset; on the second call, with C set, "
                "go back to editor_init, keeping the editor in memory.")
    d.entry(0x1C10)
    comments(main, [(0x1C10, "Second call (after the reset)? Start again"),
                    (0x1C12, "First call: return")])

    main.sub(0x1C13, "editor_init", "Set up and choose a level",
             "Disable ESCAPE, point the BREAK intercept at break_to_start (so "
             f"BREAK at a prompt starts again) and BRKV at {mos}'s reset entry "
             "(so any error, such as a missing file, resets the machine), and "
             "note that no level has been encrypted. " +
             ("" if model_b else "Load Table the first time only, marking "
              "table_loaded_flag so that a restart skips it. ") +
             "Set the map cursor's keys to ',' '.' 'A' 'Z', *TV255 1 (applied "
             "by the MODE 7 that follows) and ask whether to edit a level or "
             "start a new one. A new level goes to new_level. To edit, choose "
             "disc or tape (and the drive), read the filename into "
             "load_command, *LOAD the file at &2700 and go to start_editing. "
             "Reached from editor_start, from break_to_start and after a save "
             "when another level is asked for.")
    comments(main, [
        (0x1C13, "OSBYTE &C8 with X=1, Y=0: disable ESCAPE"),
        (0x1C15, "X = 1: ESCAPE does nothing while editing"), (0x1C17, "Y = 0: replace the whole setting"), (0x1C19, "Set it, so ESCAPE cannot stop the editor"),
        (0x1C1C, "BREAK intercept = JMP break_to_start..."),
        (0x1C1E, "Arm the intercept with a JMP..."), (0x1C21, "...whose target is break_to_start..."), (0x1C23, "...its low byte..."), (0x1C26, "...high byte of the target..."),
        (0x1C28, "...so BREAK at a prompt restarts the editor"),
        (0x1C2B, f"BRKV = {'&D9CD' if model_b else '&E364'}, {mos}'s reset entry: an error resets"),
        (0x1C2D, "...low byte of the error handler..."), (0x1C30, "...high byte of the error handler..."), (0x1C32, "...so any error (File not found...) resets"),
        (0x1C35, "No level saved yet (so the buffer is not encrypted)"),
        (0x1C37, "...so the level at &2700 is plain until saved"),
        (0x1C3A, "Table loaded already (a restart)?"),
        (0x1C3D, "Table's mark there means it is loaded"),
        (0x1C3F, "Yes: do not load it again"),
        (0x1C41, "No: mark it loaded..."),
        (0x1C43, "...so a restart after BREAK skips the load..."),
        (0x1C46, "...and *L. TABLE (the row offsets and *FREE)"),
        (0x1C48, "...high byte of the command"), (0x1C4A, "Load Table into private RAM"),
        (0x1C4D, "Map cursor keys: left..."),
        (0x1C4F, "Comma moves the map cursor left"),
        (0x1C51, "...right..."),
        (0x1C53, "Full stop moves it right"),
        (0x1C55, "...up..."),
        (0x1C57, "A moves it up"),
        (0x1C59, "...down"),
        (0x1C5B, "Z moves it down"),
        (0x1C5D, "80 item slots, 0-&4F"),
        (0x1C5F, "Slots are searched from the last, &4F, down"),
        (0x1C61, "*TV255 1: shift the picture a line, interlace off"),
        (0x1C63, "...high byte of the command"), (0x1C65, "...taking effect at the MODE 7 change below"),
        (0x1C68, "VDU 3: printer off"),
        (0x1C6A, "Stop any printer output"),
        (0x1C6D, "VDU 22,7: MODE 7"),
        (0x1C6F, "Send the mode change..."), (0x1C72, "...for MODE 7..."), (0x1C74, "...where the questions are asked"),
        (0x1C77, "Ask: edit (E) or new level (N)"),
        (0x1C79, "...high byte of the prompt"), (0x1C7B, "Internal key &22, E: answer 0, edit..."), (0x1C7D, "...as ask_key's first key"), (0x1C7F, "Internal key &55, N: answer 1, new level..."),
        (0x1C81, "...as ask_key's second key"), (0x1C83, "A = 0: take one of the two keys"), (0x1C85, "Ask, and get 0 for edit or 1 for new"),
        (0x1C88, "Remember the choice for start_editing: 1 for new"),
        (0x1C8B, "E: edit a level file"),
        (0x1C8D, "N: start with an empty level"),
        (0x1C90, "Leave a blank line under the question"),
        (0x1C93, "Choose disc or tape (and the drive)"),
        (0x1C96, "Blank the filename in load_command..."),
        (0x1C98, "From the name field at load_command+5..."), (0x1C9A, "...put a space..."), (0x1C9D, "...in each character..."), (0x1C9E, "...up to load_command+11..."),
        (0x1CA0, "...so no longer earlier name is left in it"),
        (0x1CA2, "Read the filename (L if none is typed)"),
        (0x1CA5, "Line feed"),
        (0x1CA7, "Leave a blank line under the typed name"),
        (0x1CAA, "A space at the name's last character..."),
        (0x1CAC, "...already blank: the space at +12 ends the name"),
        (0x1CAF, "Copy the filename typed into load_command..."),
        (0x1CB1, "Take a character of the typed name..."), (0x1CB4, "...into the command's name field..."), (0x1CB7, "...the next character..."), (0x1CB8, "...for the name's length, without its CR..."),
        (0x1CBA, "...until the name is copied"),
        (0x1CBC, "*LOAD name 2700"),
        (0x1CBE, "...high byte of the command"), (0x1CC0, "Load the level file at &2700, still encrypted"),
        (0x1CC3, "Edit it: start_editing decrypts and draws it"),
    ])
    if not model_b:
        main.label(0x1C4D, "table_loaded")
    for addr, name in [(0x1C90, "edit_level"),
                       (0x1C9A, "blank_load_name"), (0x1CB1, "copy_load_name")]:
        main.label(addr, name)

    main.sub(0x1CC6, "ask_key", "Print a prompt and wait for one of its keys",
             "Print the text at XY up to its '*', flush the input buffer and "
             "scan the keyboard until an answer is pressed. With A=0 the "
             "answers are the two keys whose internal numbers are in scratch "
             "and scratch_hi, and A returns 0 or 1. Otherwise the answers are "
             "the digits 0-3 (drive_keys), and the digit is printed. The keys "
             "are read by scanning, so the key pressed is left in the input "
             "buffer; ask_filename flushes it. Used for edit or new, disc or "
             "tape, the drive, and another level or quit.",
             on_entry={"A": "0 for two keys, else a drive digit",
                       "X": "prompt address, low byte", "Y": "prompt address, high byte",
                       "scratch": "first key's internal number (A=0)",
                       "scratch_hi": "second key's internal number (A=0)"},
             on_exit={"A": "0 or 1 for the key pressed (A=0 on entry); else the digit's character",
                      "Y": "the digit, 0-3 (A non-zero on entry)"})
    comments(main, [
        (0x1CC6, "Keep the mode: 0 for two answer keys, else digits"),
        (0x1CC7, "Point plot_x/plot_y at the prompt..."),
        (0x1CC9, "...high byte: the prompt's address"),
        (0x1CCB, "Print it up to the '*'..."),
        (0x1CCD, "Take a character of the prompt..."), (0x1CCF, "...show it..."), (0x1CD2, "...move to the next..."), (0x1CD3, "...and look ahead at it:"),
        (0x1CD5, "The '*' ends the prompt..."), (0x1CD7, "...so print until it"),
        (0x1CD9, "Flush the input buffer"),
        (0x1CDB, "Discard keys pressed before the prompt"),
        (0x1CDE, "OSBYTE &7A: scan the keyboard from key 16..."),
        (0x1CE0, "...X = the internal number of a key held, or &FF"),
        (0x1CE3, "Which mode?"),
        (0x1CE4, "...keeping the mode for the next pass"),
        (0x1CE5, "Two keys"),
        (0x1CE7, "Digits: is it 0, 1, 2 or 3?"),
        (0x1CE9, "The internal key number pressed..."), (0x1CEA, "...against digit Y's key..."), (0x1CED, "Match: digit Y was pressed"), (0x1CEF, "No: try the digit below..."),
        (0x1CF0, "...down to 0"),
        (0x1CF2, "Not a drive digit: scan again"),
        (0x1CF4, "Drop the kept mode"),
        (0x1CF5, "The digit's value, 0-3..."), (0x1CF6, "...plus '0'..."), (0x1CF7, "...as its character..."), (0x1CF9, "...echoed after the prompt"),
        (0x1CFC, "Return the digit's character, for *DRIVE"),
        (0x1CFD, "The first key?"),
        (0x1CFE, "Is it the first answer's key..."), (0x1D00, "Yes: first key"),
        (0x1D02, "The second key?"),
        (0x1D04, "Neither answer: scan again"),
        (0x1D06, "Second: drop the kept mode"),
        (0x1D07, "The second answer: 1"), (0x1D09, "Return the answer in A"),
        (0x1D0A, "First: drop the kept mode"),
        (0x1D0B, "The first answer: 0"), (0x1D0D, "Return the answer in A"),
    ])
    for addr, name in [(0x1CCD, "print_prompt"), (0x1CDE, "scan_keys"),
                       (0x1CE9, "check_digit"), (0x1CF4, "digit_pressed"),
                       (0x1CFD, "check_two_keys"), (0x1D0A, "first_key")]:
        main.label(addr, name)

    # -----------------------------------------------------------------------
    # Text and commands.

    main.banner(0x1D0E, "Prompts and commands",
                "Prompts end with '*' (for ask_key) or a zero (printed by "
                "callers); commands end with CR. load_command's filename is "
                "copied in from the filename buffer.")
    main.label(0x1D0E, "edit_or_new_prompt")
    main.string(0x1D0E, 0x21)
    main.c(0x1D0E, "editor_init's first question, for ask_key")
    main.label(0x1D2F, "disc_or_tape_prompt")
    main.string(0x1D2F, 0x16)
    main.c(0x1D2F, "choose_filing_system's question, for ask_key")
    main.label(0x1D45, "filename_prompt")
    main.string(0x1D45, 9)
    main.c(0x1D45, "Printed by ask_filename; the name is typed after it")
    main.byte(0x1D4E)
    main.c(0x1D4E, "Zero: the end")
    main.label(0x1D4F, "drive_prompt")
    main.string(0x1D4F, 13)
    main.c(0x1D4F, "Asked after *DISC; answered with a digit 0-3")
    main.label(0x1D5C, "drive_command", description="*DRIVE n, with the digit at +5.")
    main.string(0x1D5C, 5)
    main.byte(0x1D61)
    main.c(0x1D61, "The drive digit")
    main.byte(0x1D62)
    main.c(0x1D62, "CR")
    main.label(0x1D61, "drive_digit")
    main.label(0x1D63, "filename_buffer", length=8, description=(
        "OSWORD 0's buffer: a filename (up to 7 characters) or a level "
        "number's digits."))
    main.byte(0x1D63, 8, cols=8)
    d.expr_label(0x1D64, "filename_buffer+1")
    main.label(0x1D6B, "read_line_block", length=5, description=(
        "OSWORD 0 block: buffer address, maximum length, lowest and highest "
        "character, filled in before each call."))
    main.byte(0x1D6B, 5, cols=5)
    for k in range(1, 5):
        d.expr_label(0x1D6B + k, f"read_line_block+{k}")
    main.label(0x1D70, "load_command", description="*LOAD name 2700, the name at +5.")
    main.stringcr(0x1D70)
    d.expr_label(0x1D75, "load_command+5")
    d.expr_label(0x1D7B, "load_command+11")
    # The commands differ between the sides; they are declared at the
    # side's own addresses.
    if model_b:
        commands = [(0x1D6F, "drive_0_command", 6), (0x1D76, "disc_command", 4),
                    (0x1D7B, "tv_command", 7), (0x1D83, "tape_command", 4),
                    (0x1D88, "cat_command", 3)]
    else:
        commands = [(0x1D82, "drive_0_command", 4), (0x1D87, "disc_command", 3),
                    (0x1D8B, "tv_command", 7), (0x1D93, "load_table_command", 8),
                    (0x1D9C, "tape_command", 2), (0x1D9F, "cat_command", 1)]
    raw_main = Annotator(raw_d, version, lambda addr: [(None, "")])
    for addr, name, length in commands:
        raw_main.label(addr, name)
        raw_main.stringcr(addr)
    main.label(0x1DA1, "count_labels", description=(
        "VDU 31 and the labels of the three counts: Objs, Mons (the "
        "trapdoors, where monsters appear) and Dors."))
    for addr, row in ((0x1DA1, 0), (0x1DA8, 4), (0x1DAF, 8)):
        main.byte(addr, 3, cols=3)
        main.c(addr, f"VDU 31,16,{row}: TAB(16,{row})")
        main.string(addr + 3, 4)
    main.byte(0x1DB6)
    main.c(0x1DB6, "CR: the end")
    main.label(0x1DB7, "edit_screen_vdu", length=0x21, description=(
        "VDU 23,0,10,32 (no cursor), VDU 23,0,6,30 (30 rows), VDU 19,10,1 and "
        "VDU 19,9,3."))
    for addr, length, text in [
        (0x1DB7, 10, "VDU 23,0,10,32: 6845 register 10 = &20, no cursor"),
        (0x1DC1, 1, "VDU 0: does nothing"),
        (0x1DC2, 10, "VDU 23,0,6,30: 6845 register 6 = 30 character rows displayed"),
        (0x1DCC, 6, "VDU 19,10,1: logical colour 10 shows red"),
        (0x1DD2, 6, "VDU 19,9,3: logical colour 9 shows yellow"),
    ]:
        main.byte(addr, length, cols=length)
        main.c(addr, text)
    main.label(0x1DD8, "edit_screen_vdu_end")
    main.banner(0x1DD8, "Unused", "Four asterisks, not sent.")
    main.byte(0x1DD8, 4, cols=4)
    main.c(0x1DD8, "Not used")
    d.expr(0x215D, sym("edit_screen_vdu_end") - sym("edit_screen_vdu"))
    main.label(0x1DDC, "level_number_prompt")
    main.stringz(0x1DDC)
    main.c(0x1DDC, "Asked when saving: the level number")
    main.label(0x1DFA, "save_command", description="*SAVE name 2700+2B0, the name at +5.")
    main.stringcr(0x1DFA)
    main.c(0x1DFA, "*SAVE the &2B0-byte level file from &2700")
    d.expr_label(0x1DFF, "save_command+5")
    main.label(0x1E10, "another_prompt")
    main.string(0x1E10, 0x1F)
    main.c(0x1E10, "Asked after a save, for ask_key")

    # -----------------------------------------------------------------------

    main.sub(0x1E2F, "new_lines", "Print a new line and a blank line",
             "CR, LF, LF: spaces out the MODE 7 questions.",
              on_exit={"A": "corrupted", "X": "preserved", "Y": "preserved"})
    comments(main, [
        (0x1E2F, "CR"), (0x1E31, "Start a new line"),
        (0x1E34, "LF, twice"), (0x1E36, "Down one line..."), (0x1E39, "...and another, leaving a blank line"),
        (0x1E3C, "Return"),
    ])

    main.sub(0x1E3D, "ask_filename", "Ask for a filename",
             "Pause, flush the input buffer (which still holds the key that "
             "answered ask_key's last question), prompt and read up to seven "
             "characters into filename_buffer with OSWORD 0. If only RETURN "
             "is typed, write 'L' after the prompt and use the name L. Used "
             "for both the file to load and the file to save.",
             on_exit={"scratch": "the name's length, without its CR (at least 1)"})
    comments(main, [
        (0x1E3D, "Pause for 256 x 256 loops..."),
        (0x1E3F, "Each outer pass..."), (0x1E41, "...wastes time..."), (0x1E42, "...256 times..."), (0x1E43, "...in the inner loop..."),
        (0x1E45, "...for 256 outer passes..."), (0x1E46, "...a short wait after the last answer"),
        (0x1E48, "Flush buffers (X = 0: all)"),
        (0x1E4A, "Drop the answer key, so it is not read as the name"),
        (0x1E4D, "Leave a blank line before the prompt"),
        (0x1E50, "Print the filename prompt, up to and including its zero"),
        (0x1E52, "Take a character of the prompt..."), (0x1E55, "...show it..."), (0x1E58, "...the next..."), (0x1E59, "...the zero ends it..."),
        (0x1E5B, "...and is printed too"),
        (0x1E5D, "Point XY at read_line_block..."),
        (0x1E5F, "...high byte of the block"),
        (0x1E61, "...buffer filename_buffer..."),
        (0x1E63, "...low byte of the buffer..."), (0x1E66, "...high byte of the buffer..."), (0x1E68, "...high byte"),
        (0x1E6B, "...at most 7 characters..."),
        (0x1E6D, "...a DFS filename's length"),
        (0x1E70, "...from space..."),
        (0x1E72, "...lowest character accepted..."),
        (0x1E75, "...to '~'"),
        (0x1E77, "...highest character accepted"),
        (0x1E7A, "OSWORD 0: read the name"),
        (0x1E7C, "Read the filename the user types"),
        (0x1E7F, "Keep its length, not counting the CR"),
        (0x1E81, "Anything typed?"),
        (0x1E83, "A name was typed: return"),
        (0x1E85, "Only RETURN: VDU 11, up a line..."),
        (0x1E87, "...back onto the prompt line"),
        (0x1E8A, "...and VDU 9, right..."),
        (0x1E8C, "...nine times..."), (0x1E8E, "...stepping right..."), (0x1E91, "...counting the steps..."), (0x1E92, "...past 'Filename '"),
        (0x1E94, "...show 'L'..."),
        (0x1E96, "...as if typed"),
        (0x1E99, "...and use it as the name"),
        (0x1E9C, "Length 1 (Y is 0 after the loop)"),
        (0x1E9D, "...as the name's length"),
        (0x1E9F, "New line, as RETURN gave before"),
        (0x1EA2, "Return"),
    ])
    for addr, name in [(0x1E3F, "pause_outer"), (0x1E41, "pause_inner"),
                       (0x1E52, "print_filename_prompt"), (0x1E8E, "move_right"),
                       (0x1EA2, "filename_read")]:
        main.label(addr, name)

    main.sub(0x1EA3, "new_level", "Start a new, empty level",
             "Reached from editor_init when N is chosen. Fill the level's "
             "wall block (&30 bytes at &2980) with &03, which "
             "choose_wall_block replaces with a block from Stones when the "
             "level is saved, then fall into start_editing, which sees "
             "new_level_flag set and draws an empty map.",
              on_exit={"A": "corrupted", "X": "corrupted", "Y": "preserved"})
    comments(main, [
        (0x1EA3, "Fill level_wall_block with &03..."),
        (0x1EA5, "...for all &30 bytes..."), (0x1EA7, "...the block a new level starts with..."), (0x1EAA, "...from the last byte..."), (0x1EAB, "...to the first, then fall into start_editing"),
    ])
    main.label(0x1EA7, "fill_wall_block")

    main.sub(0x1EAD, "start_editing", "Set up the editing screen and edit",
             "Reached from editor_init once a level file is loaded, and from "
             "new_level. Clear the wall map and the item slots, select MODE 2, "
             "disarm the BREAK intercept, set up the edit screen (no cursor, "
             "30 rows, colours 10 and 9), copy unpack_level and mark_object_cell to "
             "&7B00 and &7D80, set every bit of the object-free map, free "
             "every door-key link, set GCOL 3,3 for the link lines, zero the "
             "counts and turn off cursor editing. For a loaded level, decrypt "
             "it, take any object of type &73 off the map (the Chalice, which "
             "only level 25 has and the editor has no item for), unpack it "
             "into the slots and maps, plot every occupied cell and take the "
             "exit as placed. Then fill the level file's object, door and key "
             "tables with &FF, ready for pack_level to pack the slots into, "
             "show the labels and counts, put the cursor at (11, 11) with the "
             "wall as the item, the slow cursor on and colour 10 red, and fall "
             "into edit_loop.")
    comments(main, [
        (0x1EAD, "Clear wall_map..."),
        (0x1EAF, "...from offset 0..."), (0x1EB0, "...no walls in this byte..."), (0x1EB3, "...the next byte down..."), (0x1EB4, "...through all 256"),
        (0x1EB6, "...and the item slots (&0C00-&0CFF)"),
        (0x1EB9, "...one byte of the slot tables..."), (0x1EBA, "...through all 256: every slot free"),
        (0x1EBC, "Cursor flash phase 0..."),
        (0x1EBE, "...so the first wall pass plots the cursor"),
        (0x1EC1, "Door-key link 0..."),
        (0x1EC3, "...is the first to be made"),
        (0x1EC6, "VDU 22,2: MODE 2"),
        (0x1EC8, "Send the mode change..."), (0x1ECB, "...for MODE 2..."), (0x1ECD, "...the 16-colour screen the map is drawn on"),
        (0x1ED0, "Not a JMP: disarm the BREAK intercept..."),
        (0x1ED2, "...so BREAK while editing is an ordinary reset"),
        (0x1ED5, "No cursor, 30 rows, colours 10 and 9"),
        (0x1ED8, "Copy unpack_level to &7B00..."),
        (0x1EDA, "Take a byte of the stored routine..."), (0x1EDD, "...to &7B00, where it runs..."), (0x1EE0, "...the next..."), (0x1EE1, "...for unpack_level's &CE bytes..."),
        (0x1EE3, "...until it is all copied"),
        (0x1EE5, "...and mark_object_cell to &7D80"),
        (0x1EE7, "Take a byte of the stored routine..."), (0x1EEA, "...to &7D80, where it runs..."), (0x1EED, "...the next..."), (0x1EEE, "...for mark_object_cell's &43 bytes..."),
        (0x1EF0, "...until it is all copied"),
        (0x1EF2, "Every cell object-free..."),
        (0x1EF4, "...from offset 0..."), (0x1EF6, "...set every bit: no object anywhere..."), (0x1EF9, "...the next byte down..."), (0x1EFA, "...through all 256"),
        (0x1EFC, "...and &FF: all 20 door-key links unused"),
        (0x1EFF, "...no key for it..."), (0x1F02, "...the next link..."), (0x1F03, "...all 20 of them..."), (0x1F05, "...until every link is free"),
        (0x1F07, "&FF: no door waiting for its key"),
        (0x1F0A, "VDU 18,3,3: GCOL 3,3 (exclusive-OR, for the link lines)"),
        (0x1F0C, "Send GCOL..."), (0x1F0F, "...mode 3: exclusive-OR, so a line..."), (0x1F11, "...drawn twice is erased..."), (0x1F14, "...in colour 3"),
        (0x1F17, "No trapdoors, objects, exit or doors"),
        (0x1F19, "No trapdoors yet"), (0x1F1B, "No doors yet"), (0x1F1D, "No exit yet"), (0x1F1F, "No objects yet"),
        (0x1F21, "OSBYTE 4,1: cursor editing off..."),
        (0x1F23, "...X = 1: the arrow keys give codes &88-&8B"), (0x1F25, "Set it; the editor reads the arrow keys by scanning"),
        (0x1F28, "New level?"),
        (0x1F2B, "No: unpack the loaded one"),
        (0x1F2D, "Yes: link_index = 0..."),
        (0x1F2F, "...again (it was set above)"),
        (0x1F32, "...and clear the level tables (always branches)"),
        (0x1F34, "Decrypt the loaded level in place at &2700"),
        (0x1F37, "Find an object of type &73 (the Chalice)..."),
        (0x1F39, "This object's type..."), (0x1F3C, "...the Chalice?"), (0x1F3E, "Yes: take it off the map"), (0x1F40, "No: the next object down..."),
        (0x1F41, "...to object 1 (not the exit, 30)"),
        (0x1F43, "No Chalice: unpack the level as it is"),
        (0x1F45, "Drop it: x and y &FF"),
        (0x1F47, "...so unpack_level skips it: the editor..."), (0x1F4A, "...has no item for the Chalice"),
        (0x1F4D, "Unpack the level into the slots and maps"),
        (0x1F50, "Show the labels..."),
        (0x1F53, "...and the unpacked level's counts"),
        (0x1F56, "Draw every cell: rows 0-47..."),
        (0x1F58, "...from the top row"),
        (0x1F5A, "...columns 0-31..."),
        (0x1F5C, "...from the left column"),
        (0x1F5E, "...the item in this cell, if any"),
        (0x1F61, "&FF: nothing here"),
        (0x1F63, "Empty: nothing to plot"),
        (0x1F65, "Plot the item's sprite in the cell"),
        (0x1F68, "Next column"),
        (0x1F6A, "Which column now?"), (0x1F6C, "Past the last column?"), (0x1F6E, "No: draw the next cell"),
        (0x1F70, "Next row"),
        (0x1F72, "Which row now?"), (0x1F74, "Past the last row?"), (0x1F76, "No: draw the next row"),
        (0x1F78, "Take a loaded level to have its exit..."),
        (0x1F7A, "...which SHIFT+S needs before it saves"),
        (0x1F7C, "Clear the level file's object tables..."),
        (0x1F7E, "...objects 29 to 1 (the exit is 30)..."), (0x1F80, "...off the map..."), (0x1F83, "...both x and y..."), (0x1F86, "...the next object down..."),
        (0x1F87, "...until all are cleared"),
        (0x1F89, "...and the door and key tables, for pack_level"),
        (0x1F8B, "...door off the map..."), (0x1F8E, "...its y too..."), (0x1F91, "...its key off the map..."), (0x1F94, "...and its y"),
        (0x1F97, "...the next door down..."), (0x1F98, "...until doors 20 to 1 are cleared"),
        (0x1F9A, "Show the labels (again, for a loaded level)..."),
        (0x1F9D, "...and the counts"),
        (0x1FA0, "Cursor at (11, 11)..."),
        (0x1FA2, "...column 11..."), (0x1FA4, "...row 11: a corner of the heroes' start"),
        (0x1FA6, "...placing walls"),
        (0x1FA8, "...item 0, the wall"),
        (0x1FAA, "Slow cursor on, colour 10 = 1"),
        (0x1FAC, "Move the cursor every third frame"), (0x1FAF, "Logical colour 10 shows red, as set above"),
        (0x1FB2, "OSBYTE 4,1 again..."),
        (0x1FB4, "...X = 1: cursor editing off..."), (0x1FB6, "...a repeat of the call above"),
    ])
    for addr, name in [(0x1EB0, "clear_walls"), (0x1EB6, "clear_slots"),
                       (0x1EDA, "copy_unpack"), (0x1EE7, "copy_mark_object_cell"),
                       (0x1EF6, "clear_free_map"), (0x1EFC, "clear_links"),
                       (0x1F34, "unpack_loaded"), (0x1F39, "find_chalice"),
                       (0x1F45, "drop_chalice"), (0x1F4D, "draw_loaded"),
                       (0x1F5A, "draw_row"), (0x1F5E, "draw_cell"),
                       (0x1F68, "next_cell"), (0x1F7C, "clear_level_tables"),
                       (0x1F80, "clear_object_entries"), (0x1F8B, "clear_door_entries")]:
        main.label(addr, name)

    main.sub(0x1FB9, "edit_loop", "The editing loop",
             "Each pass: wait three frames when the slow cursor is on; f0 "
             "toggles it. SHIFT+S saves, once the exit, all eight trapdoors "
             "and a key for every door are placed. Then move the cursor "
             "(',' '.' 'A' 'Z'), flash it when placing walls, change colour 10 "
             "(cursor up and down), choose the item ('1' and '2'), place it "
             "(SPACE, repeating while held), delete what is under the cursor "
             "(TAB) and show the door-key links while CTRL is held.")
    comments(main, [
        (0x1FB9, "Slow cursor?"),
        (0x1FBC, "No: a pass as fast as it runs"),
        (0x1FBE, "Yes: wait for three frames..."),
        (0x1FC0, "Keep the frame count..."), (0x1FC1, "...across the call..."), (0x1FC2, "OSBYTE &13: wait for the next frame"), (0x1FC4, "...so the cursor steps one cell per three frames"),
        (0x1FC7, "Recover the frame count..."), (0x1FC8, "...into X"), (0x1FC9, "One frame done..."), (0x1FCA, "...until three have passed"),
        (0x1FCC, "f0?"),
        (0x1FCE, "...held?"), (0x1FD1, "No: check for SHIFT+S"),
        (0x1FD3, "Yes: toggle the slow cursor..."),
        (0x1FD6, "...between on and off..."), (0x1FD8, "...and keep the new setting"),
        (0x1FDB, "...and wait for f0 to be released"),
        (0x1FDD, "...still held?"), (0x1FE0, "Still held: keep waiting"),
        (0x1FE2, "S..."),
        (0x1FE4, "...held?"), (0x1FE7, "No: the editing keys"),
        (0x1FE9, "...with SHIFT?"),
        (0x1FEB, "...held as well?"), (0x1FEE, "No: the editing keys"),
        (0x1FF0, "Yes: is the exit placed..."),
        (0x1FF2, "No: cannot save yet"),
        (0x1FF4, "...does every door have its key..."),
        (0x1FF7, "No: cannot save yet"),
        (0x1FF9, "...and are all 8 trapdoors placed?"),
        (0x1FFB, "...all 8?"), (0x1FFD, "No: cannot save yet"),
        (0x1FFF, "Yes: *DISC..."),
        (0x2001, "...(Stones, the wall blocks, is read from disc)"), (0x2003, "...select the disc filing system"),
        (0x2006, "...*DRIVE 0"),
        (0x2008, "...high byte of the command's address"), (0x200A, "...select drive 0, where Stones is"),
        (0x200D, "Wall in the map's four edges"),
        (0x2010, "Pack the slots and maps into the level file"),
        (0x2013, "Choose its wall block from Stones"),
        (0x2016, "VDU 22,7: MODE 7"),
        (0x2018, "...send the MODE number"), (0x201B, "...7, so the save prompts are in text"), (0x201D, "...send it"),
        (0x2020, "Save it: ends by restarting the editor or resetting"),
        (0x2023, "Not reached: save_level never returns"),
        (0x2024, "Move the cursor, redrawing the cell it leaves"),
        (0x2027, "Placing walls?"),
        (0x2029, "Not walls: the item itself shows as the cursor"),
        (0x202B, "Yes: flash the cursor sprite over the wall..."),
        (0x202E, "...toggling cursor_flash each pass..."), (0x2030, "...and keeping it"), (0x2033, "Off this pass: move_cursor's wall sprite shows"),
        (0x2035, "On: the cursor sprite..."),
        (0x2037, "...over the wall move_cursor drew"),
        (0x203A, "Cursor up?"),
        (0x203C, "...(Z set if pressed)"), (0x203F, "Not pressed: try cursor down"),
        (0x2041, "Yes: colour 10 up, to at most 7..."),
        (0x2044, "...read the new colour..."), (0x2047, "...past 7 (white)?"), (0x2049, "No: use it"), (0x204B, "Yes: back to 7"),
        (0x204E, "...set it..."),
        (0x2051, "...and wait for the key to be released"),
        (0x2053, "...(Z set while held)"), (0x2056, "Still held: keep waiting, one step a press"),
        (0x2058, "Cursor down?"),
        (0x205A, "...(Z set if pressed)"), (0x205D, "Not pressed: go on to the item keys"),
        (0x205F, "Yes: colour 10 down, to at least 1..."),
        (0x2062, "Still 1 or more: use it"), (0x2064, "Down to 0 (black): back to 1"),
        (0x2067, "...set it..."),
        (0x206A, "...and wait for the key to be released"),
        (0x206C, "...(Z set while held)"), (0x206F, "Still held: keep waiting, one step a press"),
        (0x2071, "Print the cursor's x and y beside the map"),
        (0x2074, "'1'?"),
        (0x2076, "...(Z set if pressed)"), (0x2079, "Not pressed: try '2'"),
        (0x207B, "Yes: the previous item, to at least 0"),
        (0x207D, "Still 0 or more: go on"), (0x207F, "Below item 0: stay at item 0 (walls)"), (0x2081, "...keep it at item 0"), (0x2083, "Go on to SPACE (always branches)"),
        (0x2085, "'2'?"),
        (0x2087, "...(Z set if pressed)"), (0x208A, "Not pressed: go on to SPACE"),
        (0x208C, "Yes: the next item, to at most &0F"),
        (0x208E, "...read it..."), (0x2090, "...past the last item, the key (&0F)?"), (0x2092, "No: keep it"), (0x2094, "Yes: back to the key"),
        (0x2096, "SPACE?"),
        (0x2098, "...(Z set if pressed)"), (0x209B, "Not pressed: try TAB"),
        (0x209D, "Placing walls?"),
        (0x209F, "No: an item, which may not go on the edge"),
        (0x20A1, "Yes: place a wall, anywhere"),
        (0x20A4, "Next pass: walls repeat while SPACE is held"),
        (0x20A7, "Other items: not on the edges, which are walled..."),
        (0x20A9, "Column 0: refuse"), (0x20AB, "...the right-hand column?"), (0x20AD, "Yes: refuse"), (0x20AF, "...row 0..."),
        (0x20B1, "Row 0: refuse"), (0x20B3, "...or the bottom row?"), (0x20B5, "Yes: refuse"),
        (0x20B7, "Place the item, within its limits"),
        (0x20BA, "Update the counts beside the map"),
        (0x20BD, "Wait for SPACE to be released..."),
        (0x20BF, "...(Z set while held)"), (0x20C2, "Released: go on to TAB"),
        (0x20C4, "...an item, never walls, is chosen here..."),
        (0x20C6, "...so keep waiting: one item per press"),
        (0x20C8, "TAB?"),
        (0x20CA, "...(Z set if pressed)"), (0x20CD, "Not pressed: try CTRL"),
        (0x20CF, "Yes: delete what is under the cursor..."),
        (0x20D2, "...and update the counts"),
        (0x20D5, "Wait while B (not TAB) is held, with an item chosen..."),
        (0x20D7, "...(Z set while held)"), (0x20DA, "B not held: go on to CTRL"), (0x20DC, "...is an item chosen?"), (0x20DE, "Yes: keep waiting while B is held"),
        (0x20E0, "CTRL?"),
        (0x20E2, "...(Z set if pressed)"), (0x20E5, "Not pressed: next pass"),
        (0x20E7, "Yes: draw the door-key links..."),
        (0x20EA, "...while CTRL is held..."),
        (0x20EC, "...(Z set while held)"), (0x20EF, "Still held: keep the lines showing"),
        (0x20F1, "...then draw them again, which erases them"),
        (0x20F4, "Next pass"),
    ])
    for addr, name in [(0x1FC0, "slow_wait"), (0x1FCC, "check_f0"),
                       (0x1FDB, "wait_f0_released"), (0x1FE2, "check_save"),
                       (0x2024, "edit_keys"), (0x203A, "check_cursor_up"),
                       (0x204E, "set_colour_up"), (0x2051, "wait_up_released"),
                       (0x2058, "check_cursor_down"), (0x2067, "set_colour_down"),
                       (0x206A, "wait_down_released"), (0x2071, "check_item_keys"),
                       (0x2085, "check_next_item"), (0x2096, "check_space"),
                       (0x20A7, "place_not_edge"), (0x20BD, "wait_space_released"),
                       (0x20C8, "check_tab"), (0x20D5, "wait_b_released"),
                       (0x20E0, "check_ctrl"), (0x20EA, "wait_ctrl_released"),
                       (0x20F4, "next_pass")]:
        main.label(addr, name)

    main.sub(0x20F7, "check_door_keys", "Check that every door has its key",
             "Count the door-key links in use and compare with door_count. "
             "A link is made only when a key is placed for a waiting door, "
             "and each door has at most one, so equal counts mean that no "
             "door lacks its key. The edit loop requires it before saving.",
             on_exit={"Z": "set if every door has a key"})
    comments(main, [
        (0x20F7, "Count the links in use..."),
        (0x20F9, "...in scratch..."), (0x20FB, "...over links 19 to 0"), (0x20FD, "This link's door slot..."), (0x2100, "...negative: the link is free"),
        (0x2102, "In use: count it"), (0x2104, "Next link"), (0x2105, "...until all 20 are counted"),
        (0x2107, "...and compare with the doors"),
        (0x2109, "...Z set if every door has its key"), (0x210B, "Return"),
    ])
    main.label(0x20FD, "count_links")
    main.label(0x2104, "next_link")

    main.sub(0x210C, "key_pressed", "Test a key",
             "The edit loop's key test: OSBYTE &81 with the INKEY number in X.",
             on_entry={"X": "INKEY number (negative, as a byte)"},
             on_exit={"Z": "set if the key is pressed"})
    comments(main, [
        (0x210C, "OSBYTE &81: scan the key..."),
        (0x210E, "...Y = &FF: test the key whose INKEY number is X"), (0x2110, "Scan it: X = Y = &FF if the key is held"),
        (0x2113, "Z set if X and Y are both &FF"),
        (0x2115, "Y not &FF: not pressed (Z clear)"), (0x2117, "...Z set if X is &FF too: pressed"), (0x2119, "Return"),
    ])
    main.label(0x2119, "key_pressed_done")

    main.sub(0x211A, "choose_filing_system", "Ask for disc or tape",
             "Called before a level is loaded, by save_level before the "
             "filename, and by catalogue before *CAT. Disc: *DISC, then ask for the drive (0-3) and *DRIVE it. "
             "Tape: *TAPE.",
              on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(main, [
        (0x211A, "Ask: disc (D) or tape (T)"),
        (0x211C, "...high byte of the prompt"), (0x211E, "...first answer: D (internal key &32)..."), (0x2120, "...for ask_key"), (0x2122, "...second answer: T (internal key &23)"),
        (0x2124, "...for ask_key"), (0x2126, "...A = 0: one of two keys"), (0x2128, "...ask, A = 0 for D or 1 for T"),
        (0x212B, "T: tape"),
        (0x212D, "D: *DISC"),
        (0x212F, "...high byte of the command"), (0x2131, "...select the disc filing system"),
        (0x2134, "New line"),
        (0x2137, "Ask which drive..."),
        (0x2139, "...high byte of the prompt"), (0x213B, "...A = 1: answer with a drive digit"), (0x213D, "...ask, A = the digit typed"),
        (0x2140, "...and put the digit in drive_command"),
        (0x2143, "*DRIVE n"),
        (0x2145, "...high byte of the command"), (0x2147, "...select that drive"),
        (0x214A, "Return"),
        (0x214B, "Tape: *TAPE"),
        (0x214D, "...high byte of the command"), (0x214F, "...select the cassette filing system"),
        (0x2152, "Return"),
    ])
    main.label(0x214B, "choose_tape")

    main.sub(0x2153, "set_edit_screen", "Send edit_screen_vdu",
             "No cursor, 30 rows, and colours 10 and 9.",
              on_exit={"A": "corrupted", "X": "corrupted", "Y": "preserved"})
    comments(main, [
        (0x2153, "Send its &21 bytes"),
        (0x2155, "Next byte of the VDU commands..."), (0x2158, "...send it"), (0x215B, "...on to the next"), (0x215C, "...all &21 sent?"),
        (0x215E, "No: send the next"), (0x2160, "Return"),
    ])
    main.label(0x2155, "send_edit_screen")

    main.sub(0x2161, "crypt_level", "Encrypt or decrypt the level file",
             "Exclusive-OR each byte of &2700-&29AF with the low byte of its "
             "address, as the game's decrypt_level does at &6B00. Doing it "
             "twice restores the bytes. It decrypts a level once loaded, and "
             "save_level uses it to encrypt the level (decrypting it first "
             "when it was encrypted by an earlier save).",
              on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(main, [
        (0x2161, "Point at &2700, X counting the offset..."),
        (0x2163, "...X = 0: the offset within the level"), (0x2164, "...Y = 0: scratch itself steps"), (0x2165, "...low byte of &2700"), (0x2167, "...page &27, the level file"),
        (0x2169, "...high byte"),
        (0x216B, "Exclusive-OR the byte with the offset's low byte..."),
        (0x216D, "...the offset's low byte, as the key..."), (0x216F, "...applied: XOR again undoes it"), (0x2171, "...next offset"), (0x2172, "...put the byte back"),
        (0x2174, "Next byte"),
        (0x2176, "No page crossed"), (0x2178, "...into the next page of the level"),
        (0x217A, "Until &29B0"),
        (0x217C, "...the low byte of &29B0?"), (0x217E, "No: next byte"), (0x2180, "...and the high byte?"), (0x2182, "...of &29B0?"),
        (0x2184, "No: next byte"), (0x2186, "Return"),
    ])
    main.label(0x216B, "crypt_byte")
    main.label(0x217A, "crypt_check_end")

    main.sub(0x2187, "set_colour_10", "Show logical colour 10 as the chosen colour",
             "VDU 19,10,n,0,0,0 with n from colour_10. The edit loop calls it "
             "after cursor up or down changes colour_10.",
              on_entry={"colour_10": "the colour to show"}, on_exit={"A": "corrupted", "X": "preserved", "Y": "preserved"})
    comments(main, [
        (0x2187, "VDU 19,10..."),
        (0x2189, "...send VDU 19, redefine a logical colour"), (0x218C, "...logical colour 10"), (0x218E, "...send it"),
        (0x2191, "...n..."),
        (0x2194, "...send it"),
        (0x2197, "...0,0,0"),
        (0x2199, "...first"), (0x219C, "...second"), (0x219F, "...third"),
        (0x21A2, "Return"),
    ])

    main.sub(0x21A3, "show_labels", "Print the counts' labels",
             "In colour 1, at column 16 beside the map, on rows 0, 4 and 8: "
             "Objs, Mons (the trapdoors) and Dors, each above its count. "
             "Leaves colour 7 set for the counts.",
              on_exit={"A": "corrupted", "X": "corrupted", "Y": "preserved"})
    comments(main, [
        (0x21A3, "COLOUR 1"),
        (0x21A5, "...send the COLOUR code"), (0x21A8, "...red, for the labels"), (0x21AA, "...send it"),
        (0x21AD, "Print count_labels up to its CR"),
        (0x21AF, "Next label character..."), (0x21B2, "...print it"), (0x21B5, "...on to the next"), (0x21B6, "...the CR at the end?"),
        (0x21B8, "No: print the next"),
        (0x21BA, "COLOUR 7"),
        (0x21BC, "...send the COLOUR code"), (0x21BF, "...white, for the counts"), (0x21C1, "...send it"),
        (0x21C4, "Return"),
    ])
    main.label(0x21AF, "print_labels")

    main.sub(0x21C5, "show_counts", "Print the counts",
             "Objects at (17, 2), trapdoors at (17, 6) and doors at (17, 10), "
             "each under its label. Called when the editor starts and after "
             "each SPACE or TAB in the edit loop.",
              on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(main, [
        (0x21C5, "Objects at (17, 2)"),
        (0x21C7, "...row 2"), (0x21C9, "...the number of objects placed"), (0x21CB, "...print it"),
        (0x21CE, "Trapdoors at (17, 6)"),
        (0x21D0, "...row 6"), (0x21D2, "...the trapdoors placed, under Mons"), (0x21D4, "...print it"),
        (0x21D7, "Doors at (17, 10)"),
        (0x21D9, "...row 10"), (0x21DB, "...the number of doors placed"), (0x21DD, "...print it"),
        (0x21E0, "Return"),
    ])

    main.sub(0x21E1, "show_cursor_position", "Print the cursor's cell",
             "x at (17, 20) and y at (17, 21), beside the map. The edit loop "
             "calls it every pass.",
              on_entry={"cursor_x": "the cell's column", "cursor_y": "the cell's row"}, on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(main, [
        (0x21E1, "x at (17, 20)"),
        (0x21E3, "...row 20"), (0x21E5, "...the cursor's column"), (0x21E7, "...print it"),
        (0x21EA, "y at (17, 21)"),
        (0x21EC, "...row 21"), (0x21EE, "...the cursor's row"), (0x21F0, "...print it"),
        (0x21F3, "Return"),
    ])

    main.sub(0x21F4, "print_number", "Print a two-digit number at a text position",
             "Move the text cursor to (X, Y) with VDU 31 and print A (0-99) as "
             "two digits.",
             on_entry={"A": "the number", "X": "column", "Y": "row"})
    comments(main, [
        (0x21F4, "Keep the number"),
        (0x21F6, "Keep the position..."),
        (0x21F7, "...row on the stack"), (0x21F8, "...and column"), (0x21F9, "...on the stack"),
        (0x21FA, "Tens: count the 10s..."),
        (0x21FC, "...C set for the subtractions"), (0x21FD, "...X counts them"), (0x21FF, "Take away 10..."), (0x2201, "...gone below 0: X is the tens digit"),
        (0x2203, "...one more ten"), (0x2204, "...and again (always branches)"),
        (0x2206, "Units: add the last 10 back"),
        (0x2207, "...(A - &F6 = A + 10)"), (0x2209, "...Y = the units"),
        (0x220A, "VDU 31, column, row"),
        (0x220C, "...send VDU 31"), (0x220F, "...the column"), (0x2210, "...send it"), (0x2213, "...the row"),
        (0x2214, "...send it"),
        (0x2217, "Tens digit"),
        (0x2218, "...C clear for the addition"), (0x2219, "...as an ASCII digit"), (0x221B, "...print it"),
        (0x221E, "Units digit (C clear)"),
        (0x221F, "...as an ASCII digit"), (0x2221, "...print it"),
        (0x2224, "Return"),
    ])
    main.label(0x21FF, "count_tens")
    main.label(0x2206, "tens_counted")

    main.sub(0x2225, "wall_edges", "Put walls round the edge of the map",
             "Place a wall in every cell of columns 0 and 31 and rows 0 and 47, "
             "through place_item, before a level is packed for saving. It "
             "leaves cursor_x, cursor_y and current_item changed. place_item "
             "takes the top-left cell, (0, 0), for a wall already whenever a "
             "slot is free (see item_at_cursor), so that cell's wall bit is "
             "left to save_level.",
              on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(main, [
        (0x2225, "Walls..."),
        (0x2227, "...are the item place_item puts down"),
        (0x2229, "...for rows 47 to 0..."),
        (0x222B, "...moving the cursor to each in turn"),
        (0x222D, "...in column 0..."),
        (0x222F, "...the left edge"), (0x2231, "...wall it"),
        (0x2234, "...and column 31"),
        (0x2236, "...the right edge"), (0x2238, "...wall it"),
        (0x223B, "...row up"), (0x223D, "...until row 0 is done"),
        (0x223F, "For columns 31 to 0..."),
        (0x2241, "...moving the cursor to each in turn"),
        (0x2243, "...in row 0..."),
        (0x2245, "...the top edge"), (0x2247, "...wall it"),
        (0x224A, "...and row 47"),
        (0x224C, "...the bottom edge"), (0x224E, "...wall it"),
        (0x2251, "...column left"), (0x2253, "...until column 0 is done"),
        (0x2255, "Return"),
    ])
    main.label(0x222D, "wall_left_right")
    main.label(0x2243, "wall_top_bottom")

    main.label(0x2256, "break_to_save", description=(
        "BREAK intercept while saving: on the second call (C set) go back to "
        "save_level's prompt."))
    main.banner(0x2256, "BREAK intercept: back to saving",
                "Called twice during a reset; on the second call, with C set, "
                "go back to save_level, keeping the packed level in memory.")
    d.entry(0x2256)
    comments(main, [(0x2256, "Second call (after the reset)? Save again"),
                    (0x2258, "First call: return")])

    main.sub(0x2259, "save_level", "Save the level",
             "Reached from the edit loop once the level is walled in, packed "
             "and given its wall block. Point the BREAK intercept at "
             "break_to_save and BRKV at the reset entry, disable ESCAPE, ask "
             "for the level's number (nothing typed: catalogue), take its "
             "checksum from the game's level_checksums, wall the top-left "
             "cell, set the level's first byte so that its bytes sum to that "
             "checksum, encrypt it, choose disc or tape and the filename, "
             "*SAVE it and offer another level. Levels 1-24 can be saved; "
             "level 25 is in Stones. It never returns: another level "
             "restarts the editor at editor_init, and quitting resets the "
             "machine.")
    comments(main, [
        (0x2259, "BREAK intercept = JMP break_to_save..."),
        (0x225B, "...so BREAK while saving comes back here"), (0x225E, "...break_to_save's low byte..."), (0x2260, "...low byte of the intercept's address"), (0x2263, "...and high byte..."),
        (0x2265, "...high byte"),
        (0x2268, f"BRKV = {mos}'s reset entry"),
        (0x226A, "...low byte"), (0x226D, "...its high byte..."), (0x226F, "...high byte: an error resets the machine"),
        (0x2272, "OSBYTE &C8 with X=1, Y=0: disable ESCAPE"),
        (0x2274, "...X = 1: ESCAPE does nothing"), (0x2276, "...Y = 0: replace the setting"), (0x2278, "Set it, so ESCAPE cannot stop the save"),
        (0x227B, "VDU 12: clear the screen"),
        (0x227D, "...send it"),
        (0x2280, "Flush buffers"),
        (0x2282, "Discard keys pressed before the level prompt"),
        (0x2285, "Ask for the level number"),
        (0x2287, "Next prompt character..."), (0x228A, "...print it"), (0x228D, "...on to the next"), (0x228E, "...the zero at its end?"),
        (0x2290, "No: print the next"),
        (0x2292, "Point XY at read_line_block..."),
        (0x2294, "...high byte"),
        (0x2296, "...digits '0' '0' to start with..."),
        (0x2298, "...first digit"), (0x229B, "...second digit"),
        (0x229E, "...buffer filename_buffer..."),
        (0x22A0, "...low byte of the buffer"), (0x22A3, "...high byte..."), (0x22A5, "...of the buffer"),
        (0x22A8, "...two characters..."),
        (0x22AA, "...as the maximum length"),
        (0x22AD, "...'0' to '9'"),
        (0x22AF, "...lowest character accepted"), (0x22B2, "...to '9'..."), (0x22B4, "...highest character accepted"),
        (0x22B7, "OSWORD 0: read it"),
        (0x22B9, "Read the level number the user types"),
        (0x22BC, "Anything typed?"),
        (0x22BE, "Yes: level typed"),
        (0x22C0, "Nothing: catalogue, then ask again"),
        (0x22C3, "One digit?"),
        (0x22C6, "...the second character a CR?"), (0x22C8, "No: two digits"),
        (0x22CA, "Yes: the level is the digit"),
        (0x22CD, "...C set for the subtraction"), (0x22CE, "...ASCII to its value"),
        (0x22D0, "...(always branches)"),
        (0x22D2, "Two: tens..."),
        (0x22D5, "...a CR in the first place?"), (0x22D7, "Yes: ask again"), (0x22D9, "...C set for the subtraction"), (0x22DA, "...ASCII to its value"),
        (0x22DC, "...x 2..."),
        (0x22DD, "...kept..."), (0x22DF, "...x 4..."), (0x22E0, "...x 8..."), (0x22E1, "...C clear for the addition"),
        (0x22E2, "...+ x 2: x 10"),
        (0x22E4, "...plus units"),
        (0x22E7, "...C set for the subtraction"), (0x22E8, "...less the units digit's ASCII bias"),
        (0x22EA, "Level 0?"),
        (0x22EC, "No: check the top"),
        (0x22EE, "Yes: ask again"),
        (0x22F1, "25 or more?"),
        (0x22F3, "No: 1-24, a level the game loads from a file"),
        (0x22F5, "Yes: ask again"),
        (0x22F8, "Keep the level number..."),
        (0x22FB, "...X = level, to index the checksums"),
        (0x22FC, "...the game's checksum for that level..."), (0x22FF, "...which the level's bytes must sum to"),
        (0x2302, "Line feed"),
        (0x2304, "...send it"),
        (0x2307, "Saved already (so encrypted)?"),
        (0x230A, "No: the level is still plain"),
        (0x230C, "Yes: decrypt it again"),
        (0x230F, "Wall cell (0, 0), which wall_edges may have missed"),
        (0x2312, "...bit 7 of the wall map's first byte..."), (0x2314, "...set in the level file"),
        (0x2317, "Sum the level's bytes, with the first byte 0..."),
        (0x2319, "...Y = 0: scratch steps through the file"), (0x231A, "...first byte 0, so it adds nothing"), (0x231D, "...the sum starts at 0"), (0x231F, "...pointer at &2700, low byte..."),
        (0x2321, "...page &27, the level file"), (0x2323, "...high byte"),
        (0x2325, "Next byte of the level..."), (0x2327, "...C clear for the addition"), (0x2328, "...added to the sum..."), (0x232A, "...modulo 256"),
        (0x232C, "Next byte"), (0x232E, "No page crossed"), (0x2330, "...into the next page"),
        (0x2332, "...to &29AF"),
        (0x2334, "...the low byte of &29B0?"), (0x2336, "No: next byte"), (0x2338, "...and the high byte?"), (0x233A, "...of &29B0?"),
        (0x233C, "No: next byte"),
        (0x233E, "First byte = checksum - sum (modulo 256)..."),
        (0x2340, "...compared with the checksum"), (0x2343, "Sum below the checksum"),
        (0x2345, "...(sum above the checksum: &FF - sum + checksum + 1)..."),
        (0x2346, "...&FF..."), (0x2348, "...less the sum..."), (0x234A, "...C clear for the addition"), (0x234B, "...plus the checksum..."),
        (0x234E, "...plus 1"), (0x2350, "...store it"),
        (0x2353, "...(otherwise checksum - sum)"),
        (0x2354, "...the checksum..."), (0x2357, "...less the sum"),
        (0x2359, "...so that the level's sum is its checksum"),
        (0x235C, "Encrypt it"),
        (0x235F, "Mark it encrypted"),
        (0x2361, "...so a second save decrypts it first"),
        (0x2364, "Choose disc or tape"),
        (0x2367, "Blank the filename in save_command..."),
        (0x2369, "...offset 5, where the name goes..."), (0x236B, "...a space..."), (0x236E, "...on to the next"), (0x236F, "...up to offset 11?"),
        (0x2371, "No: blank the next"),
        (0x2373, "Ask for the filename"),
        (0x2376, "Line feed"),
        (0x2378, "...send it"),
        (0x237B, "Copy it into save_command..."),
        (0x237D, "Next filename character..."), (0x2380, "...into the command"), (0x2383, "...on to the next"), (0x2384, "...all the characters typed?"),
        (0x2386, "No: copy the next"),
        (0x2388, "*SAVE name 2700+2B0"),
        (0x238A, "...high byte"), (0x238C, "...save the level file"),
        (0x238F, "Line feed"),
        (0x2391, "...send it"),
        (0x2394, "Ask: another level (A) or quit (Q)"),
        (0x2396, "...high byte of the prompt"), (0x2398, "...first answer: A (internal key &41)..."), (0x239A, "...for ask_key"), (0x239C, "...second answer: Q (internal key &10)"),
        (0x239E, "...for ask_key"), (0x23A0, "...A = 0: one of two keys"), (0x23A2, "...ask, A = 0 for A or 1 for Q"),
        (0x23A5, "Quit?"),
        (0x23A7, "A: restart the editor for another level"),
        (0x23AA, "Quit: disable the BREAK intercept..."),
        (0x23AC, "...so the reset starts the machine afresh"),
        (0x23AF, "...and reset"),
    ])
    for addr, name in [(0x2280, "ask_level_number"), (0x2287, "print_level_prompt"),
                       (0x22C3, "level_typed"), (0x22D2, "two_digits"),
                       (0x22EA, "check_level_number"), (0x22F1, "level_not_zero"),
                       (0x22F8, "level_number_ok"), (0x230F, "set_checksum"),
                       (0x2325, "sum_level"), (0x2332, "sum_check_end"),
                       (0x2353, "sum_below"), (0x2359, "store_first_byte"),
                       (0x236B, "blank_save_name"), (0x237D, "copy_save_name"),
                       (0x23AA, "quit")]:
        main.label(addr, name)

    main.sub(0x23C9, "catalogue", "Catalogue the disc or tape",
             "Reached from save_level when RETURN is pressed with no level "
             "number. Show CAT after the prompt, as the answer, choose disc "
             "or tape, *CAT, "
             + ("" if model_b else "show the disc's free space with Table's routine, ")
             + "then ask for the level number again.")
    comments(main, [
        (0x23C9, "Move up a line..."),
        (0x23CB, "...back onto the prompt's line"),
        (0x23CE, "...and right past its 29 characters..."),
        (0x23D0, "...29 times..."), (0x23D2, "...one place right..."), (0x23D5, "...counted"), (0x23D6, "...until all 29 are done"),
        (0x23D8, "...and show CAT"),
        (0x23DA, "...print it"), (0x23DD, "...'A'..."), (0x23DF, "...print it"), (0x23E2, "...'T'"),
        (0x23E4, "...print it"),
        (0x23E7, "New line"),
        (0x23EA, "Choose disc or tape"),
        (0x23ED, "New line"),
        (0x23F0, "*CAT"),
        (0x23F2, "...high byte"), (0x23F4, "...list the files"),
        (0x23F7, "Show the free space (Table's *FREE)"),
        (0x23FA, "New line"),
        (0x23FD, "Ask for the level number again"),
    ])
    main.label(0x23D2, "move_right_29")

    # -----------------------------------------------------------------------
    # Choosing the wall block.

    main.sub(0x2400, "choose_wall_block", "Choose the level's wall block",
             "Called from the edit loop when saving, after the level is "
             "packed. Clear the screen, show 25 rows, load Stones (the 24 wall "
             "blocks) at &6E80, draw them in a grid of four by six and frame "
             "block 0. Move the frame with ',' '.' (one) and 'A' 'Z' (a row), "
             "paced by a delay loop; SPACE copies the chosen block into the "
             "level's wall block and returns.",
              on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(main, [
        (0x2400, "VDU 12: clear the screen"),
        (0x2402, "...send it"),
        (0x2405, "Show 25 rows, hiding &6E80 on, where Stones goes"),
        (0x2408, "Load Stones"),
        (0x240B, "(padding)"),
        (0x240C, "Padding"), (0x240D, "Padding"), (0x240E, "Padding"),
        (0x240F, "Block 0 chosen"),
        (0x2411, "...to start with"),
        (0x2414, "Draw the 24 blocks"),
        (0x2417, "Frame block 0"),
        (0x2419, "...draw the frame round it"),
        (0x241C, "Pause..."),
        (0x241E, "...255 x 100 loops..."), (0x2420, "...inner count"), (0x2421, "...until 0"), (0x2423, "...outer count"),
        (0x2424, "...until 0: slow enough to steer"),
        (0x2426, "Read the movement keys"),
        (0x2429, "SPACE?"),
        (0x242B, "...(Z set if pressed)"), (0x242E, "Not pressed: redraw if the choice moved"),
        (0x2430, "Yes: the block's address, &6E80 + block x &30..."),
        (0x2432, "...high byte, in plot_y, starts at 0"), (0x2434, "...the chosen block number..."), (0x2437, "...x 2..."),
        (0x2438, "...x 4..."), (0x2439, "...x 8..."), (0x243A, "...x 16, the carry..."), (0x243B, "...into the high byte"),
        (0x243D, "...block x 16, low byte..."), (0x243F, "...and high byte..."), (0x2441, "...kept"),
        (0x2443, "...block x 16 again..."),
        (0x2445, "...x 2: block x 32..."), (0x2446, "...carry into the high byte"), (0x2448, "...C clear for the addition"),
        (0x2449, "...+ x 16: block x 48 (&30), low byte..."),
        (0x244B, "...kept in plot_x"), (0x244D, "...high byte..."), (0x244F, "...plus x 16's high byte, with the carry"), (0x2451, "...kept in plot_y"),
        (0x2453, "...C clear for the addition"), (0x2454, "...offset low byte..."), (0x2456, "...plus where Stones' blocks start..."), (0x2458, "...pointer low byte"),
        (0x245A, "...offset high byte..."), (0x245C, "...plus the start's high byte"), (0x245E, "...pointer high byte"),
        (0x2460, "Copy its &30 bytes into level_wall_block"),
        (0x2462, "Next byte of the chosen block..."), (0x2464, "...into the level file"), (0x2467, "...down to the first"), (0x2468, "...until all &30 are copied"),
        (0x246A, "Return"),
        (0x246B, "Did the keys move the choice?"),
        (0x246E, "...still the block chosen before?"),
        (0x2471, "Not moved: pause and read the keys again"),
        (0x2473, "Yes: wait for the frame..."),
        (0x2475, "Pace the chooser to the display"),
        (0x2478, "...erase the old frame..."),
        (0x247B, "...the new choice kept"), (0x247C, "...the old one..."), (0x247F, "...made current for the frame"), (0x2482, "...the blank frame sprite..."),
        (0x2484, "...rubbed out round the old block"), (0x2487, "...the new choice back"), (0x2488, "...as the chosen block"),
        (0x248B, "...and frame the new block"),
        (0x248D, "...drawn round it"),
        (0x2490, "Pause and read the keys again"),
    ])
    for addr, name in [(0x241C, "chooser_loop"), (0x241E, "chooser_pause"),
                       (0x2420, "chooser_pause_inner"), (0x2462, "copy_wall_block"),
                       (0x246B, "chooser_moved")]:
        main.label(addr, name)

    main.sub(0x2493, "draw_wall_blocks", "Draw the 24 wall blocks",
             "Plot sprites &12-&29 at their places in the grid.",
              on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(main, [
        (0x2493, "For blocks 23 to 0..."),
        (0x2495, "Keep the block number..."), (0x2496, "...on the stack"),
        (0x2497, "...sprite &12 + block..."),
        (0x2498, "...its sprite in the editor's tables"), (0x249A, "...to plot"),
        (0x249C, "...at the block's place"),
        (0x249D, "...set plot_x, plot_y for it"), (0x24A0, "...plot the block"),
        (0x24A3, "...the block number back"), (0x24A4, "...into X"), (0x24A5, "...the block before"), (0x24A6, "...until block 0 is drawn"),
        (0x24A8, "Return"),
    ])
    main.label(0x2495, "draw_wall_block")

    main.sub(0x24A9, "move_chooser", "Move the chosen wall block",
             "'.' and ',' move one block on or back, 'Z' and 'A' a row of four; "
             "a move off the grid is undone. Only one key is taken each call. "
             "choose_wall_block compares the two blocks afterwards to see "
             "whether the frame must be moved.",
             on_exit={"chosen_block": "the block now chosen",
                      "previous_block": "the block chosen before"})
    comments(main, [
        (0x24A9, "Remember the block chosen"),
        (0x24AC, "...to compare after moving"),
        (0x24AF, "'.' pressed?"),
        (0x24B1, "...(Z set if pressed)"), (0x24B4, "Not pressed: try ','"),
        (0x24B6, "Yes: the next block..."),
        (0x24B9, "...read it"), (0x24BC, "...past the last block?"), (0x24BE, "No: the move stands"),
        (0x24C0, "Past 23: undo it"),
        (0x24C2, "',' pressed?"),
        (0x24C4, "...(Z set if pressed)"), (0x24C7, "Not pressed: try Z"),
        (0x24C9, "Yes: the previous block..."),
        (0x24CC, "Still 0 or more: the move stands"),
        (0x24CE, "Below 0: undo it"),
        (0x24D0, "'Z' pressed?"),
        (0x24D2, "...(Z set if pressed)"), (0x24D5, "Not pressed: try A"),
        (0x24D7, "Yes: a row on..."),
        (0x24D8, "...the chosen block..."), (0x24DB, "...4 on, the block below in the grid"), (0x24DD, "...kept"), (0x24E0, "...past the last block?"),
        (0x24E2, "Within the 24: the move stands"),
        (0x24E4, "Past 23: undo it"),
        (0x24E6, "'A' pressed?"),
        (0x24E8, "...(Z set if pressed)"), (0x24EB, "Not pressed: no move"),
        (0x24ED, "Yes: a row back..."),
        (0x24EE, "...the chosen block..."), (0x24F1, "...4 back, the block above in the grid"), (0x24F3, "...kept"), (0x24F6, "Still 0 or more: the move stands"),
        (0x24F8, "Below 0: undo it"),
        (0x24FA, "Return"),
        (0x24FB, "Off the grid: undo the move"),
        (0x24FE, "...restore the block chosen before"), (0x2501, "Return"),
    ])
    for addr, name in [(0x24C2, "check_back"), (0x24D0, "check_row_on"),
                       (0x24E6, "check_row_back"), (0x24FA, "chooser_moved_ok"),
                       (0x24FB, "undo_move")]:
        main.label(addr, name)

    main.sub(0x2502, "chooser_key_pressed", "Test a key",
             "OSBYTE &81 with the INKEY number in X, as key_pressed.",
             on_entry={"X": "INKEY number"}, on_exit={"Z": "set if pressed"})
    comments(main, [
        (0x2502, "OSBYTE &81: scan the key..."),
        (0x2504, "...Y = &FF: test the key whose INKEY number is X"), (0x2506, "Scan it: X = Y = &FF if the key is held"),
        (0x2509, "Z set if X and Y are both &FF"),
        (0x250B, "X not &FF: not pressed (Z clear)"), (0x250D, "...Z set if Y is &FF too: pressed"), (0x250F, "Return"),
    ])
    main.label(0x250F, "chooser_key_done")

    main.sub(0x2510, "block_place", "Find a wall block's place in the grid",
             "Block n is at column n mod 4, row n div 4: plot_x = 8 x column + "
             "&1A, plot_y = 24 x row + &14. Each block is 4 bytes by 12 rows, "
             "so the grid leaves room for the frame between them.",
             on_entry={"A": "block number"},
             on_exit={"plot_x": "the block's screen byte column",
                      "plot_y": "its pixel row", "X": "the block number",
                      "C": "clear"})
    comments(main, [
        (0x2510, "Keep the block number"),
        (0x2511, "plot_x = (n mod 4) x 8 + &1A"),
        (0x2513, "...x 2..."), (0x2514, "...x 4..."), (0x2515, "...x 8 bytes across..."), (0x2516, "...C clear for the addition"),
        (0x2517, "...from column &1A"), (0x2519, "...as plot_x"),
        (0x251B, "plot_y = (n div 4) x 24 + &14"),
        (0x251C, "...the block's grid row x 4..."), (0x251E, "...x 8..."), (0x251F, "...kept..."), (0x2521, "...x 16..."),
        (0x2522, "...C clear for the addition"), (0x2523, "...+ x 8: the row x 24 pixel rows"), (0x2525, "...from pixel row &14"), (0x2527, "...as plot_y"),
        (0x2529, "Return"),
    ])

    main.sub(0x252A, "frame_block", "Draw or erase the frame round the chosen block",
             "Plot sprite A (&2A the frame, &2B a blank), 6 bytes by 18 rows, "
             "one byte left of and three rows above the chosen block, so that "
             "it surrounds the 4-byte by 12-row block, then plot the block "
             "again inside it.",
             on_entry={"A": "&2A to frame, &2B to erase"})
    comments(main, [
        (0x252A, "The frame sprite..."),
        (0x252C, "...at the chosen block's place..."),
        (0x252F, "...set plot_x, plot_y"),
        (0x2532, "...one byte left..."),
        (0x2534, "...and up (C is clear from block_place)..."),
        (0x2536, "...SBC #2 with C clear: three rows up"), (0x2538, "...kept"),
        (0x253A, "Plot it"),
        (0x253D, "Then the block itself"),
        (0x2540, "...set plot_x, plot_y"), (0x2543, "...its number..."), (0x2546, "...C clear for the addition"), (0x2547, "...as its sprite"),
        (0x2549, "...to plot"), (0x254B, "...plot it inside the frame"),
        (0x254E, "Return"),
    ])
    main.label(0x254F, "load_stones_command")
    main.stringcr(0x254F)

    main.sub(0x255B, "show_25_rows", "Show 25 rows",
             "Send VDU 23,0,6,25,0,0,0,0,0,0: 6845 register 6, the rows "
             "displayed, = 25. Row 25 starts at &6E80, where load_stones puts "
             "Stones, so the wall-block chooser does not show it.",
              on_exit={"A": "corrupted", "X": "corrupted", "Y": "preserved"})
    comments(main, [
        (0x255B, "Send rows_25_vdu"),
        (0x255D, "Next byte of the VDU command..."), (0x2560, "...send it"), (0x2563, "...on to the next"), (0x2564, "...all ten sent?"),
        (0x2566, "No: send the next"), (0x2568, "Return"),
    ])
    main.label(0x255D, "send_25_rows")
    main.label(0x2569, "rows_25_vdu", length=10)
    main.byte(0x2569, 10, cols=10)
    main.banner(0x2573, "Unused", "Leftover bytes: a fragment of BBC BASIC assembler.")
    main.string(0x2573, 13)
    main.label(0x2580, "frame_sprite", length=0x6C, description=(
        "Sprite &2A: the frame round the chosen wall block, 6 bytes by 18 rows."))
    main.banner(0x2580, "The chooser's frame",
                "Sprite &2A: 6 bytes by 18 pixel rows.")
    main.byte(0x2580, 0x6C, cols=6)
    main.banner(0x25EC, "Unused", "Leftover bytes.")
    main.byte(0x25EC, 4, cols=4)
    main.c(0x25EC, "Not used")

    main.banner(0x25F0, "Variables")
    for addr, name, text in [
        (0x25F0, "new_level_flag", "1 if a new, empty level is being made; 0 to edit a loaded one."),
        (0x25F1, "level_number", "The level number typed when saving."),
        (0x25F2, "level_checksum", "That level's checksum."),
        (0x25F3, "slow_cursor", "Non-zero for the slow cursor (three frames a pass); f0 toggles it."),
        (0x25F4, "colour_10", "The colour logical colour 10 shows, 1-7."),
        (0x25F5, "cursor_flash", "Toggled each pass when placing walls; the cursor is plotted when it is 1."),
        (0x25F8, "chosen_block", "The wall block chosen."),
        (0x25F9, "previous_block", "The wall block chosen before the last move."),
        (0x25FA, "level_encrypted", "1 once the level in the buffer has been encrypted for saving."),
    ] + ([] if model_b else [
        (0x25FF, "table_loaded_flag", "&6F once Table has been loaded."),
    ]):
        main.label(addr, name, description=text)
    for addr in (0x25F0, 0x25F1, 0x25F2, 0x25F3, 0x25F4, 0x25F5, 0x25F8,
                 0x25F9, 0x25FA) + (() if model_b else (0x25FF,)):
        main.byte(addr)
    main.byte(0x25F6, 2, cols=2)
    main.c(0x25F6, "Not referenced")
    main.label(0x25FB, "drive_keys", length=4, description=(
        "Internal key numbers of 0, 1, 2 and 3, the drive digits."))
    main.byte(0x25FB, 4, cols=4)

    # -----------------------------------------------------------------------
    # Packing the level for saving.

    main.sub(0x2600, "pack_items", "Pack the item slots into the level file",
             "Go through the slots from the last (&4F) to the first, so that "
             "the tables come out in the reverse of the order unpack_level "
             "read them: objects into entries 1 upwards (the exit always into "
             "entry 30), trapdoors into entries 0-7, and each door with its "
             "linked key into the next door entry. Keys and free slots are "
             "skipped.",
              on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(main, [
        (0x2600, "No objects, trapdoors or doors packed yet"),
        (0x2602, "...objects"), (0x2605, "...trapdoors"), (0x2608, "...doors"),
        (0x260B, "For slots &4F to 0..."),
        (0x260D, "...what is in it?"),
        (0x2610, "Free slot: skip it"),
        (0x2612, "The exit?"),
        (0x2614, "Yes: always object entry 30"),
        (0x2616, "A trapdoor?"),
        (0x2618, "Yes: the trapdoor table"),
        (0x261A, "A door or key?"),
        (0x261C, "Yes: the door tables"),
        (0x261E, "An object: the next entry..."),
        (0x2621, "...its level type..."),
        (0x2622, "...as the game's object type"), (0x2625, "...the entry number"), (0x2628, "...into the level's object types"),
        (0x262B, "...and position"),
        (0x262E, "...into the level's object x"), (0x2631, "...y..."), (0x2634, "...into the level's object y"),
        (0x2637, "Next slot"),
        (0x2638, "...until slot 0 is done"), (0x263A, "Return"),
        (0x263B, "The exit: entry 30, type &51"),
        (0x263D, "...the exit's entry in the object tables"), (0x263F, "...its type"), (0x2642, "...its x..."), (0x2645, "...into the level"),
        (0x2648, "...its y..."), (0x264B, "...into the level"),
        (0x264E, "Next slot (always branches)"),
        (0x2650, "A trapdoor: the next trapdoor entry"),
        (0x2653, "...its x..."), (0x2656, "...into the level's trapdoor table"), (0x2659, "...its y..."), (0x265C, "...into the level's trapdoor table"),
        (0x265F, "...count it"),
        (0x2662, "Next slot (always branches)"),
        (0x2664, "A key?"),
        (0x2666, "Yes: skip it, as it is packed with its door"),
        (0x2668, "A door: the next door entry..."),
        (0x266B, "...its sprite..."),
        (0x266C, "...as the game's door sprite"), (0x266F, "...the entry number"), (0x2672, "...into the level's door sprites"),
        (0x2675, "...and position"),
        (0x2678, "...into the level's door x"), (0x267B, "...y..."), (0x267E, "...into the level's door y"),
        (0x2681, "Find the link whose door is this slot..."),
        (0x2683, "...over links 19 to 0"), (0x2685, "This link's door slot..."), (0x2688, "...the door's slot?"), (0x268A, "Yes: Y is its link"),
        (0x268C, "...next link"), (0x268D, "...until all 20 are tried"),
        (0x268F, "...and put its key's position in the same entry"),
        (0x2690, "...keeping the door's slot"), (0x2691, "...the key's slot..."), (0x2694, "...into X"), (0x2695, "...the door's entry number"),
        (0x2698, "...the key's x..."), (0x269B, "...as the door's key x"), (0x269E, "...the key's y..."), (0x26A1, "...as the door's key y"),
        (0x26A4, "...the door's slot back"), (0x26A5, "...into X"),
        (0x26A6, "Next slot"),
    ])
    for addr, name in [(0x260D, "pack_slot"), (0x2637, "pack_next"),
                       (0x263B, "pack_exit"), (0x2650, "pack_trapdoor"),
                       (0x2664, "pack_door"), (0x2685, "find_door_link"),
                       (0x268F, "pack_key")]:
        main.label(addr, name)

    main.sub(0x26A9, "pack_level", "Pack the level for saving",
             "Called from the edit loop when saving, after wall_edges. Pack "
             "the item slots, then copy the wall map and the object-free map "
             "into the level file.",
              on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(main, [
        (0x26A9, "Pack the items"),
        (0x26AC, "Copy the &C9 bytes of each map"),
        (0x26AE, "Next wall-map byte..."), (0x26B1, "...into the level file"), (0x26B4, "...and the object-free map byte..."), (0x26B7, "...into the level file"),
        (0x26BA, "...on to the next"), (0x26BB, "...all &C9 copied?"), (0x26BD, "No: copy the next"),
        (0x26BF, "Return"),
    ])
    main.label(0x26AE, "copy_maps")
    main.banner(0x26C0, "Unused", "Zeros.")
    main.byte(0x26C0, 0x10, cols=8)
    main.c(0x26C0, "Not used")

    main.sub(0x26D0, "load_stones", "Load the wall blocks",
             "*LOAD STONES (at its own address, &6E80) with VDU output off. "
             "Called by choose_wall_block, with the disc already selected.",
              on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(main, [
        (0x26D0, "VDU 21: output off"),
        (0x26D2, "...so the *LOAD message does not show"),
        (0x26D5, "*LOAD STONES"),
        (0x26D7, "...high byte"), (0x26D9, "...load the 24 wall blocks"),
        (0x26DC, "VDU 6: output on"),
        (0x26DE, "...send it"),
        (0x26E1, "Return"),
    ])
    main.banner(0x26E2, "Unused", "Zeros.")
    main.byte(0x26E2, 0x1E, cols=8)
    main.c(0x26E2, "Not used")

    # -----------------------------------------------------------------------
    # The level buffer's tail and the item sprites (not moved).

    main.banner(0x2900, "Unused", "Leftover bytes, covered by the level file "
                "(&2700-&29AF) when one is loaded.")
    main.byte(0x2900, 0x80, cols=8)
    main.c(0x2900, "Not used: the level file's &2900-&29AF when one is loaded")
    main.byte(0x2980, 0x30, cols=8)
    main.c(0x2980, "Not used: the level's wall block when one is loaded")
    main.byte(0x29B0, 0x46, cols=8)
    main.c(0x29B0, "Not used")
    main.label(0x29F6, "cursor_sprite", length=10, description="Sprite &2C: the cursor.")
    main.banner(0x29F6, "Sprites", "The cursor (sprite &2C), then the 16 "
                "items (sprites 0-&0F) and the door waiting for its key (&11), "
                "each two bytes by five pixel rows.")
    main.byte(0x29F6, 10, cols=10)
    main.label(0x2A00, "item_sprites", length=0xA0, description=(
        "Sprites 0-&0F, the editor's items: wall, exit, energy drainer, "
        "trapdoor, treasure, food, teleporter, magic sword, magic helmet, "
        "potion, weapons, Cross, boots, the two doors and the key."))
    for n in range(16):
        main.byte(0x2A00 + 10 * n, 10, cols=2)
        main.c(0x2A00 + 10 * n, f"Sprite &{n:02X}: {EDITOR_SPRITES[n][1].replace('_', ' ')}")
    main.label(0x2AA0, "waiting_door_sprite", length=10, description="Sprite &11: a door waiting for its key.")
    main.byte(0x2AA0, 10, cols=10)
    main.banner(0x2AAA, "Unused", "Leftover bytes.")
    main.byte(0x2AAA, 0x56, cols=8)
    main.c(0x2AAA, "Not used")

    # -----------------------------------------------------------------------
    # The cursor and items.

    main.sub(0x2B00, "move_cursor", "Move the cursor",
             "Called at the start of every edit-loop pass. Wait for the frame, "
             "rub out the cursor and put back what is under it, move with ',' "
             "'.' 'A' 'Z' within the 32 by 48 map (one step in x and one in y "
             "at most), and plot the current item there as the cursor. So "
             "the cursor shows what SPACE would place.",
              on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(main, [
        (0x2B00, "Wait for the frame"),
        (0x2B02, "Pace the cursor's movement to the display"),
        (0x2B05, "Rub out the cursor (the blank sprite)"),
        (0x2B07, "...at the cursor's cell"),
        (0x2B0A, "Anything here?"),
        (0x2B0D, "Empty: leave the cell blank"),
        (0x2B0F, "Yes: redraw the wall or item the cursor covered"),
        (0x2B12, "'.' (key_right) pressed?"),
        (0x2B14, "...(Z set if pressed)"), (0x2B17, "Not pressed: try left"),
        (0x2B19, "Yes: one column right..."),
        (0x2B1B, "...always branches; clamp_cursor limits it"),
        (0x2B1D, "',' (key_left) pressed?"),
        (0x2B1F, "...(Z set if pressed)"), (0x2B22, "Not pressed: try up"),
        (0x2B24, "Yes: left, to at least 0"),
        (0x2B26, "Still 0 or more: done"), (0x2B28, "Off the left: back to column 0"), (0x2B2A, "...as the cursor's column"),
        (0x2B2C, "'A' (key_up) pressed?"),
        (0x2B2E, "...(Z set if pressed)"), (0x2B31, "Not pressed: try down"),
        (0x2B33, "Yes: up, to at least 0"),
        (0x2B35, "Still 0 or more: done"), (0x2B37, "Off the top: back to row 0"), (0x2B39, "...as the cursor's row"), (0x2B3B, "...(always branches)"),
        (0x2B3D, "'Z' (key_down) pressed?"),
        (0x2B3F, "...(Z set if pressed)"), (0x2B42, "Not pressed: done"),
        (0x2B44, "Yes: one row down..."),
        (0x2B46, "...always branches; clamp_y limits it"),
        (0x2B48, "At most column 31..."),
        (0x2B4A, "...one past the right-hand column?"), (0x2B4C, "No: keep it"), (0x2B4E, "Yes: back to the right-hand column"), (0x2B50, "...as the cursor's column"),
        (0x2B52, "...and row 47"),
        (0x2B54, "...one past the bottom row?"), (0x2B56, "No: keep it"), (0x2B58, "Yes: back to the bottom row"), (0x2B5A, "...as the cursor's row"),
        (0x2B5C, "Plot the current item at the cursor..."),
        (0x2B5E, "...as the cursor, over whatever is there"),
        (0x2B61, "Return"),
    ])
    for addr, name in [(0x2B12, "check_right"), (0x2B1D, "check_left"),
                       (0x2B2C, "check_up"), (0x2B3D, "check_down"),
                       (0x2B48, "clamp_cursor"), (0x2B52, "clamp_y"),
                       (0x2B5C, "plot_cursor")]:
        main.label(addr, name)

    main.sub(0x2B62, "plot_at_cursor", "Plot a sprite in the cursor's cell",
             "At screen byte column 2x and pixel row 5y.",
             on_entry={"A": "sprite number"})
    comments(main, [
        (0x2B62, "The sprite..."),
        (0x2B64, "...at column 2x..."),
        (0x2B66, "...two screen bytes per cell..."), (0x2B67, "...as plot_x"),
        (0x2B69, "...and row 5y"),
        (0x2B6B, "...x 2..."), (0x2B6C, "...x 4..."), (0x2B6D, "...C clear for the addition"), (0x2B6E, "...+ y: five pixel rows per cell"),
        (0x2B70, "...as plot_y"),
        (0x2B72, "Plot it"),
        (0x2B75, "Return"),
    ])

    main.sub(0x2B76, "item_at_cursor", "Find what is in the cursor's cell",
             "Search the slots for an item at the cursor; failing that, look "
             "at the wall map. A free slot is item 0 at (0, 0) (see "
             "free_slot), so whenever a slot is free the top-left cell "
             "reports a wall, whatever the wall map holds there.",
             on_exit={"A": "the item's sprite and X its slot; 0 for a wall; &FF for nothing",
                      "N": "set for nothing"})
    comments(main, [
        (0x2B76, "For slots &4F to 0, free ones included..."),
        (0x2B78, "...x matches..."),
        (0x2B7B, "...the cursor's column?"), (0x2B7D, "No: next slot"),
        (0x2B7F, "...and y matches?"),
        (0x2B82, "...the cursor's row?"), (0x2B84, "No: next slot"),
        (0x2B86, "Yes: return its item (0 for a free slot)..."),
        (0x2B89, "...with X its slot"),
        (0x2B8A, "Next slot"),
        (0x2B8B, "...until slot 0 is tried"),
        (0x2B8D, "No item: is there a wall?"),
        (0x2B90, "...the map byte..."), (0x2B92, "...its bit for the cell"), (0x2B94, "Clear: nothing here"),
        (0x2B96, "Set: item 0, the wall"),
        (0x2B98, "...0: a wall (Z set)"),
        (0x2B99, "No wall: &FF"),
        (0x2B9B, "...&FF: nothing (N set)"),
    ])
    for addr, name in [(0x2B78, "search_slots"), (0x2B8A, "next_slot"),
                       (0x2B99, "nothing_here")]:
        main.label(addr, name)

    main.sub(0x2B9C, "wall_bit", "Find the cursor's bit in the wall map",
             "As the game lays out its maps: the byte at (y AND &F8) x 4 + "
             "(y AND 7) + (x AND &F8), bit 7 - (x AND 7). Used to test, set "
             "and clear walls, a door's included.",
             on_exit={"map_ptr": "address of the byte", "bit_mask": "the bit",
                      "Y": "0"})
    comments(main, [
        (0x2B9C, "(y AND &F8) x 4..."),
        (0x2B9E, "...the room row, as a multiple of 8..."), (0x2BA0, "...x 2..."), (0x2BA1, "...x 4: 32 bytes per row of rooms"), (0x2BA2, "...kept"),
        (0x2BA4, "...+ (y AND 7)..."),
        (0x2BA6, "...the cell's row within the room"), (0x2BA8, "...C clear for the addition"), (0x2BA9, "...added"), (0x2BAB, "...kept"),
        (0x2BAD, "...+ (x AND &F8)..."),
        (0x2BAF, "...the room's column x 8: its 8 bytes"), (0x2BB1, "...C clear for the addition"), (0x2BB2, "...added"), (0x2BB4, "...map_ptr: the cell's byte"),
        (0x2BB6, "...in wall_map"),
        (0x2BB8, "...high byte"),
        (0x2BBA, "Bit 7 - (x AND 7)..."),
        (0x2BBC, "...the cell's column within the room..."), (0x2BBE, "...kept..."), (0x2BC0, "...from 7..."), (0x2BC2, "...C set for the subtraction"),
        (0x2BC3, "...7 - it: the bit, leftmost cell in bit 7"),
        (0x2BC5, "...(bit 0)..."),
        (0x2BC7, "...as a count..."), (0x2BC8, "...from bit 0..."), (0x2BCA, "Shift the mask up a bit..."), (0x2BCB, "...counted"),
        (0x2BCC, "...until it is in place"), (0x2BCE, "...(always branches)"),
        (0x2BD0, "...mask 1"),
        (0x2BD2, "...as bit_mask"),
        (0x2BD4, "Y = 0"),
        (0x2BD6, "Return"),
    ])
    main.label(0x2BCA, "shift_bit")
    main.label(0x2BD0, "bit_0")
    main.label(0x2BD2, "bit_found")

    main.sub(0x2BD7, "put_item", "Put the current item in the cursor's cell",
             "place_item's last step, once the item is allowed. Clear the "
             "cell's object-free bit, for every item, walls included; nothing "
             "in the editor sets it again, so deleted items leave clear bits. "
             "A wall sets the wall map's bit; anything else takes a free slot, "
             "and a key is recorded as the key of the link being made.",
              on_entry={"cursor_x": "the cell's column", "cursor_y": "the cell's row", "current_item": "the item to put there", "link_index": "for a key, its door's link"}, on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(main, [
        (0x2BD7, "Clear the cell's object-free bit, whatever the item"),
        (0x2BDA, "A wall?"),
        (0x2BDC, "No: put it in a slot"),
        (0x2BDE, "Yes: set its bit in the wall map"),
        (0x2BE1, "...the cell's map byte..."), (0x2BE3, "...with the cell's bit set..."), (0x2BE5, "...back in the map"),
        (0x2BE7, "Return"),
        (0x2BE8, "Find a free slot..."),
        (0x2BEA, "...is its item 0?"), (0x2BED, "Yes: use it"), (0x2BEF, "...next slot down"), (0x2BF0, "...until slot 0 is tried"),
        (0x2BF2, "...and put the item in it"),
        (0x2BF4, "...as its column"), (0x2BF7, "...the cursor's row..."), (0x2BF9, "...as its row"), (0x2BFC, "...the item..."),
        (0x2BFE, "...in the slot"),
        (0x2C01, "A key?"),
        (0x2C03, "No: done"),
        (0x2C05, "Yes: this slot is the link's key..."),
        (0x2C06, "...of the link taken for the waiting door"), (0x2C09, "...the key's slot in the link"),
        (0x2C0C, "Return"),
    ])
    for addr, name in [(0x2BE8, "put_in_slot"), (0x2BEA, "find_free_slot"),
                       (0x2BF2, "free_slot_found"), (0x2C0C, "put_item_done")]:
        main.label(addr, name)

    main.sub(0x2C0D, "remove_at_cursor", "Remove what is in the cursor's cell",
             "delete_item's last step. Free an item's slot, or clear a wall's "
             "bit in the wall map. Freeing a door's slot leaves its wall bit "
             "set, so the cell then shows a wall.",
              on_entry={"cursor_x": "the cell's column", "cursor_y": "the cell's row"}, on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(main, [
        (0x2C0D, "What is here?"),
        (0x2C10, "A wall: clear its bit"),
        (0x2C12, "Nothing here: done"),
        (0x2C14, "An item: free its slot, X from item_at_cursor"),
        (0x2C17, "Return (always branches)"),
    ])
    main.label(0x2C19, "clear_wall")
    main.banner(0x2C19, "Clear the cursor's wall", "Clear its bit in the wall map.")
    comments(main, [
        (0x2C19, "Clear the cell's bit in the wall map"),
        (0x2C1C, "...the cell's bit..."), (0x2C1E, "...inverted..."), (0x2C20, "...as a mask"), (0x2C22, "...the map byte..."),
        (0x2C24, "...with the cell's bit cleared..."), (0x2C26, "...back in the map"),
        (0x2C28, "Return"),
    ])
    main.label(0x2C28, "remove_done")

    main.sub(0x2C29, "place_item", "Place the current item at the cursor",
             "In an empty cell, place the current item within the limits: one "
             "exit, eight trapdoors, 20 doors (a door is also a wall), 29 "
             "objects, and a key only when a door is waiting for one, which "
             "links the two. With a key chosen, SPACE on an unlinked door "
             "makes it the door waiting for its key (sprite &11), in place of "
             "any door waiting before. A door sets its wall bit before its "
             "count is checked, so a 21st door is refused but leaves a wall. "
             "Called from the edit loop on SPACE and by wall_edges.",
              on_entry={"cursor_x": "the cell's column", "cursor_y": "the cell's row", "current_item": "the item to place"}, on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(main, [
        (0x2C29, "What is here?"),
        (0x2C2C, "Nothing: place the item"),
        (0x2C2E, "A wall: nothing more can go here"),
        (0x2C30, "A door?"),
        (0x2C32, "Yes: perhaps make it wait for a key"), (0x2C34, "...the other door?"), (0x2C36, "Yes: perhaps make it wait for a key"),
        (0x2C38, "Occupied: refuse"),
        (0x2C39, "The current item: a wall?"),
        (0x2C3B, "Yes: put it in the map"),
        (0x2C3D, "The exit?"),
        (0x2C3F, "Yes: only one"),
        (0x2C41, "A trapdoor?"),
        (0x2C43, "Yes: at most 8"),
        (0x2C45, "A door?"),
        (0x2C47, "Yes: at most 20"), (0x2C49, "...the other door?"), (0x2C4B, "Yes: at most 20"),
        (0x2C4D, "A key?"),
        (0x2C4F, "Yes: only with a door waiting"),
        (0x2C51, "An object: count it..."),
        (0x2C53, "...how many now?"), (0x2C55, "...30, one too many?"),
        (0x2C57, "...and place it if there are now at most 29"),
        (0x2C59, "Too many: uncount it"),
        (0x2C5B, "...and refuse"),
        (0x2C5C, "The exit: only one"),
        (0x2C5E, "Placed already: refuse"),
        (0x2C60, "...it is placed now..."), (0x2C62, "...put it in (always branches)"),
        (0x2C64, "Refuse"),
        (0x2C65, "A trapdoor: at most 8"),
        (0x2C67, "...how many now?"), (0x2C69, "...9, one too many?"), (0x2C6B, "No: put it in"), (0x2C6D, "Yes: uncount it and refuse"),
        (0x2C6F, "...(refused)"),
        (0x2C70, "A door: it is a wall too, set before the count..."),
        (0x2C73, "...the cell's map byte..."), (0x2C75, "...with its bit set..."), (0x2C77, "...back in the map"),
        (0x2C79, "...at most 20"),
        (0x2C7B, "...how many now?"), (0x2C7D, "...21, one too many?"), (0x2C7F, "No: put it in"), (0x2C81, "Yes: uncount it and refuse..."),
        (0x2C83, "...leaving its wall bit set"),
        (0x2C84, "A key: is a door waiting for one?"),
        (0x2C87, "No door waiting: refuse"),
        (0x2C89, "Yes: take a free link..."),
        (0x2C8C, "...for the waiting door..."),
        (0x2C8F, "...the waiting door's slot..."), (0x2C92, "...as the link's door"),
        (0x2C95, "...give the door back its own sprite..."),
        (0x2C98, "...and nothing waiting"),
        (0x2C9A, "...no door is waiting now"),
        (0x2C9D, "Place the key, recorded in link_index's link"),
        (0x2CA0, "Put the item in the wall map or a slot"),
        (0x2CA3, "A door with a key chosen?"),
        (0x2CA5, "...the key?"), (0x2CA7, "No: refuse"),
        (0x2CA9, "Yes: is the door linked already?"),
        (0x2CAB, "...over links 19 to 0"), (0x2CAD, "This link's door slot..."), (0x2CB0, "...this door's?"), (0x2CB2, "Yes: it is linked"),
        (0x2CB4, "...next link"), (0x2CB5, "...until all 20 are tried"),
        (0x2CB7, "No: door not linked"),
        (0x2CB9, "Linked already: nothing to do"),
        (0x2CBA, "Another door waiting?"),
        (0x2CBC, "...(the waiting door's sprite)"), (0x2CBF, "None: make this door wait"),
        (0x2CC1, "Yes: show it as it was"),
        (0x2CC2, "...keeping this door's slot"), (0x2CC3, "...put its own sprite back"), (0x2CC6, "...this door's slot back"), (0x2CC7, "...into X"),
        (0x2CC8, "This door is waiting: remember its sprite and slot..."),
        (0x2CCB, "...as pending_door_item..."), (0x2CCE, "...and its slot"),
        (0x2CD1, "...and show it as waiting (sprite &11)"),
        (0x2CD3, "...in place of the door's own"),
        (0x2CD6, "Return"),
    ])
    for addr, name in [(0x2C38, "place_done"), (0x2C39, "place_in_empty"),
                       (0x2C5C, "place_exit"), (0x2C64, "place_refused"),
                       (0x2C65, "place_trapdoor"), (0x2C70, "place_door"),
                       (0x2C84, "place_key"), (0x2CA0, "place_put"),
                       (0x2CA3, "choose_door"), (0x2CAD, "find_linked_door"),
                       (0x2CB9, "door_linked"), (0x2CBA, "door_not_linked"),
                       (0x2CC8, "door_waits")]:
        main.label(addr, name)

    main.sub(0x2CD7, "restore_waiting_door", "Show the waiting door as it was",
             "Put the waiting door's own sprite back in its slot and plot it, "
             "by falling into plot_slot. Used when its key is placed, and "
             "when another door is chosen to wait instead.",
              on_exit={"A": "corrupted", "X": "corrupted", "Y": "preserved"})
    comments(main, [
        (0x2CD7, "The waiting door's slot..."),
        (0x2CDA, "...and sprite..."),
        (0x2CDD, "...back in the slot"),
    ])
    main.sub(0x2CE0, "plot_slot", "Plot a sprite at a slot's cell",
             "At screen byte column 2x and pixel row 5y of slot X's cell: "
             "plot_at_cursor for a cell away from the cursor, such as a "
             "deleted door's key.",
             on_entry={"A": "sprite number", "X": "slot"})
    comments(main, [
        (0x2CE0, "The sprite..."),
        (0x2CE2, "...at column 2x..."),
        (0x2CE5, "...x 2: two screen bytes per cell"), (0x2CE6, "...as plot_x"),
        (0x2CE8, "...and row 5y"),
        (0x2CEB, "...x 2..."), (0x2CEC, "...x 4..."), (0x2CED, "...C clear for the addition"), (0x2CEE, "...+ the row: five pixel rows per cell"),
        (0x2CF1, "...as plot_y"),
        (0x2CF3, "Plot it"),
        (0x2CF6, "Return"),
    ])

    main.sub(0x2CF7, "find_free_link", "Find a free door-key link",
             "The highest link whose door is &FF, for the key being placed for "
             "the waiting door. Were none free, link_index would be &FF.",
             on_exit={"link_index": "the link"})
    comments(main, [
        (0x2CF7, "For links 19 down..."),
        (0x2CF9, "...unused?"),
        (0x2CFC, "...negative: free"), (0x2CFE, "...next link"), (0x2CFF, "...until all 20 are tried"),
        (0x2D01, "Use it"),
        (0x2D04, "Return"),
    ])
    main.label(0x2CF9, "search_links")
    main.label(0x2D01, "free_link_found")

    main.sub(0x2D05, "free_slot", "Free a slot",
             "Zero its item and position. A free slot is therefore item 0 at "
             "(0, 0), as start_editing leaves every slot; item_at_cursor "
             "reads that as a wall in the top-left cell.", on_entry={"X": "slot"},
             on_exit={"A": "0", "Z": "set"})
    comments(main, [
        (0x2D05, "Zero its item..."),
        (0x2D07, "...so the slot is free"),
        (0x2D0A, "...and position: column 0..."),
        (0x2D0D, "...row 0"),
        (0x2D10, "Return"),
    ])

    main.sub(0x2D11, "delete_item", "Delete what is in the cursor's cell",
             "TAB in the edit loop. Uncount the item and remove it. Deleting a "
             "door removes its key too but leaves the door's wall bit, so a "
             "wall shows where the door was; deleting a key removes its door "
             "and the door's wall. A waiting door is left alone. A wall is "
             "cleared.",
              on_entry={"cursor_x": "the cell's column", "cursor_y": "the cell's row"}, on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(main, [
        (0x2D11, "What is here?"),
        (0x2D14, "Nothing: remove_at_cursor finds nothing either"),
        (0x2D16, "A wall: clear it"),
        (0x2D18, "A waiting door?"),
        (0x2D1A, "No: delete the item"),
        (0x2D1C, "Yes: it cannot be deleted"),
        (0x2D1D, "Keep the item's slot, to match against links"),
        (0x2D1F, "The exit?"),
        (0x2D21, "Yes: the exit is no longer placed"),
        (0x2D23, "A trapdoor?"),
        (0x2D25, "Yes: one fewer trapdoor"),
        (0x2D27, "A door?"),
        (0x2D29, "Yes: unlink it and delete its key"), (0x2D2B, "...the other door?"), (0x2D2D, "Yes: unlink it and delete its key"),
        (0x2D2F, "A key?"),
        (0x2D31, "Yes: delete its door too"),
        (0x2D33, "An object: one fewer"),
        (0x2D35, "...(always branches)"),
        (0x2D37, "The exit: none placed"),
        (0x2D39, "...clear exit_placed"), (0x2D3B, "...(always branches)"),
        (0x2D3D, "A trapdoor: one fewer"),
        (0x2D3F, "...(always branches)"),
        (0x2D41, "A door: uncount it..."),
        (0x2D43, "...find its link..."),
        (0x2D45, "This link's door slot..."), (0x2D48, "...this door's?"), (0x2D4A, "No: next link"),
        (0x2D4C, "...free it..."),
        (0x2D4E, "...in the link table"),
        (0x2D51, "...rub out its key..."),
        (0x2D54, "...into X"), (0x2D55, "...kept"), (0x2D56, "...the blank sprite..."), (0x2D58, "...rub it out in its cell"),
        (0x2D5B, "...the key's slot back..."), (0x2D5C, "...into X"),
        (0x2D5D, "...and free the key's slot"),
        (0x2D60, "...(always branches)"),
        (0x2D62, "Next link"),
        (0x2D63, "...until all 20 are tried"),
        (0x2D65, "Remove the item itself, or clear the wall"),
        (0x2D68, "A key: keep its cell, the cursor's..."),
        (0x2D6A, "...in line_x..."), (0x2D6D, "...and row..."), (0x2D6F, "...in line_y"),
        (0x2D72, "Find the key's link..."),
        (0x2D74, "This link's key slot..."), (0x2D77, "...this key's?"), (0x2D79, "No: next link"),
        (0x2D7B, "...keep it..."),
        (0x2D7C, "...on the stack"),
        (0x2D7D, "...take its door's slot..."),
        (0x2D80, "...into X"), (0x2D81, "...kept"),
        (0x2D82, "...and move the cursor to the door's cell..."),
        (0x2D85, "...as the cursor's column..."), (0x2D87, "...row..."), (0x2D8A, "...as the cursor's row"),
        (0x2D8C, "...rub out the door..."),
        (0x2D8E, "...in its cell"),
        (0x2D91, "...free its slot..."),
        (0x2D92, "...into X"), (0x2D93, "...free it"),
        (0x2D96, "...uncount it..."),
        (0x2D97, "...the link number back into X"), (0x2D98, "...one fewer door"),
        (0x2D9A, "...free the link..."),
        (0x2D9C, "...in the link table"),
        (0x2D9F, "...clear the door's wall, at the cursor..."),
        (0x2DA2, "...and move the cursor back to the key's cell"),
        (0x2DA5, "...as the cursor's column"), (0x2DA7, "...the key's row..."), (0x2DAA, "...as the cursor's row"),
        (0x2DAC, "Remove the key"),
        (0x2DAF, "Next link"),
        (0x2DB0, "...until all 20 are tried; none: fall through"),
    ])
    for addr, name in [(0x2D1D, "delete_item_slot"), (0x2D37, "delete_exit"),
                       (0x2D3D, "delete_trapdoor"), (0x2D41, "delete_door"),
                       (0x2D45, "find_door_link_to_delete"), (0x2D62, "next_door_link"),
                       (0x2D65, "delete_remove"), (0x2D68, "delete_key"),
                       (0x2D74, "find_key_link"), (0x2DAF, "next_key_link")]:
        main.label(addr, name)

    main.sub(0x2DB2, "line_x_to_graphics", "Convert line_x to graphics x",
             "line_gx = line_x x 32: a cell is two screen bytes, four MODE 2 "
             "pixels, 32 graphics units wide. (delete_item also falls into it, "
             "harmlessly, when a key has no link.)",
              on_entry={"line_x": "a map column"}, on_exit={"line_gx": "its graphics x, column x 32", "A": "corrupted", "X": "preserved", "Y": "preserved"})
    comments(main, [
        (0x2DB2, "Clear the result"),
        (0x2DB4, "...low byte"), (0x2DB7, "...high byte"),
        (0x2DBA, "x x 8..."),
        (0x2DBD, "...x 2..."), (0x2DBE, "...x 4..."), (0x2DBF, "...x 8 (a column is below 32: no carry)"), (0x2DC0, "...C clear (the ASL sets it anyway)"),
        (0x2DC1, "...x 16..."),
        (0x2DC2, "...carry into the high byte"),
        (0x2DC5, "...x 32, with the carries in the high byte"),
        (0x2DC6, "...carry into the high byte"), (0x2DC9, "...low byte"),
        (0x2DCC, "Return"),
    ])

    main.sub(0x2DCD, "line_y_to_graphics", "Convert line_y to graphics y",
             "line_gy = &3FF - line_y x 20: a cell is five pixel rows, 20 "
             "graphics units, counted down from the top of the screen.",
              on_entry={"line_y": "a map row"}, on_exit={"line_gy": "its graphics y, &3FF - row x 20", "A": "corrupted", "X": "preserved", "Y": "preserved"})
    comments(main, [
        (0x2DCD, "Clear the result"),
        (0x2DCF, "...low byte"), (0x2DD2, "...high byte"),
        (0x2DD5, "y x 4..."),
        (0x2DD8, "...x 2..."), (0x2DD9, "...x 4 (a row is below 48: no carry)"), (0x2DDA, "...kept"), (0x2DDC, "...C clear (the ASL sets it anyway)"),
        (0x2DDD, "...x 8..."),
        (0x2DDE, "...carry into the high byte"), (0x2DE1, "...x 16..."), (0x2DE2, "...carry into the high byte"), (0x2DE5, "...low byte kept"),
        (0x2DE8, "...plus x 4: x 20 graphics units a row"),
        (0x2DE9, "...y x 4 added..."), (0x2DEB, "...low byte"), (0x2DEE, "...high byte..."), (0x2DF1, "...with the carry"),
        (0x2DF3, "...kept"),
        (0x2DF6, "&3FF - y x 20"),
        (0x2DF8, "...C set for the subtraction"), (0x2DF9, "...less y x 20, low byte..."), (0x2DFC, "...kept"), (0x2DFF, "...&3FF's high byte..."),
        (0x2E01, "...less the high byte..."), (0x2E04, "...kept: row 0 at the top"),
        (0x2E07, "Return"),
    ])

    main.sub(0x2E08, "plot_line_point", "PLOT to a cell",
             "VDU 25 with plot code X and the graphics position of (line_x, line_y).",
             on_entry={"X": "PLOT code"})
    comments(main, [
        (0x2E08, "The cell's graphics position..."),
        (0x2E0B, "...converted to graphics x"), (0x2E0E, "...and the cell's y..."), (0x2E11, "...converted to graphics y"),
        (0x2E14, "VDU 25, X..."),
        (0x2E16, "...send VDU 25, PLOT"), (0x2E19, "...the PLOT code, in X"), (0x2E1A, "...send it"),
        (0x2E1D, "...x..."),
        (0x2E20, "...send the x low byte"), (0x2E23, "...x high byte"), (0x2E26, "...send it"),
        (0x2E29, "...y"),
        (0x2E2C, "...send the y low byte"), (0x2E2F, "...y high byte"), (0x2E32, "...send it"),
        (0x2E35, "Return"),
    ])

    main.sub(0x2E36, "draw_links", "Draw each door-key link as a line",
             "For each link in use, move to the door's cell (PLOT 68) and draw "
             "a line to its key's (PLOT 5). The lines are exclusive-OR (GCOL "
             "3, set at start-up), so the edit loop draws them when CTRL is "
             "pressed and again, rubbing them out, when it is released. Each "
             "line runs between the cells' top-left corners.",
              on_exit={"A": "corrupted", "X": "corrupted", "Y": "preserved"})
    comments(main, [
        (0x2E36, "For links 19 to 0..."),
        (0x2E38, "Keep the link number..."), (0x2E39, "...kept on the stack"),
        (0x2E3A, "...in use?"),
        (0x2E3D, "Free: next link"),
        (0x2E3F, "Yes: from the door's cell..."),
        (0x2E40, "...its column..."), (0x2E43, "...as line_x"), (0x2E46, "...its row..."), (0x2E49, "...as line_y"),
        (0x2E4C, "...PLOT 68: move absolute..."),
        (0x2E4E, "...to the door's cell, drawing nothing"),
        (0x2E51, "...to the key's cell..."),
        (0x2E52, "...kept"), (0x2E53, "...link number into X"), (0x2E54, "...the key's slot..."), (0x2E57, "...into X"),
        (0x2E58, "...its column..."), (0x2E5B, "...as line_x"), (0x2E5E, "...its row..."), (0x2E61, "...as line_y"),
        (0x2E64, "...PLOT 5: line to there..."),
        (0x2E66, "...draw the link, exclusive-OR (GCOL 3)"),
        (0x2E69, "Next link"),
        (0x2E6A, "...back into X"), (0x2E6B, "...the link before"), (0x2E6C, "...until link 0 is done"),
        (0x2E6E, "Return"),
    ])
    main.label(0x2E38, "draw_link")
    main.label(0x2E69, "next_drawn_link")
    main.banner(0x2E6F, "Unused", "Leftover bytes.")
    main.byte(0x2E6F, 0x21, cols=8)
    main.c(0x2E6F, "Not used")

    main.sub(0x2E90, "cursor_key_pressed", "Test a key",
             "OSBYTE &81 with the INKEY number in X, as key_pressed.",
             on_entry={"X": "INKEY number"}, on_exit={"Z": "set if pressed"})
    comments(main, [
        (0x2E90, "OSBYTE &81: scan the key..."),
        (0x2E92, "...Y = &FF: test the key whose INKEY number is X"), (0x2E94, "Scan it: X = Y = &FF if the key is held"),
        (0x2E97, "Z set if X and Y are both &FF"),
        (0x2E99, "X not &FF: not pressed (Z clear)"), (0x2E9B, "...Z set if Y is &FF too: pressed"), (0x2E9D, "Return"),
    ])
    main.label(0x2E9D, "cursor_key_done")

    # -----------------------------------------------------------------------
    # unpack_level, run at &7B00.

    in_unpack.sub(0x7B00, "unpack_level", "Unpack the loaded level into the slots",
                  "Called by start_editing for a loaded, decrypted level. Read "
                  "the level file's tables from the last entry back, putting "
                  "each item in the next slot down from &4F: objects 30 to 1 "
                  "(the exit, 30, first, into slot &4F), skipping any whose x "
                  "is &80 or more, with their editor items found from "
                  "item_types; doors 20 to 1, each followed by its key in the "
                  "slot below and the pair recorded as a door-key link, from "
                  "link 19 down; then all eight trapdoors. Copy the wall map "
                  "and object-free map into the editor's own. object_count "
                  "leaves out the exit (it starts at -1), door_count counts the "
                  "doors and trapdoor_count is set to 8.",
                   on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(in_unpack, [
        (0x7B00, "No doors..."),
        (0x7B02, "...for the count shown"),
        (0x7B04, "...and no objects (the exit is counted too, so -1)"),
        (0x7B06, "...starting at -1"),
        (0x7B08, "All 8 trapdoors"),
        (0x7B0A, "...as the level file has them all"),
        (0x7B0C, "Slots from &4F down..."),
        (0x7B0E, "...the next slot to fill"),
        (0x7B11, "...links from 19 down"),
        (0x7B13, "...the next link to fill"),
        (0x7B16, "For objects 30 to 1..."),
        (0x7B18, "...its x: on the map?"),
        (0x7B1B, "&80 or more (&FF): not in this level"),
        (0x7B1D, "Yes: count it..."),
        (0x7B1F, "...and put it in the next slot..."),
        (0x7B22, "...its x..."), (0x7B25, "...then its y..."), (0x7B28, "...into the slot too"),
        (0x7B2B, "...as the editor's item for its type"),
        (0x7B2E, "...from item_types..."), (0x7B31, "...back to the slot being filled..."), (0x7B34, "...stored with it..."), (0x7B37, "...and move to the next slot down"),
        (0x7B3A, "Next object"),
        (0x7B3B, "...down to object 1"),
        (0x7B3D, "For doors 20 to 1..."),
        (0x7B3F, "...its x: on the map?"),
        (0x7B42, "&80 or more (&FF): no door here"),
        (0x7B44, "Yes: count it..."),
        (0x7B46, "...link it: the door's slot..."),
        (0x7B49, "...in this link..."), (0x7B4C, "...recorded as the link's door..."),
        (0x7B4F, "...and the key's, the slot below..."),
        (0x7B50, "...one below..."), (0x7B52, "...is the key's slot..."), (0x7B55, "...and move to the next link down"),
        (0x7B58, "...put the door in its slot..."),
        (0x7B5B, "...in the slot being filled..."), (0x7B5E, "...its x..."), (0x7B61, "...then its y..."), (0x7B64, "...into the slot too"),
        (0x7B67, "...and its sprite..."), (0x7B6A, "...as the editor's door item..."), (0x7B6D, "...back to the slot being filled..."), (0x7B70, "...stored with it..."),
        (0x7B73, "...and move to the next slot down"),
        (0x7B76, "Y = the door's slot - 1: the key's slot"),
        (0x7B77, "...its x..."), (0x7B7A, "...into the slot below..."), (0x7B7D, "...then its y..."), (0x7B80, "...stored with it, in the slot below..."),
        (0x7B83, "...the key item..."), (0x7B85, "...as the slot's item..."), (0x7B88, "...and move to the next slot down"),
        (0x7B8B, "Next door"),
        (0x7B8C, "...down to door 1"),
        (0x7B8E, "For trapdoors 7 to 0, all of them present..."),
        (0x7B90, "...put each in the next slot"),
        (0x7B93, "...in the slot being filled..."), (0x7B96, "...its x..."), (0x7B99, "...then its y..."), (0x7B9C, "...into the slot too"),
        (0x7B9F, "...as the trapdoor item..."), (0x7BA1, "...stored with it..."), (0x7BA4, "...and move to the next slot down"), (0x7BA7, "...the next trapdoor down..."),
        (0x7BA8, "...to trapdoor 0"),
        (0x7BAA, "Copy the &C9 bytes of each map"),
        (0x7BAC, "Wall bits from the level..."), (0x7BAF, "...into the wall map being edited..."), (0x7BB2, "...object-free bits from the level..."), (0x7BB5, "...into the map being edited..."),
        (0x7BB8, "...the next byte..."), (0x7BB9, "...for the maps' &C9 bytes..."), (0x7BBB, "...until both are copied"),
        (0x7BBD, "Return"),
    ])
    for addr, name in [(0x7B18, "unpack_object"), (0x7B3A, "next_object"),
                       (0x7B3F, "unpack_door"), (0x7B8B, "next_door"),
                       (0x7B90, "unpack_trapdoor"), (0x7BAC, "unpack_maps")]:
        in_unpack.label(addr, name)
    in_unpack.sub(0x7BBE, "item_for_type", "Find the editor's item for a level type",
                  "Search item_types from entry 1 for the type: an object's "
                  "type, or a door's sprite &1C or &1D. A type with no item "
                  "would be matched against the bytes beyond item_types (the "
                  "checksums and sprite tables), and with no match at all Y "
                  "would wrap to 0 and run on past the routine's end.",
                  on_entry={"A": "level type"}, on_exit={"A": "item", "Y": "item"})
    comments(in_unpack, [
        (0x7BBE, "Keep the type to compare with"),
        (0x7BC0, "From item 1..."),
        (0x7BC2, "...a match?"),
        (0x7BC5, "...the type being looked up?"), (0x7BC7, "No: next type"),
        (0x7BC9, "Yes: return the item"),
        (0x7BCA, "...the item number in A"),
        (0x7BCB, "No: next"),
        (0x7BCC, "...trying every item until one matches"),
    ])
    in_unpack.label(0x7BC2, "search_types")
    in_unpack.label(0x7BCB, "next_type")

    in_mark_object_cell.sub(0x7D80, "mark_object_cell", "Mark the cursor's cell as holding an object",
                     "Clear its bit in the object-free map (laid out as the wall "
                     "map), so the game will look for an object there. put_item "
                     "calls it for every item placed, walls included. It runs "
                     "at &7D80, copied there by start_editing, in screen "
                     "memory below the 30 rows shown (&3000-&7AFF).",
                      on_entry={"cursor_x": "the cell's column", "cursor_y": "the cell's row"}, on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(in_mark_object_cell, [
        (0x7D80, "(y AND &F8) x 4..."),
        (0x7D82, "...the room row, as a multiple of 8..."), (0x7D84, "...x 2..."), (0x7D85, "...x 4: 32 bytes per row of rooms"), (0x7D86, "...kept"),
        (0x7D88, "...+ (y AND 7)..."),
        (0x7D8A, "...the cell's row within the room"), (0x7D8C, "...C clear for the addition"), (0x7D8D, "...added"), (0x7D8F, "...kept"),
        (0x7D91, "...+ (x AND &F8)..."),
        (0x7D93, "...the room's column x 8: its 8 bytes"), (0x7D95, "...C clear for the addition"), (0x7D96, "...added"), (0x7D98, "...map_ptr: the cell's byte"),
        (0x7D9A, "...in object_free_map"),
        (0x7D9C, "...high byte"),
        (0x7D9E, "Bit 7 - (x AND 7)..."),
        (0x7DA0, "...the cell's column within the room..."), (0x7DA2, "...kept..."), (0x7DA4, "...from 7..."), (0x7DA6, "...C set for the subtraction"),
        (0x7DA7, "...7 - it: the bit, leftmost cell in bit 7"), (0x7DA9, "Bit 0: the mask is 1"), (0x7DAB, "...as a count..."), (0x7DAC, "...from bit 0..."),
        (0x7DAE, "Shift the mask up a bit..."), (0x7DAF, "...counted"), (0x7DB0, "...until it is in place"),
        (0x7DB2, "...(always branches)"),
        (0x7DB4, "...mask 1"),
        (0x7DB6, "Clear it"),
        (0x7DB8, "...as a mask"), (0x7DBA, "...Y = 0"), (0x7DBC, "...the map byte..."), (0x7DBE, "...with the cell's bit cleared: objects may lie here"),
        (0x7DC0, "...back in the map"),
        (0x7DC2, "Return"),
    ])
    in_mark_object_cell.label(0x7DAE, "mark_shift_bit")
    in_mark_object_cell.label(0x7DB4, "mark_bit_0")
    in_mark_object_cell.label(0x7DB6, "mark_bit_found")

    main.banner(0x19DE, "Unused", "Leftover bytes after unpack_level's image.")
    main.byte(0x19DE, 0x22, cols=8)

    main.c(0x19DE, "Not used")
    main.banner(0x1A43, "Unused", "Leftover bytes, among them the text PAGE.")
    main.byte(0x1A43, 0x1C10 - 0x1A43, cols=16)
    main.c(0x1A43, "Not used")

    # The editor's sprite numbers, limits, characters and keys.
    for number, name in EDITOR_SPRITES:
        d.constant(number, f"spr_{name}", comment=f"Editor sprite &{number:02X}")
    for value, name, text in EDITOR_CONSTANTS + ([] if model_b else MASTER_CONSTANTS):
        d.constant(value, name, comment=text)
    if not model_b:
        d.expr(0x1C3E, sym("table_loaded_mark"))
        d.expr(0x1C42, sym("table_loaded_mark"))
    for operand_addr, expression in EDITOR_OPERANDS:
        if 0x7B00 <= operand_addr < 0x7BCE:
            d.expr(operand_addr, expression, move=unpack)
        elif 0x7D80 <= operand_addr < 0x7DC3:
            d.expr(operand_addr, expression, move=mark_object_cell)
        else:
            d.expr(operand_addr, expression)
    for operand_addr in EDITOR_CHAR_OPERANDS:
        new_addr = master_to_model_b(operand_addr) if model_b else operand_addr
        if new_addr is not None:
            raw_d.expr(new_addr, char(raw_d.memory.get_u8(new_addr)))
    for operand_addr in EDITOR_KEY_OPERANDS:
        d.inkey_number(operand_addr)

    # Operands that are negative INKEY numbers: the default cursor keys
    # and the wall-block chooser's keys.
    for operand_addr in (0x1C4E, 0x1C52, 0x1C56, 0x1C5A, 0x24B0, 0x24C3, 0x24D1):
        d.inkey_number(operand_addr)

    # Operands that are addresses of the editor's own data.
    for operand_addr, name, part in [
        (0x1C47, "load_table_command", lo), (0x1C49, "load_table_command", hi),
        (0x1C62, "tv_command", lo), (0x1C64, "tv_command", hi),
        (0x1C78, "edit_or_new_prompt", lo), (0x1C7A, "edit_or_new_prompt", hi),
        (0x1CBD, "load_command", lo), (0x1CBF, "load_command", hi),
        (0x1E5E, "read_line_block", lo), (0x1E60, "read_line_block", hi),
        (0x1E62, "filename_buffer", lo), (0x1E67, "filename_buffer", hi),
        (0x2000, "disc_command", lo), (0x2002, "disc_command", hi),
        (0x2007, "drive_0_command", lo), (0x2009, "drive_0_command", hi),
        (0x211B, "disc_or_tape_prompt", lo), (0x211D, "disc_or_tape_prompt", hi),
        (0x212E, "disc_command", lo), (0x2130, "disc_command", hi),
        (0x2138, "drive_prompt", lo), (0x213A, "drive_prompt", hi),
        (0x2144, "drive_command", lo), (0x2146, "drive_command", hi),
        (0x214C, "tape_command", lo), (0x214E, "tape_command", hi),
        (0x225F, "break_to_save", lo), (0x2264, "break_to_save", hi),
        (0x1C22, "break_to_start", lo), (0x1C27, "break_to_start", hi),
        (0x2293, "read_line_block", lo), (0x2295, "read_line_block", hi),
        (0x229F, "filename_buffer", lo), (0x22A4, "filename_buffer", hi),
        (0x2389, "save_command", lo), (0x238B, "save_command", hi),
        (0x2395, "another_prompt", lo), (0x2397, "another_prompt", hi),
        (0x23F1, "cat_command", lo), (0x23F3, "cat_command", hi),
        (0x26D6, "load_stones_command", lo), (0x26D8, "load_stones_command", hi),
        (0x1C2C, reset_entry, lo), (0x1C31, reset_entry, hi),
        (0x2269, reset_entry, lo), (0x226E, reset_entry, hi),
        (0x2457, "wall_blocks", lo), (0x245D, "wall_blocks", hi),
    ]:
        d.expr(operand_addr, part(sym(name)))
