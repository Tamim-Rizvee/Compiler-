%option noyywrap
%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include"calc.tab.h"
%}

ws               [ \t]+
digit            [0-9]
number          [-]?{digit}+(\.{digit}+)?
newline          [\n]
%%
{number}        {
                    sscanf(yytext , "%lf" , &yylval);
                    return NUMBER;
                }
"+"             {return PLUS;}
"-"             {return SUB;}
"/"             {return DIV;}
"*"             {return MUL;}
"("             {return LPAREN;}
")"             {return RPAREN;}
{newline}       {return NEWLINE;}
{ws}            {}
%%
