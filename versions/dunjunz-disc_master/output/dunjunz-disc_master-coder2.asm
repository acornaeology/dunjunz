; Memory locations
bytev            = &020a
; &020a referenced 1 time by &2009
joystick_handler = &c500  ; Code's joystick handler in private RAM (HAZEL), which BYTEV is pointed at.
oscli            = &fff7
; &fff7 referenced 2 times by &2004, &2015


    org &2000

.dasmos_start
; ***************************************************************************************
; Coder2: install the joystick handler and run Coder
;
; Coder2 is the Master side's joystick installer, 38 bytes at &2000. *DUNJUNZ's run_coder
; runs it as *CODER2, in place of *CODER, when joystick channel 1 reads as a stick at
; rest; the display is already blanked and VDU output disabled. The run is three steps in
; a straight line: *L. Code loads the joystick handler into private RAM (HAZEL) at &C500,
; which MOS 3.20 leaves paged in; BYTEV is pointed at it; and *CODER loads and starts the
; game, and does not return. There is no RTS: the two command strings follow the last
; call. It leaves BYTEV pointing at the handler for the whole game. Every OSBYTE call
; then passes through it: INKEY scans of the Barbarian's (hero 2's) keys N, M, G, B and
; SPACE are answered from the joystick's two axes and fire buttons, so the joystick plays
; the Barbarian, and every other call goes straight to the MOS 3.20 OSBYTE routine at
; &EEB1. BYTEV's old value is not saved, so anything hooked into BYTEV before is
; bypassed.
.coder2_start
    ldx #<(load_code_command)           ; *L. Code: load the joystick handler at &C500
    ldy #>(load_code_command)           ; ...(X, Y) = the command line
    jsr oscli                           ; ...loaded into HAZEL, which MOS 3.20 leaves paged in
    lda #<(joystick_handler)            ; Point BYTEV at the handler, so every OSBYTE...
    sta bytev                           ; ...goes through it first...
    lda #>(joystick_handler)            ; ...(the handler's page)...
    sta bytev + 1                       ; ...and INKEY scans for the hero's keys read the stick
    ldx #<(coder_command)               ; *CODER: load and start the game
    ldy #>(coder_command)               ; ...(X, Y) = the command line
    jsr oscli                           ; ...never returns: the game takes over the machine
; The OSCLI command lines, each ended by a carriage return.
.load_code_command
    equs "L. Code", &0d                 ; Load the joystick handler at its own &C500
.coder_command
    equs "CODER", &0d                   ; Run Coder, which loads and starts the game
.dasmos_end

save "Coder2", dasmos_start, dasmos_end, &2000, &2000

; Label references by decreasing frequency:
;     oscli:      2
;     bytev:      1
;     bytev + 1:  1

; Stats:
;     Total size (Code + Data) = 38 bytes
;     Code                     = 24 bytes (63%)
;     Data                     = 14 bytes (37%)
;
;     Number of instructions   = 10
;     Number of data bytes     = 0 bytes
;     Number of data words     = 0 bytes
;     Number of string bytes   = 14 bytes
;     Number of strings        = 2
