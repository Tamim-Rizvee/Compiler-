%option noyywrap
%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<iostream>
#include"symboltable.h"
#define YYSTYPE symbolInfo
#include"practice.tab.h"

extern "C" {
    void yyerror(const char *msg);
    int yywrap(void);
}
%}

ws          [ \t]+
digit       [0-9]+
number      {digit}(\.{digit})?
indent      [_a-zA-Z][_A-Za-z0-9]*
newline     [\n]+
%%
{ws}        {}
{newline}   {
                return NEWLINE;     
            }
"main"      {
                return MAIN;
            }

"int"       {
                return INT;
            }

{indent}    {
                symbolInfo ob(std::string(yytext) , "IDENTIFIER");
                yylval = (YYSTYPE) ob;
                return IDENTIFIER;
            }
{number}    {
                symbolInfo ob(std::string(yytext) , "NUMBER");
                yylval = (YYSTYPE)ob;
                return NUMBER;
            }
"+" 	 {
		    return ADD;
	     }
		 
"-" 	 {
		    return SUB;
	     }

"*" 	 {
		    return MUL;
	     }

"/" 	 {
		    return DIV;
	     }

"%" 	 {
		    return MOD;
	     }		 
"="		 {
			return ASSOP;
		 }
		 
"(" 	 {
			return LPARAN;
		 }
		 
")" 	 {
			return RPARAN;
		 }

"{" 	 {
			return LCURLY;
		 }
		 
"}" 	 {
			return RCURLY;
		 }
		 
";" 	 {
			return SEMICOLON;
		 }	

"&&"	 {
			return LAND;
		 }		 

"||"	 {
			return LOR;
		 }

.       {
            char msg[25];
            sprintf(msg ,"<%s %s>" , "Invalid token" , yytext);
        }
%%