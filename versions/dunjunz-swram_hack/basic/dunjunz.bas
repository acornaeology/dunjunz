10REM           Dunjunz
20REM      (c) Bug Byte 1986
30REM   (Sideways RAM version)
40 
50*FX200,3
60ONERRORGOTO440
70IFPAGE>&1900PRINT"Wrong page":END
80IFPAGE>&1100THEN650
90MODE7:VDU23;8202;0;0;0;:FORI=1TO2:PRINTTAB(15,I)"DUNJUNZ":NEXT:PRINT'"THE GAME":*FX200,2
100PRINT"4 Heroes must recover the Chalice of   Binding and save the World. Mackscrane the Great Demon, has hidden it in the  Dunjunz complex. They must battle it   out against Bashers, find treasure,    magic, adventure and death."
110PRINT'"Amazing all action adventure deep down under, 4 characters, weapons, treasure,spells, meanies, 25 levels. Fast,"'"furious and funny."
120PRINT'"By Julian (¢It's very deep¢) Avis."TAB(6,23)"Press ¢SPACE¢ to continue.";:VDU28,0,22,39,3:PROCP:PRINT'"The Story so far........"
130PRINT"To help them on their quest, the Gods  have given the four heroes extra"'"powers:"''"The Ranger uses a bow, and his quiver  has the power to produce an unlimited  supply of arrows."'
140PRINT"The Wizard has been taught how to cast powerful fireballs.":PRINT'"The Barbarian's axe can create clones  of itself."':PRINT"The Warrior can draw an infinite amountof swords from her sheath.":PROCP
150PRINT'"Each character can only fire a certain amount of weapons at any one time; you need magic to maintain the weapon's    existence."
160PRINT"Each character begins with a different set of fighting attributes. As the gameprogresses, you will find magical itemswhich boost your character's abilities and so increase your chance of         survival."
170PRINT"Four people can play this game at the  same time, each person controlling his / her character. Each character has    their 'own' quarter of the screen and  can go round the Dunjunz on their own,"
180PRINT"getting to treasures first, and even   hunting each other; the Barbarian      is a good one to start with.":PROCP:PRINT'"PROGRESSION THROUGH THE LEVELS"
190PRINT"On each level of the Dunjunz there is aexit, a square 'hole' which leads down deeper into the Dunjunz - the next"
200PRINT"level. By sliding down these exits, thecharacters will get nearer and nearer  to their ultimate goal - the Chalice."''"THE CHARACTERS"
210PRINT"The Magic-User/Wizardcan fire 3 arrowsat a time, they are not that effective.He wears leather armour, which absorbs about 1/3 damage, he does have one"
220PRINT"advantage over the Barbarian and"'"Warrior - he can use magic; all"'"monsters in the vicinity are killed,   it drains his energy badly.":PROCP
230PRINT'"The Rangercan cast 2 fireballs at a   time, and each one does the same damageas two arrows. A robe protects him and when hit it takes maximum damage."'"Not a good fighter. He has one power"
240PRINT"no one else can match - his magic, and he uses hardly any energy - a dangerouscharacter."
250PRINT"The Barbarianis a born fighter with   no magic. He begins with one axe which does horrific damage and can kill in   one shot! His natural tough skin is    better than any leather and nearly"
260PRINT"matches the Warrior's chain mail !     The Fighter/Warriorcan throw 3 swords at a time, and each equals a fireball  in damage. She wears chainmail, carriesa shield. But, she has no magic.":PROCP:PRINT'"MAKING IT THROUGH TO THE NEXT LEVEL"
270PRINT"As long as one character makes it      through to the next level (i.e. reachesthe exit) then all dead characters willbe brought back to life on the next    level with their original attributes."
280PRINT"If the Barbarian had gained three axes and then died, on the next level he    would be back to 1 axe and scores      are reset to 0.":PRINT"If all die on a level, then new heroes take their place, starting back on     level 1."
290PRINT'"Whenever a new level is begun, everyonehas their health put back to full"'"strength regardless of how weak they   were on leaving the last level.":PROCP
300PRINT'"OBJECTS IN THE GAME"'"Exit- To go deeper, walk over a"'"square hole."'"Treasure- Worth 20 points."'"Food- Increases health by 10 points.  Health cannot exceed 99."'"Worth 5 points."
310PRINT"Teleporter- Teleport to another room  on the same level."'"Trap Doors- Where new monsters emerge from replacing dead comrades."'"Energy Drainer- Lose 20 health points.They can be destroyed by repeatedly"
320PRINT"shooting them. BEWARE when a weapon    hits an energy drainer, it bounces     back. Worth 1 point for every hit.":PROCP:PRINT'"Magic Sword- Increases the damage a   character's weapon does by 1."'"Worth 10 points."
330PRINT"Pile of Weapons- Allows a character tofire an extra weapon, 3 being maximum. Worth 10 points."'"Magic Helmet- Increases armour rating by 1 point. Less damage is taken when  hit. Worth 10 points."
340PRINT"Cross of Resurrection- Increases      armour rating by 1 point. Less damage  is taken when hit. Worth 10 points."
350PRINT"Boots of Speed- Moves you about twice the normal speed. A lightning bolt on  the display shows the presence of the  boots. Bumping into anything apart fromwalls, doors and keys loses the boot.  Worth 10 points.":PROCP
360PRINT'"Potion of Healing- A blessing or a    curse. The health of the character     changes: Take the last digit (the rightmost digit) of his/her score, duplicateit, and this value is the new health   value."'"Worth 10 points."
370PRINT"Door- Open by walking into it and by  carrying the correct key. Some are     hidden."'"Worth 7 points."
380PRINT"Key- For each door there is a key.    Only one key may be carried at a time  by a character. If you go over another key, then the key lying on the floor   is picked up, and the original key"
390PRINT"being carried is dropped in its        place.":PROCP
400PRINT'"SCREEN DISPLAY"'"Concentrate on the screen that your    particular character controls, even    if you appear on other character's     screens. Your screen will ALWAYS"'"show your character in it."
410PRINT'"    Top leftRANGER"'"   Top rightWIZARD"'" Bottom leftBARBARIAN"'"Bottom rightWARRIOR":PROCP:PRINT'"NOTE:"'"Dunjunz features 25 levels of play     that MUST load into Sideways RAM."
420PRINT'"This version of the game has been set  to load levels 1-21 into BANK 5 and    levels 22-25 into BANK 4. If these     slots are not available in your machinethen you must change the code in the"
430PRINT"¢DUNK¢ file accordingly or the game    may not work correctly.":PRINT'"This game MUST be loaded from Drive 0.":REPEATUNTILGET=32
440VDU26,12:*FX200,3
450FORI%=0TO&3FF STEP4:I%!&7C00=I%!&3700:NEXT:*FX15
460G=GET:VDU26,12:*FX15
470ONERRORCALL!-4
480PRINT''" Now loading Dunjunz....":I=INKEY300:GOTO510
490DEFPROCP:*FX15
500REPEATUNTILGET=32:CLS:ENDPROC:
510MODE2:VDU23;8202;0;0;0;:COLOUR15:VDU19,15,7,0,0,0,0:VDU28,19,31,19,0:FORX%=0TO14:VDU19,X%,0,0,0,0,0:NEXTX%:*L.PIC 3000
520CLS:SOUND1,-1,100,0:SOUND0,-15,3,99:PRINT"   E S C A P E  T O  S K I P "
530A$=" D U N J U N Z     for the BBC B microcomputer......      I Mackscrane, The great Demon of Supreme Evilness, have stolen the Chalice of Binding.         Get Grunt the Barbarian......                             (c) Bug Byte 1986  "
540FORX%=0TO14:VDU19,X%,X%,0,0,0,0:NEXTX%:ONERRORGOTO580
550*FX200,2
560TIME=0:REPEATUNTILTIME>900:CLS:PRINT"                                                       ":RESTORE:FORS%=0TOLEN(A$):C%=ASC(MID$(A$,S%,1)):TIME=0:REPEATUNTILTIME>30:VDUC%:NEXTS%:CLS:FORT%=0TO599:X%=RND(7):VDU19,X%,X%,0,0,0,0::X%=RND(7):VDU19,X%,0,0,0,0,0:NEXT:*FX200,3
570FORP%=255TO0STEP-10:X%=RND(14):VDU19,X%,0,0,0,0,0:SOUND1,-1,P%,0:SOUND0,-10,7,1:NEXTP%:VDU19,RND(14),RND(7),0,0,0,0:TIME=0:REPEATUNTILTIME>300
580MODE4:*FX200,3
590ONERRORCALL!-4
600CLS:VDU23;8202;0;0;0;:*FX15
610PRINT'''" Please wait...."''':I=INKEY300:*/TITLE
620*FX225
630*TV255
640PAGE=&2500:CHAIN"DUNK"
650FORI%=0TOTOP-PAGE STEP4:I%!&1100=I%!PAGE:NEXT:?&13=?&13-(PAGE-&1100)DIV256:PAGE=&1100:LOMEM=TOP:RUN
