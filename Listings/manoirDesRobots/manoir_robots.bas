1 'Le manoir des robots 
2 'Promenez-vous dans le manoir des robots. Mais attention, vous n'y ferez pas que de bonnes rencontres. Selectionnez votre choix en actionnant la manette a droite ou a gauche. Validez votre choix en appuyant sur le bouton. 
3 'Eric Brondoni 

9 GOTO 30900
10 CLS:SCREEN7,0,0:'++ INITIALISATION ++
15 CLEAR,,62:GOSUB60000
100 BB=0:N=0:N1=0:N2=0:VIC=0:M=0:M1=1:M2=1:M3=1:M4=1:M5=1:M6=1:CP=7:SCORE=700:PV=21:P=3:F=1:F1=1:F2=1:F3=1:F4=1:S=1:R=0:CLET=0:CLEA=0:CLEA1=0:CLEC=0:CLE6=0:CLEO=0:EPEE=0:TRESOR=1:LINGOT=1:VEND=1:PASSAGE=0:PA=0:PASS=0
101 XC=1:X=0:Y=21
102 ' ++ JEU ++
200 GOSUB25000:GOSUB20000:GOSUB20100:GOSUB20300:GOSUB30100
210 GOSUB30000:LOCATE4,20:PRINT"Que faites vous ?":GOSUB61000
220 IFXC=16 THENLOCATE4,20:PRINT"REGARDE":GOSUB30000:LOCATE4,21:PRINT"Vous voyez un message sur la porte":PLAY"PPPPPP":GOTO210
221 IFXC=1 THENGOTO250
222 IFXC=19 THENGOSUB 20400:GOTO200
245 GOTO210
250 GOSUB25000:GOSUB20000:GOSUB20500:GOSUB30100:CC=5:GOSUB32000
260 GOSUB30000:LOCATE4,20:PRINT"Que faites vous ?":GOSUB61000
265 IF XC=4THENGOTO200
266 IF XC=16THENGOSUB30000:LOCATE4,20:PRINT"Vous voyez 1 coffre":PLAY"PPPPPPPP":GOTO260
267 IF XC=34THENGOSUB30000:LOCATE4,20:PRINT"Impossible il est trop lourd !":PLAY "PPPPPPPPP":GOTO260 
275 IF XC=10THENGOTO300
276 IF XC=37ANDS=1 THENGOSUB30000:LOCATE 4,20:PRINT"Malediction !!!! un serpent":LOCATE4,21:PRINT"surgit du coffre... ":PLAY"PPPPPPPP"
277 IFXC=37 AND A=0 ANDS=1 THENGOSUB30000:LOCATE4,20:PRINT"... et vous pique":LOCATE4,21:PRINT"Vous faiblissez":PLAY"PPPPPPPPPPPPP":FORI=1TO5:S=0:GOSUB26300:GOSUB30100:NEXTI
278 IFXC=37AND A>0 ANDS=1 THENGOSUB30000 :LOCATE4,20:PRINT"... mais vous le neutralisez":LOCATE4,21:PRINT"de justesse":PLAY"PPPPPPPPPPPPP":FORI=1TO5:S=0:GOSUB26400:GOSUB30100:NEXTI
279 IFXC=37AND S=0 THENGOSUB30000:LOCATE 4,20:PRINT"il est vide":PLAY"PPPPPPPPP"
280 GOTO260
300 GOSUB25000:GOSUB20000:GOSUB20500:GOSUB20600:GOSUB30100:IFM=0THENCOLOR4:GOSUB 20700:COLOR7
301 GOSUB30100
310 GOSUB30000:LOCATE4,20:PRINT"Que faites vous ? ":GOSUB61000
320 IFXC=10ANDM=0THENGOSUB10000:LOCATE4,21:PRINT"Impossible de passer. Il faut combattre":PLAY"PPPPPPPP":GOTO310
321 IFXC=10ANDM=1THENGOTO350
322 IFXC=7 THENGOTO250
323 IFXC=16ANDM=0THENGOSUB30000:LOCATE4,20:PRINT"Un robot se tient face a vous ":LOCATE4,21:PRINT"et vous barre la route":PLAY"PPPPPPPPPPP":GOTO310
330 IFXC=31ANDM=0THENGOSUB30200
335 IFVIC=1THEN M=1:CLS:VIC=0:GOTO300
340 GOTO310
350 GOSUB25000:GOSUB20000:GOSUB20100:GOSUB20500:GOSUB20600:GOSUB30100:GOSUB20300
360 GOSUB30000:LOCATE4,20:PRINT"Oue faites vous ? ":GOSUB61000:IFXC=7THENGOTO300
362 IF XC=16THEN GOSUB30000:LOCATE4,21:PRINT"Vous voyez un message":PLAY"PPPPPP":GOTO360
365 IF XC=10 THEN GOTO400
366 IF XC=19 THEN GOSUB30700:GOTO350
370 IF XC=1THEN GOTO450
395 GOTO360
400 GOSUB25000:GOSUB20000:GOSUB20600:GOSUB30100:GOSUB26000
401 GOSUB30100
405 IFN=0 THEN LOCATE20,15:COLOR1:PRINTGR$(13):LOCATE17,15:COLOR3:PRINTGR$(9);GR$(10):LOCATE17,16:COLOR2:PRINTGR$(11);GR$(12):COLOR7:LOCATE4,21
406 IFN=1 THEN LOCATE20,15:PRINT" ":LOCATE17,15:PRINT"  ":LOCATE17,16:PRINT"  ":COLOR7
410 GOSUB30000:LOCATE4,20:PRINT"Que faites vous ? ":GOSUB61000:IFXC=7THENGOTO350
419 IFXC=16 ANDN=0THENGOSUB30000:LOCATE4 ,20:PRINT"Vous voyez de la nourriture":PLAY"PPPPPPP":GOTO410
420 IFXC=22 ANDN=0THENN=1:PLAY"DORE":PV=PV+10:SCORE=SCORE+1000:GOSUB30100:GOTO406
440 GOTO410
450 GOSUB25000:GOSUB20000:GOSUB20100:GOSUB30100:IFM1=1THENCOLOR5:GOSUB20750:COLOR7
460 GOSUB30000:LOCATE4,20:PRINT"Que faites vous ? ":GOSUB61000:IFXC=4 ANDM1=1THENGOSUB30000:LOCATE4,21:PRINT"Impossible de passer il faut combattre":PLAY"PPPPP":GOTO460
475 IFXC=31ANDM1=1THENGOSUB30200:GOSUB30100
476 IFXC=1ANDM1=1THENGOSUB30000:LOCATE4,21:PRINT"Impossible de passer.II faut combattre":PLAY"PPPPP":GOTO460
477 IFXC=4ANDM1=0THENGOTO350
478 IFXC=1ANDM1=0THENGOTO500
479 IFXC=16ANDM1=1THENGOSUB30000:LOCATE4,21:PRINT"Un robot vous barre le passage ":PLAY"PPPPPPPPP":GOTO460
480 IFVIC=1ANDM1=1THENM1=0:CLS:GOTO450
495 GOTO450
500 GOSUB25000:GOSUB20000:GOSUB20100:GOSUB26000:GOSUB30100
510 IF F=1 THEN LOCATE18,16:COLOR4:PRINTGR$(8):COLOR7
511 IF F=0 THEN LOCATE18,16:PRINT" "
520 GOSUB30000:LOCATE4,20:PRINT"Oue faites vous ?":GOSUB61000
525 IFXC=25 ANDF=1 THEN GOSUB26100:GOTO510
526 IFXC=1 THEN GOTO550
527 IFXC=4 THEN GOTO450
528 IFXC=16 ANDF=1 THEN GOSUB30000:LOCATE4,20:PRINT"Vous voyez une fiole....":LOCATE4,21:PRINT"contenant un etrange liquide bleu":PLAY"PPPPPPPPPPPP":GOTO520
545 GOTO510
550 GOSUB25000:GOSUB20000:GOSUB20100:GOSUB20500:GOSUB20600:GOSUB30100:CC=4:GOSUB32000
560 GOSUB30000:LOCATE4,20:PRINT"Oue faites vous ?":GOSUB61000
565 IFXC=4THEN500
566 IF XC=16 AND R=0 THENGOSUB30000:LOCATE4,20:PRINT"Vous voyez 1 coffre":PLAY"PPPPPPPP":GOTO560
567 IF XC=34ANDR=0THENGOSUB30000:LOCATE4,20:PRINT"Impossible it est trop lourd !":PLAY"PPPPPPPPP":GOTO560
568 IF XC=37ANDR=0ANDNI=0THENGOSUB30000:LOCATE4,20:PRINT"Vous y trouvez de la nourriture":PLAY"PPPPPPPP":R=1:GOTO560
569 IF XC=16 AND R=1 THENCOLOR3:LOCATE14,15:PRINTGR$(14);GR$(15):GOSUB30000:LOCATE0,20:PRINT"Vous voyez la cle de la salle du TRESOR":PLAY"PPPPPPPPPP":GOTO560
570 IF XC=22 ANDN1=0THENFORI=0TO9:GOSUB26200:NEXTI:N1=1:R=1:GOTO560
571 IF XC=34ANDR=1THENCLET=1:R=0:LOCATE14,15:PRINT"  ":GOTO560
572 IF XC=10THENGOTO600
573 IF XC=7THENGOTO650
574 IF XC=1THENGOTO800
596 GOTO560
600 GOSUB25000:GOSUB20000:GOSUB20600:GOSUB30100:GOSUB26000
603 IF F1=1THENLOCATE18,16:COLOR1:PRINTGR$(8)
604 IF CLEA=0THENLOCATE20,16:COLOR5:PRINTGR$(16);GR$(17)
610 GOSUB30000:LOCATE4,20:PRINT"Oue fait es vous ? ":GOSUB61000
615 IF XC=16 AND F1=1THENGOSUB30000:LOCATE4,20:PRINT"Vous voyez une fiole contenant":LOCATE4,21:PRINT"...un etrange breuvage rouge":PLAY"PPPPPPPPPPPP"
616 IF XC=16 AND CLEA=0THENGOSUB30000:LOCATE4,20:PRINT"Vous voyez une CLE mauve" :PLAY"PPPPPPPPP"
617 IF XC=25 AND F1=1THENGOSUB62000 
618 IF XC=34 AND CLEA=0THENLOCATE20,16:PRINT"  ":CLEA=1
619 IF XC=7 THEN GOTO550
648 GOTO610
650 GOSUB25000:GOSUB20000:GOSUB20600:GOSUB20500:GOSUB30100:CC=7:GOSUB27000
660 GOSUB30000:LOCATE4,20:PRINT"Que faites vous ? ":GOSUB61000
665 IFXC=10THEN GOTO550
666 IFXC=16THEN GOSUB30000:LOCATE4,20:PRINT"Vous voyez une armoire":PLAY"PPPPPPPP"
667 IFXC=37AND CLEA=1 ANDEPEE=0THEN GOSUB30000:LOCATE4,20:PRINT"Vous voyez une EPEE LASER":PLAY"PPPPPPPPPP"
668 IFXC=34AND CLEA=1 THEN EPEE=1:GOSUB30000:LOCATE4,20:PRINT"Grace a cette epee laser":LOCATE4,21:PRINT"Vous allez pouvoir vous battre":LOCATE4,22:PRINT"contre les meilleurs robots":LOCATE4,23:PRINT"du manoir.":PLAY"PPPPPPPPPPPPPPPPP"
669 IFXC=37AND CLEA=0 THEN GOSUB30000:LOCATE4,20:PRINT"Cretin!! vous n'avez":LOCATE4,21:PRINT"pas la cle":PLAY"PPPPPPPPPP"
670 IFXC=7 THEN 700
698 GOTO660
700 GOSUB25000:GOSUB20000:GOSUB20600:GOSUB20500:GOSUB30100:MM=1
709 IFM2=1THENGOSUB27100
710 GOSUB30000:LOCATE4,20:PRINT"Oue faites vous ? ":GOSUB61000
711 IFXC=16 ANDM2=1THEN GOSUB30000:LOCATE4,20:PRINT"Vous voyez le gardien de":LOCATE4,21:PRINT"la salle du TRESOR":PLAY"PPPPPPPPPPP"
712 IFXC=31 AND EPEE=0 ANDM2=1 THEN GOSUB30000:LOCATE4,20:PRINT"Vous vous attaquez a un robot":LOCATE4,21:PRINT"10 fois superieur a vous et":LOCATE4,22:PRINT"vous n'avez meme pas d'arme":LOCATE4,23:PRINT"...jeune FRELUOUET!!!!!":PLAY"L96PPPPPP":GOSUB62000
713 IFXC=31 AND EPEE=1 ANDM2=1 THEN GOSUB30200:GOSUB30100:IF VIC=1THEN M2=0:CLS:GOTO700
714 IFXC=10 THEN650
715 IFXC=7 ANDM2=0 ANDCLET=0 THENGOSUB30000:LOCATE4,20:PRINT"Vous vous trouvez face a la porte":LOCATE4,21:PRINT"de la salle du tresor mais vous":LOCATE4,22:PRINT"n'avez pas la cle""":PLAY"PPPPPPPPPPPPPP"
716 IFXC=7 ANDM2=0 ANDCLET=0 THENGOSUB30000:LOCATE4,20:PRINT"vous auriez du regarder 2 fois ":LOCATE4,21:PRINT"dans certaines salles ":LOCATE4,22:PRINT"ainsi vous l'auriez trouvee!!!!":PLAY"PPPPPPPPPPPPPPPP"
717 IFXC=7 ANDM2=0 ANDCLET=1 THENGOSUB30 000:LOCATE4,20:PRINT"la cle que vous possedez ":LOCATE4,21:PRINT"vous permet d'ouvrir la porte ":PLAY"PPPPPPPPPPPPP":GOTO750
749 GOTO710
750 GOSUB25000:GOSUB20000:GOSUB20500:GOSUB30100
758 IF LINGOT=1THENCL=3:GOSUB32100
759 IF TRESOR=1THENCC=3:GOSUB32000
760 GOSUB30000:LOCATE4,20:PRINT"Oue fait es vous ? ":GOSUB61000
768 IFXC=16 AND LINGOT=1 AND TRESOR=0AND BB=0 THEN GOSUB30000:LOCATE3,21:PRINT"Vous voyez un tas de lingots d'or":PLAY"PPPPPPPPP":BB=1
769 IFXC=16 AND LINGOT=1 AND TRESOR=1 ANDBB=0 THEN GOSUB30000:LOCATE4,21:PRINT"Vous voyez un coffre":PLAY"PPPPPP"
770 IFXC=10 THENGOTO700
771 IFXC=34 AND LINGOT=1 ANDTRESOR=1ANDBB=0THEN CC=0:GOSUB32000:TRESOR=0:SCORE=SCORE+5000:GOSUB30100
772 IFXC=37 AND LINGOT=1 ANDTRESOR=1ANDBB=0THEN GOSUB30000:LOCATE3,21:PRINT"Ce coffre est plein de pieces d'or":PLAY"PPPPPPPPPP"
773 IFXC=34 AND LINGOT=1 ANDTRESOR=0 AND BB=1THEN CL=0:GOSUB32100:LINGOT=0:SCORE =SCORE+5000:GOSUB30100
790 GOTO760
800 GOSUB25000:GOSUB20000:GOSUB20100:GOSUB30100:MM=4
808 IFPA=1THENGOSUB20600
809 IFM3=1THENGOSUB27100
810 GOSUB30000:LOCATE4,20:PRINT"Oue fait es vous ? ":GOSUB61000
811 IFXC=16 ANDM3=1THEN GOSUB30000:LOCATE4,20:PRINT"Vous voyez un gardien qui":LOCATE4,21:PRINT"vous barre le passage":PLAY"PPPPPPPPPPPP"
812 IFXC=31 AND EPEE=0 ANDM3=1 THEN GOSUB30000:LOCATE4,20:PRINT"Vous vous attaquez a un robot":LOCATE4,21:PRINT"10 fois superieur a vous et":LOCATE4,22:PRINT"vo us n'avez mese pas d'arme":LOCATE4,23:PRINT"...jeune FRELUOUET!!":PLAY"L96PPPPPP":GOSUB62000
813 IFXC=31 AND EPEE=1 ANDM3=1 THEN GOSUB30200:GOSUB30100:IF VIC=1THEN M3=0:CLS:GOTO800
814 IFXC=16 ANDM3=0ANDPA=0THEN GOSUB2060 0:GOSUB30000:LOCATE4,20:PRINT"Vous avez decouvert une":LOCATE3,21:PRINT"porte secrete ...celle de la cave":PLAY"PPPPPPPPPPPPPPP":PA=1
815 IFXC=I ANDM7=1THEN GOSUBB30000:LOCATE 4,20:PRINT"Impossible de passer":play"PPPPPPPPPP"
816 IFXC=7 ANDM3=0 ANDCLEC=0 ANDPA=1THEN GOSUB30000:LOCATE4,20:PRINT"La porte est fermee a cle ":LOCATE4,21:PRINT"allez chercher la cle de la cave":PLAY"PPPPPPPPPPPPPPPPPP"
817 IFXC=1 ANDM3=0 THEN GOTO850
818 IFXC=4 ANDM3=0 THEN GOTO550
819 IFXC=7 ANDM3=0 AND PA=1ANDCLEC=1 THEN GOSUB30000:LOCATE4,20:PRINT"La cle que vous possedez ":LOCATE4,21:PRINT"vous permet de penetrer":LOCATE4,22:PRINT"dans la cave":PLAY"PPPPPPPPPPPPPPPPPP":GOTO2100
849 GOTO 810
850 GOSUB25000:GOSUB20000:GOSUB20100:GOSUB30100
859 IF VEND=1THEN ATTRB1,1:COLOR2:LOCATE 19,9:PRINTGR$(50);GR$(51):LOCATE17,11:PRINTGR$(52);GR$(53);GR$(54):LOCATE17,13:PRINTGR$(55);GR$(56);GR$(57):ATTRB0,0:COLOR7
860 GOSUB30000:LOCATE4,20:PRINT"Que faites vous ? ":GOSUB61000
865 IFXC=16 ANDVEND=1THEN GOSUB30000:LOCATE4,20:PRINT"Vous voyez un homme qui vous ":LOCATE4,21:PRINT"salut amicalement et vous propose":LOCATE 4,22:PRINT"d'echanger vos richesses contre ":LOCATE4,23: PRINT"de la nourriture":PLAY"PPPPPPPPPPPPPPPPPPPPPP"
870 IF XC=13ANDVEND=1AND TRESOR=0ANDLINGOT=0THEN PLAY"P":FORI=1TO20:GOSUB26200:NEXTI:VEND=0
871 IF XC=13ANDVEND=1AND TRESOR=1ANDLINGOT=1THEN GOSUB30000:LOCATE4,20:PRINT"Cretin!!vous n'avez rien du tout":PLAY"PPPPPPPPPPPPP"
875 IF XC=4THEN GOTO800
876 IF XC=1THEN GOTO900
899 GOTO 860
900 GOSUB25000:GOSUB20000:GOSUB20100:GOSUB20600:GOSUB20500:GOSUB30100
910 GOSUB30000:LOCATE4,20:PRINT"Oue fait es vous ? ":GOSUB61000
911 IFXC=4THEN850
912 IFXC=1THEN950
913 IFXC=10THEN2000
914 IFXC=7THEN2050
949 GOTO910
950 GOSUB25000:GOSUB20000:GOSUB20600:GOSUB30100
955 IF M4=1THEN COLOR1:GOSUB20700:COLOR7
956 IF PASSAGE=1THEN GOSUB20100
960 GOSUB30000:LOCATE4,20:PRINT"Que fait es vous ? ":GOSUB61000
965 IF XC=1ANDM4=1THEN GOSUB30000:LOCATE 0,20:PRINT"Impossible de passer it faut se battre":PLAY"PPPPPPPPPPPPPP"
966 IF XC=7ANDM4=1THEN GOSUB30000:LOCATE 0,20:PRINT"Impossible de passer it faut se battre":PLAY"PPPPPPPPPPPPPP"
967 IF XC=7ANDM4=0THEN GOTO1000
968 IF XC=1ANDM4=0ANDPASSAGE=1THEN GOTO1100
969 IF XC=16ANDM4=0ANDPASSAGE=0THEN GOSUB20100:GOSUB30000:LOCATE4,20:PRINT"Vous trouvez un passage secret!":PLAY"PPPPPPPPPP":PLAY"DOREDO":SCORE=SCORE+3000:GOSUB 30100:PASSAGE=1
970 IF XC=16ANDM4=1THEN GOSUB30000:LOCATE4,20:PRINT"un horrible robot vous barre ":LOCATE4,21:PRINT"le passage!!!":PLAY"PPPPPPPPPP"
971 IF XC=31ANDM4=1THEN GOSUB30200:GOSUB 30100:IF VIC=1THEN M4=0:SCORE=SCORE+6000:GOSUB30100:PLAY"DOREREDO":CLS:GOTO950
972 IF XC=4ANDM4=0THEN GOTO900
999 GOTO960
1000 GOSUB25000:GOSUB20000:GOSUB20500:GOSUB20600:GOSUB30100:GOSUB26000
1005 IFN2=0 THEN LOCATE20,15:COLOR1:PRINTGR$(13):LOCATE17,15:COLOR3:PRINTGR$(9);GR$(10):LOCATE17,16:COLOR2:PRINTGR$(11);GR$(12):COLOR7:LOCATE4,21
1006 IFCLEA1=0 THEN LOCATE20,17:COLOR5:PRINTGR$(16);GR$(17):COLOR7
1010 GOSUB30000:LOCATE4,20:PRINT"Oue faites vous ? ":GOSUB61000
1011 IFXC=10THEN 950
1012 IFXC=7THEN 1150
1020 IFXC=16 ANDN2=0THEN GOSUB30000:LOCATE4,20:PRINT"Vous voyez de la nourriture ":PLAY"PPPPPPPPPPPP"
1021 IFXC=16 ANDCLEA1=0THEN GOSUB30000:LOCATE4,20:PRINT"Vous voyez une cle mauve ":PLAY"PPPPPPPPPPPP"
1023 IFXC=22THENLOCATE20,15:PRINT" ":LOCATE17,15:PRINT"  ":LOCATE17,16:PRINT"  " :GOSUB30000:LOCATE4,20:PRINT"Soudain vous ressentez une douleur":LOCATE4,21:PRINT"a l'estomac":LOCATE4,22:PRINT"Votre mort est certaine":PLAY"PPPPPPPPPPPPPPPP": GOSUB62000
1025 IF XC=34 AND CLEA1=0THEN LOCATE20,1 7:PRINT"  ":CLEA1=1
1049 GOTO1010
1100 GOSUB25000:GOSUB20000:GOSUB30100:GOSUB26000
1105 IF CLEC=0THEN LOCATE18,15:COLOR4:PRINTGR$(16);GR$(17):COLOR7
1110 GOSUB30000:LOCATE4,20:PRINT"Oue faites vous ? ":GOSUB61000
1111 IFXC=4THEN 950
1112 IF CLEC=0ANDXC=16THEN GOSUB30000:LOCATE4,20:PRINT"Vous voyez la cle de la cave":PLAY"PPPPPPPPPPPPP"
1113 IF CLEC=0ANDXC=34THEN LOCATE18,15:PRINT"  ":GOSUB30000:LOCATE3,20:PRINT"Ave cette cle vous pouvez ":LOCATE3,21:PRINT"esperer ouvrir la porte de la cave":PLAY"PPPPPPPPPPPPPPPPPP":CLEC=1
1114 IF CLEC=1ANDXC=16THEN GOSUB30000:LOCATE4,20:PRINT"Rien de particulier":PLAY "PPPPPPPPPP"
1149 GOTO1110
1150 GOSUB25000:GOSUB20000:GOSUB20500:GOSUB30100:CC=7:GOSUB27000
1160 GOSUB30000:LOCATE4,20:PRINT"Oue faites vous ? ":GOSUB61000
1165 IFXC=10THEN1000
1166 IFXC=16THENGOSUB30000:LOCATE4,20:PRINT"Vous voyez une armoire...":PLAY"PPPPPPPPPPPP"
1167 IFXC=37 ANDCLEA1=0 THENGOSUB30000:LOCATE4,20:PRINT"Cretin vous n'avez pas 1 a cle":PLAY"PPPPPPPPPPPPPP"
1168 IFXC=37 ANDCLEA1=1 THENGOSUB30000:LOCATE4,20:PRINT"vous trouvez la cle du grenier":PLAY"PPPPPPPPPPPPPP"
1169 IFXC=34 ANDCLEA1=1 THENGOSUB30000:LOCATE4,20:PRINT"Grace a cette cle vous allez":LOCATE4,21:PRINT"pouvoir aller au grenier":PLAY"PPPPPPPPPPPPPP":CLEG=1
1199 GOTO1160
2000 CP=7:GOSUB25000:GOSUB20000:GOSUB20600:GOSUB30100:COLOR4:GOSUB29000:COLOR7
2001 IFPASS=1THENGOSUB20500
2010 GOSUB30000:LOCATE4,20:PRINT"Oue faites vous ? ":GOSUB61000
2015 IFXC=16 AND PASS=0 THEN GOSUB30000: LOCATE4,20:PRINT"Vous voyez un lit qui vous parait":LOCATE4,21:PRINT"bien confortable et vous avez ":LOCATE4,22:PRINT"sommeil":PLAY"PPPPPPPPPPPPPPPPPP"
2016 IFXC=28 ANDD=0THEN GOSUB30000:LOCATE4,20:PRINT"Vous venez de faire un bon " :LOCATE4,21:PRINT"roupillon":PLAY"PPPPPPPPPPPPPPPPPP":SCORE=SCORE+3000:PLAY"DOREDO":GOSUB30100:PV=PV+5:PLAY"LASI":GOSUB30100:D=1:PASS=1
2017 IFXC=7THENGOTO900
2018 IFXC=16 ANDPASS=1THEN GOSUB20500:GOSUB30000:LOCATE4,20:PRINT"Vous decouvrez une porte secrete...":LOCATE4,21:PRINT"celle du grenier":PLAY"PPPPPPPPPPPPPPPPPP"
2019 IFXC=10 ANDPASS=1 AND CLEG=1THENGOTO5000
2028 IFXC=10 ANDPASS=1ANDCLEG=0 THEN GOSUB30000:LOCATE4,20:PRINT"Impossible!!Vous n'avez pas la cle":PLAY"PPPPPPPPPPPPPP"
2049 GOTO2010
2050 GOSUB25000:GOSUB20000:GOSUB20500:GOSUB26000:GOSUB30100
2051 IF F4=1THENLOCATE18,16:COLOR7:PRINT GR$(8)
2052 IF F4=0THENLOCATE19,16:PRINT" "
2060 GOSUB30000:LOCATE4,20:PRINT"Oue faites vous ? ":GOSUB61000
2065 IFXC=10THENGOTO900
2066 IF XC=16ANDF4=1THENGOSUB30000:LOCATE4,20:PRINT"Vous voyez 1 fiole":PLAY"PPPPPPPP"
2067 IF XC=25ANDF4=1THENFORI=0TO9:GOSUB26200:NEXTI:F4=0:GOTO2051
2099 GOTO2060
2100 CP=4:GOSUB25000:GOSUB20000:GOSUB20600:GOSUB20500:GOSUB30100
2105 IFM5=1THEN COLOR1:GOSUB 29500:COLOR 4
2110 GOSUB30000:LOCATE4,20:PRINT"Oue faites vous ? ":GOSUB61000
2120 IFXC=16 ANDM5=1THEN GOSUB30000:LOCATE4,20:PRINT"Vous voyez le gardien de la cave":PLAY"PPPPPPPPPPPPPPPP"
2121 IFXC=16 ANDM5=0THEN GOSUB30000:LOCATE4,20:PRINT"Rien de particulier":PLAY"P PPPPPPPPPP"
2122 IFXC=10 ANDM5=1THEN GOSUB30000:LOCATE4,20:PRINT"Impossible!!,il faut se battre":PLAY"PPPPPPPPPPPPP"
2123 IFXC=7 ANDM5=1THEN GOSUB30000:LOCATE4,20:PRINT"Impossible!!,il faut se battre":PLAY"PPPPPPPPPPPPP"
2125 IFXC=10ANDM5=0THEN CP=7:GOTO900
2126 IFXC=31ANDM5=1THEN GOSUB30200:GOSUB 30100:IF VIC=1THEN CLS:SCORE=SCORE+7000: PLAY"DOREDO":M5=0:GOTO2100
2127 IFXC=7 ANDM5=0THEN GOTO3000
2149 GOTO2110
3000 GOSUB25000:GOSUB20000:GOSUB20500:GOSUB20100:GOSUB26000:GOSUB30100
3001 IF F2=0 THEN LOCATE18,16:PRINT" "
3002 IF F2=1 THEN LOCATE18,16:COLOR2:PRINTGR$(8):COLOR7
3010 GOSUB30000:LOCATE4,20:PRINT"Oue fai tes vous ?":GOSUB61000
3020 IFXC=16 ANDF2=1THEN GOSUB30000:LOCATE4,20:PRINT"Vous voyez une fiole contenant":LOCATE4,21:PRINT"un etrange breuvage verdatre":PLAY"PPPPPPPPPPPPPP"
3021 IFXC=25 ANDF2=1THEN GOSUB30000:LOCATE4,20:PRINT"Ce breuvage vous redonne des forces":PLAY"PPPPPPPPPPPPPPPPPP":FORI=0TO10:GOSUB26200:NEXTI:F2=0:GOTO3001
3022 IF XC=10 THEN GOTO2100
3023 IF XC=1 THEN GOTO3050
3049 GOTO3010
3050 GOSUB25000:GOSUB20000:GOSUB26000:GOSUB20300:GOSUB30100
3051 IF CLEO=0THEN LOCATE17,16:COLOR1:PRINTGR$(14);GR$(15):COLOR7
3052 IF CLEO=1THEN LOCATE17,16:PRINT" "
3060 GOSUB30000:LOCATE4,20:PRINT"Oue faites vous ? ":GOSUB61000
3061 IF XC=16 AND CLEO=0 THEN GOSUB30000 :LOCATE4,20:PRINT"Vous voyez une cle":PLAY"PPPPPPPPPPPPPPPP"
3062 IF XC=16 THEN GOSUB30000:LOCATE4,20 :PRINT"Vous voyez un message":PLAY"PPPPPPPPPPPPPPPP"
3063 IF XC=34 ANDCLEO=0 THEN CLEO=1:GOTO 3051
3064 IF XC=19 THEN GOSUB30800:GOTO3050
3065 IF XC=4 THEN GOTO3000
3099 GOTO3060
5000 CP=1:GOSUB25000:GOSUB20000:GOSUB20500:GOSUB20600:GOSUB30100:IFM6=1THENGOSUB 29500
5001 GOSUB30100
5010 GOSUB30000:LOCATE4,20:PRINT"Oue faites vous ? ":GOSUB61000
5020 IFXC=10ANDM6=1THENGOSUB30000:LOCATE 4,21:PRINT"Impossible de passer. Il faut combattre":PLAY"PPPPPPPP":GOTO5010
5021 IFXC=10ANDM6=0THENGOTO5050
5022 IFXC=7 THENGOTO2000
5023 IFXC=16ANDM6=1THENGOSUB30000:LOCATE 4,20:PRINT"Un robot se tient face a vous ":LOCATE4,21:PRINT"et vous barre la route":PLAY"PPPPPPPPPPP":GOSUB5010
5030 IFXC=31ANDM6=1THENGOSUB30200
5035 IFVIC=1THEN M6=0:CLS:VIC=0:GOTO5000
5049 GOTO2060
5050 GOSUB25000:GOSUB20000:GOSUB20600:GOSUB20100:GOSUB26000:GOSUB30100
5051 IF F3=1THENLOCATE19,16:COLOR3:PRINTGR$(8):COLOR7
5052 IF F3=0THENLOCATE18,16:PRINT" "
5060 GOSUB30000:LOCATE4,20:PRINT"Que fai tes vous ? ":GOSUB61000
5066 IF XC=16ANDF3=1THENGOSUB30000:LOCATE4,20:PRINT"Vous voyez 1 fiole":PLAY"PPPPPPPP"
5067 IF XC=25ANDF3=1THENGOSUB62000
5070 IFXC=1THENGOTO5150
5080 IFXC=7THENGOTO5000
5090 GOTO5060
5150 GOSUB25000:GOSUB20000:GOSUB20100:GOSUB30100
5160 GOSUB30000:LOCATE4,20:PRINT"Que faites vous ? ":GOSUB61000
5175 IFXC=16THENGOSUB30000:LOCATE4,20:PRINT"Vous vous trouvez face a la porte":LOCATE4,21:PRINT"qui donne sur la sortie!!!!!":PLAY"PPPPPPPPPPPPPPPPPPPPP"
5180 IFE=1ANDCLEO=0THENGOSUB30000:LOCATE4,20:PRINT"Abruti vous n'avez pas la cle":PLAY"PPPPPPPPPPPPPPPPPPP"
5181 IFXC=4THENGOTO5050
5182 IFXC=1ANDCLEO=1THENGOTO39000
5190 GOTO5160
19999 END:' SOUS FR06RAMMES ++
20000 CLS:BOX (128,40)-(192,104),CP
20001 LINE(128,40)-(8,24),CP
20002 LINE(192,40)-(304,24),CP
20003 LINE(192,104)-(304,160),CP
20004 LINE(128,104)-(8,160),CP
20005 LINE(8,24)-(8,160),CP
20006 LINE(304,24)-(304,160),CP
20007 RETURN
20100 BOX(144,64)-(176,104),CP:RETURN
20300 COLOR3:LOCATE19,9:PRINTGR$(58);GR$(59)
20301 LOCATE19,10:PRINTGR$(60);GR$(61):COLOR7:RETURN
20400 CLS:SCREEN0,7,1:LOCATE7,7:PRINT"Vous venez de penetrer dans"
20401 LOCATE7,9:PRINT"LE MANOIR DES ROBOTS . Mefiez "
20402 LOCATE7,11:PRINT"vous !!..."
20403 LOCATE7,13:PRINT"Chaque pas que vous faites est"
20404 LOCATE7,15:PRINT"un pas de plus vers la mort":FORI=1TO2500:NEXTI:CLS:SCREEN7,0,0:RETURN
20500 LINE(72,64)-(72,128),CP
20501 LINE(72,64)-(40,64),CP
20502 LINE(40,64)-(40,144),CP:RETURN
20600 LINE(272,64)-(272,144),CP
20601 LINE(272,64)-(240,64),CP
20602 LINE(240,64)-(240,128),CP:RETURN
20700 ATTRB1,1:LOCATE19,12:PRINTGR$(0);GR$(1)
20701 LOCATE17,14:PRINTGR$(2);GR$(3);GR$(4)
20702 LOCATE17,16:PRINTGR$(5);GR$(6);GR$(7):ATTRB0,0:RETURN
20750 ATTRB1,1:LOCATE19,12:PRINTGR$(19)
20751 LOCATE17,14:PRINTGR$(20);GR$(21);GR$(22)
20752 LOCATE17,16:PRINTGR$(23);GR$(24);GR$(25):ATTRB0,0:RETURN
20800 LOCATE17,15:COLORI:PRINTGR$(13):PLAY"PPPPPPPPPPP":RETURN
23320 ,0,0,14,31
25000 PV=PV-1:SCOPE=SCORE+300:A=INT(RND*2):B=INT(RND*3)
25100 A=INT(RND*2):RETURN
26000 LINE(128,152)-(128,144),2
26001 LINE(128,144)-(136,112),2
26002 LINE(136,112)-(184,112),2
26003 LINE(184,112)-(190,144),2
26004 LINE(190,144)-(190,152),2
26005 LINE(190,144)-(128,144),2:RETURN 
26100 B=INT(RND*3):IFB>0THENPLAY"P":FORSS=0TO10:GOSUB26200:NEXTSS:F=0
26101 IFB=0THENPLAY"P":GOSUB30000:LOCATE 4,20:PRINT"Vous ne suportez pas l'alcool ":LOCATE4,22:PRINT"vous etes ivre":PLAY"PPPPPPPPPPPPPP":FORI=1TO 10:GOSUB26300:NEXTI
26102 RETURN
26150 MA=INT(RND*4):IFMA>0THENPLAY"P":FORSS=0TO10:GOSUB26200:NEXTSS:F=0
26200 PV=PV+1:PLAY"DO":GOSUB30100:RETURN
26300 PV=PV-1:PLAY"SI":GOSUB30100:RETURN
26400 SCORE=SCORE+300:PLAY"P":BEEP:GOSUB 30100:RETURN
27000 LINE(232,64)-(232,122),CC:LINE(232,64)-(208,64),CC:LINE(208,64)-(208,112), CC:LINE(220,64)-(220,117),CC:RETURN
27100 ATTRB1,1:COLORMM:LOCATE17,10:PRINTGR$(26);GR$(27);GR$(28):LOCATE17,12:PRINTGR$(29);GR$(30);GR$(31):LOCATE17,14:PRINTGR$(32);GR$(33);GR$(34):COLOR7:ATTRBO,0:RETURN
29000 BOX(144,88)-(184,112):BOX(136,144)-(192,152):BOX(144,88)-(184,104):LINE(136,144)-(136,158):LINE(192,144)-(192,158):LINE(144,104)-(136,144):LINE(184,104)-(192,144):RETURN
29500 ATTRB1,1:LOCATE17,10:PRINTGR$(41);GR$(42);GR$(43):LOCATE17,12:PRINTGR$(44);GR$(45);GR$(46):LOCATE17,14:PRINTGR$(47);GR$(48);GR$(49):ATTRB0,0:RETURN
30000 B=INT(RND*3):A=INT(RND*2):GOSUB25100:BOXF(0,160)-(320,200),0:GOSUB30100:RETURN
30100 'SCORE
30110 LOCATE4,1:COLOR1:PRINT"Score: ";SCORE:LOCATE27,1:COLOR4:PRINT"PV: ";PV:COLOR7
30111 IFPV=<0THEN GOSUB62000
30112 RETURN
30200 GOSUB30000
30300 IFA>=1THENP=P+1:LOCATE4,21:COLOR1: PRINT"Vous l'avez touche !!!!":SCORE=SCORE+10:GOSUB30100:COLOR7:PLAY"PPPPPP"
30310 IFA=0THENP=P-1:LOCATE4,21:COLOR4:PRINT"Il vous a touche!!!!!":PV=PV-1:GOSUB30100:COLOR7:PLAY"PPPPP"
30320 IFP=0THENP=3:PV=PV-1:GOSUB30100
30330 IFP=5THENP=3:SCORE=SCORE+400:GOSUB 30100:GOSUB30000:LOCATE4,21:PRINT"VOUS AVEZ GAGNE":VIC=1:PLAY"PPPPPPP":PV=PV+1:RETURN
30340 IFPV=<0THEN COLOR5:LOCATE4,21:GOSUB62000
30350 GOTO30200:RETURN
30700 CLS:SCREEN0,7,2:LOCATE5,12:PRINT"N'hesitez pas a REGARDER 2 fois...":LOCATE5,14:PRINT"dans certaines pieces" :PLAY "PPPPPPPPPPPPPPPPPPP":CLS:SCREEN7,0,0:RETURN
30800 CLS:SCREEN0,7,4
30801 LOCATE4,11:PRINT"Cette cle vous permettra de "
30802 LOCATE4,13:PRINT"sortir de ce manoir de malheur"
30804 LOCATE4,15:PRINT"La sortie se trouve au grenier":PLAY"PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP":CLS:SCREEN0,0,0:RETURN
30900 CLS:SCREEN0,0,0
30901 LOCATE0,4:ATTRB1,0:COLOR1:PRINT"Le manoir des robots"
30902 LOCATE2,9:ATTRBO,0:COLOR5:PRINT"Appretez vous a"
30903 LOCATE2,11:ATTRB0,0:COLOR5:PRINT"penetrez dans "
30904 LOCATE2,13:ATTRB0,0:COLOR5:PRINT"ce sinistre manoir...":COLOR0:GOSUB62590::GOTO10
32000 BOX(200,136)-(224,152),CC
32001 LINE(168,136)-(200,152),CC:LINE(208,128)-(200,136),CC:LINE(208,128)-(176,112),CC:LINE(216,128)-(208,128),CC:LINE(168,136)-(168,120),CC:LINE(168,120)-(200, 136),CC
32002 LINE(216,128)-(224,136),CC:LINE(184,112)-(216,128),CC:LINE(176,112)-(184,112),CC:LINE(168,120)-(176,112),CC:RETURN
32100 BOX(120,140)-(160,144),CL:BOX(128,136)-(152,144),CL:BOX(136,132)-(144,144),CL:RETURN
39000 CLS:SCREEN0,0,0
39001 LOCATE2,0:COLOR1:ATTRB1,0:PRINT"Score:";SCORE
39002 LOCATE2,9:COLORS:ATTRB0,0:PRINT"FELICITATIONS!!!!!"
39003 LOCATE2,13:COLOR4:PRINT"Vous etes le seul a etre sorti"
39004 LOCATE2,15:COLOR4:PRINT"vivant du tristement celebre"
39005 LOCATE2,17:COLOR2:PRINT"Manoir des robots":COLOR0:GOSUB 62590
59999 ' ++ CARACTERES GRAPHIOUES ++
60000 DEFGR$(0)=60,126,219,255,255,231,126,60
60001 DEFGR$(1)=0,0,0,0,0,0,0,32
60002 DEFGR$(2)=15,15,15,13,13,13,12,8
60003 DEFGR$(3)=255,255,255,255,255,255,255,60
60004 DEFGR$(4)=240,240,240,176,176,176,48,16
60005 DEFGR$(5)=0,1,7,15,31,15,7,2
60006 DEFGR$(6)=255,255,255,255,255,255,0,0
60007 DEFGR$(7)=0,128,224,240,248,240,224,64 
60008 DEFGR$(8)=60,24,24,60,126,126,126,60
60009 DEFGR$(9)=0,0,3,3,7,15,26,21
60010 DEFGR$(10)=0,0,192,192,224,240,168,88
60011 DEFGR$(11)=31,127,128,255,128,255,128,255
60012 DEFGR$(12)=248,254,3,255,1,255,1,255
60013 DEFGR$(13)=24,24,24,36,36,60,60,60
60014 DEFGR$(14)=0,0,0,63,127,58,0,0
60015 DEFGR$(15)=12,30,63,255,255,255,30,12
60016 DEFGR$(16)=0,0,0,255,255,112,112,112
60017 DEFGR$(17)=28,62,119,227,227,119,62,28
60018 DEFGR$(18)=0,0,0,0,0,0,14,31
60019 DEFGR$(19)=126,255,219,255,126,102,126,60
60020 DEFGR$(20)=31,31,31,14,14,14,14,4
60021 DEFGR$(21)=255,255,126,126,126,126,126,126
60022 DEFGR$(22)=248,248,248,112,112,112,112,32
60023 DEFGR$(23)=0,0,1,3,7,7,7,31
60024 DEFGR$(24)=255,255,195,129,0,0,0,0
60025 DEFGR$(25)=0,0,128,192,224,224,224,248
60026 DEFGR$(26)=0,0,0,0,0,0,192,156
60027 DEFGR$(27)=255,219,255,255,102,60,24,24
60028 DEFGR$(28)=0,0,0,0,0,0,3,57
60029 DEFGR$(29)=255,63,63,62,28,28,28,8
60030 DEFGR$(30)=255,255,255,255,126,126,60,24
60031 DEFGR$(31)=255,252,252,124,56,56,56,16
60032 DEFGR$(32)=3,3,1,0,0,3,3,3
60033 DEFGR$(33)=255,255,255,255,126,60,255,0
60034 DEFGR$(34)=192,192,128,0,0,192,192,192
60041 DEFGR$(41)=0,0,7,7,7,1,0,0
60042 DEFGR$(42)=126,255,153,255,255,231,255,60
60043 DEFGR$(43)=0,0,224,224,224,129,0,0
60044 DEFGR$(44)=3,255,255,123,121,120,48,120
60045 DEFGR$(45)=255,255,255,255,255,126,60,60
60046 DEFGR$(46)=192,255,255,254,158,30,12,30
60047 DEFGR$(47)=252,120,3,7,3,1,0,3
60048 DEFGR$(48)=126,231,195,129,129,195,195,195
60049 DEFGR$(49)=63,30,192,224,192,0,128,192 
60050 DEFGR$(50)=60,126,219,255,255,195,126,60
60051 DEFGR$(51)=0,0,6,6,6,6,14,28
60052 DEFGR$(52)=0,15,31,63,51,49,112,96
60053 DEFGR$(53)=24,255,255,255,255,255,255,126
60054 DEFGR$(54)=60,248,240,224,192,128,0,0
60055 DEFGR$(55)=96,0,0,1,1,1,1,7
60056 DEFGR$(56)=126,255,231,135,195,129,129,129
60057 DEFGR$(57)=0,0,0,0,128,128,128,224
60058 DEFGR$(58)=0,7,15,15,31,31,25,31
60059 DEFGR$(59)=0,254,254,190,252,252,92,252
60060 DEFGR$(60)=63,52,63,127,98,127,252,255
60061 DEFGR$(61)=248,152,248,240,176,240,96,224:RETURN
60999 '+++CHOIX(Par manette/clavier)+++
61000 GOSUB61500:POKE&H6073,1
61001 LOCATE0,20:C$=INKEY$:A=STICK(0)
61010 IFA=3ANDX<36THENX=X+3:B=INT(RND*3):XC=XC+3:GOSUB61500:GOSUB61600
61011 IFC$="."ANDX<36THENX=X+3:B=INT(RND*3):XC=XC+3:GOSUB61500:GOSUB61600
61019 IFC$=","ANDX>0 THENX=X-3:B=INT(RND*3):XC=XC-3:GOSUB61500:GOSUB61700
61020 IFA=7ANDX>0 THENX=X-3:XC=XC-3:B=INT(RND*3):GOSUB61500:GOSUB61700
61021 COLOR5:LOCATE1,22:PRINT"N":COLOR7
61022 COLOR3:LOCATE16,22:PRINT"R":COLOR7
61023 COLOR5:LOCATE4,22:PRINT"S":COLOR7
61024 COLOR5:LOCATE7,22:PRINT"E":COLOR7
61025 COLOR5:LOCATE10,22:PRINT"O":COLOR7
61026 COLOR3:LOCATE19,22:PRINT"L":COLOR7
61027 COLOR3:LOCATE22,22:PRINT"M":COLOR7
61028 COLOR3:LOCATE25,22:PRINT"B":COLOR7 
61029 COLOR3:LOCATE28,22:PRINT"D":COLOR7
61030 COLOR3:LOCATE31,22:PRINT"A":COLOR7
61031 COLOR3:LOCATE34,22:PRINT"P":COLOR7
61032 COLOR3:LOCATE37,22:PRINT"O":COLOR7
61033 COLOR3:LOCATE13,22:PRINT"E":COLOR7
61040 IFXC=1AND(STRIG(0)=-1ORC$=CHR$(32))THEN LOCATE24,20:COLOR5:PRINT"NORD":PLAY"PPPP":RETURN
61041 IFXC=16AND(STRIG(0)=-1ORC$=CHR$(32))THEN LOCATE24,20:COLOR3:PRINT"REGARDE":PLAY"PPPP":RETURN
61043 IFXC=4AND(STRIG(0)=-1ORC$=CHR$(32))THEN LOCATE24,20:COLOR5:PRINT"SUD":PLAY"PPPP":RETURN
61044 IFXC=7AND(STRIG(0)=-1ORC$=CHR$(32))THEN LOCATE24,20:COLOR5:PRINT"EST":PLAY"PPPP":RETURN 
61045 IFXC=10AND(STRIG(0)=-1ORC$=CHR$(32))THEN LOCATE24,20:COLOR5:PRINT"OUEST":PLAY"PPPP":RETURN
61046 IFXC=19AND(STRIG(0)=-1ORC$=CHR$(32))THEN LOCATE24,20:COLOR3:PRINT"LIT":PLAY"PPPP":RETURN
61047 IFXC=22AND(STRIG(0)=-1ORC$=CHR$(32))THEN LOCATE24,20:COLOR3:PRINT"MANGE":PLAY"PPPPP":RETURN
61048 IFXC=25AND(STRIG(0)=-1ORC$=CHR$(32))THEN LOCATE24,20:COLOR3:PRINT"BOIT":PLAY"PPPP":RETURN
61049 IFXC=28AND(STRIG(0)=-1ORC$=CHR$(32))THEN LOCATE24,20:COLOR3:PRINT"DORT":PLAY"PPPP":RETURN
61050 IFXC=31AND(STRIG(0)=-1ORC$=CHR$(32))THEN LOCATE24,20:COLOR3:PRINT"ATTAQUE":PLAY"PPPP":RETURN
61051 IFXC=34AND(STRIG(0)=-1ORC$=CHR$(32))THEN LOCATE24,20:COLOR3:PRINT"PREND":PLAY"PPPP":RETURN 
61052 IFXC=37AND(STRIG(0)=-1ORC$=CHR$(32))THEN LOCATE24,20:COLOR3:PRINT"OUVRE":PLAY"PPPP":RETURN
61053 IFXC=13AND(STRIG(0)=-1ORC$=CHR$(32))THEN LOCATE24,20:COLOR3:PRINT"ECHANGE":PLAY"PPPP":RETURN
61480 GOTO61001
61490 END
61500 LOCATEX,Y:PRINT"***"
61510 LOCATEX,Y+2:PRINT"***":RETURN
61600 LOCATEX-3,Y:PRINT"   "
61610 LOCATEX-3,Y+2:PRINT"   ":RETURN
61700 LOCATEX+3,Y:PRINT"   "
61710 LOCATEX+3,Y+2:PRINT"   ":RETURN
61999 '+++++ MORT ++++++++++++++++++++
62000 CLS:SCREEN7,7,7:SCREEN1,1,1:SCREEN0,0,0:SCREEN0,7,7:SCREEN7,7,7
62100 LINE(128,72)-(144,24),0:LINE(144,24)-(176,24),0:LINE(176,24)-(192,72),0:LINE(192,72)-(176,194),0:LINE(176,184)-(144,184),0
62101 LINE(144,184)-(128,72),0:BOXF(159,48)-(161,112),0:BOXF(144,71)-(176,73),0:BOX(144,184)-(176,199),0:LINE(192,72)-(192,104),0
62102 LINE(192,104)-(177,200),0:LINE(128,72)-(128,104),0:LINE(128,104)-(143,200),0:LOCATE0,0:ATTRB0,1
62499 '+++++++++ MUSIQUES ++++++++
62500 PLAY"O2T19L24FAL36FAL12SOL24MIL48MIL24LAL36LAL12SIbL24SOL36SOL12LAL24SIbL36SIbO3L12DOO2L24LAL36LAL12T18A0LAO3REDO#REMIL24FAL12MIREL24REO2L48RE":COLOR1:ATTRB1,0:LOCATE0,0:PRINT"score:";SCORE:COLOR7:END
62590 FORI=1TO2:GOSUB62600:NEXTI:GOSUB62610:RETURN 
62600 PLAY"A0T9O3L30SOO4L12DOL30MIO3L12SOO4L18FAL12MIL36O3SOL12O4DOL18FAL12MIL30O3SOL12O4MIL48MIL42RE"
62601 PLAY"T9O3L30SOO4L12DOL30MIO3L12SOO4L18FAL12MIL36O3SOL12O4DOL18FAL12MIL30O3SOL12O4MIL48MIRE"
62602 PLAY"A1T9O3L10SIO4DOO3SIO4DOL30O3LA"
62603 PLAY"T9O4L10DOO3L10SIO4DOO3SIO4DOL30O3LAO4L10DOO3SIO4DOO3SIO4DOL20FAMIREDOO3L60SI":RETURN
62610 PLAY"T9L50O2DOT9O5L10MIL20FAL10MIL10O2REMIFAO4MIREMIT9L50DOT9O5L10MIL30FAL10REO1MIFAO2MIREMIT9L50DOT9L10REO3MIFAMIREMIT20T5O1L96DOL2REMIFASOLASIO2DOREMIFASOLASIO3DOREMIFASOLASIDO"
62611 PLAY"O4DOREMIFASOLASIDOO5DOREMIFASOLASISI#L12O5SIbLASO#SOFA#FAMIRE#REDO#DOO4SILA#LASO#SOFA#FA#MIMI#REDO#DOO3SILA#LASO#SOFA#FAMIRE#REDO#DOO3SILA#LASO#SOFA#FAMIRE#REDO#O1T10L96DO":RETURN
