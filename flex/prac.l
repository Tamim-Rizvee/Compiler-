%option noyywrap
%{
#include<stdio.h>
FILE *yyin;
FILE *yyout;
int is_name = 0;
int count = 0;
%}
upper_case 		[A-Z]
lower_case 		[a-z]
digit 			[0-9]
order_num 		"ORD"({digit}|{upper_case})+
name			{upper_case}{lower_case}+
email 			{lower_case}({lower_case}|{digit}|_|\.)*@{lower_case}+\.{lower_case}+
date			{digit}{digit}\/{digit}{digit}\/{digit}{digit}{digit}{digit}
airtel 			(\+88)?016{digit}+
bl 				(\+88)?014{digit}+
gp				(\+88)?(017|013){digit}+

%%
{order_num}		{fprintf(yyout , "Order number: %s\n", yytext);}
{name}			{
					if(!is_name)
					{
						fprintf(yyout , "Name: %s ", yytext);
						is_name = 1;
					}
					else 
						fprintf(yyout , "%s " , yytext);
				}
{email}			{fprintf(yyout , "\nEmail: %s\n", yytext); is_name = 0;}
{date}			{fprintf(yyout , "Date: %s\n", yytext);count++;}
{airtel}		{fprintf(yyout , "airtel number: %s\n", yytext);}
{bl}			{fprintf(yyout , "bangalink number: %s\n", yytext);}
{gp}			{fprintf(yyout , "grameen phone number: %s\n", yytext);}
.				{}
%%

int main()
{
	yyin = fopen("input.txt" , "r");
	yyout = fopen("output_prac.txt" , "w");
	yylex();
	fprintf(yyout , "Total Order %d", count);
	fclose(yyin);
	fclose(yyout);
	return 0;
}