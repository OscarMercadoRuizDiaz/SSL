#include <stdio.h>
#include <string.h>
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

void chequear(char *s, RegTS *TS)
{
    /* Si la cadena No esta en la Tabla de Simbolos la agrega */
    if (!estaEnTS(s, TS))
    {
        colocar(s, TS);
    }
}

int estaEnTS(char *id, RegTS *TS)
{
    /* Determina si un identificador esta en la TS */
    return posicionEnTS(id, TS) > -1;
}

void colocar(char *id, RegTS *TS)
{
    /* Agrega un identificador a la TS */
    int i = posicionEnTS("$", TS);
    if (i < 999)
    {
        strcpy(TS[i].id, id);
        strcpy(TS[++i].id, "$");
        printf("El identificador %s fue guardado en TS\n", id);
    }
    else
    {
        printf("No hay mas posiciones en la TS");
    }
}

int valor(char* id, RegTS* TS) 
{
    int pos = posicionEnTS(id, TS);

    return TS[pos].valor;
}

int posicionEnTS(char* id, RegTS* TS) 
{
    int i = 0;
    while (strcmp("$", TS[i].id))
    {
        if (!strcmp(id, TS[i].id))
        {
            return i;
        }
        i++;
    }
    if(!strcmp("$", id)) // por si lo que busco es el centinela
    { 
        return i;
    }
    return -1;
}