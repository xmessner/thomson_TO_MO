/******
*
* 21/06: beta workflow action
*
*******/
#include <string.h>
#include <libgen.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <sys/stat.h>
#include "gencass.h"

// TODO Faire attention à la taille maxi d'une image cassette si gros listing ou plusieurs fichiers à intégrer
// TODO Rajouter le cas d'un nom de fichier TO7 avec un espace, c'est possible.
// TODO Vérifier les commentaires sur la structure de la K7
// TODO Ecrire la documentation

// Détermine si un caractère est affichable ou non
unsigned char isPrintable(unsigned char car) {
	unsigned char resCar=0;
	if (car > 0x1F && car < 0x7E ) {
		resCar=car;
	} else {
		resCar='.';
	}
	
	return resCar;
}

BlocData *mallocBlocData(long size) {
	BlocData *bloc=NULL;

	bloc=(BlocData*)malloc(sizeof(struct BLOCDATA));

	if(bloc != NULL) {
		bloc->buffer=(unsigned char *)malloc(size);
		if (bloc->buffer != NULL) {
			memset(bloc->buffer,0,size);
			bloc->crc=0;
			bloc->bsize=size;
		} else {
			printf("Erreur dans l'allocation d'un bloc de %ld octets\n",size);
			exit(1);
		}
	} else {
		printf("Erreur dans l'allocation de la structure BlocData\n");
		exit(1);
	}

	return bloc;
}
// Libère un bloc BLOCDATA
void freeBlocData(BlocData *bloc) {
	if (bloc->buffer != NULL) {
		free(bloc->buffer);
	}
	if (bloc != NULL) {
		free(bloc);
	}
}

// Affiche une zone de mémoire au format hexadecimal
void dumpMemory(unsigned char *buffer, long size) {

	printf("size: %ld\n",size);
	printf("_____ | 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F  | ________________\n");
	for(int i=0; i<size; i+=16) {
		printf("%05d : ",i);
		for (int j=0;j<16;j++) {
			if (i+j < size) {
				printf("%02x ",buffer[i+j]);
			} else {
				printf("** ");
			}
		}
		printf(" | ");
		for (int j=0;j<16;j++) {
			if (i+j < size) {
				printf("%c",isPrintable(buffer[i+j]));
			} else {
				printf("~");
			}
		}
	printf("\n");
	}
}

// Affiche au format hexadecimal un bloc de donnée au format BLOCDATA
void dumpBloc(BlocData *bloc) {
	dumpMemory(bloc->buffer,bloc->bsize);
	printf("CRC: [ HEX %x / DEC %d ]\n",bloc->crc,bloc->crc);
}

// Chargement du fichier et le convertit au format attendu
BlocData *loadListing(char *file){
	FILE *fic=NULL;
	long fsize=0;
	unsigned char *buffer=NULL;
	BlocData *bloc=NULL;

	fic=fopen(file,"r");

	// Calcul de la taille du fichier
	fseek(fic,0,SEEK_END);
	fsize=ftell(fic);
	fseek(fic,0,SEEK_SET);

	buffer=malloc(fsize);
	fread(buffer, fsize, 1, fic);
	fclose(fic);

	bloc=convertToDos(buffer, fsize);
	free(buffer);
	return bloc;
}

unsigned char *utf8ToTO770(unsigned char car){
	unsigned char *cvt;

	cvt=(unsigned char *)malloc(3);
	memset(cvt,0,3);

	switch(car) {
/*		//ä
		case 0xa4:
			cvt = 
			break;
*/
		//â
		case 0xa2:
			cvt[0]=0x16;
			cvt[1]=0x43;
			cvt[2]=0x61;
			break;
		//à
		case 0xa0:
			cvt[0]=0x16;
			cvt[1]=0x41;
			cvt[2]=0x61;
			break;
		//ë
		case 0xab:
			cvt[0]=0x16;
			cvt[1]=0x48;
			cvt[2]=0x65;
			break;
		//ê
		case 0xaa:
			cvt[0]=0x16;
			cvt[1]=0x43;
			cvt[2]=0x65;
			break;
		//é
		case 0xa9:
			cvt[0]=0x16;
			cvt[1]=0x42;
			cvt[2]=0x65;
			break;
		//è
		case 0xa8:
			cvt[0]=0x16;
			cvt[1]=0x41;
			cvt[2]=0x65;
			break;
		//ï
		case 0xaf:
			cvt[0]=0x16;
			cvt[1]=0x48;
			cvt[2]=0x69;
			break;
		//î
		case 0xae:
			cvt[0]=0x16;
			cvt[1]=0x43;
			cvt[2]=0x69;
			break;
		//ö
		case 0xb6:
			cvt[0]=0x16;
			cvt[1]=0x48;
			cvt[2]=0x6F;
			break;
		//ô
		case 0xb4:
			cvt[0]=0x16;
			cvt[1]=0x43;
			cvt[2]=0x6F;
			break;
		//ü
		case 0xbc:
			cvt[0]=0x16;
			cvt[1]=0x48;
			cvt[2]=0x75;
			break;
		//û
		case 0xbb:
			cvt[0]=0x16;
			cvt[1]=0x43;
			cvt[2]=0x75;
			break;
		//ù
		case 0xb9:
			cvt[0]=0x16;
			cvt[1]=0x41;
			cvt[2]=0x75;
			break;
		//ç
		case 0xa7:
			cvt[0]=0x16;
			cvt[1]=0x4b;
			cvt[2]=0x63;
			break;
	}
	return cvt;
}

long calculTailleTO7Texte(unsigned char *buffer, long bSize){
	long size=0;
	long i=0;
	unsigned char car=0;

	for ( i=0; i< bSize; i++ ){
		car=buffer[i];

		// On rajoute 2 car l'encodage TO7 travaille sur 3 octets (2 pour le controle et 1 pour le caractère à accentuer)
		// en UTF8 on a que 2 caractère, le caractère de contrôle et le code correspondant
		if ( car == 0xc3 ) {
			size+=2;
		} else {
			size++;
		}
	}
	return size;
}

// Convertit un fichier unix au format attendu.
// Ne convertit que le 0xa en 0xd.
BlocData *convertToDos(unsigned char *buffer, long bSize){
	long i=0,j=0;
	unsigned char *cvtBuffer=NULL;
	unsigned char car=0,last=0;
	unsigned char utf8Found=0;
	unsigned char *string=NULL;
	long size=0;
	BlocData *bloc=NULL;

	size=calculTailleTO7Texte(buffer,bSize);
	cvtBuffer=(unsigned char *)malloc(size);
	memset(cvtBuffer,0xFF,size);

	for (i=0;i<bSize;i++){
		// On convertit les 0x0A en 0x0D
		// si plusieurs valeurs 0x0A ou 0x0D trouvées, on continu sans en tenir compte
		car=buffer[i];
		switch(car){
			case 0x0a:
				if(last == 0){
					cvtBuffer[j]=0x0d;
					j++;
					last=1;
				}
				break;
			case 0xd:
				if(last == 0){
					cvtBuffer[j]=car;
					j++;
					last=1;
				}
				break;
			// Cas d'un texte en UTF8
			case 0xc3:
				//On ne traite pas le caractère, on passe au suivant
				utf8Found=1;
				break;
			default:
				if(utf8Found == 1) {
					utf8Found=0;
					string=utf8ToTO770(car);

					cvtBuffer[j++]=string[0];
					cvtBuffer[j++]=string[1];
					cvtBuffer[j++]=string[2];

					free(string);
				} else {
					cvtBuffer[j]=car;
					j++;
					last=0;
				}
				break;
		}
	}
	bloc=mallocBlocData(j);
	memcpy(bloc->buffer,cvtBuffer,j);
	free(cvtBuffer);
	return bloc;
}

// On récupère le nom du fichier et on suppose que le nom se termine avec une extention
char *stripName(char *fileName){
	char *file=NULL;
	int sizeOfString=0;
	char *strippedFile=NULL;
	int i=0;
	int length=0;
	unsigned char car=0;

	sizeOfString=strlen(fileName);
	file=basename(fileName);
	// Calcul la taille du nom de fichier sans l'extension. Extension commence par un point: .ext
	// Si pas d'extension, on attend la fin de la chaine \0
	for (i=0;i<sizeOfString;i++){
		car=file[i];		
		if (car != 0x2e && car != 0){
			length++;
		} else {
			break;
		}
	}
	strippedFile=malloc(length+1);
	memcpy(strippedFile,file,length);
	strippedFile[length]=0;

	return strippedFile;
}

// Convertis le nom du fichier en entrée au format 8+3
unsigned char *convertName(char *longFileName){
	unsigned char fileName[11]="        BAS";
	unsigned char *k7Name=NULL;
	char *stringUp=NULL;
	char *strippedName=NULL;

	// Supprime l'extension de fichier
	strippedName=stripName(longFileName);

	// Mise en majuscule
	stringUp=upperCase(strippedName);
	free(strippedName);

	// Formatage du nom de fichier
	k7Name=malloc(11);
	memcpy(k7Name,stringUp,_MAXCAR);
	free(stringUp);
	memcpy(&k7Name[8], &fileName[8],3);

	return k7Name;
}

// Calcule simple d'un CRC comme attendu par le format k7
// On ajoute chacun des octects à la valeur précédente et on applique un masque 0xFF
// pour ne garder que la valeur du premier octet
unsigned char calculCRC(unsigned char *string,long length){
	int idx=0;
	unsigned char crc=0;

	for (idx=0;idx < length; idx++) {
		crc=(crc+string[idx]) & 0xFF;
	}
	return crc;
}

// Convertis une chaine en majuscule
char *upperCase(char *string){
	unsigned int idx=0,newIdx=0,car=0;
	unsigned int sizeOfString=0;
	char *newString=NULL;

	sizeOfString=strlen(string);
	newString=malloc(_MAXCAR);
	memset(newString,0x20,_MAXCAR);

	for(idx=0; idx<sizeOfString; idx++) {
		car=string[idx];
		// a-z
		if((car >= 0x61) && (car <= 0x7A)){
			newString[newIdx]=car-0x20;
			newIdx++;
		}
		// A-Z 0-9
		if(((car >=0x41) && (car <= 0x5A)) || ((car >= 0x30) && (car <= 0x39))){
			newString[newIdx]=car;
			newIdx++;
		}
		if( newIdx == _MAXCAR ){
			break;
		}
	}
	return newString;
}
void printHelp(char *argv[]){
	printf("%s: Produit une image de cassette TO7 à partir de fichiers\n",argv[0]);
	printf("    -t [fichier] : Déclare un fichier texte\n");
	printf("    -b [fichier] : Déclare un fichier binaire\n");
	printf("    -l [fichier] : Liste le contenu de la cassette lorsque c'est possible\n");
	printf("    -d [fichier] : Affiche les informations techniques\n");
	printf("    -o [fichier] : Nom du fichier de sortie, out.k7 par défaut.\n");
	printf("    -c [fichier] : Vérifie un fichier k7\n");
	printf("    -e [fichier] : Extrait les fichiers de la cassette sur disque\n");
	printf("\nDrapeaux\n");
	printf("    -a Mode APPEND, ajoute un fichier à la fin de la cassette\n");
	printf("    -f Force l'écriture du fichier de sortie si il existe déjà\n");
	printf("    -h Affiche l'aide\n");
	printf("\n");   
}

void printHelpTemp(char *argv[]) {
	printf("usage: %s [input.txt] [output.k7]\n",argv[0]);
	printf("\n");
}

// Création du header en fonction du type de bloc
// type 0 : Premier header à 15 octets
// type 1 : Headers suivants à 14 octets

unsigned char *forgeHeader(int size, int type) {
	unsigned char *data=NULL;

	if( type == 1 ) {
		data=(unsigned char*)malloc(15);
		memcpy(data,header,15);
		data[12]=0x01;
		data[13]=size & 0xFF;
		data[14]=0x0D;
	} else {
		data=(unsigned char*)malloc(14);
		memcpy(data,header,14);
		data[13]=size & 0xFF;
	}
	return data;
}

// Retourne uniquement un bloc de données avec un crc équivalent
BlocData *chunckBloc(unsigned char *data, long size) {
	BlocData *bloc=NULL;

	bloc=mallocBlocData(size);
	memcpy(bloc->buffer,data,size);
	bloc->crc=calculCRC(data,size);

	return bloc;
}
// convertit un fichier texte au format TO7
BlocData *fileToBloc(char *file) {
	BlocData *fileData=NULL;		// Données source
	BlocData *to7Bloc=NULL;		// Données à retourner
	BlocData *tmpBloc=NULL;		// Bloc temporaire forgé
	unsigned char *dataHeader=NULL;	// header du bloc
	int lastBloc=0;			// Indique si dernier bloc
	int firstBloc=1;		// Si premier bloc
	int tailleFirstHeader=15;	// Taille header du premier bloc
	int tailleNextHeader=14;	// Taille header des blocs suivants
	int tailleHeader=0;		// VAR prendra la valeur du header du moment
	int size=0;			// Taille du bloc cassette final
	int idxBloc=0;			// index du bloc courant
	int type=0;			// type : 0 -> second bloc et suivants, 1 -> premier bloc
	int partSize=0;			// taille du bloc en cours
	int tailleBloc=255;		// Taille max d'un bloc de données
	int nbBlocs=0;			// nombre de blocs à créer
	int nbCrc=0;			// nombre de crc à présents
	int tailleChunk=0;		// Taille du bloc à l'instant T
	int crc=0,crc2=0;			// valeur d'un crc de bloc
	int addCRC=0;			// VAR valeur à rajouter au CRC calculé
	int sizeTmp=0;			// VAR temporaire pour calcul d'une taille
	unsigned char *ptrBloc=NULL;		// pointeur sur le bloc à générer
	unsigned char *ptrFile=NULL;		// pointeur sur le bloc du fichier texte
	
	// Chargement des données
	fileData=loadListing(file);

	// Réservation mémoire pour la structure

	// calcul du nombre de bloc, on rajoute 1 car toujours au moins 1 bloc à traiter
	nbBlocs=(fileData->bsize / tailleBloc) + 1;
	// Tout les blocs ont un CRC
	nbCrc=nbBlocs;

	// La taille du bloc cassette est calculée ainsi
	// taille du fichier texte
	// + taille du premier header
	// + (nbBlocs - 1 -> on ne compte pas le premier header qui est ajouté au dessus) * taille des headers suivants = peut être égale à 0 si cassette d'un seul bloc
	// + nombre de CRCs
	size = fileData->bsize + tailleFirstHeader + ((nbBlocs-1) * tailleNextHeader) + (nbCrc);

	// Préparation du bloc cassette
	to7Bloc=mallocBlocData(size);

	// Assignation des pointeurs sur les 2 zones mémoires
	ptrBloc=to7Bloc->buffer;
	ptrFile=fileData->buffer;

	// On traite tout les blocs
	while(idxBloc < nbBlocs) {
		// Positionnement du paramétrage du bloc
		// Cas lorsque nous sommes sur le premier bloc
		if(firstBloc == 1) {
			tailleHeader=15;	// Le header contient un octet descripteur du contenu des blocs
			tailleChunk=254;	// Le bloc ne fait plus que 254 octets, le header étant 1 octet plus grand
			firstBloc=0;
			type=1;
			addCRC=0x0d;
		} else {
			addCRC=0;
			type=0;
			tailleHeader=14;
			tailleChunk=255;
		}

		// On détermine la taille réelle d'un bloc
		if ((fileData->bsize - (idxBloc * tailleChunk)) > tailleChunk) {
			partSize = tailleChunk;
		} else {
			partSize = fileData->bsize - (idxBloc * tailleChunk);
			lastBloc=1;
		}

		// Découpage d'un nouveau bloc
		tmpBloc=chunckBloc(ptrFile,partSize);
		// Génération du header
		dataHeader=forgeHeader(tmpBloc->bsize,type);

		//Copy du header
		// Modification de la taille trouvée en fonction du positionnement dans les données
		// Cas du premier bloc, on rajoute 1 pour compenser la taille du bloc à 254

		// 1 seul bloc résultat
		if ( type == 1 && lastBloc == 1 ) {
			dataHeader[tailleHeader-2]=partSize+1;
		}
		// Premier bloc, suivront n blocs
		if ( type == 1 && lastBloc == 0 ) {
			dataHeader[tailleHeader-2]=partSize+1;
		}
		// Dernier bloc
		if ( lastBloc == 1 && type == 0) {
			dataHeader[tailleHeader-1]=partSize+1;
		}
		// 2eme et suivants sauf dernier
		if ( lastBloc == 0 && type == 0) {
			sizeTmp=partSize+1;
			if ( sizeTmp>255 ) { sizeTmp=255; }
			dataHeader[tailleHeader-1]=sizeTmp;
		}
		// Ajout du header calculé
		memcpy(ptrBloc,dataHeader,tailleHeader);
		//Copy du bloc texte découpé
		memcpy(ptrBloc+tailleHeader, tmpBloc->buffer, tmpBloc->bsize);

		//Calcul du CRC
		// Le dernier bloc est particulier crc=crc + taille + 1 & 0xFF

		// Premier et seul bloc de données
		if ( lastBloc == 1 && type == 1 ) {
			crc=(tmpBloc->crc + tmpBloc->bsize + 1) & 0xFF;
			crc2=crc + 0x0d + 1;
			*(ptrBloc+partSize+tailleHeader)=crc2;
		}
		// Dernier bloc
		if ( lastBloc == 1 && type == 0 ) {
			*(ptrBloc+partSize+tailleHeader)=0x0d;
			crc=(tmpBloc->crc + tmpBloc->bsize + 1) & 0xFF;
			crc2=crc + 0x0d + 1;
			*(ptrBloc+partSize+tailleHeader+1)=crc2;
		}
		// 2eme et suivants sauf dernier
		if ( lastBloc == 0 && type == 0 ) {
			crc2=tmpBloc->crc+addCRC;
			*(ptrBloc+partSize+tailleHeader)=crc2;
		}
		// Premier bloc, d'autres à suivre
		if ( lastBloc == 0 && type == 1 ) {
			crc2=tmpBloc->crc+addCRC;
			*(ptrBloc+partSize+tailleHeader)=crc2;
		}

		idxBloc++;
		ptrFile+=partSize;
		// Taille d'un bloc avec le header + crc (255+14+1 ou 254+15+1)
		ptrBloc+=270;

		// Libération de la mémoire
		free(dataHeader);
		freeBlocData(tmpBloc);
	}	
	freeBlocData(fileData);
	return to7Bloc;
}

// Création d'une cassette TO7
// - Un seul fichier au format texte
int createK7(char *in, char *out) {
	int errCode=0;
	FILE *outFic=NULL;
	BlocData *buff=NULL;
	BlocData *k7=NULL;
	unsigned char *to7Name=NULL;
	unsigned char crc=0;
	unsigned char *k7Header=NULL;
	unsigned char *ptr=NULL;
	
	// TODO: A Supprimer et à utiliser directement depuis le bloc plutôt que d'ici - pas propre	
	unsigned char toCrc[16]={0x00,0x14,0,0,0,0,0,0,0,0,0,0,0,0,0xFF,0xFF};

	k7Header=(unsigned char*)malloc(35);
	memset(k7Header,0,35);

	// Valorisation du header
	memcpy(k7Header,header,12);

	// convertit le nom de fichier
	to7Name=convertName(in);

	// Calcul le CRC
	// TODO +2 ? a expliquer
	memcpy(toCrc+2,to7Name,11);

	memcpy(k7Header+12,toCrc,16);
	crc=calculCRC(toCrc,16);

	k7Header[34]=crc;

	outFic=fopen(out,"wb");
	// Convertion du fichier en format k7
	buff=fileToBloc(in);

	// 35 : header
	// bsize : taille du contenu du fichier convertit
	// 1 : crc
	// 15 : footer
	k7=mallocBlocData(35+buff->bsize+15);
	
	ptr=k7->buffer;
	memcpy(ptr,k7Header,35);
	ptr+=35;
	memcpy(ptr,buff->buffer,buff->bsize);
	ptr+=buff->bsize;

	memcpy(ptr,footer,15);

	freeBlocData(buff);

	fwrite(k7->buffer, sizeof(unsigned char), k7->bsize, outFic);
	
	fclose(outFic);
	free(to7Name);
	free(k7Header);
	freeBlocData(k7);
	return errCode;
}

int isFileExist(char *name) {
	FILE *file;

	file = fopen(name, "r");
	if(file == NULL ) {
		fclose(file);
		return 1;
	}
	return 0;
}

int checkOptions(Options *opt) {
	for (int i=0;i<opt->nbFiles;i++) {
		printf("A ajouter\n");
		printf("  %d -> %s\n",opt->fileType[i],opt->inFile[i]);
	}
	printf("En sortie : %s\n",opt->outFile);
	return 0;
}
// Libération de la mémoire pour les options
void freeOpt(Options *opt) {
	if(opt != NULL) {
		for(int i=0;i<opt->nbFiles;i++) {
			if(opt->inFile[i] != NULL) {
				free(opt->inFile[i]);
			}
		}
		if(opt->outFile != NULL) {
			free(opt->outFile);
		}
	}
	free(opt);
}
// Quitte en libérant la mémoire correctement
void exitCmd(Options *opt,int codeErr) {
	freeOpt(opt);
	exit(codeErr);
}

Options *parseArgs(int argc, char *argv[]) {
	Options *opt;
	int arg=0;
	
	// Allocation de la structure
	opt=(Options*)malloc(sizeof(struct OPTIONS));
	// init struct
	opt->force=0;
	opt->append=0;
	opt->nbFiles=0;
	opt->outFile=NULL;
	for (int i=0; i<MAXFILES; i++) {
		opt->inFile[i]=NULL;
		opt->fileType[i]=0;
	}

	if(argc < 2) {
		printf("ERREUR: Nombre d'arguments insuffisants.\n\n");
		printHelp(argv);
		exitCmd(opt,1);
	}
	// Parse arguments
	while(arg<argc) {
		if(strcmp(argv[arg],"-h") == 0) {
			printHelp(argv);
			exit(0);
		}
		// Fichier de sortie
		if (strcmp(argv[arg],"-o") == 0) {
			if(opt->outFile == NULL) {
				arg++;
				//TODO rajouter le teste d'allocation memoire
				opt->outFile=(char *)malloc(sizeof(argv[arg])); // On copie également le \0
				strcpy(opt->outFile,argv[arg]);
				
			} else {
				printf("WARNING: Fichier de sortie déjà défini [%s]. On en tient pas compte.\n\n",opt->outFile);
			}
		}
		if (strcmp(argv[arg],"-l") == 0) {
			arg++;
			if (argv[arg] != NULL) {
				if(isFileExist(argv[arg])) {
					printf("Liste le contenu de la k7 : %s\n",argv[arg]);
				} else {
					printf("ERREUR: Le fichier %s n'existe pas.\n\n",argv[arg]);
					exitCmd(opt,1);
				}
				exitCmd(opt,0);
			} else {
				printf("ERREUR: Il manque un argument à \"-l\".\n\n");
				printHelp(argv);
				exitCmd(opt,1);
			}
		}
		if (strcmp(argv[arg],"-d") == 0) {
			arg++;
			if (argv[arg] != NULL) {
				if(isFileExist(argv[arg])) {
					printf("Dump les informations de la k7 : %s\n",argv[arg]);
				} else {
					printf("ERREUR: Le fichier %s n'existe pas.\n\n",argv[arg]);
					exitCmd(opt,1);
				}
				exitCmd(opt,0);
			} else {
				printf("ERREUR: il manque un argument à \"-d\".\n\n");
				printHelp(argv);
				exitCmd(opt,0);
			}
		}
		if (strcmp(argv[arg],"-c") == 0) {
			arg++;
			if (argv[arg] != NULL) {
				if(isFileExist(argv[arg])) {
					printf("Check de la k7 : %s\n",argv[arg]);
				} else {
					printf("ERREUR: Le fichier %s n'existe pas.\n\n",argv[arg]);
					exitCmd(opt,1);
				}
				exitCmd(opt,0);
			} else {
				printf("ERREUR: il manque un argument à \"-c\".\n\n");
				printHelp(argv);
				exitCmd(opt,0);
			}
			exitCmd(opt,0);
		}
		if (strcmp(argv[arg],"-t") == 0) {
			arg++;
			if (argv[arg] != NULL) {
				if(isFileExist(argv[arg]) == 0) {
					if(opt->nbFiles < MAXFILES) {
						opt->inFile[opt->nbFiles]=(char*)malloc(sizeof(argv[arg]));
						strcpy(opt->inFile[opt->nbFiles],argv[arg]);
						opt->fileType[opt->nbFiles]=0;
						opt->nbFiles++;
					} else {
						printf("ERREUR: Nombre de fichier en entrée trop grand > %d\n\n",MAXFILES);
						exitCmd(opt,1);
					}
				} else {
					printf("ERREUR: Le fichier %s n'existe pas.\n\n",argv[arg]);
					exitCmd(opt,1);
				}
			} else {
				printf("ERREUR: il manque un argument à \"-t\".\n\n");
				printHelp(argv);
				exitCmd(opt,0);
			}
		}
		if (strcmp(argv[arg],"-b") == 0) {
			arg++;
			if (argv[arg] != NULL) {
				if(isFileExist(argv[arg]) == 0) {
					if(opt->nbFiles < MAXFILES) {
						opt->inFile[opt->nbFiles]=(char*)malloc(sizeof(argv[arg]));
						strcpy(opt->inFile[opt->nbFiles],argv[arg]);
						opt->fileType[opt->nbFiles]=1;
						opt->nbFiles++;
					} else {
						printf("ERREUR: Nombre de fichier en entrée trop grand > %d\n\n",MAXFILES);
						exitCmd(opt,1);
					}
				} else {
					printf("ERREUR: Le fichier %s n'existe pas.\n\n",argv[arg]);
					exitCmd(opt,1);
				}
			} else {
				printf("ERREUR: il manque un argument à \"-b\".\n\n");
				printHelp(argv);
				exitCmd(opt,0);
			}
		}
		arg++;
	}
	return opt;
}
int main(int argc, char *argv[])
	{
	Options *opt=NULL;
	
	opt=parseArgs(argc,argv);

	// Ne tient compte que d'un seul fichier en entrée et au format texte
	// TODO: à retirer lorsque les modifications pour gérer plusieurs fichiers seront apportées.
	if (opt->fileType[0] == 0) {
		printf("Generation de la K7 ... ");
		createK7(opt->inFile[0],opt->outFile);
		printf("OK\n");
	} else {
		printf("ERREUR: Le premier fichier n'est pas au format TEXTE, option -t.\n\n");
		printHelp(argv);
		exitCmd(opt,1);
	}
	return 0;
}
