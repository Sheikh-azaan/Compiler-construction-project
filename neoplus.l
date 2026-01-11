%{
#include "t.tab.h"
#include <iostream>
using namespace std;

int line_no = 1;
%}

%%


"//"[^\n]*              { return COMMENT; }
"/\\*"([^*]|\*+[^*/])*\*+"/" { return COMMENT; }


"func"|"num"|"decil"|"txt"|"booll"|"charac" { return DATATYPE; }


"ifx"   { return IFX; }
"elx"   { return ELX; }
"wloop" { return WLOOP; }
"show"  { return SHOW; }
"take"  { return TAKE; }


"yes"|"no"          { return BOOL_LITERAL; }
[0-9]+\.[0-9]+      { return FLOAT_LITERAL; }
[0-9]+              { return INT_LITERAL; }
`[^`]*`             { return STRING_LITERAL; }
\|.\|               { return CHAR_LITERAL; }


"::"                { return ASSIGN_OP; }
"=="|"!="|"<"|">"   { return REL_OP; }


";;"  { return ENDLINE; }
"(("  { return GROUP_START; }
"))"  { return GROUP_END; }
"{{"  { return BLOCK_START; }
"}}"  { return BLOCK_END; }


@[_a-zA-Z][_a-zA-Z0-9]* { return IDENTIFIER; }


[ \t\r]+  { }
\n        { line_no++; }


. {
    cout << "Syntax Error at line " << line_no
         << ": syntax error '" << yytext[0] << "'" << endl;
}

%%

int yywrap() { return 1; }

int main()
{
    cout << "\nNEO++ LEXICAL ANALYZER STARTED\n";

    while (yylex() != 0)
        ;   

    cout << "\nLexical analysis completed." << endl;
    cout << "Total lines scanned: " << line_no << endl;

    return 0;
}

