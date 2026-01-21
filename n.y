%{
#include <iostream>

using namespace std;

void yyerror(const char *s);
int yylex();
%}


%token NUMBER IDENTIFIER LITERAL
%token CHECK OTHERWISE REPEATWHILE SHOWOUT
%token BLOCK_START BLOCK_END TERMINATOR
%token ADD_OP EQ_OP

%start Program

%%

Program
    : Block
    ;

Block
    : BLOCK_START StmtList BLOCK_END
    | error BLOCK_END
      { yyerror("Missing BLOCK_START or incorrect block"); yyerrok; }
    ;

StmtList
    : Stmt StmtList
    | /* empty */
    ;

Stmt
    : Assign
    | CondMatched
    | Loop
    | Output
    | error TERMINATOR
      { yyerror("Invalid statement"); yyerrok; }
    ;

Assign
    : IDENTIFIER ADD_OP TERMINATOR
      { cout << "Increment statement detected.\n"; }
    ;

CondMatched
    : CHECK '(' IDENTIFIER EQ_OP IDENTIFIER ')' Block OTHERWISE Block
      { cout << "IF-ELSE statement detected.\n"; }
    | error ')' Block OTHERWISE Block
      { yyerror("Invalid IF-ELSE statement"); yyerrok; }
    ;

Loop
    : REPEATWHILE '(' IDENTIFIER EQ_OP IDENTIFIER ')' Block
      { cout << "RepeatWhile loop detected.\n"; }
    | error ')' Block
      { yyerror("Invalid RepeatWhile loop"); yyerrok; }
    ;

Output
    : SHOWOUT '(' LITERAL ')' TERMINATOR
      { cout << "Output statement detected.\n"; }
    | error ')' TERMINATOR
      { yyerror("Invalid output statement"); yyerrok; }
    ;

%%

void yyerror(const char *s) {
    cerr << "Syntax Error: " << s << endl;
}

int main() {
    cout << "NovaLang Parser Started..." << endl;
    yyparse();
    cout << "Parsing Finished." << endl;
    return 0;
}
