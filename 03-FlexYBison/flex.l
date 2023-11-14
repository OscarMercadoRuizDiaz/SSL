%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "y.tab.h"

	void yyerror(char *s);
%}
DIGITO [0-9]

LETRA [a-zA-Z]

IDENTIFICADOR {LETRA}({LETRA}|{DIGITO})*

constEntera {DIGITO}({DIGITO})*

ESPACIOENBLANCO [[:blank:]]
%%
":=" { return ASIGNACION; }
"," { return COMA; }
";" { return PYCOMA; }
"+" { return SUMA;}
"-" { return RESTA;} 
"(" { return PARENIZQUIERDO; }
")" { return PARENDERECHO;}
"inicio" { return INICIO; }
"fin" { return FIN; }
"leer" { return LEER; }
"escribir" { return ESCRIBIR; }
{constEntera} { yylval.num = atoi(yytext); return CONSTANTE; }
{IDENTIFICADOR} { yylval.cadena = strdup(yytext); return ID; }
{ESPACIOENBLANCO} 	;
. { yyerror("lexico: el lexema no pertenece a ningun token\n"); return ERRORLEXICO; }

%%
