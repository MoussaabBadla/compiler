# SIMPLE COMPILER

## Overview
This project is a simple compiler built using **Flex**  and **Bison**

---

## Directory Structure

- **`out/`**: Output directory for build artifacts.
- **`lib/`**: Directory containing source files, including Flex and Bison specifications and the symbol table implementation.
- **`out/compiler/`**: Directory for the final compiler executable.
- **`test/`**: Directory for test files used to verify the compiler.

---

## Source Files

### Lexical Analyzer
- **`lib/lex.l`**: Defines the tokens and rules for lexical analysis using Flex.

### Syntax Analyzer
- **`lib/synt.y`**: Specifies the grammar rules for syntax analysis using Bison.

### Symbol Table
- **`lib/ts.c`**: Implements the symbol table.
- **`lib/ts.h`**: Header file for the symbol table.

---

## Prerequisites

Ensure the following tools are installed:

1. **Flex**: For lexical analysis.
2. **Bison**: For syntax analysis.
3. **GCC**: The GNU Compiler Collection.
4. **Make**: For building the project.

To install these tools on macOS using Homebrew:

```bash
brew install flex bison gcc make
```

using apt on Ubuntu:

```bash
sudo apt-get install flex bison gcc make
```

---

## Makefile Targets

### 1. **`all`**

Builds the compiler by running all necessary steps (build, compile) and cleans up intermediate files.

```bash
make all
```

### 2. **`build`**

Generates C source files from the Flex and Bison specifications.

```bash
make build
```

### 3. **`compiler`**

Compiles the generated source files and creates the final executable in the `out/compiler/` directory.

```bash
make compiler
```

### 4. **`clean`**

Removes all build artifacts and intermediate files.

```bash
make clean
```

---

## How to Run

1. **Build the Compiler:**

   ```bash
   make all
   ```

2. **Run the Compiler:**

   Use the generated compiler to process a source code file.

   ```bash
   ./out/compiler/compiler <source_file>
   ```

   Replace `<source_file>` with the path to your source code file.

---

## Dependencies

The project uses the following libraries:

- **Flex**: Generates the lexical analyzer (`lex.yy.c`).
- **Bison**: Generates the syntax parser (`synt.tab.c`).
- **GCC**: Compiles the C files into an executable.
- **Standard C Libraries**: Used for file handling and basic operations.

---

## Testing

Place test source files in the `test/` directory. Run the compiler with these test files to validate its functionality.

Example:

```bash
./out/compiler/compiler test/example_source.txt
```

---

## Authors
- **BADLA MOUSSAAB**: 
- **BOUKHARI DJINANE**:

---

