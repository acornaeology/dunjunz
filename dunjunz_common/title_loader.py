"""Annotations for *DUNJUNZ, the loader and title screen, on both sides
of the disc.

The Model B side's `Dunjunz` (load &26C0, exec &2700) sets up page &08 for
the game, arms the BREAK intercept that chains the levels, shows the title
screen with its twinkling stars, and runs Coder. The Master 128 side's
(load and exec &2649) is the same program with &2649-&26BF added in front,
which loads the private-RAM files and chooses between Coder and Coder2,
and four bytes changed: &26D2 (the call that leaves the title), &278D
(the BREAK intercept is left disabled) and &287F/&2887 (Table's copy of
the screen's row offsets, at &C675, in place of MOS 1.20's at &C375). The
two share their addresses from &26C0 on.
"""

from dasmos.expr import char, hi, lo, sym

from dunjunz_common.annotator import Annotator


def comments(a, pairs):
    for addr, text in pairs:
        a.c(addr, text)


def no_return(disassembler, jsr_binary_addr):
    """leave_title never returns: stop the trace at its JSR, so that the
    padding after the call is not decoded as code."""
    return jsr_binary_addr


def annotate(d, model_b=False):
    """Annotate the Dunjunz loaded in `d`: the Master side's, or with
    `model_b` the Model B side's."""
    version = "disc" if model_b else "disc_master"
    loader = Annotator(d, version, lambda addr: [(None, "")],
                       default_group=lambda addr: "loader")

    d.constant(0x7B, "title_plot_reversed",
               comment="Zero page flag for title_plot_star: non-zero plots each row right to left")
    d.constant(0x80, "star_x", comment="Zero page: each star's byte column (three stars)")
    d.constant(0x83, "star_y", comment="Zero page: each star's pixel row")
    d.constant(0x86, "star_frame", comment="Zero page: each star's animation frame, 0-6")
    d.constant(0x89, "star_frame_step", comment="Zero page: each star's frame step, +1 or -1")
    d.constant(0x8C, "star_place", comment="Zero page: each star's place in star_places_x")


    def loader_sym(operand_addr, name):
        d.expr(operand_addr, sym(name))


    if not model_b:
        annotate_master_prefix(loader)

    loader.sub(0x26C0, "load_title_screen", "Load the title screen while output is off",
               "VDU 21, *LOAD SCREEN (the MODE 2 picture, to &3280), VDU 6.",
                on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(loader, [
        (0x26C0, "VDU 21: disable VDU output"),
        (0x26C2, "..."),
        (0x26C5, "*LOAD SCREEN"),
        (0x26C7, "..."), (0x26C9, "..."),
        (0x26CC, "VDU 6: enable VDU output"),
        (0x26CE, "..."), (0x26D1, "Return"),
    ])
    d.hook_subroutine(0x26D2, "leave_title", no_return)
    if model_b:
        loader.sub(0x26D2, "leave_title", "Disable VDU output and run Coder",
                   "VDU 21, then *CODER, which does not return.")
        comments(loader, [
            (0x26D2, "VDU 21: disable VDU output"),
            (0x26D4, "..."),
            (0x26D7, "*CODER (no return)"),
            (0x26D9, "..."), (0x26DB, "..."),
        ])
        loader.banner(0x26DE, "Unused", "Leftover bytes.")
        loader.byte(0x26DE, 0x22, cols=8)
        loader.c(0x26DE, "Not used")
    else:
        loader.sub(0x26D2, "leave_title", "Blank the display and run Coder",
                   "Where the Model B loader ends with VDU 21 and *CODER, this "
                   "version blanks the display and chooses between CODER and "
                   "CODER2. It never returns.")
        comments(loader, [
            (0x26D2, "Blank the display and disable output"),
            (0x26D5, "Padding"), (0x26D6, "..."),
            (0x26D7, "Run Coder (no return)"),
        ])
        loader.banner(0x26DA, "Unused",
                      "Leftover bytes, never run: the tail of the Model B loader's "
                      "*CODER call, then data.")
        loader.byte(0x26DA, 0x26, cols=8)
        loader.c(0x26DA, "Not used")

    if model_b:
        title_start_description = (
            "Disable ESCAPE, make the cursor keys return codes, set the level "
            "counter, the level digits and the menu tables in page &08 for "
            "Coder and the game, point the BREAK intercept at &15B5 (the "
            "game's next-level intercept), load and show the title screen, "
            "twinkle stars on it until a key is pressed, then select the "
            "game's display, arm the BREAK intercept and run Coder.")
    else:
        title_start_description = (
            "The Model B loader's start-up. Disable ESCAPE, make the cursor "
            "keys return codes, set the Model B release's level counter and "
            "menu tables in page &08 (not used by this side's game), point "
            "the BREAK intercept at &15B5 but leave it disabled, load and show "
            "the title screen, twinkle stars on it until a key is pressed, "
            "then select the game's display and run Coder.")
    loader.sub(0x2700, "title_start", "Set up, show the title and run Coder",
               title_start_description,
                on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(loader, [
        (0x2700, "OSBYTE &C8: ESCAPE disabled..."),
        (0x2702, "..."), (0x2704, "..."), (0x2706, "..."),
        (0x2709, "OSBYTE 4, 1: cursor keys return codes"),
        (0x270B, "..."), (0x270D, "..."),
        (0x2710, "Levels started = 0, for Coder" if model_b
                 else "Levels started = 0, for the Model B release's Coder"),
        (0x2712, "..."),
        (0x2715, "Level digits = \"0 \"..."),
        (0x2717, "..."), (0x271A, "..."), (0x271C, "..."),
        (0x271F, "For each hero..."),
        (0x2721, "...no ten-thousands digit (sprite &69)..."),
        (0x2723, "...at &08B0..."),
        (0x2726, "...and switched on..."),
        (0x2728, "...at &08B4 (the menu tables)" if model_b
                 else "...at &08B4 (the Model B release's menu tables)"),
        (0x272B, "..."), (0x272C, "..."),
        (0x272E, "BREAK intercept address = &15B5 (the game's next-level "
                 "intercept)..." if model_b else
                 "BREAK intercept address = &15B5 (the Model B game's "
                 "next-level intercept)..."),
        (0x2730, "..."), (0x2733, "..."), (0x2735, "..."),
        (0x2738, "...disabled for now: &0287 is not a JMP" if model_b
                 else "...but disabled: &0287 is not a JMP"),
        (0x273A, "..."),
        (0x273D, "*TV 255,1: vertical offset for the title's MODE 2"),
        (0x273F, "..."), (0x2741, "..."),
        (0x2744, "MODE 2, cursor off"),
        (0x2747, "Make all sixteen logical colours black..."),
        (0x2749, "...VDU 19, colour, 0, 0, 0, 0..."),
        (0x274B, "..."), (0x274E, "..."), (0x274F, "..."), (0x2752, "..."),
        (0x2754, "..."), (0x2757, "..."), (0x275A, "..."), (0x275D, "..."),
        (0x2760, "..."), (0x2761, "..."),
        (0x2763, "Load the title screen unseen"),
        (0x2766, "Padding"), (0x2767, "..."), (0x2768, "..."), (0x2769, "..."),
        (0x276A, "VDU 20: default colours, showing the picture"),
        (0x276C, "..."),
        (0x276F, "Plot the stars left to right"),
        (0x2771, "..."),
        (0x2773, "OSBYTE &15: flush the buffer X"),
        (0x2775, "..."),
        (0x2778, "Twinkle stars until a key is pressed"),
        (0x277B, "*TV 252,1: vertical offset for the game's display"),
        (0x277D, "..."), (0x277F, "..."),
        (0x2782, "MODE 2, cursor off"),
        (0x2785, "*DISC"),
        (0x2787, "..."), (0x2789, "..."),
        (0x278C, "Arm the BREAK intercept: &0287 = JMP" if model_b
                 else "BREAK intercept stays disabled"),
        (0x278E, "..."),
        (0x2791, ("Disable output" if model_b else "Blank the display")
                 + " and run Coder (no return)"),
        (0x2794, "Padding"), (0x2795, "..."), (0x2796, "..."), (0x2797, "..."),
    ])
    for addr, name, length in [
        (0x2798, "load_screen_command", 11),
        (0x27A4, "disc_command", 4),
        (0x27A9, "coder_command", 5),
        (0x27AF, "tv_game_command", 7),
        (0x27B7, "tv_title_command", 7),
    ]:
        loader.label(addr, name)
        loader.stringcr(addr)

    loader.sub(0x27BF, "mode2_cursor_off", "Select MODE 2 and turn the cursor off",
               "VDU 22,2 then VDU 23,0,10,&20,0,0,0,0,0,0 (6845 register 10: no "
               "cursor), from cursor_off_vdu.",
                on_exit={"A": "corrupted", "X": "corrupted", "Y": "preserved"})
    comments(loader, [
        (0x27BF, "VDU 22, 2: MODE 2"),
        (0x27C1, "..."), (0x27C4, "..."), (0x27C6, "..."),
        (0x27C9, "Send the eleven bytes of cursor_off_vdu"),
        (0x27CB, "..."), (0x27CE, "..."), (0x27D1, "..."), (0x27D2, "..."),
        (0x27D4, "..."), (0x27D6, "Return"),
    ])
    loader.banner(0x27D7, "Unused", "Leftover bytes.")
    loader.byte(0x27D7, 0x19, cols=8)
    loader.c(0x27D7, "Not used")
    loader.label(0x27F0, "cursor_off_vdu", length=11)
    loader.byte(0x27F0, 11, cols=11)
    loader.byte(0x27FB, 5, cols=5)
    loader.c(0x27FB, "Not used")

    loader.sub(0x2800, "title_plot_star", "Plot a star frame on the title screen",
               "Exclusive-OR a 7-byte by 28-row frame of the star animation onto "
               "the MODE 2 screen at byte column plot_x and pixel row plot_y, "
               "row by row and left to right (or right to left if "
               "title_plot_reversed is set). A version of the game's plot_sprite "
               "with its own frames.",
               on_entry={"plot_x": "byte column", "plot_y": "pixel row",
                         "sprite_number": "frame, 0-6"})
    comments(loader, [
        (0x2800, "Seven bytes wide..."),
        (0x2802, "..."),
        (0x2804, "...and 28 rows high"),
        (0x2806, "..."),
        (0x2808, "Point at the frame's data..."),
        (0x280A, "..."), (0x280D, "..."), (0x280F, "..."), (0x2812, "..."),
        (0x2814, "Screen address of the top left"),
        (0x2817, "For each row..."),
        (0x2819, "...remember its start..."),
        (0x281B, "..."), (0x281D, "..."), (0x281F, "..."),
        (0x2821, "..."), (0x2822, "..."),
        (0x2823, "...for each byte across..."),
        (0x2825, "...exclusive-OR the frame onto the screen..."),
        (0x2827, "..."), (0x2829, "..."),
        (0x282B, "...and step a character cell (8 bytes) right or left"),
        (0x282D, "..."),
        (0x282F, "Right..."),
        (0x2830, "..."), (0x2832, "..."), (0x2834, "..."), (0x2836, "..."),
        (0x2838, "..."), (0x283A, "...(always branches)"),
        (0x283C, "Left..."),
        (0x283D, "..."), (0x283F, "..."), (0x2841, "..."), (0x2843, "..."),
        (0x2845, "..."),
        (0x2847, "Next byte of the frame"),
        (0x2849, "..."), (0x284B, "..."),
        (0x284D, "Next byte across"),
        (0x284E, "..."),
        (0x2850, "Down one pixel row from the row's start..."),
        (0x2851, "..."), (0x2853, "..."), (0x2855, "..."), (0x2857, "..."),
        (0x2859, "..."), (0x285B, "..."),
        (0x285D, "...crossing into the next character row every eight "
                 "(640 - 8 bytes on)"),
        (0x285F, "..."), (0x2861, "..."), (0x2863, "..."), (0x2864, "..."),
        (0x2866, "..."), (0x2868, "..."), (0x286A, "..."), (0x286C, "..."),
        (0x286E, "..."),
        (0x2870, "Next row"),
        (0x2871, "..."), (0x2872, "..."), (0x2873, "..."),
        (0x2875, "Return"),
    ])
    loader_sym(0x282C, "title_plot_reversed")

    loader.sub(0x2876, "title_screen_address", "Calculate a title screen address",
               "The game's screen_address, reading the row offsets from MOS "
               "1.20's table at &C375." if model_b else
               "The game's screen_address, reading the row offsets from Table "
               "at &C675 in private RAM where the Model B loader reads MOS "
               "1.20's at &C375.",
               on_entry={"plot_x": "byte column", "plot_y": "pixel row"},
               on_exit={"screen_ptr": "screen address", "Y": "0"})
    comments(loader, [
        (0x2876, "Character row x 2..."),
        (0x2878, "..."), (0x2879, "..."), (0x287A, "..."), (0x287C, "..."),
        (0x287D, "High byte of row x 640, from the MOS table..." if model_b
                 else "High byte of row x 640, from Table's copy of the MOS table..."),
        (0x2880, "...plus &3000, the screen start"),
        (0x2881, "..."), (0x2883, "..."),
        (0x2885, "Low byte of row x 640"),
        (0x2888, "..."),
        (0x288A, "Plus the pixel row within the character row"),
        (0x288C, "..."), (0x288E, "..."), (0x2890, "..."),
        (0x2892, "Plus 8 x byte column: high part..."),
        (0x2893, "..."), (0x2895, "..."), (0x2897, "..."), (0x2898, "..."),
        (0x2899, "..."), (0x289A, "..."), (0x289B, "..."), (0x289C, "..."),
        (0x289E, "..."),
        (0x28A0, "...low part"),
        (0x28A2, "..."), (0x28A3, "..."), (0x28A4, "..."), (0x28A5, "..."),
        (0x28A6, "..."), (0x28A8, "..."), (0x28AA, "..."), (0x28AC, "..."),
        (0x28AE, "Y = 0 for the plotting loop"),
        (0x28B0, "Return"),
    ])
    loader.banner(0x28B1, "Unused", "Leftover bytes.")
    loader.byte(0x28B1, 0x0F, cols=8)
    loader.c(0x28B1, "Not used")
    loader.label(0x28C0, "star_frames_lo", length=7, description=(
        "Low bytes of the seven star frames' addresses (&2A00 + &C4 x frame)."))
    loader.byte(0x28C0, 7, cols=7)
    loader.byte(0x28C7, 9, cols=9)
    loader.c(0x28C7, "Not used")
    loader.label(0x28D0, "star_frames_hi", length=7, description=(
        "High bytes of the seven star frames' addresses."))
    loader.byte(0x28D0, 7, cols=7)
    loader.byte(0x28D7, 0x29, cols=8)
    loader.c(0x28D7, "Not used")

    loader.sub(0x2900, "twinkle_stars", "Twinkle stars on the title screen until a key is pressed",
               "Up to three stars at once, each at one of the eight places in "
               "star_places_x and star_places_y, picked at random. A star grows "
               "through frames 0-6 and shrinks back through 5-0. When a key is "
               "pressed the stars still showing are erased.",
                on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(loader, [
        (0x2900, "No stars showing"),
        (0x2902, "..."), (0x2904, "..."), (0x2907, "..."), (0x2908, "..."),
        (0x290A, "One time in four (System VIA timer 1, low bits)..."),
        (0x290D, "..."), (0x290F, "..."),
        (0x2911, "...start a star"),
        (0x2914, "Advance every star"),
        (0x2917, "OSBYTE &7A: any key pressed?"),
        (0x2919, "..."), (0x291C, "..."),
        (0x291E, "No: carry on"),
        (0x2920, "Yes: erase the stars still showing..."),
        (0x2922, "..."), (0x2925, "..."), (0x2927, "..."), (0x292A, "..."),
        (0x292B, "..."),
        (0x292D, "Return"),
    ])
    loader.sub(0x292E, "start_star", "Start a star at a free place",
               "Take the first star not showing, if any, give it frame 0 and "
               "step +1, choose a free place at random, mark the place taken "
               "and plot the first frame.",
                on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(loader, [
        (0x292E, "Find a star not showing..."),
        (0x2930, "..."), (0x2933, "..."), (0x2935, "..."), (0x2936, "..."),
        (0x2938, "..."),
        (0x293A, "All three showing: return"),
        (0x293B, "Mark it showing"),
        (0x293D, "..."),
        (0x2940, "Frame step +1..."),
        (0x2942, "..."),
        (0x2945, "...from frame 0"),
        (0x2947, "..."),
        (0x294A, "Pick a place at random (timer, &FA and &FC mixed)..."),
        (0x294D, "..."), (0x294F, "..."), (0x2951, "..."), (0x2953, "..."),
        (0x2954, "...that is free"),
        (0x2957, "..."),
        (0x2959, "Star position from the place..."),
        (0x295C, "..."), (0x295F, "..."),
        (0x2962, "...remembering the place"),
        (0x2964, "Mark the place taken"),
        (0x2966, "..."),
        (0x2969, "Plot the first frame"),
        (0x296C, "Return"),
    ])
    loader.sub(0x296D, "advance_stars", "Advance each star by one frame",
               "For each showing star, erase the frame (exclusive-OR) and step "
               "it; past frame 6 it turns back at 5, and below 0 it is finished "
               "and its place freed. Then plot the new frame and pause, longer "
               "for a star not showing so the timing stays even.",
                on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(loader, [
        (0x296D, "For each star..."),
        (0x296F, "...showing?"),
        (0x2972, "No: just pause"),
        (0x2974, "Erase its frame"),
        (0x2977, "Step the frame"),
        (0x2978, "..."), (0x297B, "..."), (0x297E, "..."),
        (0x2981, "Below 0: finished"),
        (0x2983, "Past 6?"),
        (0x2985, "No: plot it"),
        (0x2987, "Yes: frame 5..."),
        (0x2989, "..."),
        (0x298C, "...stepping back"),
        (0x298E, "..."),
        (0x2991, "...and plot it (always branches)"),
        (0x2993, "Finished: not showing..."),
        (0x2995, "..."),
        (0x2998, "...and free its place"),
        (0x299B, "..."), (0x299D, "..."),
        (0x29A0, "...(always branches)"),
        (0x29A2, "Plot the new frame"),
        (0x29A5, "Pause..."),
        (0x29A6, "..."), (0x29A7, "..."),
        (0x29A9, "...X x 256 iterations..."),
        (0x29AB, "..."), (0x29AC, "..."), (0x29AE, "..."), (0x29AF, "..."),
        (0x29B1, "..."), (0x29B2, "..."),
        (0x29B3, "Next star"),
        (0x29B4, "..."), (0x29B6, "..."),
        (0x29B8, "Return"),
    ])
    loader.sub(0x29B9, "plot_star", "Plot star Y's current frame",
               "Call title_plot_star with the star's position and frame, "
               "keeping Y.",
               on_entry={"Y": "star, 0-2"}, on_exit={"Y": "preserved"})
    comments(loader, [
        (0x29B9, "plot_x = star's column"),
        (0x29BC, "..."),
        (0x29BE, "plot_y = star's row"),
        (0x29C1, "..."),
        (0x29C3, "sprite_number = star's frame"),
        (0x29C6, "..."),
        (0x29C8, "Plot it, keeping Y"),
        (0x29C9, "..."), (0x29CA, "..."), (0x29CD, "..."), (0x29CE, "..."),
        (0x29CF, "Return"),
        (0x29D0, "Star not showing: pause for longer..."),
        (0x29D1, "..."), (0x29D2, "..."),
        (0x29D4, "...(always branches)"),
    ])
    for operand_addr, name in [
        (0x2943, "star_frame_step"), (0x2948, "star_frame"),
        (0x295A, "star_x"), (0x2960, "star_y"), (0x2963, "star_place"),
        (0x2979, "star_frame"), (0x297C, "star_frame_step"), (0x297F, "star_frame"),
        (0x298A, "star_frame"), (0x298F, "star_frame_step"),
        (0x2999, "star_x"), (0x299C, "star_place"),
        (0x29BA, "star_x"), (0x29BF, "star_y"), (0x29C4, "star_frame"),
    ]:
        loader_sym(operand_addr, name)
    loader_sym(0x2772, "title_plot_reversed")
    loader.byte(0x29D6, 4, cols=4)
    loader.c(0x29D6, "Not used")
    loader.label(0x29DA, "star_showing", length=3, description=(
        "Non-zero for each of the three stars while it is showing."))
    loader.byte(0x29DA, 3, cols=3)
    loader.byte(0x29DD, 3, cols=3)
    loader.c(0x29DD, "Not used")
    loader.label(0x29E0, "star_places_x", length=8, description=(
        "The byte columns of the eight places a star can appear; &FF marks a "
        "place taken."))
    loader.byte(0x29E0, 8, cols=8)
    loader.byte(0x29E8, 8, cols=8)
    loader.c(0x29E8, "Not used")
    loader.label(0x29F0, "star_places_y", length=8, description=(
        "The pixel rows of the eight places."))
    loader.byte(0x29F0, 8, cols=8)
    loader.byte(0x29F8, 8, cols=8)
    loader.c(0x29F8, "Not used")
    loader.label(0x2A00, "star_frame_data", length=0x55C, description=(
        "The seven frames of the star, 7 bytes by 28 rows each, at &C4-byte "
        "intervals."))
    loader.banner(0x2A00, "Star frames",
                  "Seven 7-byte by 28-row MODE 2 frames of the title screen's "
                  "twinkling star, from small (frame 0) to large (frame 6).")
    for frame in range(7):
        loader.byte(0x2A00 + frame * 0xC4, 0xC4, cols=7)
        loader.c(0x2A00 + frame * 0xC4, f"Frame {frame}: 7 bytes by 28 rows")


    # ---------------------------------------------------------------------------
    # Addresses outside *DUNJUNZ. The star plotter is a copy of the game's
    # sprite plotter and keeps its zero-page workspace.

    zp = dict(group="zero_page", access="rw")
    for addr, name, text in [
        (0x70, "plot_x", "Star position: screen byte column."),
        (0x71, "plot_y", "Star position: pixel row."),
        (0x72, "sprite_width", "Width of the frame being plotted, in screen bytes."),
        (0x73, "sprite_height", "Height of the frame being plotted, in pixel rows."),
        (0x74, "screen_ptr", "Screen address being written, low byte."),
        (0x75, "screen_ptr_hi", "Screen address being written, high byte."),
        (0x76, "row_start_ptr", "Screen address of the row being plotted, low byte."),
        (0x77, "row_start_ptr_hi", "Screen address of the row being plotted, high byte."),
        (0x78, "sprite_data_ptr", "Address of the next frame byte to plot, low byte."),
        (0x79, "sprite_data_ptr_hi", "Address of the next frame byte to plot, high byte."),
        (0x7A, "sprite_number", "Star frame to plot, 0-6."),
    ]:
        loader.label(addr, name, description=text, **zp)
    loader.label(0x00FA, "os_zp_fa", group="os_workspace", description=(
        "MOS zero-page workspace, mixed into the choice of a star's place."))
    loader.label(0x00FC, "os_irq_a", group="os_workspace", description=(
        "The MOS's copy of A at the last interrupt, mixed into the choice of a "
        "star's place."))
    loader.region(0x0287, "os_break_intercept", (0, 2), group="os_workspace",
                  access="w", description=(
                      "MOS BREAK intercept: a JMP here is called during a reset. "
                      + ("Dunjunz points it at the game's next-level intercept "
                         "and arms it before running Coder." if model_b else
                         "*DUNJUNZ sets its address but leaves it disabled.")))
    if model_b:
        for addr, name, text in [
            (0x08B0, "hero_score_ten_thousands", "Each hero's score ten-thousands digit, as a small digit sprite; &69 for none."),
            (0x08B4, "hero_absent", "Non-zero for each hero switched off on the menu."),
            (0x08BC, "levels_started", "Number of levels started, kept by Coder in page &08, which survives the reset between levels."),
        ]:
            loader.label(addr, name, group="game_state", access="w", description=text)
        loader.region(0x08BD, "level_digits", (0, 1), group="game_state",
                      access="w", description=(
                          "The level number as ASCII digits for the level's "
                          "filename: one digit and a space, or two digits."))
        loader.region(0xC375, "mos_row_offsets", (0, 1), group="mos_internals",
                      description=(
                          "MOS 1.20's table of the offsets of the screen's "
                          "character rows, high byte then low byte."))
    else:
        for addr, name, text in [
            (0x08B0, "modelb_hero_score_ten_thousands", "per-hero ten-thousands digits"),
            (0x08B4, "modelb_hero_absent", "per-hero absent flags"),
            (0x08BC, "modelb_levels_started", "count of levels started"),
        ]:
            loader.label(addr, name, group="loader", access="w", description=(
                f"The Model B side's {text}, in the game's Dunj3; set up as the "
                "Model B loader does, but this side's game does not read it."))
        loader.region(0x08BD, "modelb_level_digits", (0, 1), group="loader",
                      access="w", description=(
                          "The Model B side's ASCII level digits, in the game's "
                          "Dunj3; set up as the Model B loader does, but this side's "
                          "game does not read them."))
        loader.region(0xC675, "row_offsets", (0, 1), group="private_ram", description=(
            "In Table, which *DUNJUNZ loads first: the offsets of the screen's "
            "character rows, high byte then low byte, a copy of MOS 1.20's table "
            "at &C375."))

    # Values named rather than written as numbers.
    for value, name, text in [
        (0x15B5, "game_next_level_intercept", "The game's BREAK intercept that runs Coder for the next level"),
        (0x69, "spr_no_small_digit", "The game's sprite &69, drawn where a hero has no ten-thousands digit"),
        (0x4C, "opcode_jmp", "The JMP opcode, which arms the MOS BREAK intercept"),
        (0x3000, "screen_start", "The start of MODE 2 screen memory"),
    ]:
        d.constant(value, name, comment=text)
    d.expr(0x2716, char(0x30))
    d.expr(0x271B, char(0x20))
    d.expr(0x2722, sym("spr_no_small_digit"))
    d.expr(0x272F, lo(sym("game_next_level_intercept")))
    d.expr(0x2734, hi(sym("game_next_level_intercept")))
    d.expr(0x2882, hi(sym("screen_start")))
    if model_b:
        d.expr(0x278D, sym("opcode_jmp"))

    # The commands passed to OSCLI.
    commands = [(0x26C6, "load_screen_command"), (0x273E, "tv_title_command"),
                (0x277C, "tv_game_command"), (0x2786, "disc_command")]
    if model_b:
        commands.append((0x26D8, "coder_command"))
    for operand_addr, name in commands:
        d.expr(operand_addr, lo(sym(name)))
        d.expr(operand_addr + 2, hi(sym(name)))

    for addr, name in [
        (0x2721, "init_hero_tables"), (0x2749, "black_colours"),
        (0x27CB, "send_cursor_off_vdu"), (0x2819, "plot_star_row"),
        (0x2825, "plot_star_byte"), (0x283C, "plot_star_left"),
        (0x2847, "plot_star_next_data"), (0x284D, "plot_star_next_byte"),
        (0x2870, "plot_star_next_row"), (0x28AE, "title_screen_address_done"),
        (0x2904, "clear_star_showing"), (0x290A, "twinkle_loop"),
        (0x2914, "twinkle_advance"), (0x2922, "erase_stars"),
        (0x292A, "erase_next_star"), (0x2930, "find_free_star"),
        (0x293B, "star_found"), (0x294A, "pick_place"),
        (0x296F, "advance_star"), (0x2993, "star_finished"),
        (0x29A2, "plot_new_frame"), (0x29A5, "star_pause"),
        (0x29A9, "star_pause_outer"), (0x29AB, "star_pause_inner"),
        (0x29D0, "star_not_showing"),
    ]:
        loader.label(addr, name)


def annotate_master_prefix(loader):
    """The Master side's &2649-&26BF: load the private-RAM files, and
    choose between Coder and Coder2."""
    loader.sub(0x2649, "dunjunz_start", "*DUNJUNZ: load the private-RAM code and show the title",
               "Run by BOOT on a Master 128. Load Code2, Code3 and Table into "
               "the Master's private RAM (HAZEL, &C000-&DFFF), which MOS 3.20 "
               "leaves paged in for a *RUN program, then carry on into the Model "
               "B loader's start-up at title_start.")
    comments(loader, [
        (0x2649, "*LOAD Code2 (the music, at &C700)"),
        (0x264B, "..."), (0x264D, "..."),
        (0x2650, "*LOAD Code3 (a copy of the sprite plotter, at &D800)"),
        (0x2652, "..."), (0x2654, "..."),
        (0x2657, "Load Table and start the title"),
    ])
    loader.label(0x265A, "load_code2_command")
    loader.stringcr(0x265A)
    loader.label(0x2665, "load_code3_command")
    loader.stringcr(0x2665)

    loader.sub(0x2670, "run_coder", "Run Coder, through Coder2 if a joystick is present",
               "Read joystick channel 1. A reading with high byte &80 or &81 "
               "(a joystick at rest) runs CODER2, which installs the joystick "
               "handler and runs CODER; anything else runs CODER directly. "
               "Neither returns.")
    comments(loader, [
        (0x2670, "OSBYTE &80: read ADC channel 1 (joystick 1, horizontal)..."),
        (0x2672, "..."), (0x2674, "..."),
        (0x2677, "High byte &80 (at rest)?"),
        (0x2679, "Yes: a joystick"),
        (0x267B, "High byte &81?"),
        (0x267D, "Yes: a joystick"),
        (0x267F, "No joystick: *CODER, which does not return"),
        (0x2681, "..."), (0x2683, "..."),
        (0x2686, "Joystick: *CODER2, which does not return"),
        (0x2688, "..."), (0x268A, "..."),
    ])
    loader.label(0x268D, "coder2_command")
    loader.stringcr(0x268D)

    loader.sub(0x2694, "blank_display", "Blank the display and disable VDU output",
               "Send VDU 23,0,1,0,0,0,0,0,0,0 (6845 register 1, characters per "
               "row, set to 0) and VDU 21, from blank_display_vdu.",
                on_exit={"A": "corrupted", "X": "11", "Y": "preserved"})
    comments(loader, [
        (0x2694, "Send the eleven bytes of blank_display_vdu"),
        (0x2696, "..."), (0x2699, "..."), (0x269C, "..."), (0x269D, "..."),
        (0x269F, "..."), (0x26A1, "Return"),
    ])
    loader.label(0x26A2, "blank_display_vdu", length=11)
    loader.byte(0x26A2, 11, cols=11)

    comments(loader, [
        (0x26AD, "*L. TABLE (level 25, game over, row offsets, pause, at &C5A0)"),
        (0x26AF, "..."), (0x26B1, "..."),
        (0x26B4, "Carry on with the Model B loader's start-up"),
    ])
    loader.label(0x26B7, "load_table_command")
    loader.stringcr(0x26B7)
    for operand_addr, name in [(0x264A, "load_code2_command"),
                               (0x2651, "load_code3_command"),
                               (0x2680, "coder_command"),
                               (0x2687, "coder2_command"),
                               (0x26AE, "load_table_command")]:
        loader.d.expr(operand_addr, lo(sym(name)))
        loader.d.expr(operand_addr + 2, hi(sym(name)))
    for addr, name in [(0x2686, "run_coder2"), (0x2696, "blank_display_loop"),
                       (0x26AD, "load_table")]:
        loader.label(addr, name)
