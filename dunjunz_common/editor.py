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
]
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
    free_cell = d.add_move(0x7D80, 0x1A00, 0x43, name="free_cell")

    main = Annotator(d, version, lambda addr: [(None, "")])
    in_plotter = Annotator(d, version, lambda addr: [(plotter, "")])
    in_unpack = Annotator(d, version, lambda addr: [(unpack, "")])
    in_free_cell = Annotator(d, version, lambda addr: [(free_cell, "")])

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
        (0x0902, "Point sprite_data_ptr at the sprite's data..."),
        (0x0907, "..."),
        (0x090C, "Width in bytes..."),
        (0x0911, "Height in pixel rows..."),
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
            (0x096E, "High byte of row x 640, from Table's copy of the MOS table..."),
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
    main.label(0x1A00, "free_cell_image", description=(
        "free_cell as stored, copied to &7D80 by start_editing."))
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
        (0x23B4, "..."), (0x23B7, "..."), (0x23BA, "..."), (0x23BB, "..."),
        (0x23BD, "...and &2800-&28FF to &0A00"),
        (0x23C0, "..."), (0x23C3, "..."), (0x23C4, "..."),
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
             "Disable ESCAPE, point the BREAK intercept at break_to_start and "
             f"BRKV at {mos}'s reset entry (so any error restarts the "
             "machine), " + ("" if model_b else "load Table the first time, ") +
             "set the cursor keys and "
             "*TV255 1, select MODE 7 and ask whether to edit a level or start "
             "a new one. To edit, choose disc or tape and the file, and *LOAD "
             "it at &2700.")
    comments(main, [
        (0x1C13, "OSBYTE &C8 with X=1, Y=0: disable ESCAPE"),
        (0x1C15, "..."), (0x1C17, "..."), (0x1C19, "..."),
        (0x1C1C, "BREAK intercept = JMP break_to_start..."),
        (0x1C1E, "..."), (0x1C21, "..."), (0x1C23, "..."), (0x1C26, "..."),
        (0x1C28, "..."),
        (0x1C2B, f"BRKV = {'&D9CD' if model_b else '&E364'}, {mos}'s reset entry: an error resets"),
        (0x1C2D, "..."), (0x1C30, "..."), (0x1C32, "..."),
        (0x1C35, "No level saved yet (so the buffer is not encrypted)"),
        (0x1C37, "..."),
        (0x1C3A, "Table loaded already?"),
        (0x1C3D, "..."),
        (0x1C3F, "Yes"),
        (0x1C41, "No: mark it loaded..."),
        (0x1C43, "..."),
        (0x1C46, "...and *L. TABLE (the row offsets and *FREE)"),
        (0x1C48, "..."), (0x1C4A, "..."),
        (0x1C4D, "Cursor keys: left..."),
        (0x1C4F, "..."),
        (0x1C51, "...right..."),
        (0x1C53, "..."),
        (0x1C55, "...up..."),
        (0x1C57, "..."),
        (0x1C59, "...down"),
        (0x1C5B, "..."),
        (0x1C5D, "80 item slots, 0-&4F"),
        (0x1C5F, "..."),
        (0x1C61, "*TV255 1: move the picture down a line, interlace off"),
        (0x1C63, "..."), (0x1C65, "..."),
        (0x1C68, "VDU 3: printer off"),
        (0x1C6A, "..."),
        (0x1C6D, "VDU 22,7: MODE 7"),
        (0x1C6F, "..."), (0x1C72, "..."), (0x1C74, "..."),
        (0x1C77, "Ask: edit (E) or new level (N)"),
        (0x1C79, "..."), (0x1C7B, "..."), (0x1C7D, "..."), (0x1C7F, "..."),
        (0x1C81, "..."), (0x1C83, "..."), (0x1C85, "..."),
        (0x1C88, "Remember the choice: 1 for a new level"),
        (0x1C8B, "Edit?"),
        (0x1C8D, "New: start with an empty level"),
        (0x1C90, "Edit: new line"),
        (0x1C93, "Choose disc or tape"),
        (0x1C96, "Blank the filename in load_command..."),
        (0x1C98, "..."), (0x1C9A, "..."), (0x1C9D, "..."), (0x1C9E, "..."),
        (0x1CA0, "..."),
        (0x1CA2, "Ask for the filename"),
        (0x1CA5, "Line feed"),
        (0x1CA7, "..."),
        (0x1CAA, "End the filename field with a space"),
        (0x1CAC, "..."),
        (0x1CAF, "Copy the filename typed into load_command..."),
        (0x1CB1, "..."), (0x1CB4, "..."), (0x1CB7, "..."), (0x1CB8, "..."),
        (0x1CBA, "..."),
        (0x1CBC, "*LOAD name 2700"),
        (0x1CBE, "..."), (0x1CC0, "..."),
        (0x1CC3, "Edit it"),
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
             "the digits 0-3 (drive_keys), and the digit is printed.",
             on_entry={"A": "0 for two keys, else a drive digit",
                       "X": "prompt address, low byte", "Y": "prompt address, high byte",
                       "scratch": "first key's internal number (A=0)",
                       "scratch_hi": "second key's internal number (A=0)"},
             on_exit={"A": "0 or 1 for the key pressed (A=0 on entry)"})
    comments(main, [
        (0x1CC6, "Keep the mode"),
        (0x1CC7, "Point plot_x/plot_y at the prompt..."),
        (0x1CC9, "..."),
        (0x1CCB, "Print it up to the '*'..."),
        (0x1CCD, "..."), (0x1CCF, "..."), (0x1CD2, "..."), (0x1CD3, "..."),
        (0x1CD5, "..."), (0x1CD7, "..."),
        (0x1CD9, "Flush the input buffer"),
        (0x1CDB, "..."),
        (0x1CDE, "OSBYTE &7A: X = the internal number of a key pressed"),
        (0x1CE0, "..."),
        (0x1CE3, "Which mode?"),
        (0x1CE4, "..."),
        (0x1CE5, "Two keys"),
        (0x1CE7, "Digits: is it 0, 1, 2 or 3?"),
        (0x1CE9, "..."), (0x1CEA, "..."), (0x1CED, "..."), (0x1CEF, "..."),
        (0x1CF0, "..."),
        (0x1CF2, "No: scan again"),
        (0x1CF4, "Yes: print the digit"),
        (0x1CF5, "..."), (0x1CF6, "..."), (0x1CF7, "..."), (0x1CF9, "..."),
        (0x1CFC, "Return"),
        (0x1CFD, "The first key?"),
        (0x1CFE, "..."), (0x1D00, "..."),
        (0x1D02, "The second key?"),
        (0x1D04, "No: scan again"),
        (0x1D06, "Second: A = 1"),
        (0x1D07, "..."), (0x1D09, "..."),
        (0x1D0A, "First: A = 0"),
        (0x1D0B, "..."), (0x1D0D, "..."),
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
    main.label(0x1D2F, "disc_or_tape_prompt")
    main.string(0x1D2F, 0x16)
    main.label(0x1D45, "filename_prompt")
    main.string(0x1D45, 9)
    main.byte(0x1D4E)
    main.c(0x1D4E, "Zero: the end")
    main.label(0x1D4F, "drive_prompt")
    main.string(0x1D4F, 13)
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
    main.label(0x1DFA, "save_command", description="*SAVE name 2700+2B0, the name at +5.")
    main.stringcr(0x1DFA)
    d.expr_label(0x1DFF, "save_command+5")
    main.label(0x1E10, "another_prompt")
    main.string(0x1E10, 0x1F)

    # -----------------------------------------------------------------------

    main.sub(0x1E2F, "new_lines", "Print a new line and a blank line",
             "CR, LF, LF.",
              on_exit={"A": "corrupted", "X": "preserved", "Y": "preserved"})
    comments(main, [
        (0x1E2F, "CR"), (0x1E31, "..."),
        (0x1E34, "LF, twice"), (0x1E36, "..."), (0x1E39, "..."),
        (0x1E3C, "Return"),
    ])

    main.sub(0x1E3D, "ask_filename", "Ask for a filename",
             "Pause, flush the input buffer, prompt and read up to seven "
             "characters into filename_buffer. If nothing is typed, the name is "
             "L.",
             on_exit={"scratch": "the name's length, with its CR"})
    comments(main, [
        (0x1E3D, "Pause for 256 x 256 loops..."),
        (0x1E3F, "..."), (0x1E41, "..."), (0x1E42, "..."), (0x1E43, "..."),
        (0x1E45, "..."), (0x1E46, "..."),
        (0x1E48, "Flush buffers (X = 0: all)"),
        (0x1E4A, "..."),
        (0x1E4D, "New line"),
        (0x1E50, "Print the filename prompt, up to and including its zero"),
        (0x1E52, "..."), (0x1E55, "..."), (0x1E58, "..."), (0x1E59, "..."),
        (0x1E5B, "..."),
        (0x1E5D, "Point XY at read_line_block..."),
        (0x1E5F, "..."),
        (0x1E61, "...buffer filename_buffer..."),
        (0x1E63, "..."), (0x1E66, "..."), (0x1E68, "..."),
        (0x1E6B, "...at most 7 characters..."),
        (0x1E6D, "..."),
        (0x1E70, "...from space..."),
        (0x1E72, "..."),
        (0x1E75, "...to '~'"),
        (0x1E77, "..."),
        (0x1E7A, "OSWORD 0: read the name"),
        (0x1E7C, "..."),
        (0x1E7F, "Keep its length"),
        (0x1E81, "Anything typed?"),
        (0x1E83, "Yes: return"),
        (0x1E85, "No: move up a line..."),
        (0x1E87, "..."),
        (0x1E8A, "...and right nine places..."),
        (0x1E8C, "..."), (0x1E8E, "..."), (0x1E91, "..."), (0x1E92, "..."),
        (0x1E94, "...show 'L'..."),
        (0x1E96, "..."),
        (0x1E99, "...and use it as the name"),
        (0x1E9C, "Length 1"),
        (0x1E9D, "..."),
        (0x1E9F, "New line"),
        (0x1EA2, "Return"),
    ])
    for addr, name in [(0x1E3F, "pause_outer"), (0x1E41, "pause_inner"),
                       (0x1E52, "print_filename_prompt"), (0x1E8E, "move_right"),
                       (0x1EA2, "filename_read")]:
        main.label(addr, name)

    main.sub(0x1EA3, "new_level", "Start a new, empty level",
             "Fill the level's wall block with &03, then set up the editing "
             "screen as for a loaded level.",
              on_exit={"A": "corrupted", "X": "corrupted", "Y": "preserved"})
    comments(main, [
        (0x1EA3, "Fill level_wall_block with &03..."),
        (0x1EA5, "..."), (0x1EA7, "..."), (0x1EAA, "..."), (0x1EAB, "..."),
    ])
    main.label(0x1EA7, "fill_wall_block")

    main.sub(0x1EAD, "start_editing", "Set up the editing screen and edit",
             "Clear the wall map and the item slots, select MODE 2 with no "
             "cursor and 30 rows, copy unpack_level and free_cell to &7B00 and "
             "&7D80, mark every cell object-free and every link unused, and "
             "zero the counts. For a loaded level, decrypt it, drop any object "
             "of type &73 (the Chalice, which only level 25 has and the editor "
             "has no sprite for), unpack it and draw it. Then clear the level "
             "file's tables, ready for saving, and run the editing loop.")
    comments(main, [
        (0x1EAD, "Clear wall_map..."),
        (0x1EAF, "..."), (0x1EB0, "..."), (0x1EB3, "..."), (0x1EB4, "..."),
        (0x1EB6, "...and the item slots (&0C00-&0CFF)"),
        (0x1EB9, "..."), (0x1EBA, "..."),
        (0x1EBC, "Cursor showing"),
        (0x1EBE, "..."),
        (0x1EC1, "First link"),
        (0x1EC3, "..."),
        (0x1EC6, "VDU 22,2: MODE 2"),
        (0x1EC8, "..."), (0x1ECB, "..."), (0x1ECD, "..."),
        (0x1ED0, "Disable the BREAK intercept"),
        (0x1ED2, "..."),
        (0x1ED5, "No cursor, 30 rows, colours 10 and 9"),
        (0x1ED8, "Copy unpack_level to &7B00..."),
        (0x1EDA, "..."), (0x1EDD, "..."), (0x1EE0, "..."), (0x1EE1, "..."),
        (0x1EE3, "..."),
        (0x1EE5, "...and free_cell to &7D80"),
        (0x1EE7, "..."), (0x1EEA, "..."), (0x1EED, "..."), (0x1EEE, "..."),
        (0x1EF0, "..."),
        (0x1EF2, "Every cell object-free..."),
        (0x1EF4, "..."), (0x1EF6, "..."), (0x1EF9, "..."), (0x1EFA, "..."),
        (0x1EFC, "...and all 20 links unused"),
        (0x1EFF, "..."), (0x1F02, "..."), (0x1F03, "..."), (0x1F05, "..."),
        (0x1F07, "No door waiting for a key"),
        (0x1F0A, "VDU 18,3,3: GCOL 3,3 (exclusive-OR, for the link lines)"),
        (0x1F0C, "..."), (0x1F0F, "..."), (0x1F11, "..."), (0x1F14, "..."),
        (0x1F17, "No trapdoors, objects, exit or doors"),
        (0x1F19, "..."), (0x1F1B, "..."), (0x1F1D, "..."), (0x1F1F, "..."),
        (0x1F21, "OSBYTE 4,1: cursor keys give codes"),
        (0x1F23, "..."), (0x1F25, "..."),
        (0x1F28, "New level?"),
        (0x1F2B, "No: unpack the loaded one"),
        (0x1F2D, "Yes: first link"),
        (0x1F2F, "..."),
        (0x1F32, "...(always branches)"),
        (0x1F34, "Decrypt the level"),
        (0x1F37, "Find an object of type &73 (the Chalice)..."),
        (0x1F39, "..."), (0x1F3C, "..."), (0x1F3E, "..."), (0x1F40, "..."),
        (0x1F41, "..."),
        (0x1F43, "None"),
        (0x1F45, "Drop it: x and y &FF"),
        (0x1F47, "..."), (0x1F4A, "..."),
        (0x1F4D, "Unpack the level into the slots and maps"),
        (0x1F50, "Show the labels..."),
        (0x1F53, "...and the counts"),
        (0x1F56, "Draw every cell: rows 0-47..."),
        (0x1F58, "..."),
        (0x1F5A, "...columns 0-31..."),
        (0x1F5C, "..."),
        (0x1F5E, "...what is here?"),
        (0x1F61, "..."),
        (0x1F63, "Nothing"),
        (0x1F65, "Plot it"),
        (0x1F68, "Next column"),
        (0x1F6A, "..."), (0x1F6C, "..."), (0x1F6E, "..."),
        (0x1F70, "Next row"),
        (0x1F72, "..."), (0x1F74, "..."), (0x1F76, "..."),
        (0x1F78, "A loaded level has its exit"),
        (0x1F7A, "..."),
        (0x1F7C, "Clear the level file's object tables..."),
        (0x1F7E, "..."), (0x1F80, "..."), (0x1F83, "..."), (0x1F86, "..."),
        (0x1F87, "..."),
        (0x1F89, "...and its door and key tables, ready to be packed"),
        (0x1F8B, "..."), (0x1F8E, "..."), (0x1F91, "..."), (0x1F94, "..."),
        (0x1F97, "..."), (0x1F98, "..."),
        (0x1F9A, "Show the labels..."),
        (0x1F9D, "...and the counts"),
        (0x1FA0, "Cursor at (11, 11)..."),
        (0x1FA2, "..."), (0x1FA4, "..."),
        (0x1FA6, "...placing walls"),
        (0x1FA8, "..."),
        (0x1FAA, "Slow cursor on, colour 10 = 1"),
        (0x1FAC, "..."), (0x1FAF, "..."),
        (0x1FB2, "OSBYTE 4,1 again"),
        (0x1FB4, "..."), (0x1FB6, "..."),
    ])
    for addr, name in [(0x1EB0, "clear_walls"), (0x1EB6, "clear_slots"),
                       (0x1EDA, "copy_unpack"), (0x1EE7, "copy_free_cell"),
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
        (0x1FBC, "..."),
        (0x1FBE, "Yes: wait for three frames..."),
        (0x1FC0, "..."), (0x1FC1, "..."), (0x1FC2, "..."), (0x1FC4, "..."),
        (0x1FC7, "..."), (0x1FC8, "..."), (0x1FC9, "..."), (0x1FCA, "..."),
        (0x1FCC, "f0?"),
        (0x1FCE, "..."), (0x1FD1, "..."),
        (0x1FD3, "Yes: toggle the slow cursor..."),
        (0x1FD6, "..."), (0x1FD8, "..."),
        (0x1FDB, "...and wait for f0 to be released"),
        (0x1FDD, "..."), (0x1FE0, "..."),
        (0x1FE2, "S..."),
        (0x1FE4, "..."), (0x1FE7, "..."),
        (0x1FE9, "...with SHIFT?"),
        (0x1FEB, "..."), (0x1FEE, "..."),
        (0x1FF0, "Yes: is the exit placed..."),
        (0x1FF2, "..."),
        (0x1FF4, "...does every door have its key..."),
        (0x1FF7, "..."),
        (0x1FF9, "...and are all 8 trapdoors placed?"),
        (0x1FFB, "..."), (0x1FFD, "..."),
        (0x1FFF, "Yes: *DISC..."),
        (0x2001, "..."), (0x2003, "..."),
        (0x2006, "...*DRIVE 0"),
        (0x2008, "..."), (0x200A, "..."),
        (0x200D, "Wall the edges"),
        (0x2010, "Pack the level into the file"),
        (0x2013, "Choose its wall block"),
        (0x2016, "VDU 22,7: MODE 7"),
        (0x2018, "..."), (0x201B, "..."), (0x201D, "..."),
        (0x2020, "Save it"),
        (0x2023, "(not reached)"),
        (0x2024, "Move the cursor"),
        (0x2027, "Placing walls?"),
        (0x2029, "..."),
        (0x202B, "Yes: flash the cursor..."),
        (0x202E, "..."), (0x2030, "..."), (0x2033, "..."),
        (0x2035, "...plotting it every other pass"),
        (0x2037, "..."),
        (0x203A, "Cursor up?"),
        (0x203C, "..."), (0x203F, "..."),
        (0x2041, "Yes: colour 10 up, to at most 7..."),
        (0x2044, "..."), (0x2047, "..."), (0x2049, "..."), (0x204B, "..."),
        (0x204E, "...set it..."),
        (0x2051, "...and wait for the key to be released"),
        (0x2053, "..."), (0x2056, "..."),
        (0x2058, "Cursor down?"),
        (0x205A, "..."), (0x205D, "..."),
        (0x205F, "Yes: colour 10 down, to at least 1..."),
        (0x2062, "..."), (0x2064, "..."),
        (0x2067, "...set it..."),
        (0x206A, "...and wait for the key to be released"),
        (0x206C, "..."), (0x206F, "..."),
        (0x2071, "Show the cursor's position"),
        (0x2074, "'1'?"),
        (0x2076, "..."), (0x2079, "..."),
        (0x207B, "Yes: the previous item, to at least 0"),
        (0x207D, "..."), (0x207F, "..."), (0x2081, "..."), (0x2083, "..."),
        (0x2085, "'2'?"),
        (0x2087, "..."), (0x208A, "..."),
        (0x208C, "Yes: the next item, to at most &0F"),
        (0x208E, "..."), (0x2090, "..."), (0x2092, "..."), (0x2094, "..."),
        (0x2096, "SPACE?"),
        (0x2098, "..."), (0x209B, "..."),
        (0x209D, "Placing walls?"),
        (0x209F, "..."),
        (0x20A1, "Yes: place a wall, anywhere"),
        (0x20A4, "Next pass"),
        (0x20A7, "Other items: not on the edges..."),
        (0x20A9, "..."), (0x20AB, "..."), (0x20AD, "..."), (0x20AF, "..."),
        (0x20B1, "..."), (0x20B3, "..."), (0x20B5, "..."),
        (0x20B7, "Place it"),
        (0x20BA, "Show the counts"),
        (0x20BD, "Wait for SPACE to be released..."),
        (0x20BF, "..."), (0x20C2, "..."),
        (0x20C4, "...(always, for an item)"),
        (0x20C6, "..."),
        (0x20C8, "TAB?"),
        (0x20CA, "..."), (0x20CD, "..."),
        (0x20CF, "Yes: delete what is under the cursor..."),
        (0x20D2, "...and show the counts"),
        (0x20D5, "While an item is chosen, wait for B (not TAB) to be released..."),
        (0x20D7, "..."), (0x20DA, "..."), (0x20DC, "..."), (0x20DE, "..."),
        (0x20E0, "CTRL?"),
        (0x20E2, "..."), (0x20E5, "..."),
        (0x20E7, "Yes: draw the door-key links..."),
        (0x20EA, "...while CTRL is held..."),
        (0x20EC, "..."), (0x20EF, "..."),
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
             "Count the links in use and compare with door_count.",
             on_exit={"Z": "set if every door has a key"})
    comments(main, [
        (0x20F7, "Count the links in use..."),
        (0x20F9, "..."), (0x20FB, "..."), (0x20FD, "..."), (0x2100, "..."),
        (0x2102, "..."), (0x2104, "..."), (0x2105, "..."),
        (0x2107, "...and compare with the doors"),
        (0x2109, "..."), (0x210B, "Return"),
    ])
    main.label(0x20FD, "count_links")
    main.label(0x2104, "next_link")

    main.sub(0x210C, "key_pressed", "Test a key",
             "OSBYTE &81 with the INKEY number in X.",
             on_entry={"X": "INKEY number (negative, as a byte)"},
             on_exit={"Z": "set if the key is pressed"})
    comments(main, [
        (0x210C, "OSBYTE &81: scan the key..."),
        (0x210E, "..."), (0x2110, "..."),
        (0x2113, "Z set if X and Y are both &FF"),
        (0x2115, "..."), (0x2117, "..."), (0x2119, "Return"),
    ])
    main.label(0x2119, "key_pressed_done")

    main.sub(0x211A, "choose_filing_system", "Ask for disc or tape",
             "Disc: *DISC, then ask for the drive (0-3) and *DRIVE it. Tape: "
             "*TAPE.",
              on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(main, [
        (0x211A, "Ask: disc (D) or tape (T)"),
        (0x211C, "..."), (0x211E, "..."), (0x2120, "..."), (0x2122, "..."),
        (0x2124, "..."), (0x2126, "..."), (0x2128, "..."),
        (0x212B, "Tape"),
        (0x212D, "Disc: *DISC"),
        (0x212F, "..."), (0x2131, "..."),
        (0x2134, "New line"),
        (0x2137, "Ask which drive..."),
        (0x2139, "..."), (0x213B, "..."), (0x213D, "..."),
        (0x2140, "...and put the digit in drive_command"),
        (0x2143, "*DRIVE n"),
        (0x2145, "..."), (0x2147, "..."),
        (0x214A, "Return"),
        (0x214B, "Tape: *TAPE"),
        (0x214D, "..."), (0x214F, "..."),
        (0x2152, "Return"),
    ])
    main.label(0x214B, "choose_tape")

    main.sub(0x2153, "set_edit_screen", "Send edit_screen_vdu",
             "No cursor, 30 rows, and colours 10 and 9.",
              on_exit={"A": "corrupted", "X": "corrupted", "Y": "preserved"})
    comments(main, [
        (0x2153, "Send its &21 bytes"),
        (0x2155, "..."), (0x2158, "..."), (0x215B, "..."), (0x215C, "..."),
        (0x215E, "..."), (0x2160, "Return"),
    ])
    main.label(0x2155, "send_edit_screen")

    main.sub(0x2161, "crypt_level", "Encrypt or decrypt the level file",
             "Exclusive-OR each byte of &2700-&29AF with the low byte of its "
             "address, as the game's decrypt_level does at &6B00. Doing it "
             "twice restores the bytes.",
              on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(main, [
        (0x2161, "Point at &2700, X counting the offset..."),
        (0x2163, "..."), (0x2164, "..."), (0x2165, "..."), (0x2167, "..."),
        (0x2169, "..."),
        (0x216B, "Exclusive-OR the byte with the offset's low byte..."),
        (0x216D, "..."), (0x216F, "..."), (0x2171, "..."), (0x2172, "..."),
        (0x2174, "Next byte"),
        (0x2176, "..."), (0x2178, "..."),
        (0x217A, "Until &29B0"),
        (0x217C, "..."), (0x217E, "..."), (0x2180, "..."), (0x2182, "..."),
        (0x2184, "..."), (0x2186, "Return"),
    ])
    main.label(0x216B, "crypt_byte")
    main.label(0x217A, "crypt_check_end")

    main.sub(0x2187, "set_colour_10", "Show logical colour 10 as the chosen colour",
             "VDU 19,10,n,0,0,0 with n from colour_10.",
              on_entry={"colour_10": "the colour to show"}, on_exit={"A": "corrupted", "X": "preserved", "Y": "preserved"})
    comments(main, [
        (0x2187, "VDU 19,10..."),
        (0x2189, "..."), (0x218C, "..."), (0x218E, "..."),
        (0x2191, "...n..."),
        (0x2194, "..."),
        (0x2197, "...0,0,0"),
        (0x2199, "..."), (0x219C, "..."), (0x219F, "..."),
        (0x21A2, "Return"),
    ])

    main.sub(0x21A3, "show_labels", "Print the counts' labels",
             "In colour 1, at column 16: Objs, Mons and Dors.",
              on_exit={"A": "corrupted", "X": "corrupted", "Y": "preserved"})
    comments(main, [
        (0x21A3, "COLOUR 1"),
        (0x21A5, "..."), (0x21A8, "..."), (0x21AA, "..."),
        (0x21AD, "Print count_labels up to its CR"),
        (0x21AF, "..."), (0x21B2, "..."), (0x21B5, "..."), (0x21B6, "..."),
        (0x21B8, "..."),
        (0x21BA, "COLOUR 7"),
        (0x21BC, "..."), (0x21BF, "..."), (0x21C1, "..."),
        (0x21C4, "Return"),
    ])
    main.label(0x21AF, "print_labels")

    main.sub(0x21C5, "show_counts", "Print the counts",
             "Objects at (17, 2), trapdoors at (17, 6) and doors at (17, 10).",
              on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(main, [
        (0x21C5, "Objects at (17, 2)"),
        (0x21C7, "..."), (0x21C9, "..."), (0x21CB, "..."),
        (0x21CE, "Trapdoors at (17, 6)"),
        (0x21D0, "..."), (0x21D2, "..."), (0x21D4, "..."),
        (0x21D7, "Doors at (17, 10)"),
        (0x21D9, "..."), (0x21DB, "..."), (0x21DD, "..."),
        (0x21E0, "Return"),
    ])

    main.sub(0x21E1, "show_cursor_position", "Print the cursor's cell",
             "x at (17, 20) and y at (17, 21).",
              on_entry={"cursor_x": "the cell's column", "cursor_y": "the cell's row"}, on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(main, [
        (0x21E1, "x at (17, 20)"),
        (0x21E3, "..."), (0x21E5, "..."), (0x21E7, "..."),
        (0x21EA, "y at (17, 21)"),
        (0x21EC, "..."), (0x21EE, "..."), (0x21F0, "..."),
        (0x21F3, "Return"),
    ])

    main.sub(0x21F4, "print_number", "Print a two-digit number at a text position",
             "Move the text cursor to (X, Y) with VDU 31 and print A (0-99) as "
             "two digits.",
             on_entry={"A": "the number", "X": "column", "Y": "row"})
    comments(main, [
        (0x21F4, "Keep the number"),
        (0x21F6, "Keep the position..."),
        (0x21F7, "..."), (0x21F8, "..."), (0x21F9, "..."),
        (0x21FA, "Tens: count the 10s..."),
        (0x21FC, "..."), (0x21FD, "..."), (0x21FF, "..."), (0x2201, "..."),
        (0x2203, "..."), (0x2204, "..."),
        (0x2206, "Units: add the last 10 back"),
        (0x2207, "..."), (0x2209, "..."),
        (0x220A, "VDU 31, column, row"),
        (0x220C, "..."), (0x220F, "..."), (0x2210, "..."), (0x2213, "..."),
        (0x2214, "..."),
        (0x2217, "Tens digit"),
        (0x2218, "..."), (0x2219, "..."), (0x221B, "..."),
        (0x221E, "Units digit (C clear)"),
        (0x221F, "..."), (0x2221, "..."),
        (0x2224, "Return"),
    ])
    main.label(0x21FF, "count_tens")
    main.label(0x2206, "tens_counted")

    main.sub(0x2225, "wall_edges", "Put walls round the edge of the map",
             "Place a wall in every cell of columns 0 and 31 and rows 0 and 47, "
             "as every level has.",
              on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(main, [
        (0x2225, "Walls..."),
        (0x2227, "..."),
        (0x2229, "...for rows 47 to 0..."),
        (0x222B, "..."),
        (0x222D, "...in column 0..."),
        (0x222F, "..."), (0x2231, "..."),
        (0x2234, "...and column 31"),
        (0x2236, "..."), (0x2238, "..."),
        (0x223B, "..."), (0x223D, "..."),
        (0x223F, "For columns 31 to 0..."),
        (0x2241, "..."),
        (0x2243, "...in row 0..."),
        (0x2245, "..."), (0x2247, "..."),
        (0x224A, "...and row 47"),
        (0x224C, "..."), (0x224E, "..."),
        (0x2251, "..."), (0x2253, "..."),
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
             "Point the BREAK intercept at break_to_save, ask for the level's "
             "number (nothing typed: catalogue the disc), take its checksum "
             "from level_checksums, set the level's first byte so that its "
             "bytes sum to that, encrypt it, choose disc or tape and the "
             "filename, *SAVE it and offer another level. Levels 1-24 can be "
             "saved; level 25 is in Stones.")
    comments(main, [
        (0x2259, "BREAK intercept = JMP break_to_save..."),
        (0x225B, "..."), (0x225E, "..."), (0x2260, "..."), (0x2263, "..."),
        (0x2265, "..."),
        (0x2268, f"BRKV = {mos}'s reset entry"),
        (0x226A, "..."), (0x226D, "..."), (0x226F, "..."),
        (0x2272, "OSBYTE &C8 with X=1, Y=0: disable ESCAPE"),
        (0x2274, "..."), (0x2276, "..."), (0x2278, "..."),
        (0x227B, "VDU 12: clear the screen"),
        (0x227D, "..."),
        (0x2280, "Flush buffers"),
        (0x2282, "..."),
        (0x2285, "Ask for the level number"),
        (0x2287, "..."), (0x228A, "..."), (0x228D, "..."), (0x228E, "..."),
        (0x2290, "..."),
        (0x2292, "Point XY at read_line_block..."),
        (0x2294, "..."),
        (0x2296, "...digits '0' '0' to start with..."),
        (0x2298, "..."), (0x229B, "..."),
        (0x229E, "...buffer filename_buffer..."),
        (0x22A0, "..."), (0x22A3, "..."), (0x22A5, "..."),
        (0x22A8, "...two characters..."),
        (0x22AA, "..."),
        (0x22AD, "...'0' to '9'"),
        (0x22AF, "..."), (0x22B2, "..."), (0x22B4, "..."),
        (0x22B7, "OSWORD 0: read it"),
        (0x22B9, "..."),
        (0x22BC, "Anything typed?"),
        (0x22BE, "Yes"),
        (0x22C0, "No: catalogue the disc"),
        (0x22C3, "One digit?"),
        (0x22C6, "..."), (0x22C8, "..."),
        (0x22CA, "Yes: the level is the digit"),
        (0x22CD, "..."), (0x22CE, "..."),
        (0x22D0, "...(always branches)"),
        (0x22D2, "Two: tens..."),
        (0x22D5, "..."), (0x22D7, "..."), (0x22D9, "..."), (0x22DA, "..."),
        (0x22DC, "...x 10..."),
        (0x22DD, "..."), (0x22DF, "..."), (0x22E0, "..."), (0x22E1, "..."),
        (0x22E2, "..."),
        (0x22E4, "...plus units"),
        (0x22E7, "..."), (0x22E8, "..."),
        (0x22EA, "Level 0?"),
        (0x22EC, "..."),
        (0x22EE, "Yes: ask again"),
        (0x22F1, "25 or more?"),
        (0x22F3, "..."),
        (0x22F5, "Yes: ask again"),
        (0x22F8, "Keep the level number..."),
        (0x22FB, "...and its checksum"),
        (0x22FC, "..."), (0x22FF, "..."),
        (0x2302, "Line feed"),
        (0x2304, "..."),
        (0x2307, "Saved already (so encrypted)?"),
        (0x230A, "..."),
        (0x230C, "Yes: decrypt it again"),
        (0x230F, "Make the top-left cell of the wall map a wall"),
        (0x2312, "..."), (0x2314, "..."),
        (0x2317, "Sum the level's bytes, with the first byte 0..."),
        (0x2319, "..."), (0x231A, "..."), (0x231D, "..."), (0x231F, "..."),
        (0x2321, "..."), (0x2323, "..."),
        (0x2325, "..."), (0x2327, "..."), (0x2328, "..."), (0x232A, "..."),
        (0x232C, "..."), (0x232E, "..."), (0x2330, "..."),
        (0x2332, "...to &29AF"),
        (0x2334, "..."), (0x2336, "..."), (0x2338, "..."), (0x233A, "..."),
        (0x233C, "..."),
        (0x233E, "First byte = checksum - sum (modulo 256)..."),
        (0x2340, "..."), (0x2343, "..."),
        (0x2345, "...(sum above the checksum: &FF - sum + checksum + 1)..."),
        (0x2346, "..."), (0x2348, "..."), (0x234A, "..."), (0x234B, "..."),
        (0x234E, "..."), (0x2350, "..."),
        (0x2353, "...(otherwise checksum - sum)"),
        (0x2354, "..."), (0x2357, "..."),
        (0x2359, "...so that the level's sum is its checksum"),
        (0x235C, "Encrypt it"),
        (0x235F, "Mark it encrypted"),
        (0x2361, "..."),
        (0x2364, "Choose disc or tape"),
        (0x2367, "Blank the filename in save_command..."),
        (0x2369, "..."), (0x236B, "..."), (0x236E, "..."), (0x236F, "..."),
        (0x2371, "..."),
        (0x2373, "Ask for the filename"),
        (0x2376, "Line feed"),
        (0x2378, "..."),
        (0x237B, "Copy it into save_command..."),
        (0x237D, "..."), (0x2380, "..."), (0x2383, "..."), (0x2384, "..."),
        (0x2386, "..."),
        (0x2388, "*SAVE name 2700+2B0"),
        (0x238A, "..."), (0x238C, "..."),
        (0x238F, "Line feed"),
        (0x2391, "..."),
        (0x2394, "Ask: another level (A) or quit (Q)"),
        (0x2396, "..."), (0x2398, "..."), (0x239A, "..."), (0x239C, "..."),
        (0x239E, "..."), (0x23A0, "..."), (0x23A2, "..."),
        (0x23A5, "Quit?"),
        (0x23A7, "No: another level"),
        (0x23AA, "Quit: disable the BREAK intercept..."),
        (0x23AC, "..."),
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
             "Show CAT after the prompt, choose disc or tape, *CAT, "
             + ("" if model_b else "show the disc's free space with Table's routine, ")
             + "then ask for the level number again.")
    comments(main, [
        (0x23C9, "Move up a line..."),
        (0x23CB, "..."),
        (0x23CE, "...and right 29 places..."),
        (0x23D0, "..."), (0x23D2, "..."), (0x23D5, "..."), (0x23D6, "..."),
        (0x23D8, "...and show CAT"),
        (0x23DA, "..."), (0x23DD, "..."), (0x23DF, "..."), (0x23E2, "..."),
        (0x23E4, "..."),
        (0x23E7, "New line"),
        (0x23EA, "Choose disc or tape"),
        (0x23ED, "New line"),
        (0x23F0, "*CAT"),
        (0x23F2, "..."), (0x23F4, "..."),
        (0x23F7, "Show the free space (Table's *FREE)"),
        (0x23FA, "New line"),
        (0x23FD, "Ask for the level number again"),
    ])
    main.label(0x23D2, "move_right_29")

    # -----------------------------------------------------------------------
    # Choosing the wall block.

    main.sub(0x2400, "choose_wall_block", "Choose the level's wall block",
             "Clear the screen, show 25 rows, load Stones (the 24 wall blocks) "
             "at &6E80, draw them in a grid of four by six and frame the "
             "chosen one. Move the frame with ',' '.' (one) and 'A' 'Z' (a "
             "row); SPACE copies the chosen block into the level's wall block.",
              on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(main, [
        (0x2400, "VDU 12: clear the screen"),
        (0x2402, "..."),
        (0x2405, "Show 25 rows"),
        (0x2408, "Load Stones"),
        (0x240B, "(padding)"),
        (0x240C, "..."), (0x240D, "..."), (0x240E, "..."),
        (0x240F, "Block 0 chosen"),
        (0x2411, "..."),
        (0x2414, "Draw the 24 blocks"),
        (0x2417, "Frame block 0"),
        (0x2419, "..."),
        (0x241C, "Pause..."),
        (0x241E, "..."), (0x2420, "..."), (0x2421, "..."), (0x2423, "..."),
        (0x2424, "..."),
        (0x2426, "Read the movement keys"),
        (0x2429, "SPACE?"),
        (0x242B, "..."), (0x242E, "..."),
        (0x2430, "Yes: the block's address, &6E80 + block x &30..."),
        (0x2432, "..."), (0x2434, "..."), (0x2437, "...(x 16)..."),
        (0x2438, "..."), (0x2439, "..."), (0x243A, "..."), (0x243B, "..."),
        (0x243D, "..."), (0x243F, "..."), (0x2441, "..."),
        (0x2443, "...(x 32)..."),
        (0x2445, "..."), (0x2446, "..."), (0x2448, "..."),
        (0x2449, "...(x 48)..."),
        (0x244B, "..."), (0x244D, "..."), (0x244F, "..."), (0x2451, "..."),
        (0x2453, "..."), (0x2454, "..."), (0x2456, "..."), (0x2458, "..."),
        (0x245A, "..."), (0x245C, "..."), (0x245E, "..."),
        (0x2460, "Copy its &30 bytes into level_wall_block"),
        (0x2462, "..."), (0x2464, "..."), (0x2467, "..."), (0x2468, "..."),
        (0x246A, "Return"),
        (0x246B, "Moved?"),
        (0x246E, "..."),
        (0x2471, "No: carry on"),
        (0x2473, "Yes: wait for the frame..."),
        (0x2475, "..."),
        (0x2478, "...erase the old frame..."),
        (0x247B, "..."), (0x247C, "..."), (0x247F, "..."), (0x2482, "..."),
        (0x2484, "..."), (0x2487, "..."), (0x2488, "..."),
        (0x248B, "...and frame the new block"),
        (0x248D, "..."),
        (0x2490, "Carry on"),
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
        (0x2495, "..."), (0x2496, "..."),
        (0x2497, "...sprite &12 + block..."),
        (0x2498, "..."), (0x249A, "..."),
        (0x249C, "...at the block's place"),
        (0x249D, "..."), (0x24A0, "..."),
        (0x24A3, "..."), (0x24A4, "..."), (0x24A5, "..."), (0x24A6, "..."),
        (0x24A8, "Return"),
    ])
    main.label(0x2495, "draw_wall_block")

    main.sub(0x24A9, "move_chooser", "Move the chosen wall block",
             "'.' and ',' move one block on or back, 'Z' and 'A' a row of four; "
             "a move off the grid is undone.",
             on_exit={"chosen_block": "the block now chosen",
                      "previous_block": "the block chosen before"})
    comments(main, [
        (0x24A9, "Remember the block chosen"),
        (0x24AC, "..."),
        (0x24AF, "Pressed?"),
        (0x24B1, "..."), (0x24B4, "..."),
        (0x24B6, "Yes: the next block..."),
        (0x24B9, "..."), (0x24BC, "..."), (0x24BE, "..."),
        (0x24C0, "...but not past 23"),
        (0x24C2, "Pressed?"),
        (0x24C4, "..."), (0x24C7, "..."),
        (0x24C9, "Yes: the previous block..."),
        (0x24CC, "..."),
        (0x24CE, "...but not before 0"),
        (0x24D0, "Pressed?"),
        (0x24D2, "..."), (0x24D5, "..."),
        (0x24D7, "Yes: a row on..."),
        (0x24D8, "..."), (0x24DB, "..."), (0x24DD, "..."), (0x24E0, "..."),
        (0x24E2, "..."),
        (0x24E4, "...but not past 23"),
        (0x24E6, "Pressed?"),
        (0x24E8, "..."), (0x24EB, "..."),
        (0x24ED, "Yes: a row back..."),
        (0x24EE, "..."), (0x24F1, "..."), (0x24F3, "..."), (0x24F6, "..."),
        (0x24F8, "...but not before 0"),
        (0x24FA, "Return"),
        (0x24FB, "Off the grid: undo the move"),
        (0x24FE, "..."), (0x2501, "Return"),
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
        (0x2504, "..."), (0x2506, "..."),
        (0x2509, "Z set if X and Y are both &FF"),
        (0x250B, "..."), (0x250D, "..."), (0x250F, "Return"),
    ])
    main.label(0x250F, "chooser_key_done")

    main.sub(0x2510, "block_place", "Find a wall block's place in the grid",
             "Block n is at column n mod 4, row n div 4: plot_x = 8 x column + "
             "&1A, plot_y = 24 x row + &14.",
             on_entry={"A": "block number"})
    comments(main, [
        (0x2510, "Keep it"),
        (0x2511, "plot_x = (n mod 4) x 8 + &1A"),
        (0x2513, "..."), (0x2514, "..."), (0x2515, "..."), (0x2516, "..."),
        (0x2517, "..."), (0x2519, "..."),
        (0x251B, "plot_y = (n div 4) x 24 + &14"),
        (0x251C, "..."), (0x251E, "..."), (0x251F, "..."), (0x2521, "..."),
        (0x2522, "..."), (0x2523, "..."), (0x2525, "..."), (0x2527, "..."),
        (0x2529, "Return"),
    ])

    main.sub(0x252A, "frame_block", "Draw or erase the frame round the chosen block",
             "Plot sprite A (&2A the frame, &2B a blank) one byte left of and "
             "two rows above the chosen block, then plot the block again.",
             on_entry={"A": "&2A to frame, &2B to erase"})
    comments(main, [
        (0x252A, "The frame sprite..."),
        (0x252C, "...at the chosen block's place..."),
        (0x252F, "..."),
        (0x2532, "...one byte left..."),
        (0x2534, "...and two rows up (C is clear: three, as the block is 18 rows)"),
        (0x2536, "..."), (0x2538, "..."),
        (0x253A, "Plot it"),
        (0x253D, "Then the block itself"),
        (0x2540, "..."), (0x2543, "..."), (0x2546, "..."), (0x2547, "..."),
        (0x2549, "..."), (0x254B, "..."),
        (0x254E, "Return"),
    ])
    main.label(0x254F, "load_stones_command")
    main.stringcr(0x254F)

    main.sub(0x255B, "show_25_rows", "Show 25 rows",
             "Send VDU 23,0,6,25,0,0,0,0,0,0.",
              on_exit={"A": "corrupted", "X": "corrupted", "Y": "preserved"})
    comments(main, [
        (0x255B, "Send rows_25_vdu"),
        (0x255D, "..."), (0x2560, "..."), (0x2563, "..."), (0x2564, "..."),
        (0x2566, "..."), (0x2568, "Return"),
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
        (0x2602, "..."), (0x2605, "..."), (0x2608, "..."),
        (0x260B, "For slots &4F to 0..."),
        (0x260D, "...what is in it?"),
        (0x2610, "Nothing"),
        (0x2612, "The exit?"),
        (0x2614, "..."),
        (0x2616, "A trapdoor?"),
        (0x2618, "..."),
        (0x261A, "A door or key?"),
        (0x261C, "..."),
        (0x261E, "An object: the next entry..."),
        (0x2621, "...its level type..."),
        (0x2622, "..."), (0x2625, "..."), (0x2628, "..."),
        (0x262B, "...and position"),
        (0x262E, "..."), (0x2631, "..."), (0x2634, "..."),
        (0x2637, "Next slot"),
        (0x2638, "..."), (0x263A, "Return"),
        (0x263B, "The exit: entry 30, type &51"),
        (0x263D, "..."), (0x263F, "..."), (0x2642, "..."), (0x2645, "..."),
        (0x2648, "..."), (0x264B, "..."),
        (0x264E, "Next slot (always branches)"),
        (0x2650, "A trapdoor: the next trapdoor entry"),
        (0x2653, "..."), (0x2656, "..."), (0x2659, "..."), (0x265C, "..."),
        (0x265F, "..."),
        (0x2662, "Next slot (always branches)"),
        (0x2664, "A key: skip it (it goes with its door)"),
        (0x2666, "..."),
        (0x2668, "A door: the next door entry..."),
        (0x266B, "...its sprite..."),
        (0x266C, "..."), (0x266F, "..."), (0x2672, "..."),
        (0x2675, "...and position"),
        (0x2678, "..."), (0x267B, "..."), (0x267E, "..."),
        (0x2681, "Find the door's link..."),
        (0x2683, "..."), (0x2685, "..."), (0x2688, "..."), (0x268A, "..."),
        (0x268C, "..."), (0x268D, "..."),
        (0x268F, "...and put its key's position in the same entry"),
        (0x2690, "..."), (0x2691, "..."), (0x2694, "..."), (0x2695, "..."),
        (0x2698, "..."), (0x269B, "..."), (0x269E, "..."), (0x26A1, "..."),
        (0x26A4, "..."), (0x26A5, "..."),
        (0x26A6, "Next slot"),
    ])
    for addr, name in [(0x260D, "pack_slot"), (0x2637, "pack_next"),
                       (0x263B, "pack_exit"), (0x2650, "pack_trapdoor"),
                       (0x2664, "pack_door"), (0x2685, "find_door_link"),
                       (0x268F, "pack_key")]:
        main.label(addr, name)

    main.sub(0x26A9, "pack_level", "Pack the level for saving",
             "Pack the item slots, then copy the wall map and the object-free "
             "map into the level file.",
              on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(main, [
        (0x26A9, "Pack the items"),
        (0x26AC, "Copy the &C9 bytes of each map"),
        (0x26AE, "..."), (0x26B1, "..."), (0x26B4, "..."), (0x26B7, "..."),
        (0x26BA, "..."), (0x26BB, "..."), (0x26BD, "..."),
        (0x26BF, "Return"),
    ])
    main.label(0x26AE, "copy_maps")
    main.banner(0x26C0, "Unused", "Zeros.")
    main.byte(0x26C0, 0x10, cols=8)
    main.c(0x26C0, "Not used")

    main.sub(0x26D0, "load_stones", "Load the wall blocks",
             "*LOAD STONES (at its own address, &6E80) with VDU output off.",
              on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(main, [
        (0x26D0, "VDU 21: output off"),
        (0x26D2, "..."),
        (0x26D5, "*LOAD STONES"),
        (0x26D7, "..."), (0x26D9, "..."),
        (0x26DC, "VDU 6: output on"),
        (0x26DE, "..."),
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
    main.c(0x2980, "...")
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
             "Wait for the frame, rub out the cursor and put back what is "
             "under it, move with ',' '.' 'A' 'Z' within the 32 by 48 map, and "
             "plot the current item there as the cursor.",
              on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(main, [
        (0x2B00, "Wait for the frame"),
        (0x2B02, "..."),
        (0x2B05, "Rub out the cursor (the blank sprite)"),
        (0x2B07, "..."),
        (0x2B0A, "Anything here?"),
        (0x2B0D, "No"),
        (0x2B0F, "Yes: plot it again"),
        (0x2B12, "Right key pressed?"),
        (0x2B14, "..."), (0x2B17, "..."),
        (0x2B19, "Yes: right (always branches)"),
        (0x2B1B, "..."),
        (0x2B1D, "Left key pressed?"),
        (0x2B1F, "..."), (0x2B22, "..."),
        (0x2B24, "Yes: left, to at least 0"),
        (0x2B26, "..."), (0x2B28, "..."), (0x2B2A, "..."),
        (0x2B2C, "Up key pressed?"),
        (0x2B2E, "..."), (0x2B31, "..."),
        (0x2B33, "Yes: up, to at least 0"),
        (0x2B35, "..."), (0x2B37, "..."), (0x2B39, "..."), (0x2B3B, "..."),
        (0x2B3D, "Down key pressed?"),
        (0x2B3F, "..."), (0x2B42, "..."),
        (0x2B44, "Yes: down (always branches)"),
        (0x2B46, "..."),
        (0x2B48, "At most column 31..."),
        (0x2B4A, "..."), (0x2B4C, "..."), (0x2B4E, "..."), (0x2B50, "..."),
        (0x2B52, "...and row 47"),
        (0x2B54, "..."), (0x2B56, "..."), (0x2B58, "..."), (0x2B5A, "..."),
        (0x2B5C, "Plot the current item at the cursor"),
        (0x2B5E, "..."),
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
        (0x2B66, "..."), (0x2B67, "..."),
        (0x2B69, "...and row 5y"),
        (0x2B6B, "..."), (0x2B6C, "..."), (0x2B6D, "..."), (0x2B6E, "..."),
        (0x2B70, "..."),
        (0x2B72, "Plot it"),
        (0x2B75, "Return"),
    ])

    main.sub(0x2B76, "item_at_cursor", "Find what is in the cursor's cell",
             "Search the slots for an item at the cursor; failing that, look "
             "at the wall map.",
             on_exit={"A": "the item's sprite and X its slot; 0 for a wall; &FF for nothing",
                      "N": "set for nothing"})
    comments(main, [
        (0x2B76, "For slots &4F to 0..."),
        (0x2B78, "...x matches..."),
        (0x2B7B, "..."), (0x2B7D, "..."),
        (0x2B7F, "...and y matches?"),
        (0x2B82, "..."), (0x2B84, "..."),
        (0x2B86, "Yes: return its item"),
        (0x2B89, "..."),
        (0x2B8A, "Next slot"),
        (0x2B8B, "..."),
        (0x2B8D, "No item: is there a wall?"),
        (0x2B90, "..."), (0x2B92, "..."), (0x2B94, "..."),
        (0x2B96, "Yes: 0"),
        (0x2B98, "..."),
        (0x2B99, "No: &FF"),
        (0x2B9B, "..."),
    ])
    for addr, name in [(0x2B78, "search_slots"), (0x2B8A, "next_slot"),
                       (0x2B99, "nothing_here")]:
        main.label(addr, name)

    main.sub(0x2B9C, "wall_bit", "Find the cursor's bit in the wall map",
             "As the game lays out its maps: the byte at (y AND &F8) x 4 + "
             "(y AND 7) + (x AND &F8), bit 7 - (x AND 7).",
             on_exit={"map_ptr": "address of the byte", "bit_mask": "the bit",
                      "Y": "0"})
    comments(main, [
        (0x2B9C, "(y AND &F8) x 4..."),
        (0x2B9E, "..."), (0x2BA0, "..."), (0x2BA1, "..."), (0x2BA2, "..."),
        (0x2BA4, "...+ (y AND 7)..."),
        (0x2BA6, "..."), (0x2BA8, "..."), (0x2BA9, "..."), (0x2BAB, "..."),
        (0x2BAD, "...+ (x AND &F8)..."),
        (0x2BAF, "..."), (0x2BB1, "..."), (0x2BB2, "..."), (0x2BB4, "..."),
        (0x2BB6, "...in wall_map"),
        (0x2BB8, "..."),
        (0x2BBA, "Bit 7 - (x AND 7)..."),
        (0x2BBC, "..."), (0x2BBE, "..."), (0x2BC0, "..."), (0x2BC2, "..."),
        (0x2BC3, "..."),
        (0x2BC5, "...(bit 0)..."),
        (0x2BC7, "..."), (0x2BC8, "..."), (0x2BCA, "..."), (0x2BCB, "..."),
        (0x2BCC, "..."), (0x2BCE, "...(always branches)"),
        (0x2BD0, "..."),
        (0x2BD2, "..."),
        (0x2BD4, "Y = 0"),
        (0x2BD6, "Return"),
    ])
    main.label(0x2BCA, "shift_bit")
    main.label(0x2BD0, "bit_0")
    main.label(0x2BD2, "bit_found")

    main.sub(0x2BD7, "put_item", "Put the current item in the cursor's cell",
             "Clear the cell's object-free bit. A wall sets the wall map's "
             "bit; anything else takes a free slot, and a key is recorded as "
             "the key of the link being made.",
              on_entry={"cursor_x": "the cell's column", "cursor_y": "the cell's row", "current_item": "the item to put there", "link_index": "for a key, its door's link"}, on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(main, [
        (0x2BD7, "Clear the cell's object-free bit"),
        (0x2BDA, "A wall?"),
        (0x2BDC, "..."),
        (0x2BDE, "Yes: set its bit in the wall map"),
        (0x2BE1, "..."), (0x2BE3, "..."), (0x2BE5, "..."),
        (0x2BE7, "Return"),
        (0x2BE8, "Find a free slot..."),
        (0x2BEA, "..."), (0x2BED, "..."), (0x2BEF, "..."), (0x2BF0, "..."),
        (0x2BF2, "...and put the item in it"),
        (0x2BF4, "..."), (0x2BF7, "..."), (0x2BF9, "..."), (0x2BFC, "..."),
        (0x2BFE, "..."),
        (0x2C01, "A key?"),
        (0x2C03, "..."),
        (0x2C05, "Yes: it is the link's key"),
        (0x2C06, "..."), (0x2C09, "..."),
        (0x2C0C, "Return"),
    ])
    for addr, name in [(0x2BE8, "put_in_slot"), (0x2BEA, "find_free_slot"),
                       (0x2BF2, "free_slot_found"), (0x2C0C, "put_item_done")]:
        main.label(addr, name)

    main.sub(0x2C0D, "remove_at_cursor", "Remove what is in the cursor's cell",
             "Free an item's slot, or clear a wall's bit in the wall map.",
              on_entry={"cursor_x": "the cell's column", "cursor_y": "the cell's row"}, on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(main, [
        (0x2C0D, "What is here?"),
        (0x2C10, "A wall"),
        (0x2C12, "Nothing"),
        (0x2C14, "An item: free its slot"),
        (0x2C17, "Return (always branches)"),
    ])
    main.label(0x2C19, "clear_wall")
    main.banner(0x2C19, "Clear the cursor's wall", "Clear its bit in the wall map.")
    comments(main, [
        (0x2C19, "Clear the cell's bit in the wall map"),
        (0x2C1C, "..."), (0x2C1E, "..."), (0x2C20, "..."), (0x2C22, "..."),
        (0x2C24, "..."), (0x2C26, "..."),
        (0x2C28, "Return"),
    ])
    main.label(0x2C28, "remove_done")

    main.sub(0x2C29, "place_item", "Place the current item at the cursor",
             "In an empty cell, place the current item within the limits: one "
             "exit, eight trapdoors, 20 doors (a door is also a wall), 29 "
             "objects, and a key only when a door is waiting for one, which "
             "links the two. With a key chosen, SPACE on an unlinked door "
             "makes it the door waiting for its key.",
              on_entry={"cursor_x": "the cell's column", "cursor_y": "the cell's row", "current_item": "the item to place"}, on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(main, [
        (0x2C29, "What is here?"),
        (0x2C2C, "Nothing: place the item"),
        (0x2C2E, "A wall: leave it"),
        (0x2C30, "A door?"),
        (0x2C32, "..."), (0x2C34, "..."), (0x2C36, "..."),
        (0x2C38, "Return"),
        (0x2C39, "The current item: a wall?"),
        (0x2C3B, "..."),
        (0x2C3D, "The exit?"),
        (0x2C3F, "..."),
        (0x2C41, "A trapdoor?"),
        (0x2C43, "..."),
        (0x2C45, "A door?"),
        (0x2C47, "..."), (0x2C49, "..."), (0x2C4B, "..."),
        (0x2C4D, "A key?"),
        (0x2C4F, "..."),
        (0x2C51, "An object: count it..."),
        (0x2C53, "..."), (0x2C55, "..."),
        (0x2C57, "...and place it if there are now at most 29"),
        (0x2C59, "Too many: uncount it"),
        (0x2C5B, "Return"),
        (0x2C5C, "The exit: only one"),
        (0x2C5E, "..."),
        (0x2C60, "..."), (0x2C62, "..."),
        (0x2C64, "Return"),
        (0x2C65, "A trapdoor: at most 8"),
        (0x2C67, "..."), (0x2C69, "..."), (0x2C6B, "..."), (0x2C6D, "..."),
        (0x2C6F, "Return"),
        (0x2C70, "A door: it is a wall too..."),
        (0x2C73, "..."), (0x2C75, "..."), (0x2C77, "..."),
        (0x2C79, "...at most 20"),
        (0x2C7B, "..."), (0x2C7D, "..."), (0x2C7F, "..."), (0x2C81, "..."),
        (0x2C83, "Return"),
        (0x2C84, "A key: is a door waiting for one?"),
        (0x2C87, "No: return"),
        (0x2C89, "Yes: take a free link..."),
        (0x2C8C, "...for the waiting door..."),
        (0x2C8F, "..."), (0x2C92, "..."),
        (0x2C95, "...show the door as it was..."),
        (0x2C98, "...and nothing waiting"),
        (0x2C9A, "..."),
        (0x2C9D, "Place the key"),
        (0x2CA0, "Put it in the cell"),
        (0x2CA3, "A door with a key chosen?"),
        (0x2CA5, "..."), (0x2CA7, "..."),
        (0x2CA9, "Yes: is the door linked already?"),
        (0x2CAB, "..."), (0x2CAD, "..."), (0x2CB0, "..."), (0x2CB2, "..."),
        (0x2CB4, "..."), (0x2CB5, "..."),
        (0x2CB7, "No"),
        (0x2CB9, "Yes: return"),
        (0x2CBA, "Another door waiting?"),
        (0x2CBC, "..."), (0x2CBF, "..."),
        (0x2CC1, "Yes: show it as it was"),
        (0x2CC2, "..."), (0x2CC3, "..."), (0x2CC6, "..."), (0x2CC7, "..."),
        (0x2CC8, "This door is waiting: remember its sprite and slot..."),
        (0x2CCB, "..."), (0x2CCE, "..."),
        (0x2CD1, "...and show it as waiting (sprite &11)"),
        (0x2CD3, "..."),
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
             "Put the waiting door's own sprite back in its slot and plot it.",
              on_exit={"A": "corrupted", "X": "corrupted", "Y": "preserved"})
    comments(main, [
        (0x2CD7, "The waiting door's slot..."),
        (0x2CDA, "...and sprite..."),
        (0x2CDD, "...back in the slot"),
    ])
    main.sub(0x2CE0, "plot_slot", "Plot a sprite at a slot's cell",
             "At screen byte column 2x and pixel row 5y of slot X's cell.",
             on_entry={"A": "sprite number", "X": "slot"})
    comments(main, [
        (0x2CE0, "The sprite..."),
        (0x2CE2, "...at column 2x..."),
        (0x2CE5, "..."), (0x2CE6, "..."),
        (0x2CE8, "...and row 5y"),
        (0x2CEB, "..."), (0x2CEC, "..."), (0x2CED, "..."), (0x2CEE, "..."),
        (0x2CF1, "..."),
        (0x2CF3, "Plot it"),
        (0x2CF6, "Return"),
    ])

    main.sub(0x2CF7, "find_free_link", "Find a free door-key link",
             "The highest link whose door is &FF.",
             on_exit={"link_index": "the link"})
    comments(main, [
        (0x2CF7, "For links 19 down..."),
        (0x2CF9, "...unused?"),
        (0x2CFC, "..."), (0x2CFE, "..."), (0x2CFF, "..."),
        (0x2D01, "Use it"),
        (0x2D04, "Return"),
    ])
    main.label(0x2CF9, "search_links")
    main.label(0x2D01, "free_link_found")

    main.sub(0x2D05, "free_slot", "Free a slot",
             "Zero its item and position.", on_entry={"X": "slot"},
             on_exit={"A": "0", "Z": "set"})
    comments(main, [
        (0x2D05, "Zero its item..."),
        (0x2D07, "..."),
        (0x2D0A, "...and position"),
        (0x2D0D, "..."),
        (0x2D10, "Return"),
    ])

    main.sub(0x2D11, "delete_item", "Delete what is in the cursor's cell",
             "Uncount the item and remove it. Deleting a door removes its key "
             "too, and deleting a key removes its door (and the door's wall). "
             "A waiting door is left alone. A wall is cleared.",
              on_entry={"cursor_x": "the cell's column", "cursor_y": "the cell's row"}, on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(main, [
        (0x2D11, "What is here?"),
        (0x2D14, "Nothing: remove (nothing)"),
        (0x2D16, "A wall: clear it"),
        (0x2D18, "A waiting door?"),
        (0x2D1A, "..."),
        (0x2D1C, "Yes: leave it"),
        (0x2D1D, "Keep the slot"),
        (0x2D1F, "The exit?"),
        (0x2D21, "..."),
        (0x2D23, "A trapdoor?"),
        (0x2D25, "..."),
        (0x2D27, "A door?"),
        (0x2D29, "..."), (0x2D2B, "..."), (0x2D2D, "..."),
        (0x2D2F, "A key?"),
        (0x2D31, "..."),
        (0x2D33, "An object: uncount it (always branches)"),
        (0x2D35, "..."),
        (0x2D37, "The exit: none placed"),
        (0x2D39, "..."), (0x2D3B, "..."),
        (0x2D3D, "A trapdoor: uncount it (always branches)"),
        (0x2D3F, "..."),
        (0x2D41, "A door: uncount it..."),
        (0x2D43, "...find its link..."),
        (0x2D45, "..."), (0x2D48, "..."), (0x2D4A, "..."),
        (0x2D4C, "...free it..."),
        (0x2D4E, "..."),
        (0x2D51, "...rub out its key..."),
        (0x2D54, "..."), (0x2D55, "..."), (0x2D56, "..."), (0x2D58, "..."),
        (0x2D5B, "..."), (0x2D5C, "..."),
        (0x2D5D, "...and free the key's slot"),
        (0x2D60, "...(always branches)"),
        (0x2D62, "Next link"),
        (0x2D63, "..."),
        (0x2D65, "Remove the item itself"),
        (0x2D68, "A key: keep the cursor's cell"),
        (0x2D6A, "..."), (0x2D6D, "..."), (0x2D6F, "..."),
        (0x2D72, "Find the key's link..."),
        (0x2D74, "..."), (0x2D77, "..."), (0x2D79, "..."),
        (0x2D7B, "...keep it..."),
        (0x2D7C, "..."),
        (0x2D7D, "...take its door's slot..."),
        (0x2D80, "..."), (0x2D81, "..."),
        (0x2D82, "...and cell..."),
        (0x2D85, "..."), (0x2D87, "..."), (0x2D8A, "..."),
        (0x2D8C, "...rub out the door..."),
        (0x2D8E, "..."),
        (0x2D91, "...free its slot..."),
        (0x2D92, "..."), (0x2D93, "..."),
        (0x2D96, "...uncount it..."),
        (0x2D97, "..."), (0x2D98, "..."),
        (0x2D9A, "...free the link..."),
        (0x2D9C, "..."),
        (0x2D9F, "...clear the door's wall..."),
        (0x2DA2, "...and go back to the key's cell"),
        (0x2DA5, "..."), (0x2DA7, "..."), (0x2DAA, "..."),
        (0x2DAC, "Remove the key"),
        (0x2DAF, "Next link"),
        (0x2DB0, "..."),
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
        (0x2DB4, "..."), (0x2DB7, "..."),
        (0x2DBA, "x x 8..."),
        (0x2DBD, "..."), (0x2DBE, "..."), (0x2DBF, "..."), (0x2DC0, "..."),
        (0x2DC1, "...x 16..."),
        (0x2DC2, "..."),
        (0x2DC5, "...x 32, with the carries in the high byte"),
        (0x2DC6, "..."), (0x2DC9, "..."),
        (0x2DCC, "Return"),
    ])

    main.sub(0x2DCD, "line_y_to_graphics", "Convert line_y to graphics y",
             "line_gy = &3FF - line_y x 20: a cell is five pixel rows, 20 "
             "graphics units, counted down from the top of the screen.",
              on_entry={"line_y": "a map row"}, on_exit={"line_gy": "its graphics y, &3FF - row x 20", "A": "corrupted", "X": "preserved", "Y": "preserved"})
    comments(main, [
        (0x2DCD, "Clear the result"),
        (0x2DCF, "..."), (0x2DD2, "..."),
        (0x2DD5, "y x 4..."),
        (0x2DD8, "..."), (0x2DD9, "..."), (0x2DDA, "..."), (0x2DDC, "..."),
        (0x2DDD, "...x 16..."),
        (0x2DDE, "..."), (0x2DE1, "..."), (0x2DE2, "..."), (0x2DE5, "..."),
        (0x2DE8, "...plus x 4: x 20"),
        (0x2DE9, "..."), (0x2DEB, "..."), (0x2DEE, "..."), (0x2DF1, "..."),
        (0x2DF3, "..."),
        (0x2DF6, "&3FF - y x 20"),
        (0x2DF8, "..."), (0x2DF9, "..."), (0x2DFC, "..."), (0x2DFF, "..."),
        (0x2E01, "..."), (0x2E04, "..."),
        (0x2E07, "Return"),
    ])

    main.sub(0x2E08, "plot_line_point", "PLOT to a cell",
             "VDU 25 with plot code X and the graphics position of (line_x, line_y).",
             on_entry={"X": "PLOT code"})
    comments(main, [
        (0x2E08, "The cell's graphics position..."),
        (0x2E0B, "..."), (0x2E0E, "..."), (0x2E11, "..."),
        (0x2E14, "VDU 25, X..."),
        (0x2E16, "..."), (0x2E19, "..."), (0x2E1A, "..."),
        (0x2E1D, "...x..."),
        (0x2E20, "..."), (0x2E23, "..."), (0x2E26, "..."),
        (0x2E29, "...y"),
        (0x2E2C, "..."), (0x2E2F, "..."), (0x2E32, "..."),
        (0x2E35, "Return"),
    ])

    main.sub(0x2E36, "draw_links", "Draw each door-key link as a line",
             "For each link in use, PLOT 68 at the door's cell and PLOT 5 to "
             "its key's: exclusive-OR lines (GCOL 3), so drawing them again "
             "rubs them out.",
              on_exit={"A": "corrupted", "X": "corrupted", "Y": "preserved"})
    comments(main, [
        (0x2E36, "For links 19 to 0..."),
        (0x2E38, "..."), (0x2E39, "..."),
        (0x2E3A, "...in use?"),
        (0x2E3D, "..."),
        (0x2E3F, "Yes: from the door's cell..."),
        (0x2E40, "..."), (0x2E43, "..."), (0x2E46, "..."), (0x2E49, "..."),
        (0x2E4C, "...(PLOT 68: a point)..."),
        (0x2E4E, "..."),
        (0x2E51, "...to the key's cell..."),
        (0x2E52, "..."), (0x2E53, "..."), (0x2E54, "..."), (0x2E57, "..."),
        (0x2E58, "..."), (0x2E5B, "..."), (0x2E5E, "..."), (0x2E61, "..."),
        (0x2E64, "...(PLOT 5: a line)"),
        (0x2E66, "..."),
        (0x2E69, "Next link"),
        (0x2E6A, "..."), (0x2E6B, "..."), (0x2E6C, "..."),
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
        (0x2E92, "..."), (0x2E94, "..."),
        (0x2E97, "Z set if X and Y are both &FF"),
        (0x2E99, "..."), (0x2E9B, "..."), (0x2E9D, "Return"),
    ])
    main.label(0x2E9D, "cursor_key_done")

    # -----------------------------------------------------------------------
    # unpack_level, run at &7B00.

    in_unpack.sub(0x7B00, "unpack_level", "Unpack the loaded level into the slots",
                  "Read the level file's tables from the last entry back, "
                  "putting each item in the next slot down from &4F: objects "
                  "(with their editor items found from item_types), each door "
                  "and then its key (linked), and the trapdoors. Copy the wall "
                  "map and object-free map. Count the objects and doors.",
                   on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(in_unpack, [
        (0x7B00, "No doors..."),
        (0x7B02, "..."),
        (0x7B04, "...and no objects (the exit is counted too, so -1)"),
        (0x7B06, "..."),
        (0x7B08, "All 8 trapdoors"),
        (0x7B0A, "..."),
        (0x7B0C, "Slots from &4F down..."),
        (0x7B0E, "..."),
        (0x7B11, "...links from 19 down"),
        (0x7B13, "..."),
        (0x7B16, "For objects 30 to 1..."),
        (0x7B18, "...in use?"),
        (0x7B1B, "..."),
        (0x7B1D, "Yes: count it..."),
        (0x7B1F, "...and put it in the next slot..."),
        (0x7B22, "..."), (0x7B25, "..."), (0x7B28, "..."),
        (0x7B2B, "...as the editor's item for its type"),
        (0x7B2E, "..."), (0x7B31, "..."), (0x7B34, "..."), (0x7B37, "..."),
        (0x7B3A, "Next object"),
        (0x7B3B, "..."),
        (0x7B3D, "For doors 20 to 1..."),
        (0x7B3F, "...in use?"),
        (0x7B42, "..."),
        (0x7B44, "Yes: count it..."),
        (0x7B46, "...link it: the door's slot..."),
        (0x7B49, "..."), (0x7B4C, "..."),
        (0x7B4F, "...and the key's, the slot below..."),
        (0x7B50, "..."), (0x7B52, "..."), (0x7B55, "..."),
        (0x7B58, "...put the door in its slot..."),
        (0x7B5B, "..."), (0x7B5E, "..."), (0x7B61, "..."), (0x7B64, "..."),
        (0x7B67, "..."), (0x7B6A, "..."), (0x7B6D, "..."), (0x7B70, "..."),
        (0x7B73, "..."),
        (0x7B76, "...and the key in the next"),
        (0x7B77, "..."), (0x7B7A, "..."), (0x7B7D, "..."), (0x7B80, "..."),
        (0x7B83, "..."), (0x7B85, "..."), (0x7B88, "..."),
        (0x7B8B, "Next door"),
        (0x7B8C, "..."),
        (0x7B8E, "For trapdoors 7 to 0..."),
        (0x7B90, "...put each in the next slot"),
        (0x7B93, "..."), (0x7B96, "..."), (0x7B99, "..."), (0x7B9C, "..."),
        (0x7B9F, "..."), (0x7BA1, "..."), (0x7BA4, "..."), (0x7BA7, "..."),
        (0x7BA8, "..."),
        (0x7BAA, "Copy the &C9 bytes of each map"),
        (0x7BAC, "..."), (0x7BAF, "..."), (0x7BB2, "..."), (0x7BB5, "..."),
        (0x7BB8, "..."), (0x7BB9, "..."), (0x7BBB, "..."),
        (0x7BBD, "Return"),
    ])
    for addr, name in [(0x7B18, "unpack_object"), (0x7B3A, "next_object"),
                       (0x7B3F, "unpack_door"), (0x7B8B, "next_door"),
                       (0x7B90, "unpack_trapdoor"), (0x7BAC, "unpack_maps")]:
        in_unpack.label(addr, name)
    in_unpack.sub(0x7BBE, "item_for_type", "Find the editor's item for a level type",
                  "Search item_types from entry 1 for the type. A type with no "
                  "item would search on into the bytes beyond.",
                  on_entry={"A": "level type"}, on_exit={"A": "item"})
    comments(in_unpack, [
        (0x7BBE, "Keep the type"),
        (0x7BC0, "From item 1..."),
        (0x7BC2, "...a match?"),
        (0x7BC5, "..."), (0x7BC7, "..."),
        (0x7BC9, "Yes: return the item"),
        (0x7BCA, "..."),
        (0x7BCB, "No: next"),
        (0x7BCC, "..."),
    ])
    in_unpack.label(0x7BC2, "search_types")
    in_unpack.label(0x7BCB, "next_type")

    in_free_cell.sub(0x7D80, "free_cell", "Mark the cursor's cell as holding an object",
                     "Clear its bit in the object-free map (laid out as the wall map).",
                      on_entry={"cursor_x": "the cell's column", "cursor_y": "the cell's row"}, on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(in_free_cell, [
        (0x7D80, "(y AND &F8) x 4..."),
        (0x7D82, "..."), (0x7D84, "..."), (0x7D85, "..."), (0x7D86, "..."),
        (0x7D88, "...+ (y AND 7)..."),
        (0x7D8A, "..."), (0x7D8C, "..."), (0x7D8D, "..."), (0x7D8F, "..."),
        (0x7D91, "...+ (x AND &F8)..."),
        (0x7D93, "..."), (0x7D95, "..."), (0x7D96, "..."), (0x7D98, "..."),
        (0x7D9A, "...in object_free_map"),
        (0x7D9C, "..."),
        (0x7D9E, "Bit 7 - (x AND 7)..."),
        (0x7DA0, "..."), (0x7DA2, "..."), (0x7DA4, "..."), (0x7DA6, "..."),
        (0x7DA7, "..."), (0x7DA9, "..."), (0x7DAB, "..."), (0x7DAC, "..."),
        (0x7DAE, "..."), (0x7DAF, "..."), (0x7DB0, "..."),
        (0x7DB2, "...(always branches)"),
        (0x7DB4, "..."),
        (0x7DB6, "Clear it"),
        (0x7DB8, "..."), (0x7DBA, "..."), (0x7DBC, "..."), (0x7DBE, "..."),
        (0x7DC0, "..."),
        (0x7DC2, "Return"),
    ])
    in_free_cell.label(0x7DAE, "free_shift_bit")
    in_free_cell.label(0x7DB4, "free_bit_0")
    in_free_cell.label(0x7DB6, "free_bit_found")

    main.banner(0x19DE, "Unused", "Leftover bytes after unpack_level's image.")
    main.byte(0x19DE, 0x22, cols=8)

    main.c(0x19DE, "Not used")
    main.banner(0x1A43, "Unused", "Leftover bytes, among them the text PAGE.")
    main.byte(0x1A43, 0x1C10 - 0x1A43, cols=16)
    main.c(0x1A43, "Not used")

    # The editor's sprite numbers, limits, characters and keys.
    for number, name in EDITOR_SPRITES:
        d.constant(number, f"spr_{name}", comment=f"Editor sprite &{number:02X}")
    for value, name, text in EDITOR_CONSTANTS:
        d.constant(value, name, comment=text)
    for operand_addr, expression in EDITOR_OPERANDS:
        if 0x7B00 <= operand_addr < 0x7BCE:
            d.expr(operand_addr, expression, move=unpack)
        elif 0x7D80 <= operand_addr < 0x7DC3:
            d.expr(operand_addr, expression, move=free_cell)
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
