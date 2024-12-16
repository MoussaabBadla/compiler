%{
#include <stdio.h>
#include<stdlib.h>
#include<string.h>


extern FILE *yyin;  

void yyerror(const char *s); 
int yylex();              

%}

/* Token Declarations from Lexical Analyzer */
%token PROGRAMME VAR BEGIN END IF ELSE FOR WHILE CONST INTEGER FLOAT TRUE FALSE ReadIn WriteIn
%token IDF CST_INT CST_FLOAT OP_AFFECTATION OP_ARITH OP_LOGIC OP_COMP SEP_PAR SEP_COM SEP_PV SEP_END

/* Grammar Starting Point */
%start programme

%%

programme:
    PROGRAMME declarations BEGIN instructions END SEP_END
    {
        printf("Programme syntaxiquement correct\n");
    }
    ;

declarations:
    declarations declaration
    | declaration
    ;

declaration:
    VAR IDF SEP_PV
    | CONST IDF OP_AFFECTATION CST_INT SEP_PV
    | CONST IDF OP_AFFECTATION CST_FLOAT SEP_PV
    ;

instructions:
    instructions instruction
    | instruction
    ;

instruction:
    IDF OP_AFFECTATION expression SEP_PV
    | IF condition BEGIN instructions END
    | IF condition BEGIN instructions END ELSE BEGIN instructions END
    | WHILE condition BEGIN instructions END
    | FOR IDF OP_AFFECTATION expression SEP_PV condition SEP_PV expression BEGIN instructions END
    | ReadIn SEP_PAR IDF SEP_PAR SEP_PV
    | WriteIn SEP_PAR expression SEP_PAR SEP_PV
    ;

expression:
    CST_INT
    | CST_FLOAT
    | IDF
    | expression OP_ARITH expression
    ;

condition:
    expression OP_COMP expression
    | expression OP_LOGIC expression
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Erreur syntaxique: %s\n", s);
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Usage: %s <source_file>\n", argv[0]);
        return 1;
    }

    FILE *input = fopen(argv[1], "r");
    if (!input) {
        perror("Erreur d'ouverture du fichier");
        return 1;
    }

    yyin = input;  
    yyparse();     
    fclose(input);
    return 0;
}
