%option noyywrap
%{
    #include<bits/stdc++.h>
    #include "SymbolTable.h"
    #define YYSTYPE SymbolInfo
    #include "ass5_113.tab.h"
    using namespace std;
    void yyerror(const char *msg);
    SymbolTable tb;
%}

ws          [ \t]+
digit       [0-9]+
number      {digit}(\.{digit})?
ident       [_a-zA-Z][_a-zA-Z0-9]*
newline     [\n]+
%%
"main"      {
                return MAIN;
            }
"int"       {
                return INT;
            }
{ws}        {}
{newline}   {
                return NEWLINE;
            }
{ident}     {
                string value = string(yytext) , token = "IDENTIFIER";
                SymbolInfo ob(value , token);
                yylval = (YYSTYPE) ob;
                tb.INSERT(value , token);
                return IDENTIFIER;
            }
{number}    {
                string value = string(yytext) , token = "NUMBER";
                SymbolInfo ob(value , token);
                yylval = (YYSTYPE) ob;
                tb.INSERT(value , token);
                return NUMBER;
            }
"+"         {
                return ADD;
            }
"-"         {
                return SUB;
            }
"*"         {
                return MUL;
            }
"{"         {
                return LCURLY;
            }
"}"         {
                return RCULRLY;
            }
"("         {
                return LPAREN;
            }
")"         {
                return RPAREN;
            }
"="         {
                return ASSOP;
            }
";"         {
                return SEMICOLON;
            }
.           {
                char msg[25];
                sprintf(msg , "%s %s" , "Invalid character" , yytext);
                yyerror(msg);
            }
%%
