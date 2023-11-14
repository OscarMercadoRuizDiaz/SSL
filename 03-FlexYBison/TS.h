#define TAMLEX 32 + 1
typedef struct {
    char id[TAMLEX];
    int valor;
} RegTS;

RegTS TS[1000];

void chequear(char *s);
int estaEnTS(char *id);
void colocar(char *id);
int valor(char* id);
int posicionEnTS(char* id);
void asignar(char* s, int valor);