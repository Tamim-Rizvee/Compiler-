%{
    #include<bits/stdc++.h>
    #include "SymbolTable.h"
    #define YYSTYPE SymbolInfo
    using namespace std;
    char *str;
    int yylex(void);
    int t_count = 1;
    SymbolInfo asmc;
    extern SymbolTable tb;
    extern FILE *yyin;
    ofstream fir("code.ir");
    ofstream fasm("code.asm");
    void yyerror(const char *s)
    {
        fprintf(stderr , "%s\n" , s);
        return;
    }
    char *new_temp(int i)
    {
        char *tvar = (char *) malloc(15);
        sprintf(tvar , "t%d" , i);
        return tvar;
    }
%}

%error-verbose
%token NUMBER
%token INT
%token IDENTIFIER
%token MAIN
%token NEWLINE
%token SEMICOLON
%token LCURLY
%token RCURLY

%right ASSOP
%left  LOR LAND
%left  ADD SUB
%left  MUL DIV MOD
%left  LPAREN RPAREN

%%
program: 
    MAIN LPAREN RPAREN LCURLY NEWLINE stmt RCURLY
    {
        asmc.code += "MAIN ENDP\n";
        asmc.code += "END MAIN\n";
        fasm << asmc.code;
    }
;
stmt: stmt line     {}
| line              {}
;
line: 
    expr_decl NEWLINE
    {
        t_count = 1;
        printf("\t\n");
    }
;

expr_decl:
    term ASSOP expr SEMICOLON
    {
        t_count -= 1;
        str = new_temp(t_count);
        SymbolInfo obj(string(str) , "");
        $$ = obj;

        fir << $1.getSymbol() << " = " << $3.getSymbol() << endl;
        asmc.code += "MOV AX , " + $3.getSymbol() + "\n";
        asmc.code += "MOV " + $1.getSymbol() + " , AX\n";
        t_count = 1;
    }
;

expr:
    expr ADD expr
    {
        str = new_temp(t_count);
        SymbolInfo obj(string(str) , "");
        $$ = obj;

        fir << $$.getSymbol() << "=" << $1.getSymbol() << "+" << $3.getSymbol() << endl;
        asmc.code += "MOV AX , " + $1.getSymbol() + "\n";
        asmc.code += "MOV BX , " + $3.getSymbol() + "\n";
        asmc.code += "ADD AX , BX\n";
        t_count++;
    }
|   NUMBER
    {
        $$ = $1;
    }
|   term 
    {
        $$ = $1;
    }
;
term:
    IDENTIFIER
    {
        $$ = $1;
    }
;

%%
int main()
{
    asmc.code += ".MODEL SMALL\n";
    asmc.code += ".STACK 100H\n";
    asmc.code += ".DATA\n";
    asmc.code += ".CODE\n";
    asmc.code += "MAIN PROC\n";
    asmc.code += "MOV AX , @DATA\n";
    asmc.code += "MOV DS , AX\n";
    yyin = fopen("input.txt" , "r");
    yyparse();
    fclose(yyin);
    fir.close();
    fasm.close();
    tb.print();
    return 0;
}