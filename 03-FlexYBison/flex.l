%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "y.tab.h"
%}
DIGITO [0-9]

LETRA [a-zA-Z]

IDENTIFICADOR {LETRA}({LETRA}|{DIGITO})*

constEntera {DIGITO}({DIGITO})*
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
"leer" { return ESCRIBIR; }
"escribir" { return ESCRIBIR; }
{constEntera} { yylval.num = atoi(yytext); return CONSTANTE; }
{IDENTIFICADOR} { return ID; }

%%
