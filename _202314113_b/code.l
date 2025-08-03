%option noyywrap

%{
#include <stdio.h>
FILE *yyin;
FILE *yyout;
%}

letter			[A-Za-z]
id           	letter*
delim 			[ \t\n]+

%%
{id}		{fprintf(yyout , "identifier , %s\n" , yytext);}
delim		;
.			{fprintf(yyout , "none %s\n" , yytext);}		
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