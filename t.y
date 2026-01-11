%{
#include <iostream>
using namespace std;

extern int yylex();
extern int line_no;
void yyerror(const char *s);
%}

%token FUNC IDENTIFIER DATATYPE
%token IFX ELX WLOOP SHOW TAKE
%token INT_LITERAL FLOAT_LITERAL STRING_LITERAL BOOL_LITERAL CHAR_LITERAL
%token ASSIGN_OP REL_OP ENDLINE
%token BLOCK_START BLOCK_END GROUP_START GROUP_END
%token COMMENT

%start Program

%%

Program
    : DATATYPE IDENTIFIER ASSIGN_OP Block
    ;

Block
    : BLOCK_START StmtList BLOCK_END
    ;

StmtList
    : Statement StmtList
    | /* empty */
    ;

Statement
    : Declaration
    | Assignment
    | Conditional
    | Loop
    | IOStatement
    ;

Declaration
    : DATATYPE IDENTIFIER ASSIGN_OP Value ENDLINE
    ;

Assignment
    : IDENTIFIER ASSIGN_OP Value ENDLINE
    ;

Conditional
    : IFX Condition Block ElsePart
    ;

ElsePart
    : ELX Block
    | /* empty */
    ;

Loop
    : WLOOP Condition Block
    ;

IOStatement
    : SHOW Value ENDLINE
    | TAKE IDENTIFIER ENDLINE
    ;

Condition
    : IDENTIFIER REL_OP Value
    ;

Value
    : IDENTIFIER
    | INT_LITERAL
    | FLOAT_LITERAL
    | STRING_LITERAL
    | BOOL_LITERAL
    | CHAR_LITERAL
    | GROUP_START Value GROUP_END
    ;

%%

void yyerror(const char *s)
{
    cout << "Syntax Error at line " << line_no
         << ": code does not match CFG" << endl;
}

int main()
{
    cout << "\nNEO++ PARSER STARTED\n";
    yyparse();
    return 0;
}
