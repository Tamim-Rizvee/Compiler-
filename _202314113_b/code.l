%option noyywrap
%{
#include<stdio.h>
#include<string.h>
int line_number = 1;
FILE *yyin;
FILE *yyout;
%}

digit			[0-9]
digits			{digit}+
letter 			[a-zA-Z_]
id 				{letter}({letter}|{digit})*
delim 			[ \t]
keyword 		"if"|"int"|"else"|"switch"|"case"|"while"|"for"|"float"|"double"|"break"|"default"|"void"|"return"
number 			[+\-]?{digits}(\.{digits})*(e[+\-]?{digits})?
ass_op			=|<<=|>>=|&=|^=|\|=
bit_op			>>|<<|&|^|\|
parenthesis 	[()]
curly_braces	[{}]
seperator 		[,:;]
function 		{id}\(\".*\"\)


%%
\n				{line_number++;}
{keyword}		{fprintf(yyout , "<Keywords , %s, %d>\n" , yytext, line_number);}
{id}			{fprintf(yyout , "<Identifier , %s, %d>\n" , yytext, line_number);}
{number}		{fprintf(yyout , "<Number , %s, %d>\n" , yytext , line_number);}
{ass_op}		{fprintf(yyout , "<Assignment Operator , %s , %d>\n" , yytext , line_number);}
{bit_op}		{fprintf(yyout , "<Bitwise Operartor , %s, %d>\n" , yytext , line_number);}
{parenthesis}	{fprintf(yyout , "<Parentheses , %s, %d>\n" , yytext, line_number);}
{curly_braces}	{fprintf(yyout , "<Curly , %s, %d>\n" , yytext, line_number);}
{seperator}		{fprintf(yyout , "<Seperator , %s , %d>\n" , yytext , line_number);}
{function}		{
					char *find = strchr(yytext , '(');
					if(find != NULL)
						*find = '\0';
					fprintf(yyout , "<Function , \"%s\" , %d>\n" , yytext , line_number);
				}
{delim}			{}
%%

int main()
{
	yyin = fopen("sample_input.txt" , "r");
	if(!yyin)
	{
		perror("Could not open the file");
		return 1;
	}
	
	yyout = fopen("output.txt" , "w");
	if(!yyout)
	{
		perror("could not open the file");
		fclose(yyin);
		return 1;
	}
	
	yylex();
	fclose(yyin);
	fclose(yyout);
	return 0;
}