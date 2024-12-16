%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>



// les lignes et colonnes

int nb_ligne = 1;
int nb_colonne = 1;


// error handling here 

void gestion_erreur(const char *type_erreur, const char *entite) {
    printf("%s, line %d, column %d: %s\n", type_erreur, nb_ligne, nb_colonne, entite);
}
%}

%option noyywrap


PROGRAMME    { return PROGRAMME; }
VAR          { return VAR; }
BEGIN        { return BEGIN; }
END          { return END. }
IF           { return IF; }
ELSE         { return ELSE; }
FOR          { return FOR; }
WHILE        { return WHILE; }
CONST        { return CONST; }
INTEGER      { return INTEGER; }
FLOAT        { return FLOAT; }
ReadIn       { return READIN; }
WriteIn      { return WRITEIN; }

IDF          [a-zA-Z][a-zA-Z0-9_]{0,6}
CST_INT      [-+]?[0-9]{1,5}
CST_FLOAT    [-+]?[0-9]+\.[0-9]+
OP_ARITH     [\+\-\*/]
OP_LOGIC     (\&\&|\|\||!)
OP_COMP      (==|!=|<=|>=|<|>)
OP_AFFECTATION "="
SEP_PAR      [\(\)]
SEP_COM      [,]
SEP_PV       [;]
SEP_END      [.]

COMMENTAIRE_LIGNE    \/\/[^\n]*
COMMENTAIRE_MULTI    \/\*([^*]|\*[^/])*\*\/
ESPACE_TAB_NL    [ \t\n]

%%

{IDF}        { 
                    printf("Identificateur: %s\n", yytext); 
                    nb_colonne += yyleng; 
                }

{CST_INT}    { 
                    printf("Constante entière: %s\n", yytext); 
                    nb_colonne += yyleng; 
                }

{CST_FLOAT}  { 
                    printf("Constante flottante: %s\n", yytext); 
                    nb_colonne += yyleng; 
                }

{OP_ARITH}   { 
                    printf("Opérateur arithmétique: %s\n", yytext); 
                    nb_colonne += yyleng; 
                }

{OP_LOGIC}   { 
                    printf("Opérateur logique: %s\n", yytext); 
                    nb_colonne += yyleng; 
                }
{OP_AFFECTATION} {
                    printf("Opérateur d'affectation: %s\n", yytext);
                    nb_colonne += yyleng;
                }


{OP_COMP}    { 
                    printf("Opérateur de comparaison: %s\n", yytext); 
                    nb_colonne += yyleng; 
                }

{SEP_PAR}    { 
                    printf("Parenthèse: %s\n", yytext); 
                    nb_colonne += yyleng; 
                }

{SEP_COM}    { 
                    printf("Virgule: %s\n", yytext); 
                    nb_colonne += yyleng; 
                }

{SEP_PV}     { 
                    printf("Point-virgule:: %s\n", yytext); 
                    nb_colonne += yyleng; 
                }
{SEP_END}     { 
    printf("End instruction: %s\n", yytext); 
    nb_colonne += yyleng; 
}


{COMMENTAIRE_LIGNE}   { 
                    nb_colonne += yyleng; 
                }

{COMMENTAIRE_MULTI}   { 
                    nb_colonne += yyleng; 
                }


{ESPACE_TAB_NL}  { 
                    if (yytext[0] == '\n') {
                        nb_ligne++;
                        nb_colonne = 1; 
                    } else {
                        nb_colonne += yyleng;
                    }
                }



.           { 
                    gestion_erreur("Erreur lexicale", yytext); 
                    nb_colonne += yyleng; 
                }

%%



// CHECK THE PROGRAM HAS AN ARGUMENT, if not, it shows the correct usage, and opens the file
int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <input_file>\n", argv[0]);
        return 1;
    }
    yyin = fopen(argv[1], "r");
    if (yyin == NULL) {
        perror("Failed to open file");
        return 1;
    }




    yylex();  
    fclose(yyin);  
    return 0;
}

