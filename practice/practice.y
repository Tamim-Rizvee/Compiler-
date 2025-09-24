%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<iostream>
#include<fstream>
#include"symboltable.h"
#define YYSTYPE symbolInfo
extern int yylex(void);
int t_count = 1;
char *str;
symbolInfo asmc;
extern FILE *yyin;
std::ofstream fir("code.ir");
std::ofstream fasm("code.asm");

extern "C" {
    void yyerror(const char *s);
    int yyparse(void);
}

void yyerror(const char *s)
{
    fprintf(stderr , "%s\n" , s);
}

char *newTemp(int i)
{
    char *tvar = (char *) malloc(15);
    sprintf(tvar , "t%d" , i);
    return tvar;
}
%}
%error-verbose
%token NUMBER
%token INT
%token IDENTIFIER
%token MAIN
%token NEWLINE
%token SEMICOLON
%token LCURLY
%token RCURLY

%right ASSOP
%left LOR
%left LAND
%left ADD SUB
%left MUL DIV MOD
%left LPARAN RPARAN
%%
program: INT MAIN LPARAN RPARAN LCURLY NEWLINE stmt RCURLY {
                                                                asmc.code = asmc.code + "MAIN ENDP\nEND";
                                                                fasm << asmc.code;
                                                           } 
;
stmt: stmt line { }
| line          { }
;
line: expr_decl  NEWLINE    {
                                t_count = 1;
                                printf("\n");
                            }
;

expr_decl: term ASSOP expr SEMICOLON {
                                        t_count-= 1;
                                        str = newTemp(t_count);
                                        symbolInfo obj1(std::string(str) , "");
                                        $$ = obj1;
                                        fir << $1.getSymbol() << "=" << $3.getSymbol() << std::endl;

                                        asmc.code=asmc.code+"MOV ax, "+$3.getSymbol()+"\nMOV "+$1.getSymbol()+", ax\n";
									    t_count=1;	
                                     }
;
expr: expr ADD expr                 {
                                        str = newTemp(t_count);
                                        symbolInfo obj1(std::string(str) , "");
                                        $$ = obj1;
                                        fir << $$.getSymbol() << "=" << $1.getSymbol() << "+" << $3.getSymbol() << std::endl;
                                        asmc.code = asmc.code + "MOV ax , " + $1.getSymbol() + "\nMOV bx , " + $3.getSymbol()+"\nADD ax, bx\nMOV "+$$.getSymbol()+", ax\n";
								        t_count++;
                                    }
| NUMBER                            {
                                        $$ = $1;
                                    }

|term					            {
							            $$=$1;
						            }
;
term : IDENTIFIER                   {
                                        $$ = $1;
                                    }
;
%%
extern "C" int main(void)
{
	asmc.code = asmc.code + ".MODEL SMALL\n.STACK 100H\n.DATA\na DW ?\nt1 DW ?\nt2 DW ?\nt3 DW ?\nt4 DW ?\n";
	asmc.code = asmc.code + ".CODE\nMAIN PROC\nMOV AX,@DATA\nMOV DS,AX \n";
	yyin=fopen("input.txt","r");
	yyparse();
	fclose(yyin);
	fir.close();
	fasm.close();
	return 0;
}