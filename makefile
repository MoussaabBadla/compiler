buildDir = out
libDir = lib
compilerDir = $(buildDir)/compiler
testDir = test


lexFile = $(libDir)/lex.l
synFile = $(libDir)/synt.y
symbolFile = $(libDir)/ts.c
headerFile = $(libDir)/ts.h


$(buildDir):
		mkdir -p $(buildDir)

all: $(buildDir) build compiler clean


build: $(buildDir)
		flex -o $(buildDir)/lex.yy.c $(lexFile)
		bison -d $(synFile) -o $(buildDir)/synt.tab.c


compile: $(buildDir)
		mkdir -p $(compilerDir)
		gcc  $(buildDir)/lex.yy.c  $(buildDir)/synt.tab.c  -o $(compilerDir)/compiler  -ly -lm
		 
clean:
		rm -rf $(buildDir)/*



		
.PHONY: all build clean