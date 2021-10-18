%{
    int linhas=1, erros=0;
%}

DIGITO  [0-9]
ID      [A-Za-z][A-Za-z0-9]*
ESPACO  [\t\r" "]
SIMBOLO [\w=+-*/()]

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

"+" {printf("Operador de soma: %s\n",yytext);}
"/" {printf("Operador de divisão: %s\n",yytext);}
"*" {printf("Operador de multiplicação: %s\n",yytext);}
"-" {printf("Operador de subtração: %s\n",yytext);}
"%" {printf("Operador de resto: %s\n",yytext);}

">" {printf("Operador de maior: %s\n",yytext);}
"<" {printf("Operador de menor: %s\n",yytext);}
">=" {printf("Operador de maior ou igual: %s\n",yytext);}
"<=" {printf("Operador de menor ou igual: %s\n",yytext);}
"=" {printf("Operador de atribuição: %s\n",yytext);}
"==" {printf("Operador de igual: %s\n",yytext);}
"!=" {printf("Operador de diferente: %s\n",yytext);}

"||" {printf("Operador OR: %s\n",yytext);}
"&&" {printf("Operador AND: %s\n",yytext);}
"!" {printf("Operador NOT: %s\n",yytext);}

"," {printf("Pontuação virgula: %s\n",yytext);}
";" {printf("Pontuação ponto e virgula: %s\n",yytext);}
"." {printf("Pontuação ponto: %s\n",yytext);}
":" {printf("Pontuação dois pontos: %s\n",yytext);}

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

.+{ID} {
    printf("Identificador inválido: %s - ", yytext);
    printf("Linha: %d\n", linhas);
} /*reconhece erro em identificador que começa com token invalido*/

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