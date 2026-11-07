10 REM ***(c) Bug Byte 1987.               Mastered by S Benfield...                   ************
20 MODE 7:VDU23;8202;0;0;0;
30 PROCLOGO
40 T%=INKEY-256
50 IF T%=253 THEN 100
60 PRINT'''" BBC Version on the flip side of this    disc. please turn over the disc and     press the Space Bar."
70 REPEAT UNTIL INKEY-99
80*DUNJUNZ
90 END
100 PRINT TAB(0,21);" ";CHR$157;"Press Shift & CTRL to slow screen"
110 TIME=0:REPEAT UNTIL TIME>300:*FX 15
120 VDU28,2,20,38,4
130 *TYPE README
140 PRINT'''"Press Space to Load Dunjunz"''
150 REPEAT UNTIL INKEY-99
160 *DUNJUNZ
170 END
180 END
190 DEF PROCLOGO
200 VDU22,7,23;8202;0;0;0;
210 PRINT'CHR$141;"";CHR$157;"Dunjunz Main Menu - Bug Byte 1987"
220 PRINTCHR$141;"";CHR$157;"Dunjunz Main Menu - Bug Byte 1987"
230 ENDPROC
