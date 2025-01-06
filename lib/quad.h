#ifndef QUADRUPLETS_H
#define QUADRUPLETS_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_QUADS 1000    // max number  quadruplets
#define OP_LEN 20         // max length  operators
#define ARG_LEN 50        // max length  arguments and results

typedef struct {
    char op[OP_LEN];       // opt
    char arg1[ARG_LEN];    // fst operand
    char arg2[ARG_LEN];    // sd operand
    char res[ARG_LEN];     // Result
} Quadruplet;

static Quadruplet quadruplets[MAX_QUADS];
static int quadIndex = 0;

void addQuadruplet(const char* op, const char* arg1, const char* arg2, const char* res) {
    if (quadIndex >= MAX_QUADS) {
        fprintf(stderr, "Error: Quadruplet array overflow! Maximum limit is %d.\n", MAX_QUADS);
        exit(EXIT_FAILURE);
    }

    strncpy(quadruplets[quadIndex].op, op, OP_LEN - 1);
    quadruplets[quadIndex].op[OP_LEN - 1] = '\0'; // Ensure null-terminated

    strncpy(quadruplets[quadIndex].arg1, arg1, ARG_LEN - 1);
    quadruplets[quadIndex].arg1[ARG_LEN - 1] = '\0';

    strncpy(quadruplets[quadIndex].arg2, arg2, ARG_LEN - 1);
    quadruplets[quadIndex].arg2[ARG_LEN - 1] = '\0';

    strncpy(quadruplets[quadIndex].res, res, ARG_LEN - 1);
    quadruplets[quadIndex].res[ARG_LEN - 1] = '\0';

    quadIndex++;
}

 // display.
void printQuadruplets() {
    printf("\n/** Quadruplets **/\n");
    printf("| Index | Operator           | Arg1                | Arg2                | Result              |\n");
    printf("---------------------------------------------------------------------------------------------\n");

    for (int i = 0; i < quadIndex; i++) {
        printf("| %5d | %-18s | %-18s | %-18s | %-18s |\n",
               i, quadruplets[i].op, quadruplets[i].arg1,
               quadruplets[i].arg2, quadruplets[i].res);
    }
}

/**
 * clear
 */
void clearQuadruplets() {
    quadIndex = 0;
    memset(quadruplets, 0, sizeof(quadruplets));
    printf("Quadruplets cleared successfully.\n");
}

#endif 
