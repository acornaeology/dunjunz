; Constants
osfile_block_length        = &12  ; An OSFILE control block's length
screen_start               = &3000  ; The start of MODE 2 screen memory
screen_end                 = &8000  ; The top of screen memory, where the packed file ends
osbyte_read_char_at_cursor = &87
osfind_open_input          = &40
osfind_close               = &00
osfile_load                = &ff

; Memory locations
packed_ptr   = &80
; &80 referenced 6 times by &2ee5, &2efb, &2f33, &2f6e, &2f8c, &2f8e
screen_ptr   = &82
; &82 referenced 5 times by &2eeb, &2f38, &2f54, &2f56, &2f68
command_ptr  = &84
; &84 referenced 11 times by &2e1d, &2e1f, &2e31, &2e33, &2e53, &2e77, &2e8d, &2e97, &2ead, &2edb, &2f85
osfile_block = &0c00
; &0c00 referenced 1 time by &2edd; also used as index base 3 times by &2ece, &2ed5, &2f73
osfind       = &ffce
; &ffce referenced 2 times by &2e9d, &2f0b
osargs       = &ffda
; &ffda referenced 2 times by &2e65, &2ef5
osfile       = &ffdd
; &ffdd referenced 1 time by &2f2c
oswrch       = &ffee
; &ffee referenced 4 times by &2f12, &2f16, &2f1d, &2f89
osbyte       = &fff4
; &fff4 referenced 1 time by &2e41


    org &2e00

.dasmos_start
; ***************************************************************************************
; EXPAND: unpack a compressed MODE 2 picture
;
; *EXPAND <filename>. Entered at the load address, which jumps over the copyright notice.
;
; On Entry:
;     COMMAND LINE: the filename, after *EXPAND
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
.expand_start
    jmp expand                          ; Skip the copyright notice
; ***************************************************************************************
; Copyright notice
.copyright_notice
    equs "(C) 1985 Rhys E. Davies."     ; The author's copyright
; ***************************************************************************************
; Find the next argument on the command line
;
; Step command_ptr past spaces and commas. A carriage return (the end of the line) is
; left for the next call.
;
; On Exit:
;     C: set if the line has no more arguments; clear if command_ptr is one past the argument's first character
; &2e1b referenced 1 time by &2e68
.skip_separators
    ldy #0                              ; Y = 0 throughout: command_ptr itself advances
; &2e1d referenced 2 times by &2e27, &2e2b
.skip_separators_loop
    lda (command_ptr),y                 ; Read the next character of the command line
    inc command_ptr                     ; Advance command_ptr past it...
    bne check_separator                 ; No carry: pointer done
    inc command_ptr + 1                 ; Carry into the high byte
; &2e25 referenced 1 time by &2e21
.check_separator
    cmp #' '                            ; Skip spaces
    beq skip_separators_loop            ; A space: read on
    cmp #','                            ; Skip commas
    beq skip_separators_loop            ; A comma: read on
    cmp #&0d                            ; The end of the line?
    bne argument_found                  ; No: an argument starts here
    dec command_ptr                     ; Step command_ptr back onto the carriage return...
    lda command_ptr                     ; ...did the low byte wrap...
    cmp #&ff                            ; ...from &00 to &FF?
    bne no_argument                     ; No: pointer done
    dec command_ptr + 1                 ; Yes: borrow from the high byte
; &2e3b referenced 1 time by &2e37
.no_argument
    sec                                 ; Carry set: no argument
    rts                                 ; Return
; &2e3d referenced 1 time by &2e2f
.argument_found
    clc                                 ; Carry clear: an argument found
    rts                                 ; Return
; ***************************************************************************************
; Load the named picture and unpack it onto the screen
;
; Refuses to run outside MODE 2. Finds the filename on the command line, opens the file
; to learn its length, and loads it so that it ends at &8000, with all sixteen logical
; colours black so that neither the packed bytes nor the unpacking show. Unpacks it from
; &3000 until the screen is full, restores the zero page and page &0C bytes it used, and
; resets the palette (VDU 20) to reveal the picture.
;
; On Entry:
;     COMMAND LINE: the filename, after *EXPAND
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &2e3f referenced 1 time by &2e00
.expand
    lda #osbyte_read_char_at_cursor     ; Read the screen mode into Y
    jsr osbyte                          ; ...Y = the current screen mode  Read character at text cursor position and current screen MODE
    cpy #2                              ; MODE 2?
    beq mode_ok                         ; Yes: carry on
    brk                                 ; No: error 25, "Bad Mode"
    equb &19                            ; Error number 25 (BASIC's own "Bad MODE" number)
.bad_mode_message
    equs "Bad Mode"                     ; Error message
    equb &00                            ; End of the message
; &2e53 referenced 1 time by &2e46
.mode_ok
    lda command_ptr                     ; Save the four zero-page bytes OSARGS will overwrite...
    pha                                 ; ...low byte of command_ptr...
    lda command_ptr + 1                 ; ...next byte...
    pha                                 ; ...pushed...
    lda command_ptr + 2                 ; ...third byte...
    pha                                 ; ...pushed...
    lda command_ptr + 3                 ; ...fourth byte...
    pha                                 ; ...pushed, to restore before returning
    lda #1                              ; OSARGS 1: command_ptr = the address of the command line after "EXPAND"...
    ldx #command_ptr                    ; ...into command_ptr...
    ldy #0                              ; ...Y = 0 for this call...
    jsr osargs                          ; ...so command_ptr points past "EXPAND"  Get address of remaining command line into zero page address X (A=1, Y=0)
    jsr skip_separators                 ; Find the filename
    bcc open_picture                    ; Found: open it
    pla                                 ; None: restore command_ptr...
    sta command_ptr + 3                 ; ...its fourth byte...
    pla                                 ; ...the third...
    sta command_ptr + 2                 ; ...restored...
    pla                                 ; ...the second...
    sta command_ptr + 1                 ; ...restored...
    pla                                 ; ...the first...
    sta command_ptr                     ; ...restored, so the caller's zero page is intact
    brk                                 ; ...and give error 0, "Filename expected"
    equb &00                            ; Error number 0
.filename_expected_message
    equs "Filename expected"            ; Error message
    equb &00                            ; End of the message
; &2e8d referenced 1 time by &2e6b
.open_picture
    ldx command_ptr                     ; Step command_ptr back one, onto the filename's first character...
    ldy command_ptr + 1                 ; ...high byte into Y...
    dex                                 ; ...low byte minus one...
    cpx #&ff                            ; ...wrapped to &FF?
    bne filename_found                  ; No: no borrow
    dey                                 ; Yes: borrow from the high byte
; &2e97 referenced 1 time by &2e94
.filename_found
    stx command_ptr                     ; ...stored back, low byte...
    sty command_ptr + 1                 ; ...and high byte; XY = the filename too
    lda #osfind_open_input              ; Open the file for input (X, Y = the filename)
    jsr osfind                          ; ...A = the handle, or 0 if not found  osfind: open file for input
    tay                                 ; Y = the file handle
    bne load_picture                    ; Opened: go on
    pla                                 ; Not found: restore command_ptr...
    sta command_ptr + 3                 ; ...its fourth byte...
    pla                                 ; ...the third...
    sta command_ptr + 2                 ; ...restored...
    pla                                 ; ...the second...
    sta command_ptr + 1                 ; ...restored...
    pla                                 ; ...the first...
    sta command_ptr                     ; ...restored, so the caller's zero page is intact
    brk                                 ; ...and give error 0, "No such compressed picture"
    equb &00                            ; Error number 0
.no_such_picture_message
    equs "No such compressed picture"   ; Error message
    equb &00                            ; End of the message
; &2ecc referenced 1 time by &2ea1
.load_picture
    ldx #osfile_block_length - 1        ; For each of the 18 bytes of the OSFILE block at &0C00, last first:
; &2ece referenced 1 time by &2ed9
.set_up_osfile_block
    lda osfile_block,x                  ; Save the byte already there
    pha                                 ; ...on the stack, for restoring afterwards
    lda osfile_block_template,x         ; Replace it with the template's
    sta osfile_block,x                  ; ...in the block at &0C00
    dex                                 ; Next byte
    bpl set_up_osfile_block             ; Until all 18 bytes are set
    lda command_ptr                     ; Point the block at the filename...
    sta osfile_block                    ; ...low byte...
    lda command_ptr + 1                 ; ...high byte...
    sta osfile_block + 1                ; ...into the block's filename address
    lda packed_ptr                      ; Save the four zero-page bytes OSARGS will overwrite...
    pha                                 ; ...packed_ptr low byte pushed...
    lda packed_ptr + 1                  ; ...high byte...
    pha                                 ; ...pushed...
    lda screen_ptr                      ; ...screen_ptr low byte...
    pha                                 ; ...pushed...
    lda screen_ptr + 1                  ; ...high byte...
    pha                                 ; ...pushed, to restore before returning
    ldx #packed_ptr                     ; OSARGS 2 (Y = the handle): packed_ptr = the file's length (EXT#)...
    lda #2                              ; ...reason 2: the file's length
    jsr osargs                          ; ...four bytes into packed_ptr onwards  Get length of file into zero page address X (A=2)
    lda #0                              ; Load address = &8000 - length, so that the file ends at the top of screen memory...
    sec                                 ; ...ready to subtract...
    sbc packed_ptr                      ; ...the length's low byte...
    sta osfile_block + 2                ; ...into the block's load address, low byte
    pha                                 ; ...and keep it on the stack
    lda #>(screen_end)                  ; ...&80, the top of the screen's page...
    sbc packed_ptr + 1                  ; ...minus the length's high byte...
    sta osfile_block + 3                ; ...into the block's load address, high byte
    pha                                 ; ...and keep it too
    lda #osfind_close                   ; Close the file (Y = its handle)
    jsr osfind                          ; ...the length is known, so it is not needed open  osfind: close one or all files
    ldx #&0f                            ; For logical colours 15 down to 0:
; &2f10 referenced 1 time by &2f24
.blacken_colours
    lda #&13                            ; VDU 19,colour,0,0,0,0: make it black...
    jsr oswrch                          ; ...starts a palette change...
    txa                                 ; ...logical colour X...
    jsr oswrch                          ; ...sent...
    lda #0                              ; ...physical colour 0, black, and three zeros...
    ldy #4                              ; ...four bytes to send...
; &2f1d referenced 1 time by &2f21
.send_zeros
    jsr oswrch                          ; ...each sent...
    dey                                 ; ...one fewer to go...
    bne send_zeros                      ; Not all four: send another
    dex                                 ; Next colour
    bpl blacken_colours                 ; Until colours 15 to 0 are black
    lda #osfile_load                    ; Load the file at its load address in the block (exec byte 0: use the block's address)...
    ldx #<(osfile_block)                ; ...XY = the block at &0C00...
    ldy #>(osfile_block)                ; ...its high byte...
    jsr osfile                          ; ...so the file lands ending at &8000  osfile: load file
    pla                                 ; packed_ptr = the load address, the first packed byte...
    sta packed_ptr + 1                  ; ...high byte first, as pushed last...
    pla                                 ; ...then the low byte...
    sta packed_ptr                      ; ...into packed_ptr
    lda #0                              ; screen_ptr = &3000, the start of the MODE 2 screen; Y = 0 throughout...
    tay                                 ; ...Y = 0 for the (pointer),Y accesses...
    sta screen_ptr                      ; ...screen_ptr low byte...
    lda #>(screen_start)                ; ...the screen's page...
    sta screen_ptr + 1                  ; ...as screen_ptr's high byte
; &2f3e referenced 1 time by &2f61
.unpack_run
    jsr read_packed_byte                ; Read a packed byte
    pha                                 ; Keep it
    and #&c0                            ; Top two bits: the run length code...
    clc                                 ; ...moved down to bits 1-0 (through the carry)
    rol a                               ; ...bit 7 into the carry...
    rol a                               ; ...bit 6 into the carry, bit 7 into bit 0...
    rol a                               ; ...and bit 6 into bit 0: the code, 0-3
    cmp #3                              ; Code 3?
    bne run_length_known                ; No: the run is the code + 1 bytes
    jsr read_packed_byte                ; Yes: the run is the next byte + 1 (0 = 256)
; &2f4f referenced 1 time by &2f4a
.run_length_known
    tax                                 ; X = the run length...
    inx                                 ; ...plus one: 1-256 (0 wraps to 256)
    pla                                 ; A = the screen byte, the low six bits (so each pixel is one of colours 0-7)
    and #&3f ; '?'                      ; ...pixel bits only, dropping the run code
; &2f54 referenced 1 time by &2f5f
.write_run
    sta (screen_ptr),y                  ; Write it to the screen
    inc screen_ptr                      ; Advance screen_ptr...
    bne next_in_run                     ; No carry: same page
    inc screen_ptr + 1                  ; Carry: the next page
    bmi unpacked                        ; Reached &8000: the screen is full
; &2f5e referenced 1 time by &2f58
.next_in_run
    dex                                 ; Count down the run
    bne write_run                       ; More of the run: write it again
    jmp unpack_run                      ; Next packed byte
; &2f64 referenced 1 time by &2f5c
.unpacked
    pla                                 ; Restore the zero-page bytes...
    sta screen_ptr + 1                  ; ...screen_ptr high byte...
    pla                                 ; ...its low byte...
    sta screen_ptr                      ; ...restored...
    pla                                 ; ...packed_ptr high byte...
    sta packed_ptr + 1                  ; ...restored...
    pla                                 ; ...its low byte...
    sta packed_ptr                      ; ...restored
    ldx #0                              ; Restore the 18 bytes at &0C00...
; &2f72 referenced 1 time by &2f79
.restore_osfile_block
    pla                                 ; ...each from the stack...
    sta osfile_block,x                  ; ...back into the block's place
    inx                                 ; ...next byte...
    cpx #osfile_block_length            ; ...all 18?
    bne restore_osfile_block            ; No: restore the next
    pla                                 ; Restore command_ptr...
    sta command_ptr + 3                 ; ...its fourth byte...
    pla                                 ; ...the third...
    sta command_ptr + 2                 ; ...restored...
    pla                                 ; ...the second...
    sta command_ptr + 1                 ; ...restored...
    pla                                 ; ...the first...
    sta command_ptr                     ; ...restored
    lda #&14                            ; VDU 20: restore the default colours, revealing the picture, and return
    jmp oswrch                          ; ...OSWRCH returns to EXPAND's caller
; ***************************************************************************************
; Read the next packed byte
;
; Read the byte at packed_ptr and step packed_ptr past it.
;
; On Entry:
;     Y: 0
;
; On Exit:
;     A: the byte at packed_ptr, which advances past it
; &2f8c referenced 2 times by &2f3e, &2f4c
.read_packed_byte
    lda (packed_ptr),y                  ; Read the byte
    inc packed_ptr                      ; Advance packed_ptr...
    bne read_packed_byte_done           ; No carry: pointer done
    inc packed_ptr + 1                  ; Carry into the high byte
; &2f94 referenced 1 time by &2f90
.read_packed_byte_done
    rts                                 ; Return
; ***************************************************************************************
; OSFILE block template
;
; Copied to &0C00. The filename address (+0) and the low half of the load address (+2)
; are filled in; the high half, &FFFF, loads into the I/O processor, and exec address
; byte 0 (+6) tells OSFILE to use this load address. The start and end addresses (+10,
; +14) are unused by a load.
; &2f95 used as index base 1 time by &2ed2
.osfile_block_template
    equb &00, &00                       ; +0 filename address (filled in)
    equb &00, &2c, &ff, &ff             ; +2 load address (low half filled in)
    equb &00, &00, &00, &00             ; +6 exec address: low byte 0 means load at +2
    equb &00, &2c, &ff, &ff             ; +10 start address (unused)
    equb &00, &7c, &ff, &ff             ; +14 end address (unused)
.dasmos_end

save "EXPAND", dasmos_start, dasmos_end, &2e00, &2e00

; Label references by decreasing frequency:
;     command_ptr:            11
;     command_ptr + 1:         9
;     packed_ptr:              6
;     packed_ptr + 1:          5
;     screen_ptr:              5
;     command_ptr + 2:         4
;     command_ptr + 3:         4
;     osfile_block:            4
;     oswrch:                  4
;     screen_ptr + 1:          4
;     osargs:                  2
;     osfind:                  2
;     read_packed_byte:        2
;     skip_separators_loop:    2
;     argument_found:          1
;     blacken_colours:         1
;     check_separator:         1
;     expand:                  1
;     filename_found:          1
;     load_picture:            1
;     mode_ok:                 1
;     next_in_run:             1
;     no_argument:             1
;     open_picture:            1
;     osbyte:                  1
;     osfile:                  1
;     osfile_block + 1:        1
;     osfile_block + 2:        1
;     osfile_block + 3:        1
;     osfile_block_template:   1
;     read_packed_byte_done:   1
;     restore_osfile_block:    1
;     run_length_known:        1
;     send_zeros:              1
;     set_up_osfile_block:     1
;     skip_separators:         1
;     unpack_run:              1
;     unpacked:                1
;     write_run:               1

; Stats:
;     Total size (Code + Data) = 423 bytes
;     Code                     = 324 bytes (77%)
;     Data                     = 99 bytes (23%)
;
;     Number of instructions   = 179
;     Number of data bytes     = 24 bytes
;     Number of data words     = 0 bytes
;     Number of string bytes   = 75 bytes
;     Number of strings        = 4
