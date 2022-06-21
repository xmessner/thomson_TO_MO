char *upperCase(char *filename);
char *stripName(char *fileName);
void printHelp(char *argv[]);
int createK7(char *in, char *out);

unsigned int _MAXCAR=8;
char MAXFILES=15;
//unsigned long sizeBuffer;

/* Format de la cassette

00 : FF ou DC. DC format basic protégé ?
0x01 - 0x0b : FFFFFFFFFFFFFFFFFFFF013C header
0x0c - 0x0d : 0x00 0x14 Debut de bloc
0x0e - 0x18 : Nom du fichier, 8+3 (BAS)
0x19 - 0x21 : 0x00 ??
0x22 -      : CRC de 0x à 0x **
0x23 - 0x2e : FFFFFFFFFFFFFFFFFFFF013C header
0x2e - 0x36 : ????
0x37        : Début du listing

*/
//34
const uint8_t header[]={0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x01,0x3c,0x01,0,0};
//14
const uint8_t footer[]={0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x01,0x3c,0xff,0,0xff};

// Contient uniquement un bloc de donnée avec sa taille.
typedef struct BLOCDATA {
	unsigned char *buffer;
	long bsize;
	unsigned char crc;
}BlocData;

typedef struct OPTIONS {
        char force;
        char append;
        unsigned char nbFiles;
        char *inFile[16];
        unsigned char fileType[16];     // 0: texte
                                        // 1: Binare
        char *outFile;
}Options;

BlocData *loadListing(char *file);
BlocData *fileToBloc(char *file);
BlocData *convertToDos(unsigned char *buffer, long bSize);
BlocData *chunkBloc(unsigned char *data, long size);
BlocData *mallocBlocData(long size);
unsigned char *convertName(char *longFileName);
Options *parseArgs(int argc, char *argv[]);
