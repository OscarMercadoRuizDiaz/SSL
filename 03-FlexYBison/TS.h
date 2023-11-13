#define TAMLEX 32 + 1
typedef struct {
    char id[TAMLEX];
    int valor;
} RegTS;

void chequear(char *s, RegTS *TS);
int estaEnTS(char *id, RegTS *TS);
void colocar(char *id, RegTS *TS);
int valor(char* id, RegTS *TS);
int posicionEnTS(char* id, RegTS* TS);