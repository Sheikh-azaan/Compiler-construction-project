%{
#include <iostream>
using namespace std;

extern int yylex();
extern int line_no;
void yyerror(const char *s);
%}


%token DATATYPE IDENTIFIER
%token IFX ELX WLOOP SHOW TAKE
%token INT_LITERAL FLOAT_LITERAL STRING_LITERAL BOOL_LITERAL CHAR_LITERAL
%token ASSIGN_OP REL_OP ENDLINE
%token BLOCK_START BLOCK_END GROUP_START GROUP_END
%token COMMENT

%start Program
%expect 1  

%%

Program
    : StmtList
    ;

StmtList
    : /* empty */
    | Statement StmtList
    ;

Statement
    : Declaration
    | Assignment
    | Conditional
    | Loop
    | IOStatement
    | COMMENT
    ;


Declaration
    : DATATYPE IDENTIFIER ASSIGN_OP Value ENDLINE
    | DATATYPE error ENDLINE
        { yyerror("Invalid declaration statement"); }
    ;


Assignment
    : IDENTIFIER ASSIGN_OP Value ENDLINE
    | IDENTIFIER error ENDLINE
        { yyerror("Invalid assignment statement"); }
    ;


Conditional
    : IFX Condition ENDLINE
    | IFX Condition Block ElsePart
    | IFX error ENDLINE
        { yyerror("Invalid ifx condition"); }
    ;

ElsePart
    : ELX Block
    | 
    ;


Loop
    : WLOOP Condition Block
    | WLOOP error ENDLINE
        { yyerror("Invalid loop statement"); }
    ;


IOStatement
    : SHOW Value ENDLINE
    | TAKE IDENTIFIER ENDLINE
    | SHOW error ENDLINE
        { yyerror("Invalid print statement"); }
    | TAKE error ENDLINE
        { yyerror("Invalid input statement"); }
    ;


Block
    : BLOCK_START StmtList BLOCK_END
    | BLOCK_START error BLOCK_END
        { yyerror("Invalid block statement"); }
    ;


Condition
    : IDENTIFIER REL_OP Value
    | IDENTIFIER ASSIGN_OP Value
    | GROUP_START Condition GROUP_END
    | error
        { yyerror("Invalid condition"); }
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
         << ": " << s << endl;
}

int main()
{
    cout << "\nNEO++ PARSER STARTED\n";
    yyparse();
    return 0;
}
