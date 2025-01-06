%{
    #include <stdio.h>
    #include <string.h>
    #include "quad.h"
    
    int N = 1 ;
    int C = 1 ;
    char sauvType[20];
    int yylex();
    int yyerror(const char *s) {
        fprintf(stderr, "Erreur de syntaxe a la ligne %d : %s\n", N, s);
        return 0; 
    }
    
    void initialisation();
    void afficher();
    void rechercher(const char* entite, const char* code, const char* type, float val, int categorie);
    void insererType(const char* name, const char* type);
    int rechercheNonDeclare(const char* name);
    int CompType(const char* name, const char* type);
%}

%union {
    int entier;
    float reel;
    char* string;
    char* exp_val;    /* Add this for EXP values */

}


%left foi division
%left plus moin
%left inf inf_eg sup sup_eg egale diff

%token <string> mc_prog <string> mc_var <string> mc_cst <string> mc_begin <string> mc_end <string> mc_if <string> mc_else <string> mc_for
       <string> mc_do <string> mc_while <string> idf inf inf_eg sup sup_eg eg diff et_log ou_log non_log aff pvg plus moin
       foi division deuxp ao af po pf cst_e cst_r <string> chaine <reel> mc_float <entier> mc_integer <string> mc_string
       vg <string> mc_writeln <string> mc_readln <string> mc_then
       

%type <exp_val> EXP
%type <string> INSTRUCTIONS

%start S
%%

S : mc_prog idf mc_var ao VARIABLES af mc_begin INSTRUCTIONS mc_end  {
        printf("\n Le programme est correcte syntaxiquement. \n");
        YYACCEPT;
    }
  | mc_prog idf mc_begin INSTRUCTIONS mc_end  {
        printf("\n Le programme est correcte syntaxiquement. \n");
        YYACCEPT;
    }
;

VARIABLES : TYPES LISTVAR pvg VARIABLES
          | mc_cst TYPES LISTCONST pvg VARIABLES
          |
;

TYPES : mc_integer {strcpy(sauvType, "INTEGER");}
     | mc_float {strcpy(sauvType, "FLOAT");}
     | mc_string {strcpy(sauvType, "STRING");}
;

LISTVAR : idf aff cst_e vg LISTVAR {
            if (rechercheNonDeclare($1) == 0) {
                insererType($1, sauvType);
            } else {
                printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N, C, $1);
            }
            if (CompType($1, "INTEGER") == 0) {
                printf("****Erreur a la ligne %d et la colonne %d \n", N, C, $1);
            }
            addQuadruplet("=", $2, NULL, $1);  // Adding quadruplet for assignment
        }
        | idf aff cst_e {
            if (rechercheNonDeclare($1) == 0) {
                insererType($1, sauvType);
            } else {
                printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N, C, $1);
            }
            if (CompType($1, "INTEGER") == 0) {
                printf("****Erreur a la ligne %d et la colonne %d \n", N, C, $1);
            }
            addQuadruplet("=", $2, NULL, $1); 
        }
        | idf vg LISTVAR {
            if (rechercheNonDeclare($1) == 0) {
                insererType($1, sauvType);
            } else {
                printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N, C, $1);
            }
            addQuadruplet("=", $2, NULL, $1); 
        }
        | idf {
            if (rechercheNonDeclare($1) == 0) {
                insererType($1, sauvType);
            } else {
                printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N, C, $1);
            }
            addQuadruplet("=", NULL, NULL, $1);  
        }
        | idf aff cst_r vg LISTVAR {
            if (rechercheNonDeclare($1) == 0) {
                insererType($1, sauvType);
            } else {
                printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N, C, $1);
            }
            if (CompType($1, "FLOAT") == 0) {
                printf("****Erreur a la ligne %d et la colonne %d : ICOMPATIBILITE DE TYPE de la variable %s ****\n", N, C, $1);
            }
            addQuadruplet("=", $2, NULL, $1);  // Adding quadruplet for assignment
        }
        | idf aff cst_r {
            if (rechercheNonDeclare($1) == 0) {
                insererType($1, sauvType);
            } else {
                printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N, C, $1);
            }
            if (CompType($1, "FLOAT") == 0) {
                printf("****Erreur a la ligne %d et la colonne %d : ICOMPATIBILITE DE TYPE de la variable %s ****\n", N, C, $1);
            }
            addQuadruplet("=", $2, NULL, $1);  // Adding quadruplet for assignment
        }
        | idf aff chaine vg LISTVAR {
            if (rechercheNonDeclare($1) == 0) {
                insererType($1, sauvType);
            } else {
                printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N, C, $1);
            }
            if (CompType($1, "STRING") == 0) {
                printf("****Erreur semantique a la ligne %d et la colonne %d : ICOMPATIBILITE DE TYPE de la variable %s ****\n", N, C, $1);
            }
            addQuadruplet("=", $2, NULL, $1);  // Adding quadruplet for assignment
        }
        | idf aff chaine {
            if (rechercheNonDeclare($1) == 0) {
                insererType($1, sauvType);
            } else {
                printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N, C, $1);
            }
            if (CompType($1, "STRING") == 0) {
                printf("****Erreur a la ligne %d et la colonne %d : ICOMPATIBILITE DE TYPE de la variable %s ****\n", N, C, $1);
            }
            addQuadruplet("=", $2, NULL, $1);  // Adding quadruplet for assignment
        }

;

LISTCONST : idf aff cst_e vg LISTCONST {
            if (rechercheNonDeclare($1) == 0) {
                insererType($1, sauvType);
            } else {
                printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N, C, $1);
            }
            if (CompType($1, "INTEGER") == 0) {
                printf("****Erreur a la ligne %d et la colonne %d : ICOMPATIBILITE DE TYPE de la variable %s ****\n", N, C, $1);
            }
            addQuadruplet("=", $2, NULL, $1); 
        }
         | idf aff cst_e 
         {
            if (rechercheNonDeclare($1) == 0) {
                insererType($1, sauvType);
            } else {
                printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N, C, $1);
            }
            if (CompType($1, "INTEGER") == 0) {
                printf("****Erreur a la ligne %d et la colonne %d : ICOMPATIBILITE DE TYPE de la variable %s ****\n", N, C, $1);
            }
            addQuadruplet("=", $2, NULL, $1);  // Adding quadruplet for assignment
        }

;

EXP : EXP plus EXP {
        addQuadruplet("+", $1, $3, "temp");
    }
    | EXP moin EXP {
        addQuadruplet("-", $1, $3, "temp");
    }
    | EXP foi EXP {
        addQuadruplet("*", $1, $3, "temp");
    }
    | EXP division EXP {
        addQuadruplet("/", $1, $3, "temp");
    }
    | cst_e {
        addQuadruplet("=", $1, NULL, "temp");
    }
    | cst_r {
        addQuadruplet("=", $1, NULL, "temp");
    }
    | idf {
        addQuadruplet("=", $1, NULL, "temp");
    }
;

INSTRUCTIONS : idf aff EXP pvg INSTRUCTIONS {
                addQuadruplet("=", $3, NULL, $1); 
                }
                | INST_IF INSTRUCTIONS
                | INST_FOR INSTRUCTIONS
                | INST_WHILE INSTRUCTIONS
                | INST_DO INSTRUCTIONS
                | mc_writeln po chaine pf pvg INSTRUCTIONS
                | mc_writeln po idf pf pvg INSTRUCTIONS
                | mc_readln po chaine pf pvg INSTRUCTIONS
                | mc_readln po idf pf pvg INSTRUCTIONS
                |
    ;

INST_IF : mc_if po CONDITION pf ao INSTRUCTIONS af mc_else ao INSTRUCTIONS af pvg
        | mc_if po CONDITION pf ao INSTRUCTIONS af pvg
;

CONDITION : EXP inf EXP
          | EXP inf_eg EXP 
          | EXP sup EXP
          | EXP sup_eg EXP
          | EXP eg EXP
          | EXP diff EXP
;


INST_FOR : mc_for po idf deuxp cst_e deuxp cst_e deuxp CONDITION pf ao INSTRUCTIONS af
{
    addQuadruplet("for", $2, $4, "temp");  // Adding quadruplet for for loop
}

;

INST_WHILE : mc_while po CONDITION pf ao INSTRUCTIONS af
{
    addQuadruplet("while", $2, NULL, "temp");  // Adding quadruplet for while loop
}

;

INST_DO : mc_do mc_begin INSTRUCTIONS mc_end mc_while po CONDITION pf pvg
{
    addQuadruplet("do", NULL, NULL, "temp");  // Adding quadruplet for do-while loop
}

;

%%

int main() {
   initialisation();
   yyparse();
   afficher();
   printQuadruplets();  
   clearQuadruplets(); 
   return 0;
}
int yywrap ()
 {}