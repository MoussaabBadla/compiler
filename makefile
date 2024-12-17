buildDir = out
libDir = lib
compilerDir = $(buildDir)/compiler
testDir = test

compiler = $(compilerDir)/lexical

lexFile = $(libDir)/lex.l
synFile = $(libDir)/synt.y
symbolFile = $(libDir)/ts.c
headerFile = $(libDir)/ts.h


$(buildDir):
		mkdir -p $(buildDir)




all: $(buildDir) build compile test 


build: $(buildDir)
		cp $(headerFile) $(buildDir)/ts.h
		flex -o $(buildDir)/lex.yy.c $(lexFile)
		bison -d $(synFile) -o $(buildDir)/synt.tab.c


compile: $(buildDir)
		mkdir -p $(compilerDir)
		gcc  $(buildDir)/lex.yy.c  $(buildDir)/synt.tab.c   -o $(compilerDir)/lexical
		 
clean:
		rm -rf $(buildDir)/*


test: $(buildDir) compile
		$(compiler) < $(testDir)/program.txt
		
.PHONY: all build clean