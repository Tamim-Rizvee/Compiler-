%option noyywrap
%{
#include<stdio.h>
%}

digit			[0-9]
digits 			{digit}+
letter 			[a-zA-Z_]
id 				{letter}({letter}|{digit})*
delim 			[ \t\n]
number 			[+\-]?{digits}(\.{digits})*(e[+\-]?{digits})?
bit_op			>>|<<|&|^|\|
ass_op			=|<<=|>>=|&=|^=|\|=
parenthesis 	[()]
curly_braces	[{}]
function		{id}\(\".*\"\)

%%
{function}		{printf("function , %s" , yytext);}
{number}		{printf("number , %s\n", yytext);}
{id}			{printf("Identifier , %s\n" , yytext);}
{ass_op}		{printf("ass_op , %s\n" , yytext);}
{bit_op}		{printf("Bit_op , %s\n" , yytext);}
{parenthesis}	{printf("parenthesis , %s\n" , yytext);}
{curly_braces}	{printf("Curly , %s\n" , yytext);}
{delim}			{}
%%

int main()
{
	yylex();
	return 0;
}