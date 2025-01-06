#ifndef QUADRUPLETS_H
#define QUADRUPLETS_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_QUADS 1000    // Maximum number of quadruplets
#define OP_LEN 20         // Maximum length of operators
#define ARG_LEN 50        // Maximum length of arguments and results

// Define the structure for a quadruplet
typedef struct {
    char op[OP_LEN];       // Operator
    char arg1[ARG_LEN];    // First operand
    char arg2[ARG_LEN];    // Second operand
    char res[ARG_LEN];     // Result
} Quadruplet;

// Static array to hold quadruplets
static Quadruplet quadruplets[MAX_QUADS];
static int quadIndex = 0;

/**
 * Adds a new quadruplet to the array.
 * @param op: The operator.
 * @param arg1: The first operand (can be NULL).
 * @param arg2: The second operand (can be NULL).
 * @param res: The result.
 */
void addQuadruplet(const char *op, const char *arg1, const char *arg2, const char *res) {
    if (quadIndex >= MAX_QUADS) {
        fprintf(stderr, "Error: Quadruplet array overflow! Maximum limit is %d.\n", MAX_QUADS);
        exit(EXIT_FAILURE);
    }

    if (!op || !res) {
        fprintf(stderr, "Error: Null operator or result in quadruplet.\n");
        exit(EXIT_FAILURE);
    }

    // Safely copy operator
    strncpy(quadruplets[quadIndex].op, op, OP_LEN - 1);
    quadruplets[quadIndex].op[OP_LEN - 1] = '\0';

    // Safely copy arguments and result
    if (arg1 && arg1 < (char*)0x555500000000) {
        strncpy(quadruplets[quadIndex].arg1, arg1, ARG_LEN - 1);
        quadruplets[quadIndex].arg1[ARG_LEN - 1] = '\0';
    } else {
        quadruplets[quadIndex].arg1[0] = '\0'; // Set empty string
    }

    if (arg2 && arg2 < (char*)0x555500000000) {
        strncpy(quadruplets[quadIndex].arg2, arg2, ARG_LEN - 1);
        quadruplets[quadIndex].arg2[ARG_LEN - 1] = '\0';
    } else {
        quadruplets[quadIndex].arg2[0] = '\0'; // Set empty string
    }

    strncpy(quadruplets[quadIndex].res, res, ARG_LEN - 1);
    quadruplets[quadIndex].res[ARG_LEN - 1] = '\0';

    quadIndex++;
}

/**
 * Prints all the quadruplets in a table format.
 */
void printQuadruplets() {
    printf("\n/** Quadruplets **/\n");
    printf("| Index | Operator           | Arg1                | Arg2                | Result              |\n");
    printf("---------------------------------------------------------------------------------------------\n");

    for (int i = 0; i < quadIndex; i++) {
        printf("| %5d | %-18s | %-18s | %-18s | %-18s |\n",
               i,
               quadruplets[i].op,
               quadruplets[i].arg1[0] ? quadruplets[i].arg1 : "NULL",
               quadruplets[i].arg2[0] ? quadruplets[i].arg2 : "NULL",
               quadruplets[i].res);
    }
}

/**
 * Clears all quadruplets from the array.
 */
void clearQuadruplets() {
    quadIndex = 0;
    memset(quadruplets, 0, sizeof(quadruplets));
    printf("Quadruplets cleared successfully.\n");
}

#endif // QUADRUPLETS_H
