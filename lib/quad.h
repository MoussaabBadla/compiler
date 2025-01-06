#ifndef QUADRUPLETS_H
#define QUADRUPLETS_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <ctype.h>
#include <stdint.h>

#define MAX_QUADS 1000    // Maximum number of quadruplets
#define OP_LEN 20         // Maximum length of operators
#define ARG_LEN 50        // Maximum length of arguments and results

// Define the structure for a quadruplet
typedef struct {
    char op[OP_LEN];      // Operator
    char arg1[ARG_LEN];   // First operand
    char arg2[ARG_LEN];   // Second operand
    char res[ARG_LEN];    // Result
} Quadruplet;

// Static array to hold quadruplets
static Quadruplet quadruplets[MAX_QUADS];
static int quadIndex = 0;
static int tempVarCount = 0;

// Helper function to check if a string is a number
bool isNumber(const char* str) {
    if (!str || *str == '\0') return false;
    char* endptr;
    strtod(str, &endptr);
    return *endptr == '\0';
}

// Helper function to convert int to string
char* generateTempVar() {
    static char tempVar[20];
    snprintf(tempVar, sizeof(tempVar), "T%d", tempVarCount++);
    return tempVar;
}

// Helper function to convert void* to string representation
void convertToString(char* dest, size_t destSize, const void* arg) {
    if (!arg) {
        dest[0] = '\0';
        return;
    }
    
    // Check if arg is a string pointer first
    if (((uintptr_t)arg & 0xFFFFFFFF00000000) != 0) {
        strncpy(dest, (const char*)arg, destSize - 1);
    } else {
        // Treat as integer
        snprintf(dest, destSize, "%d", (int)(uintptr_t)arg);
    }
    dest[destSize - 1] = '\0';
}

void addQuadruplet(char* op, void* arg1, void* arg2, char* res) {
    if (quadIndex >= MAX_QUADS) {
        fprintf(stderr, "Error: Quadruplet array overflow!\n");
        exit(EXIT_FAILURE);
    }

    if (!op || !res) {
        fprintf(stderr, "Error: Null operator or result in quadruplet.\n");
        exit(EXIT_FAILURE);
    }

    // Copy operator
    strncpy(quadruplets[quadIndex].op, op, OP_LEN - 1);
    quadruplets[quadIndex].op[OP_LEN - 1] = '\0';

    // Convert and copy arg1
    convertToString(quadruplets[quadIndex].arg1, ARG_LEN, arg1);

    // Convert and copy arg2
    convertToString(quadruplets[quadIndex].arg2, ARG_LEN, arg2);

    // Handle arithmetic operations
    if (strcmp(op, "+") == 0 || strcmp(op, "-") == 0 || 
        strcmp(op, "*") == 0 || strcmp(op, "/") == 0) {
        // For arithmetic operations, create a new temp variable if result is "temp"
        if (strcmp(res, "temp") == 0) {
            strncpy(quadruplets[quadIndex].res, generateTempVar(), ARG_LEN - 1);
        } else {
            strncpy(quadruplets[quadIndex].res, res, ARG_LEN - 1);
        }
    } else {
        // For other operations, use the provided result
        strncpy(quadruplets[quadIndex].res, res, ARG_LEN - 1);
    }
    quadruplets[quadIndex].res[ARG_LEN - 1] = '\0';

    printf("Generated quadruplet: (%s, %s, %s, %s)\n", 
           quadruplets[quadIndex].op,
           quadruplets[quadIndex].arg1,
           quadruplets[quadIndex].arg2,
           quadruplets[quadIndex].res);

    quadIndex++;
}

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

void clearQuadruplets() {
    quadIndex = 0;
    tempVarCount = 0;
    memset(quadruplets, 0, sizeof(quadruplets));
}

#endif // QUADRUPLETS_H