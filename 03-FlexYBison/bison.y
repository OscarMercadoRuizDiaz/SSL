%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <ctype.h>
#include <string.h>

#define TAMNOM 20 + 1

extern char *yytext;
extern int yyleng;
extern int yylex(void);
extern void yyerror(char *);
extern FILE *yyin;
int variable = 0;
%}
%union
{
    char *cadena;
    int num;
}
%token ASIGNACION COMA PYCOMA SUMA RESTA PARENIZQUIERDO PARENDERECHO INICIO FIN LEER ESCRIBIR
%token <cadena> ID
%token <num> CONSTANTE
%%
programa: INICIO listaSentencias FIN
listaSentencias: sentencia
        | listaSentencias sentencia
        ;
sentencia: ID { if(yyleng > 32) yyerror("semantico: la longitud del identificador es mayor a 32"); } ASIGNACION expresion PYCOMA
        | LEER PARENIZQUIERDO listaIdentificadores PARENDERECHO PYCOMA
        | ESCRIBIR PARENIZQUIERDO listaExpresiones PARENDERECHO PYCOMA
        ;
listaIdentificadores: ID
        | listaIdentificadores COMA ID
listaExpresiones: expresion
        | listaExpresiones COMA expresion
expresion: primaria 
        | expresion operadorAditivo primaria 
        ; 
primaria: ID
        | CONSTANTE { printf("valores %d %d", atoi(yytext), $1); }
        | PARENIZQUIERDO expresion PARENDERECHO
        ;
operadorAditivo: SUMA
        | RESTA
        ;

%%
int main(int argc, char *argv[])
{
    char nomArchi[TAMNOM];
    int l;
    FILE * in;

    if (argc == 1)
    {
        printf("Debe ingresar el nombre del archivo fuente (en lenguaje Micro) en la linea de comandos\n");
        return -1;
    } // no puso nombre de archivo fuente
    if (argc != 2)
    {
        printf("Numero incorrecto de argumentos\n");
        return -1;
    } // los argumentos deben ser 2
    strcpy(nomArchi, argv[1]);
    l = strlen(nomArchi);
    if (l > TAMNOM)
    {
        printf("Nombre incorrecto del Archivo Fuente\n");
        return -1;
    }
    // requiere para compilar un archivo de extensión.m archivo.m
    if (nomArchi[l - 1] != 'm' || nomArchi[l - 2] != '.')
    {
        printf("Nombre incorrecto del Archivo Fuente\n");
        return -1;
    }
    if ((in = fopen(nomArchi, "r")) == NULL)
    {
        printf("No se pudo abrir archivo fuente\n");
        return -1; // no pudo abrir archivo
    }
    yyin = in;
    yyparse();
    fclose(in);
    return 0;
}

void yyerror(char *s)
{
    printf("Error %s\n", s);
}

int yywrap()
{
    return 1;
}