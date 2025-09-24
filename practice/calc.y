%{
#include<stdio.h>
#include<stdlib.h>
#define YYSTYPE double
void yyerror(const char *s)
{
    printf("%s\n" , s);
}
int yylex();
%}
%token NEWLINE NUMBER RPAREN LPAREN
%left  PLUS SUB
%left  DIV MUL
%%
input:
| input line;

line: NEWLINE {printf("New line detected\n");}
| expr NEWLINE {printf("Result: %g\n", $1);};

expr: NUMBER 
| expr PLUS expr {$$ = $1 + $3;}
| expr SUB expr {$$ = $1 - $3;}
| expr MUL expr {$$ = $1 * $3;}
| expr DIV expr {
                    if($3 == 0)
                    {
                        yyerror("Cant be divided by 0");
                    }
                    else 
                    {
                        $$ = $1 / $3;
                    }
                }
| LPAREN expr RPAREN {$$ = $2;};
%%
int main()
{
    yyparse();
    return 0;
}