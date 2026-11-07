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
        (0x26C2, "...so the load leaves no messages on screen"),
        (0x26C5, "*LOAD SCREEN"),
        (0x26C7, "...command's high byte"), (0x26C9, "...and run it: the picture into screen memory"),
        (0x26CC, "VDU 6: enable VDU output"),
        (0x26CE, "...so later text is seen again"), (0x26D1, "Return"),
    ])
    d.hook_subroutine(0x26D2, "leave_title", no_return)
    if model_b:
        loader.sub(0x26D2, "leave_title", "Disable VDU output and run Coder",
                   "VDU 21, then *CODER, which does not return.")
        comments(loader, [
            (0x26D2, "VDU 21: disable VDU output"),
            (0x26D4, "...so the CODER command's messages stay hidden"),
            (0x26D7, "*CODER (no return)"),
            (0x26D9, "...command's high byte"), (0x26DB, "...and run it; the game takes over from here"),
        ])
        loader.banner(0x26DE, "Unused", "Leftover bytes.")
        loader.byte(0x26DE, 0x22, cols=8)
        loader.c(0x26DE, "Not used")
    else:
        loader.sub(0x26D2, "leave_title", "Blank the display and run Coder",
                   "Blank the display, then choose between CODER and CODER2 "
                   "by whether a joystick is present. It never returns.")
        comments(loader, [
            (0x26D2, "Blank the display and disable output"),
            (0x26D5, "Padding"), (0x26D6, "...the second padding byte"),
            (0x26D7, "Run Coder (no return)"),
        ])
        loader.banner(0x26DA, "Unused",
                      "Leftover bytes, never run: the tail of a *CODER call "
                      "(its JSR OSCLI), then data.")
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
            "Disable ESCAPE, make the cursor keys return codes, set bytes "
            "in page &08 that the game does not read (a level counter, level "
            "digits and two hero tables), point the BREAK intercept at &15B5 "
            "but leave it disabled, load and show the title screen, twinkle "
            "stars on it until a key is pressed, then select the game's "
            "display and run Coder.")
    loader.sub(0x2700, "title_start", "Set up, show the title and run Coder",
               title_start_description,
                on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(loader, [
        (0x2700, "OSBYTE &C8: ESCAPE disabled..."),
        (0x2702, "...X = 1: ESCAPE disabled, BREAK as normal..."), (0x2704, "...Y = 0: X replaces the old setting"), (0x2706, "...so ESCAPE cannot interrupt the title"),
        (0x2709, "OSBYTE 4, 1: cursor keys return codes"),
        (0x270B, "...X = 1: cursor keys return codes"), (0x270D, "...so the game can read them as keys"),
        (0x2710, "Levels started = 0, for Coder" if model_b
                 else "Level count = 0, in a byte the game does not read"),
        (0x2712, "...in page &08, which survives a reset"),
        (0x2715, "Level digits = \"0 \"..."),
        (0x2717, "...first digit '0'..."), (0x271A, "...second digit a space"), (0x271C, "...for the level filename"),
        (0x271F, "For each hero..."),
        (0x2721, "...no ten-thousands digit (sprite &69)..."),
        (0x2723, "...at &08B0..."),
        (0x2726, "...and switched on..."),
        (0x2728, "...at &08B4 (the menu tables)" if model_b
                 else "...at &08B4, bytes the game does not read"),
        (0x272B, "Next hero"), (0x272C, "Until all four heroes are set"),
        (0x272E, "BREAK intercept address = &15B5 (the game's next-level "
                 "intercept)..." if model_b else
                 "BREAK intercept address = &15B5, which the game does "
                 "not use..."),
        (0x2730, "...into the intercept's address low byte"), (0x2733, "...high byte"), (0x2735, "...into the intercept's address high byte"),
        (0x2738, "...disabled for now: &0287 is not a JMP" if model_b
                 else "...but disabled: &0287 is not a JMP"),
        (0x273A, "...into &0287, so no JMP: the intercept is off"),
        (0x273D, "*TV 255,1: vertical offset for the title's MODE 2"),
        (0x273F, "...command's high byte"), (0x2741, "...and run it"),
        (0x2744, "MODE 2, cursor off"),
        (0x2747, "Make all sixteen logical colours black..."),
        (0x2749, "...VDU 19, colour, 0, 0, 0, 0..."),
        (0x274B, "...VDU 19 starts the palette change..."), (0x274E, "...logical colour X..."), (0x274F, "...sent as the first parameter"), (0x2752, "...zero, for the rest of the command"),
        (0x2754, "...physical colour 0: black"), (0x2757, "...first padding byte"), (0x275A, "...second padding byte"), (0x275D, "...third padding byte"),
        (0x2760, "Next logical colour"), (0x2761, "Until colours 15 to 0 are all black"),
        (0x2763, "Load the title screen unseen"),
        (0x2766, "Padding"), (0x2767, "...second padding byte"), (0x2768, "...third padding byte"), (0x2769, "...fourth padding byte"),
        (0x276A, "VDU 20: default colours, showing the picture"),
        (0x276C, "...so the loaded picture appears all at once"),
        (0x276F, "Plot the stars left to right"),
        (0x2771, "...so title_plot_star steps right across a row"),
        (0x2773, "OSBYTE &15: flush the buffer X"),
        (0x2775, "...X is whatever OSCLI left: buffer unknown"),
        (0x2778, "Twinkle stars until a key is pressed"),
        (0x277B, "*TV 252,1: vertical offset for the game's display"),
        (0x277D, "...command's high byte"), (0x277F, "...and run it"),
        (0x2782, "MODE 2, cursor off"),
        (0x2785, "*DISC"),
        (0x2787, "...command's high byte"), (0x2789, "...and run it, so Coder loads from disc"),
        (0x278C, "Arm the BREAK intercept: &0287 = JMP" if model_b
                 else "BREAK intercept stays disabled"),
        (0x278E, "...into &0287, the intercept's opcode byte"),
        (0x2791, ("Disable output" if model_b else "Blank the display")
                 + " and run Coder (no return)"),
        (0x2794, "Padding"), (0x2795, "...never run: leave_title does not return"), (0x2796, "...never run"), (0x2797, "...never run"),
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
        (0x27C1, "...selects a mode..."), (0x27C4, "...mode 2: 16 colours, 20 columns"), (0x27C6, "...sent as the mode number"),
        (0x27C9, "Send the eleven bytes of cursor_off_vdu"),
        (0x27CB, "Next byte of the VDU sequence..."), (0x27CE, "...to the VDU drivers"), (0x27D1, "...on to the next"), (0x27D2, "...until all eleven are sent"),
        (0x27D4, "Not yet: send the next"), (0x27D6, "Return"),
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
        (0x2802, "...as the plotter's width"),
        (0x2804, "...and 28 rows high"),
        (0x2806, "...as the plotter's height"),
        (0x2808, "Point at the frame's data..."),
        (0x280A, "...low byte from star_frames_lo"), (0x280D, "...into the data pointer"), (0x280F, "...high byte from star_frames_hi"), (0x2812, "...into the data pointer"),
        (0x2814, "Screen address of the top left"),
        (0x2817, "For each row..."),
        (0x2819, "...remember its start..."),
        (0x281B, "...low byte, to step down from later"), (0x281D, "...high byte..."), (0x281F, "...kept with the low byte"),
        (0x2821, "...and keep the row count..."), (0x2822, "...on the stack while X counts bytes"),
        (0x2823, "...for each byte across..."),
        (0x2825, "...exclusive-OR the frame onto the screen..."),
        (0x2827, "...flip the screen pixels the frame sets..."), (0x2829, "...so plotting twice erases the star"),
        (0x282B, "...and step a character cell (8 bytes) right or left"),
        (0x282D, "Non-zero: step left instead"),
        (0x282F, "Right..."),
        (0x2830, "...screen pointer low byte..."), (0x2832, "...plus 8: the next cell to the right"), (0x2834, "...stored back"), (0x2836, "No carry: pointer done"),
        (0x2838, "Carry into the high byte"), (0x283A, "...(always branches)"),
        (0x283C, "Left..."),
        (0x283D, "...screen pointer low byte..."), (0x283F, "...minus 8: the next cell to the left"), (0x2841, "...stored back"), (0x2843, "No borrow: pointer done"),
        (0x2845, "Borrow from the high byte"),
        (0x2847, "Next byte of the frame"),
        (0x2849, "No carry: pointer done"), (0x284B, "Carry into the high byte"),
        (0x284D, "Next byte across"),
        (0x284E, "More bytes in this row: plot the next"),
        (0x2850, "Down one pixel row from the row's start..."),
        (0x2851, "...from the row's start, low byte..."), (0x2853, "...plus one pixel row"), (0x2855, "...as the new screen pointer"), (0x2857, "...high byte..."),
        (0x2859, "...with the carry"), (0x285B, "...as the new screen pointer"),
        (0x285D, "...crossing into the next character row every eight "
                 "(640 - 8 bytes on)"),
        (0x285F, "...pixel row within the character row"), (0x2861, "Not 0: still in the same character row"), (0x2863, "Row 0: moved into the next character row..."), (0x2864, "...so add 640 - 8 to the pointer..."),
        (0x2866, "...low byte of &278..."), (0x2868, "...stored back"), (0x286A, "...high byte..."), (0x286C, "...plus &02 with the carry"),
        (0x286E, "...stored back"),
        (0x2870, "Next row"),
        (0x2871, "...into X..."), (0x2872, "...one row fewer to go"), (0x2873, "More rows: plot the next"),
        (0x2875, "Return"),
    ])
    loader_sym(0x282C, "title_plot_reversed")

    loader.sub(0x2876, "title_screen_address", "Calculate a title screen address",
               "The game's screen_address, reading the row offsets from MOS "
               "1.20's table at &C375." if model_b else
               "The game's screen_address, reading the row offsets from Table "
               "at &C675 in private RAM.",
               on_entry={"plot_x": "byte column", "plot_y": "pixel row"},
               on_exit={"screen_ptr": "screen address", "Y": "0"})
    comments(loader, [
        (0x2876, "Character row x 2..."),
        (0x2878, "...divide plot_y by 4..."), (0x2879, "...(character row x 2)..."), (0x287A, "...even, to index the table's byte pairs"), (0x287C, "...into Y"),
        (0x287D, "High byte of row x 640, from the MOS table..." if model_b
                 else "High byte of row x 640, from Table's copy of the MOS table..."),
        (0x2880, "...plus &3000, the screen start"),
        (0x2881, "...the screen starts at &3000"), (0x2883, "...as the high byte"),
        (0x2885, "Low byte of row x 640"),
        (0x2888, "...as the low byte"),
        (0x288A, "Plus the pixel row within the character row"),
        (0x288C, "...plot_y MOD 8..."), (0x288E, "...added to the low byte (no carry out)"), (0x2890, "...stored back"),
        (0x2892, "Plus 8 x byte column: high part..."),
        (0x2893, "...byte column..."), (0x2895, "...top three bits, worth &100 each x 8..."), (0x2897, "...rotated down..."), (0x2898, "...towards the bottom..."),
        (0x2899, "...of the byte..."), (0x289A, "...as bits 2-0: the high byte's share"), (0x289B, "...to add to the high byte..."), (0x289C, "...added..."),
        (0x289E, "...stored back"),
        (0x28A0, "...low part"),
        (0x28A2, "...x 2..."), (0x28A3, "...x 4..."), (0x28A4, "...x 8: eight bytes per character cell"), (0x28A5, "...to add to the low byte..."),
        (0x28A6, "...added..."), (0x28A8, "...stored back"), (0x28AA, "No carry: address done"), (0x28AC, "Carry into the high byte"),
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
        (0x2902, "...0 for every star"), (0x2904, "...cleared..."), (0x2907, "...next star"), (0x2908, "Until stars 2 to 0 are cleared"),
        (0x290A, "One time in four (System VIA timer 1, low bits)..."),
        (0x290D, "...lowest two bits, 0-3..."), (0x290F, "Not 0: no new star this time"),
        (0x2911, "...start a star"),
        (0x2914, "Advance every star"),
        (0x2917, "OSBYTE &7A: any key pressed?"),
        (0x2919, "...X = &FF if none"), (0x291C, "...no key?"),
        (0x291E, "No: carry on"),
        (0x2920, "Yes: erase the stars still showing..."),
        (0x2922, "...star Y showing?"), (0x2925, "No: nothing to erase"), (0x2927, "Yes: plot it again to erase it"), (0x292A, "Next star"),
        (0x292B, "Until stars 2 to 0 are done"),
        (0x292D, "Return"),
    ])
    loader.sub(0x292E, "start_star", "Start a star at a free place",
               "Take the first star not showing, if any, give it frame 0 and "
               "step +1, choose a free place at random, mark the place taken "
               "and plot the first frame.",
                on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    comments(loader, [
        (0x292E, "Find a star not showing..."),
        (0x2930, "...star Y showing?"), (0x2933, "No: use this one"), (0x2935, "Yes: try the next"), (0x2936, "...of the three"),
        (0x2938, "Not all tried: carry on looking"),
        (0x293A, "All three showing: return"),
        (0x293B, "Mark it showing"),
        (0x293D, "...in star_showing"),
        (0x2940, "Frame step +1..."),
        (0x2942, "...the frame grows"),
        (0x2945, "...from frame 0"),
        (0x2947, "...the smallest"),
        (0x294A, "Pick a place at random (timer, &FA and &FC mixed)..."),
        (0x294D, "...mixed with OS workspace..."), (0x294F, "...and the last interrupt's A..."), (0x2951, "...one of the eight places"), (0x2953, "...as the place index"),
        (0x2954, "...that is free"),
        (0x2957, "Taken (&FF): pick again"),
        (0x2959, "Star position from the place..."),
        (0x295C, "...its pixel row..."), (0x295F, "...as the star's row"),
        (0x2962, "...remembering the place"),
        (0x2964, "Mark the place taken"),
        (0x2966, "...by setting its column to &FF"),
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
        (0x2978, "...current frame..."), (0x297B, "...plus the step, +1 or -1..."), (0x297E, "...stored back"),
        (0x2981, "Below 0: finished"),
        (0x2983, "Past 6?"),
        (0x2985, "No: plot it"),
        (0x2987, "Yes: frame 5..."),
        (0x2989, "...stored..."),
        (0x298C, "...stepping back"),
        (0x298E, "...step -1, so the star shrinks"),
        (0x2991, "...and plot it (always branches)"),
        (0x2993, "Finished: not showing..."),
        (0x2995, "...cleared in star_showing..."),
        (0x2998, "...and free its place"),
        (0x299B, "...by putting its column back..."), (0x299D, "...into star_places_x"),
        (0x29A0, "...(always branches)"),
        (0x29A2, "Plot the new frame"),
        (0x29A5, "Pause..."),
        (0x29A6, "...keeping Y, the star..."), (0x29A7, "...5 x 256 loops between stars"),
        (0x29A9, "...X x 256 iterations..."),
        (0x29AB, "...count the inner loop..."), (0x29AC, "Inner loop not done: keep waiting"), (0x29AE, "...count the outer loop..."), (0x29AF, "Outer loop not done: keep waiting"),
        (0x29B1, "...recover the star..."), (0x29B2, "...into Y"),
        (0x29B3, "Next star"),
        (0x29B4, "...of the three"), (0x29B6, "More stars: advance the next"),
        (0x29B8, "Return"),
    ])
    loader.sub(0x29B9, "plot_star", "Plot star Y's current frame",
               "Call title_plot_star with the star's position and frame, "
               "keeping Y.",
               on_entry={"Y": "star, 0-2"}, on_exit={"Y": "preserved"})
    comments(loader, [
        (0x29B9, "plot_x = star's column"),
        (0x29BC, "...as the plotter's column"),
        (0x29BE, "plot_y = star's row"),
        (0x29C1, "...as the plotter's row"),
        (0x29C3, "sprite_number = star's frame"),
        (0x29C6, "...as the frame to plot"),
        (0x29C8, "Plot it, keeping Y"),
        (0x29C9, "...on the stack"), (0x29CA, "...exclusive-OR the frame on screen"), (0x29CD, "...recover the star..."), (0x29CE, "...into Y"),
        (0x29CF, "Return"),
        (0x29D0, "Star not showing: pause for longer..."),
        (0x29D1, "...keeping Y, the star..."), (0x29D2, "...20 x 256 loops instead of 5 x 256"),
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
            (0x08B0, "unread_digit_table", "four bytes set to &69"),
            (0x08B4, "unread_hero_table", "four bytes set to 0"),
            (0x08BC, "unread_level_count", "a byte set to 0"),
        ]:
            loader.label(addr, name, group="loader", access="w", description=(
                f"In the game's Dunj3: {text} by title_start, which the game "
                "never reads."))
        loader.region(0x08BD, "unread_level_digits", (0, 1), group="loader",
                      access="w", description=(
                          "In the game's Dunj3: two bytes set to \"0 \" by "
                          "title_start, which the game never reads."))
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
               "leaves paged in for a *RUN program, then carry on with the "
               "start-up at title_start.")
    comments(loader, [
        (0x2649, "*LOAD Code2 (the music, at &C700)"),
        (0x264B, "...command's high byte"), (0x264D, "...and run it: Code2 into private RAM"),
        (0x2650, "*LOAD Code3 (a copy of the sprite plotter, at &D800)"),
        (0x2652, "...command's high byte"), (0x2654, "...and run it: Code3 into private RAM"),
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
        (0x2672, "...channel 1"), (0x2674, "...Y = the reading's high byte"),
        (0x2677, "High byte &80 (at rest)?"),
        (0x2679, "Yes: a joystick"),
        (0x267B, "High byte &81?"),
        (0x267D, "Yes: a joystick"),
        (0x267F, "No joystick: *CODER, which does not return"),
        (0x2681, "...command's high byte"), (0x2683, "...and run it; the game takes over from here"),
        (0x2686, "Joystick: *CODER2, which does not return"),
        (0x2688, "...command's high byte"), (0x268A, "...and run it; the game takes over from here"),
    ])
    loader.label(0x268D, "coder2_command")
    loader.stringcr(0x268D)

    loader.sub(0x2694, "blank_display", "Blank the display and disable VDU output",
               "Send VDU 23,0,1,0,0,0,0,0,0,0 (6845 register 1, characters per "
               "row, set to 0) and VDU 21, from blank_display_vdu.",
                on_exit={"A": "corrupted", "X": "11", "Y": "preserved"})
    comments(loader, [
        (0x2694, "Send the eleven bytes of blank_display_vdu"),
        (0x2696, "Next byte of the VDU sequence..."), (0x2699, "...to the VDU drivers"), (0x269C, "...on to the next"), (0x269D, "...until all eleven are sent"),
        (0x269F, "Not yet: send the next"), (0x26A1, "Return"),
    ])
    loader.label(0x26A2, "blank_display_vdu", length=11)
    loader.byte(0x26A2, 11, cols=11)

    comments(loader, [
        (0x26AD, "*L. TABLE (level 25, game over, row offsets, pause, at &C5A0)"),
        (0x26AF, "...command's high byte"), (0x26B1, "...and run it: Table into private RAM"),
        (0x26B4, "Carry on with the start-up at title_start"),
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
