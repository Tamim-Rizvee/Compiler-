%option noyywrap
%{
    #include<bits/stdc++.h>
    #include "SymbolTable.h"
    #define YYSTYPE SymbolInfo
    #include "prac.tab.h"
    using namespace std;
    void yyerror(const char *msg);
    SymbolTable tb;
%}

ws              [ \t]+
digit           [0-9]
number          {digit}+(\.{digit}+)?
ident           [_a-zA-Z][_a-zA-Z0-9]*
newline         [\n]+
%%
{ws}            {}
{newline}       {
                    return NEWLINE;
                }
"int"           {
                    return INT;
                }
"main"          {
                    return MAIN;
                }
{ident}         {
                    string value = string(yytext) , type = "IDENTIFIER";
                    SymbolInfo ob(value , type);
                    yylval = (YYSTYPE) ob;
                    tb.INSERT(value , type);
                    return IDENTIFIER;
                }
{number}        {
                    string value = string(yytext) , type = "NUMBER";
                    SymbolInfo ob(value , type);
                    yylval = (YYSTYPE) ob;
                    tb.INSERT(value , type);
                    return NUMBER;
                }

"+"             {
                    return ADD;
                }
"-"             {
                    return SUB;
                }
"/"             {
                    return DIV;
                }
"*"             {
                    return MUL;
                }
"{"             {
                    return LCURLY;
                }
"}"             {
                    return RCURLY;
                }
"("             {
                    return LPAREN;
                }
")"             {
                    return RPAREN;
                }
"%"             {
                    return MOD;
                }
"="             {
                    return ASSOP;
                }
";"             {
                    return SEMICOLON;
                }
"||"            {
                    return LOR;
                }
"&&"            {
                    return LAND;
                }
.               {
                    char msg[25];
                    sprintf(msg , "%s" , "Invalid Character");
                    yyerror(msg);
                }

%%