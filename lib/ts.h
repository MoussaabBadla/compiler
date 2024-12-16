#ifndef ts_h
#define ts_h

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct EntreeTableSymbole {
    char nom[20];
    char type[20];
    char valeur[20];
    int ligne;
    int colonne;
    struct EntreeTableSymbole *suivant;
} EntreeTableSymbole;

extern EntreeTableSymbole *tableSymboles;

void insererSymbole(char *nom, char *type, char *valeur, int ligne, int colonne);
EntreeTableSymbole *rechercherSymbole(char *nom);
void afficherTableSymboles();

#endif // BOKHARI_BADLA_H
