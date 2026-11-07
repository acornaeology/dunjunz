; Memory locations
bytev = &020a
; &020a referenced 1 time by &2009
oscli = &fff7
; &fff7 referenced 2 times by &2004, &2015


    org &2000

.dasmos_start
; ***************************************************************************************
; Coder2: install the joystick handler and run Coder
;
; Run by *DUNJUNZ when a joystick is present. *L. Code loads the joystick handler into
; private RAM at &C500, BYTEV is pointed at it, and *CODER is run, which does not return.
.coder2_start
    ldx #&18                            ; *L. Code: load the joystick handler at &C500
    ldy #&20 ; ' '                      ; ...
    jsr oscli                           ; ...
    lda #0                              ; BYTEV = &C500, the joystick handler...
    sta bytev                           ; ...
    lda #&c5                            ; ...
    sta bytev + 1                       ; ...
    ldx #&20 ; ' '                      ; *CODER: load and start the game (no return)
    ldy #&20 ; ' '                      ; ...
    jsr oscli                           ; ...
.load_code_command
    equs "L. Code"
    equb &0d
.coder_command2
    equs "CODER"
    equb &0d
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
;     Number of data bytes     = 2 bytes
;     Number of data words     = 0 bytes
;     Number of string bytes   = 12 bytes
;     Number of strings        = 2
