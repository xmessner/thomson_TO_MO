10 REM GRENOUILLE
20 REM
30 CLEAR 1000,,17:DEFINT A-Z
40 DIM P(22),I(22):GOSUB 500
50 V=2:LOCATE 24,0:COLOR 3,5:PRINT "VIE: 2"
60 P=0
70 T=0
80 X=19:Y=21
90 COLOR I(Y),P(Y):PSET(X,Y)GR$(10):AX=X:AY=Y
100 A=1:FOR I=1 TO 8
110 COLOR I(I*2+A),P(I*2+A):LOCATE 0,I*2+A:PRINT MID$(L$(I),D(I),40)
120 IF I=4 THEN A=3
130 NEXT
140 IF Y=1 THEN 1200
150 FOR I=1 TO 7 STEP 2
160 D(I)=D(I)+1:IF D(I)=25 THEN D(I)=1
170 D(I+1)=D(I+1)-1:IF D(I+1)=0 THEN D(I+1)=24
180 NEXT
190 COLOR 3,5:LOCATE 5,0:PRINT "POINTS:";P
280 REM--------------------------------
290 REM DEPLACEMENTS
300 A$=INKEY$
310 IF A$="P" THEN X=X+1
320 IF A$="A" THEN X=X-1
330 IF A$=" " THEN Y=Y-2:P=P+1
340 IF AY=11 OR AY=21 THEN COLOR I(AY),P(AY):PSET(AX,AY)" "
350 C=SCREEN(X,Y)
360 IF Y<11 AND C=32 THEN 1100
370 IF Y>12 AND C=0 THEN 1100
380 IF X<1 OR X>38 THEN 1100
390 IF AY<>Y THEN 90
400 If Y=3 OR Y=7 THEN X=X-1
410 IF Y=5 OR Y=9 THEN X=X+1
420 GOTO 90
480 REM ------------------------
490 REM GRAPHIQUES
500 DEFGR$(0)=63,72,136,255,128,255,136,112
510 DEFGR$(1)=224,16,8,255,1,255,34,28
520 DEFGR$(2)=7,8,16,255,128,255,68,56
530 DEFGR$(3)=248,36,34,255,1,255,17,14
540 DEFGR$(4)=254,142,142,254,255,255,68,56
550 DEFGR$(5)=127,113,113,127,255,255,34,28
560 DEFGR$(6)=15,23,35,65,65,35,23,15
570 DEFGR$(7)=240,248,252,254,254,252,248,240
580 DEFGR$(8)=240,232,196,130,130,196,232,240
590 DEFGR$(9)=15,31,63,127,127,63,31,15
600 DEFGR$(10)=28,73,127,28,28,62,99,99
610 DEFGR$(11)=255,255,255,254,255,255,255,255
620 DEFGR$(12)=255,255,255,255,255,255,68,56
630 DEFGR$(13)=255,255,255,255,255,255,0,0
640 DEFGR$(14)=0,192,96,48,31,13,7,255
650 DEFGR$(15)=0,0,0,0,255,255,255,255
660 DEFGR$(16)=0,0,0,0,192,240,252,255
670 FOR J=1 TO 4:A$="":READ N,M,O
680 FOR I=1 TO O
690 READ A:IF A=17 THEN A$=A$+" " ELSE A$=A$+GR$(A)
700 NEXT I
710 FOR I=1 TO M:L$(N)=L$(N)+A$:NEXT I
720 NEXT J
730 L$(3)=L$(1):L$(4)=L$(2)
740 L$(7)=L$(5):L$(8)=L$(6)
750 DATA 1,3,22,6,11,11,11,7,17,17,17,17,17,17,14,15,15,15,16,17,17,17,17,17,17
760 DATA 2,3,24,9,11,11,8,17,17,17,17,17,17,17,17,9,11,11,8,17,17,17,17,17,17,17,17
770 DATA 5,6,12,4,12,13,13,12,17,17,2,3,17,17,17
780 DATA 6,6,12,12,12,5,17,17,17,17,0,1,17,17,17
880 REM ----------------------------
890 REM COULEURS
900 SCREEN 2,2,2:CLS:PRINT
910 FOR I=1 TO 22
920 READ A,B:COLOR B,A:FOR J=1 TO 40:PRINT" ";:NEXT
930 P(I)=A:I(I)=B
940 NEXT I
950 DATA 0,7,0,7,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,1,2,1,2
960 DATA 7,0,7,0,7,0,7,0,7,0,7,0,7,0,7,0,1,2,1,2
970 FOR I=1 TO 7 STEP 4
980 D(I)=1:D(I+1)=26
990 D(I+2)=5:D(I+3)=21
1000 NEXT I
1010 COLOR 7,0
1020 LOCATE 7,1:PRINT GR$(11)GR$(11)"    "GR$(11)GR$(11);
1030 PRINT"    "GR$(11)GR$(11)"    "GR$(11)GR$(11)"    "GR$(11)GR$(11)
1040 RETURN
1080 REM -------------------------------------------------
1090 REM PERDU
1100 PLAY "SILASOFAMIREDO"
1110 V=V-1
1120 IF V<0 THEN LINE INPUT A$:RUN
1130 COLOR 3,5:LOCATE 24,0:PRINT "VIES:";V
1140 GOTO 80
1180 REM ------------------------------
1200 PLAY"O3DOREMIFASOLASIO4DOREMIFASOLASIO5DO"
1210 T=T+1:P=P+10
1190 REM GAGNE
1220 IF T=5 THEN GOSUB 1010:P=P+50:GOTO 70
1230 COLOR ,0:LOCATE X-1,Y:PRINT "   "
1240 GOTO 80
