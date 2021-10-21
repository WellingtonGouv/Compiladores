%{
    int linhas=1, erros=0;
%}

DIGITO  [0-9]
ID      [A-Za-z][A-Za-z0-9]*
ESPACO  [\t\r" "]
OP_MAT  "+"|"-"|"/"|"*"|"%"
OP_LOG  "||"|"&&"|"!"
OP_REL  ">"|">="|"<"|"<="|"=="|"!="
ATRIB   "="
PONT_V  ";"
PONT  "."
VIRGULA ","

%%

{ESPACO} /*reconhece espaço em branco*/

{DIGITO}+{ID} {
    printf("Identificador inválido: %s - ", yytext);
    erros++;
    printf("Linha: %d\n", linhas);
} /*reconhece erro em identificador*/

{ID}{DIGITO}*{ID}* {printf("Identificador: %s\n", yytext);}

{DIGITO}+ {printf("Inteiro: %s\n",yytext);}

{DIGITO}+"."{DIGITO}+ {printf("Real: %s\n",yytext);}

{OP_MAT} {printf("Operador matematico: %s\n",yytext);} /*Identifica operadores matematicos*/
{OP_LOG} {printf("Operador logico: %s\n",yytext);} /*Identifica operadores logicos*/
{OP_REL} {printf("Operador relacional: %s\n",yytext);} /*Identifica operadores relacionais*/
{ATRIB} {printf("Sinal de atribuicao: %s\n",yytext);}
{PONT_V} {printf("Sinal de ponto e virgula: %s\n",yytext);}
{PONT} {printf("Sinal de ponto: %s\n",yytext);}
{VIRGULA} {printf("Sinal de virgula: %s\n",yytext);}

"//"[^\n]* {
    printf("Comentários\n");
} /*Comentários Simples, nessa linguagem não há
comentário de mais de uma linha, para fazê-lo, deve-se
comentar uma linha por vez */

\n {linhas++;} /*reconhece mudança de linhas*/

. {
    printf("Token inválido: %s - ", yytext);
    erros++;
    printf("Linha: %d\n", linhas);
} /*Apresenta erro em qualquer coisa que não for uma
regra válida*/


%%

int yywrap();

void main() {
    yylex();
    
    printf("Total de erros encontrados: %d\n", erros);
    
    if (erros == 0)
        printf("\nCódigo analisado com sucesso!\n");
}

int yywrap() {
    return 1;
}