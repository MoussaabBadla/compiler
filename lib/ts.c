#include "ts.h"

EntreeTableSymbole *tableSymboles = NULL;

void insererSymbole(char *nom, char *type, char *valeur, int ligne, int colonne) {
    EntreeTableSymbole *nouveau = (EntreeTableSymbole *)malloc(sizeof(EntreeTableSymbole));
    strcpy(nouveau->nom, nom);
    strcpy(nouveau->type, type);
    strcpy(nouveau->valeur, valeur);
    nouveau->ligne = ligne;
    nouveau->colonne = colonne;
    nouveau->suivant = NULL;

    if (tableSymboles == NULL) {
        tableSymboles = nouveau;
    } else {
        EntreeTableSymbole *courant = tableSymboles;
        while (courant->suivant != NULL) {
            courant = courant->suivant;
        }
        courant->suivant = nouveau;
    }
}

EntreeTableSymbole *rechercherSymbole(char *nom) {
    EntreeTableSymbole *courant = tableSymboles;
    while (courant != NULL) {
        if (strcmp(courant->nom, nom) == 0) {
            return courant; // Trouvé
        }
        courant = courant->suivant;
    }
    return NULL; // Non trouvé
}

void afficherTableSymboles() {
    printf("\nTable des Symboles :\n");
    printf("Nom\t\tType\t\tValeur\t\tLigne\tColonne\n");
    printf("---------------------------------------------------------------\n");
    EntreeTableSymbole *courant = tableSymboles;
    while (courant != NULL) {
        printf("%s\t\t%s\t\t%s\t\t%d\t%d\n", courant->nom, courant->type, courant->valeur, courant->ligne, courant->colonne);
        courant = courant->suivant;
    }
}
