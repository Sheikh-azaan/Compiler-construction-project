%option noyywrap

%{
#include "neo.tab.h"
#include <iostream>
using namespace std;

int line_no = 1;
%}

%%


"//"[^\n]*                    { return COMMENT; }
"/\\*"([^*]|\*+[^*/])*\*+"/"  { return COMMENT; }


"ifx"     { return IFX; }
"elx"     { return ELX; }
"wloop"   { return WLOOP; }
"show"    { return SHOW; }
"take"    { return TAKE; }


"num"|"decil"|"txt"|"booll"|"charac" { return DATATYPE; }


"yes"|"no"                    { return BOOL_LITERAL; }
[0-9]+\.[0-9]+                { return FLOAT_LITERAL; }
[0-9]+                        { return INT_LITERAL; }
`[^`]*`                       { return STRING_LITERAL; }
\|.\|                         { return CHAR_LITERAL; }


"::"                          { return ASSIGN_OP; }
"=="|"=?"|"<<"|">>"           { return REL_OP; }


";;"                          { return ENDLINE; }
"(("                          { return GROUP_START; }
"))"                          { return GROUP_END; }
"{{"                          { return BLOCK_START; }
"}}"                          { return BLOCK_END; }


@[_a-zA-Z][_a-zA-Z0-9]*       { return IDENTIFIER; }


[ \t\r]+                     { /* skip */ }
\n                            { line_no++; }


. {
    cout << "Lexical Error at line " << line_no
         << ": invalid character '" << yytext << "'" << endl;
}

%%
