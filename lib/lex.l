%{
    #include <stdio.h>
    #include <string.h>
    #include "synt.tab.h"
    #include "ts.h"
    extern int N ;
    extern int C ;
%}
chiffre [0-9]
lettre [a-zA-Z]
IDF {lettre}({lettre}|{chiffre}|[_]?)*
CST_INTEGER [+-]?{chiffre}*
CST_FLOAT [-+]?{chiffre}*"."{chiffre}*
CHAINE \"(\\.|[^"^\n\\]*)*\"
%%
\n          { N++; C = 1; }  // Handle newlines: Increment line, reset column
\t          { C += 4; }  // Handle tabs: Increment column by 4 (or adjust as needed)
[ \t]       { C += strlen(yytext); } // Handle spaces and tabs (update column)

"PROGRAMME" {   rechercher(yytext,"Mot Cle"," ",0,1) ;
                printf(" %s est reconnue  \n", yytext);
                C = C + strlen(yytext);
                return mc_prog ;
            }
"VAR"   {       rechercher(yytext,"Mot Cle"," ",0,1) ;
                printf("reconnue est %s \n", yytext);
                C = C + strlen(yytext);
                return mc_var;
        }
"CONST"     {   rechercher(yytext,"Mot Cle"," ",0,1) ;
                printf("reconnue est %s \n", yytext);
                C = C + strlen(yytext); 
                return mc_cst;
            }
"BEGIN"     {   rechercher(yytext,"Mot Cle"," ",0,1) ;
                printf(" %s est reconnue  \n", yytext);
                C = C + strlen(yytext);
                return mc_begin;
                }
"END"      {   rechercher(yytext,"Mot Cle"," ",0,1) ;
                printf("reconnue est %s \n", yytext);
                C = C + strlen(yytext);
                return mc_end;
            }
"INTEGER"  {   rechercher(yytext,"Mot Cle"," ",0,1) ;
                printf("reconnue est %s \n", yytext);
                C = C + strlen(yytext);
                return mc_integer;
            }
"FLOAT"     {   rechercher(yytext,"Mot Cle"," ",0,1) ;
                printf("reconnue est %s \n", yytext);
                C = C + strlen(yytext);
                return mc_float;
            }
"STRING"    {   rechercher(yytext,"Mot Cle"," ",0,1) ;
                printf("reconnue est %s \n", yytext);
                C = C + strlen(yytext);
                return mc_string;
            }
"IF"        {   rechercher(yytext,"Mot Cle"," ",0,1) ;
                printf("reconnue est %s \n", yytext);
                C = C + strlen(yytext);
                return mc_if;
            }

"ELSE"      {   rechercher(yytext,"Mot Cle"," ",0,1) ;
                printf("reconnue est %s \n", yytext);
                C = C + strlen(yytext);
                return mc_else;
                }
"WHILE"     {   rechercher(yytext,"Mot Cle"," ",0,1) ;
                printf("reconnue est %s \n", yytext);
                C = C + strlen(yytext);
                return mc_while;
            }
"FOR"       {   rechercher(yytext,"Mot Cle"," ",0,1) ;
                printf("reconnue est %s \n", yytext);
                C = C + strlen(yytext);
                return mc_for;
            }
"DO"        {   rechercher(yytext,"Mot Cle"," ",0,1) ;
                printf("reconnue est %s \n", yytext);
                C = C + strlen(yytext);
                return mc_do;
            }
"WRITELN"   {   rechercher(yytext,"Mot Cle"," ",0,1) ;
                printf(" %s est reconnue  \n", yytext);
                C = C + strlen(yytext);
                return mc_writeln;
            }
"READLN"    {   rechercher(yytext,"Mot Cle"," ",0,1) ;
                printf(" %s est reconnue  \n", yytext);
                C = C + strlen(yytext);
                return mc_readln;
            }
"<"         {   rechercher(yytext,"separateur"," ",0,2) ;
                printf(" %s est reconnue  \n", yytext);
                C = C + strlen(yytext);
                return inf;
            }
"<="        {   rechercher(yytext,"separateur"," ",0,2) ;
                printf(" %s est reconnue  \n", yytext);
                C = C + strlen(yytext);
                return inf_eg;
            }
">"         {   rechercher(yytext,"separateur"," ",0,2) ;
                printf(" %s est reconnue  \n", yytext);
                C = C + strlen(yytext);
                return sup;
            }
">="        {   rechercher(yytext,"separateur"," ",0,2) ;
                printf(" %s est reconnue  \n", yytext);
                C = C + strlen(yytext);
                return sup_eg;
            }
"=="        {   rechercher(yytext,"separateur"," ",0,2) ;
                printf(" %s est reconnue  \n", yytext);
                C = C + strlen(yytext);
                return eg;
            }
"!="        {   rechercher(yytext,"separateur"," ",0,2) ;
                printf(" %s est reconnue  \n", yytext);
                C = C + strlen(yytext);
                return diff;
            }
"+"         {   rechercher(yytext,"separateur"," ",0,2) ;
                printf(" %s est reconnue  \n", yytext);
                C = C + strlen(yytext);
                return plus;
            }
"-"         {   rechercher(yytext,"separateur"," ",0,2) ;
                printf(" %s est reconnue  \n", yytext);
                C = C + strlen(yytext);
                return moin;
            }
"*"         {   rechercher(yytext,"separateur"," ",0,2) ;
                printf(" %s est reconnue  \n", yytext);
                C = C + strlen(yytext);
                return foi;
            }
"/"         {   rechercher(yytext,"separateur"," ",0,2) ;
                printf(" %s est reconnue  \n", yytext);
                C = C + strlen(yytext);
                return division;
            }
","         {   rechercher(yytext,"separateur"," ",0,2) ;
                printf(" %s est reconnue  \n", yytext);
                C = C + strlen(yytext);
                return vg;
            }
";"         {   rechercher(yytext,"separateur"," ",0,2) ;
                printf(" %s est reconnue  \n", yytext);
                C = C + strlen(yytext);
                return pvg;
            }
"="         {   rechercher(yytext,"separateur"," ",0,2) ;
                printf(" %s est reconnue  \n", yytext);
                C = C + strlen(yytext);
                return aff;
            }
"{"         {   rechercher(yytext,"separateur"," ",0,2) ;
                printf(" %s est reconnue  \n", yytext);
                C = C + strlen(yytext);
                return ao;
            }
"}"         {   rechercher(yytext,"separateur"," ",0,2) ;
                printf(" %s est reconnue  \n", yytext);
                C = C + strlen(yytext);
                return af;
            }
":="        {   printf(" %s est reconnue  \n", yytext); C += strlen(yytext); return aff; }
"("         {   rechercher(yytext,"separateur"," ",0,2) ;
                printf(" %s est reconnue  \n", yytext);
                C = C + strlen(yytext);
                return po;
            }
")"         {   rechercher(yytext,"separateur"," ",0,2) ;
                printf(" %s est reconnue  \n", yytext);
                C = C + strlen(yytext);
                return pf;
            }
"&&"        {   rechercher(yytext,"separateur"," ",0,2) ;
                printf(" %s est reconnue  \n", yytext);
                C = C + strlen(yytext);
                return et_log;
            }
"||"        {   rechercher(yytext,"separateur"," ",0,2) ;
                printf(" %s est reconnue  \n", yytext);
                C = C + strlen(yytext);
                return ou_log;
            }
"!"         {   rechercher(yytext,"separateur"," ",0,2) ;
                printf(" %s est reconnue  \n", yytext);
                C = C + strlen(yytext);
                return non_log;
            }

":"         {   rechercher(yytext,"separateur"," ",0,2) ;
                printf(" %s est reconnue  \n", yytext);
                C = C + strlen(yytext);
                return deuxp;
            }
{IDF}       {   rechercher(yytext,"identificateur"," ",0,0) ;
                printf(" %s est reconnue  \n", yytext);
                C = C + strlen(yytext);
                yylval.string=strdup(yytext);
                return idf;
            }
{CST_INTEGER}   {   rechercher(yytext,"constante","ENTIER",atoi(yytext),0) ;
                printf(" %s est reconnue  \n", yytext);
                C = C + strlen(yytext);
                yylval.entier=atoi(yytext);
                return cst_e;
            }
{CST_FLOAT}      {   rechercher(yytext,"constante","REEL",atof(yytext),0) ;
                printf(" %s est reconnue  \n", yytext);
                C = C + strlen(yytext);
                yylval.reel=atof(yytext);
                return cst_r;
            }
{CHAINE}    {   rechercher(yytext,"constante","STRING",atof(yytext),0) ;
                printf(" %s est reconnue  \n", yytext);
                C = C + strlen(yytext);
                yylval.string=strdup(yytext);
                return chaine;
            }

"//".*                 { /* Ignore single-line comments */ }
"/\*([^*]|\*+[^*/])*\*/" { /* Ignore multi-line comments */ }


.  {printf("caractere ivalide a la ligne %d et colone %d \n", N , C);} 
