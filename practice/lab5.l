%option noyywrap
%{
#include<bits/stdc++.h>
#include "SymbolTable.h"
#define YYSTYPE SymbolInfo
#include "lab5.tab.h"
using namespace std;
void yyerror(const char* msg);
SymbolTable Tb;
%}
GAP		[ \t]+
DIGITS  [0-9]+
NUMBER	{DIGITS}(\.{DIGITS})?
IDENTIFIER	[_A-Za-z][_A-Za-z0-9]*
%%
{GAP} 	 { }

[\n]+ 	 {
			return NEWLINE;
		 }
		 
"main"	 {
			return MAIN;
		 }
		 
"int" 	 {
			return INT;
		 }
		 
{IDENTIFIER} {
				SymbolInfo ob(string(yytext), "IDENTIFIER");
				yylval=(YYSTYPE)ob;
				Tb.INSERT(string(yytext),"IDENTIFIER");
				return IDENTIFIER;
			 }
			 
{NUMBER} {
			SymbolInfo ob(string(yytext), "NUMBER");
			yylval = (YYSTYPE) ob;
			Tb.INSERT(string(yytext),"NUMBER");
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

.        {
			char msg[25];
			sprintf(msg," <%s>","invalid character",yytext);
			yyerror(msg);
		 }
%%
