%{
    #include<bits/stdc++.h>
    #include "SymbolTable.h"
    #define YYSTYPE SymbolInfo
    using namespace std;
    int yylex(void);
    char *str;
    int t_count = 1;
    SymbolInfo asmc;
    extern SymbolTable tb;
    extern FILE *yyin;
    ofstream fir("code.ir");
    ofstream fasm("code.asm");
    void yyerror(const char *s)
    {
        fprintf(stderr , "%s" , s);
        return;
    }
    char * next_var(int i)
    {
        char *var = (char *) malloc(15);
        int temp_num = ((i - 1) % 3) + 1;  // Cycle through 1, 2, 3
        sprintf(var , "t%d" , temp_num);
        return var;
    }
%}

%error-verbose
%token NUMBER
%token MAIN
%token INT
%token IDENTIFIER
%token NEWLINE
%token SEMICOLON
%token LCURLY RCULRLY

%right ASSOP
%left  ADD SUB
%left  MUL 
%left  LPAREN RPAREN

%%
program:
    MAIN LPAREN RPAREN LCURLY NEWLINE stmt RCULRLY
    {
        fasm << asmc.data << endl;
        fasm << ".CODE\n";
        fasm << "MAIN PROC\n";
        asmc.code += "MAIN ENDP\nEND MAIN";
        fasm << asmc.code ;
    }
;
stmt : stmt unit {}
| unit           {}
;
unit:
    var_decl NEWLINE
    {
        t_count = 1;
        printf("\t\n");
    }
|   expr_decl NEWLINE
    {
        t_count = 1;
        printf("\t\n");
    }
;

var_decl:
    type_spec decl_list SEMICOLON
    {
        string var = $2.getSymbol();
        asmc.data += "\t"+  var + " db ?\n";
    }
;
decl_list:
    term
    {
        $$ = $1;
    }
;
type_spec:
    INT { $$ = $1;}
;
expr_decl:
    term ASSOP expr SEMICOLON
    {
        t_count -= 1;
        str = next_var(t_count);
        SymbolInfo obj(string(str) , "");
        $$ = obj;

        fir << $1.getSymbol() << "=" << $3.getSymbol() << endl;
        asmc.code += "MOV AX , " + $3.getSymbol() + "\n";
        asmc.code += "MOV " + $1.getSymbol() + " ,AX\n";
        t_count = 1;
    }
;
expr:
    LPAREN expr RPAREN
    {
        $$ = $2;
    }
|   expr ADD expr
    {
        str = next_var(t_count);
        SymbolInfo obj(string(str) , "");
        $$ = obj;

        fir << $$.getSymbol() << "=" << $1.getSymbol() << "+" << $3.getSymbol() << endl;
        asmc.code += "MOV AX , " + $1.getSymbol() + "\n";
        asmc.code += "MOV BX , " + $3.getSymbol() + "\n";
        asmc.code += "ADD AX , BX\n";
        t_count++;
    }
|   expr SUB expr
    {
        str = next_var(t_count);
        SymbolInfo obj(string(str) , "");
        $$ = obj;

        fir << $$.getSymbol() << "=" << $1.getSymbol() << "-" << $3.getSymbol() << endl;
        asmc.code += "MOV AX , " + $1.getSymbol() + "\n";
        asmc.code += "MOV BX , " + $3.getSymbol() + "\n";
        asmc.code += "SUB AX , BX\n";
        t_count++;
    }
|   expr MUL expr
    {
        str = next_var(t_count);
        SymbolInfo obj(string(str) , "");
        $$ = obj;

        fir << $$.getSymbol() << "=" << $1.getSymbol() << "*" << $3.getSymbol() << endl;
        asmc.code += "MOV AX , " + $1.getSymbol() + "\n";
        asmc.code += "MOV BX , " + $3.getSymbol() + "\n";
        asmc.code += "MUL BX\n";
        t_count++;
    }
|   NUMBER { $$ = $1; }
|   term   { $$ = $1; }
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
    fasm << ".MODEL SMALL\n";
    fasm << ".STACK 100H\n";
    fasm << ".DATA\n";
    fasm << "\t t1 db ?\n";
    fasm << "\t t2 db ?\n";
    fasm << "\t t2 db ?\n";
    yyin = fopen("input.txt" , "r");
    yyparse();
    fclose(yyin);
    fir.close();
    fasm.close();
    tb.print();
    return 0;
}