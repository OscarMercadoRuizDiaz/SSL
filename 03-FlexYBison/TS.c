#include <stdio.h>
#include <string.h>
#define TAMLEX 32 + 1

typedef struct {
    char id[TAMLEX];
    int valor;
} RegTS;

RegTS TS[1000] = { {"$", 99} };

void chequear(char *s);
int estaEnTS(char *id);
void colocar(char *id);
int valor(char* id);
int posicionEnTS(char* id);
void asignar(char* s, int valor);

void chequear(char *s)
{
    /* Si la cadena No esta en la Tabla de Simbolos la agrega */
    if (!estaEnTS(s))
    {
        colocar(s);
    }
}

int estaEnTS(char *id)
{
    /* Determina si un identificador esta en la TS */
    return posicionEnTS(id) != -1;
}

void colocar(char *id)
{
    /* Agrega un identificador a la TS */
    int i = posicionEnTS("$");
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

int valor(char* id) 
{
    int pos = posicionEnTS(id);

    return TS[pos].valor;
}

int posicionEnTS(char* id) 
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

void asignar(char* s, int valor) 
{
    int pos = posicionEnTS(s);
    TS[pos].valor = valor;
    printf("El valor asignado es: %d\n", TS[pos].valor);
}