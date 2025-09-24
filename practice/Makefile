CXX = g++
CXXFLAGS = -std=c++11 -w

all: parser

parser: practice.tab.c lex.yy.c
	$(CXX) $(CXXFLAGS) -o parser practice.tab.c lex.yy.c

practice.tab.c: practice.y
	bison -d practice.y

lex.yy.c: prac.l practice.tab.h
	flex prac.l

clean:
	del *.tab.c *.tab.h lex.yy.c parser.exe code.ir code.asm 2>nul || echo "Cleaned"

.PHONY: all clean