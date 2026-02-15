cat > lexer.l <<'EOF'
%option noyywrap nodefault yylineno

%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern FILE *yyin;

#define BUF_SIZE 4096
static char strbuf[BUF_SIZE];
static int  stridx = 0;

static void str_reset(void) {
    stridx = 0;
    strbuf[0] = '\0';
}

static void str_add_char(char c) {
    if (stridx < BUF_SIZE - 1) {
        strbuf[stridx++] = c;
        strbuf[stridx] = '\0';
    }
}

static void print_tok(const char* tok, const char* val) {
    printf("LINEA: %d  TOKEN: %-12s  VALOR: %s\n", yylineno, tok, val);
}
%}

%x COMMENT
%x STRING

DIGIT      [0-9]
HEXDIGIT   [0-9a-fA-F]
LETTER     [A-Za-z]
ID_START   ({LETTER}|_)
ID_REST    ({LETTER}|_|{DIGIT})
ID         {ID_START}{ID_REST}*

INT        {DIGIT}+
HEX        0[xX]{HEXDIGIT}+

EXP        [eE][+-]?{DIGIT}+
FLOAT1     {DIGIT}+"."{DIGIT}*
FLOAT2     "."{DIGIT}+
FLOAT      ({FLOAT1}|{FLOAT2})
SCIENTIFIC ({DIGIT}+"."{DIGIT}*|{DIGIT}+|{FLOAT2}){EXP}

WS         [ \t\r]+

%%

"//".*                  { /* descartar comentario de una linea */ }

"/*"                    { BEGIN(COMMENT); }
<COMMENT>"*/"           { BEGIN(INITIAL); }
<COMMENT>\n             { /* mantener conteo de lineas */ }
<COMMENT>.              { /* consumir */ }

\"                      { BEGIN(STRING); str_reset(); }
<STRING>\\n             { str_add_char('\n'); }
<STRING>\\t             { str_add_char('\t'); }
<STRING>\\\"            { str_add_char('\"'); }
<STRING>\\\\            { str_add_char('\\'); }

<STRING>[^\\\"\n]+      {
                            for (int i = 0; yytext[i] != '\0'; i++) {
                                str_add_char(yytext[i]);
                            }
                        }

<STRING>\"              { BEGIN(INITIAL); print_tok("STRING", strbuf); }

<STRING>\n              { BEGIN(INITIAL); print_tok("ERROR", "String no cerrado"); }

<STRING>\\.[^\n]?       {
                            for (int i = 0; yytext[i] != '\0'; i++) {
                                str_add_char(yytext[i]);
                            }
                        }

{HEX}                   { print_tok("HEX", yytext); }
{SCIENTIFIC}            { print_tok("SCIENTIFIC", yytext); }
{FLOAT}                 { print_tok("FLOAT", yytext); }
{INT}                   { print_tok("INT", yytext); }

"=="                    { print_tok("OP_REL", yytext); }
"!="                    { print_tok("OP_REL", yytext); }
"<="                    { print_tok("OP_REL", yytext); }
">="                    { print_tok("OP_REL", yytext); }
"&&"                    { print_tok("OP_LOG", yytext); }
"||"                    { print_tok("OP_LOG", yytext); }

"<"                     { print_tok("OP_REL", yytext); }
">"                     { print_tok("OP_REL", yytext); }

"+"                     { print_tok("OP_ARIT", yytext); }
"-"                     { print_tok("OP_ARIT", yytext); }
"*"                     { print_tok("OP_ARIT", yytext); }
"/"                     { print_tok("OP_ARIT", yytext); }

"!"                     { print_tok("OP_LOG", yytext); }

{ID}                    { print_tok("ID", yytext); }

"("                     { print_tok("LPAREN", yytext); }
")"                     { print_tok("RPAREN", yytext); }
"{"                     { print_tok("LBRACE", yytext); }
"}"                     { print_tok("RBRACE", yytext); }
";"                     { print_tok("SEMI", yytext); }
","                     { print_tok("COMMA", yytext); }

\n                      { /* ignorar */ }
{WS}                    { /* ignorar */ }

.                       {
                            char msg[128];
                            snprintf(msg, sizeof(msg), "Caracter no reconocido: '%s'", yytext);
                            print_tok("ERROR", msg);
                        }

%%

int main(int argc, char** argv) {
    if (argc > 1) {
        FILE* f = fopen(argv[1], "r");
        if (!f) {
            perror("No se pudo abrir el archivo");
            return 1;
        }
        yyin = f;
    }
    yylex();
    return 0;
}
