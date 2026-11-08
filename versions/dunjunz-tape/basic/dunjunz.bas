0 REMXXXXXX
9 ON ERROR CALL !-4
10 *FX 200,3
20 MODE 7
30 VDU23;8202;0;0;0;
40 T%=INKEY(-256)
50 
60 IF T%>0 THEN PRINT''"SORRY..." ELSE GOTO 150
70 IF T%=0 PRINT''"DUNJUNZ has not been tested on a machinefitted with a O.S 0.10"'':END
80 IF T%=1 PRINT''"DUNJUNZ will not Run on the             Acorn Electron."
90 IF T%=250 PRINT''"DUNJUNZ has not been tested on an       Acorn ABC machine."'':END
100 IF T%=251 PRINT''"DUNJUNZ has not been tested on a machinefitted with a O.S 2.00"'':END
110 IF T%=252 PRINT''"DUNJUNZ has not been tested on a        German BBC"'':END
120 IF T%=253 PRINT''"DUNJUNZ will not Run on the             Acorn MASTER series."'':END
130 IF T%=254 PRINT''"DUNJUNZ will not Run on the             Acorn MASTER series fitted with MOS 1.00 or 1.1."
140 END
150 PRINT''" Now loading Dunjunz...."''
160 CHAIN"PLOAD"
