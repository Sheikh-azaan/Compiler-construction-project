%{
#include <iostream>
#include <string>
using namespace std;

int line_no = 1;
int token_count = 0;
%}

%option noyywrap

%%

"/\\"([^\\]|\\n)*"/\\" {
    token_count++;
    cout << "[Line " << line_no << " | Token " << token_count << "] "
         << "COMMENT (multi-line)\t" << yytext << endl;
}

\/\/[^\n]* {
    token_count++;
    cout << "[Line " << line_no << " | Token " << token_count << "] "
         << "COMMENT (single-line)\t" << yytext << endl;
}


"func"|"num"|"decil"|"txt"|"booll"|"charac"|"arr"|"struc" {
    token_count++;
    cout << "[Line " << line_no << " | Token " << token_count << "] "
         << "DATATYPE\t\t" << yytext << endl;
}

"ifx"|"elx"|"wloop"|"dwloop"|"floop"|"ret"|"show"|"take"|"giveback" {
    token_count++;
    cout << "[Line " << line_no << " | Token " << token_count << "] "
         << "KEYWORD\t\t" << yytext << endl;
}


"yes"|"no" {
    token_count++;
    cout << "[Line " << line_no << " | Token " << token_count << "] "
         << "BOOLEAN LITERAL\t" << yytext << endl;
}


"::"|"++"|"--"|"**"|"~"|"=\?"|"&&&"|"!"|"**" {
    token_count++;
    cout << "[Line " << line_no << " | Token " << token_count << "] "
         << "OPERATOR\t\t" << yytext << endl;
}


":" {
    token_count++;
    cout << "[Line " << line_no << " | Token " << token_count << "] "
         << "PUNCTUATION (colon)\t" << yytext << endl;
}
";;" {
    token_count++;
    cout << "[Line " << line_no << " | Token " << token_count << "] "
         << "PUNCTUATION (endline)\t" << yytext << endl;
}
"." {
    token_count++;
    cout << "[Line " << line_no << " | Token " << token_count << "] "
         << "PUNCTUATION (separator)\t" << yytext << endl;
}
"((" {
    token_count++;
    cout << "[Line " << line_no << " | Token " << token_count << "] "
         << "GROUP START ((\t" << yytext << endl;
}
"))" {
    token_count++;
    cout << "[Line " << line_no << " | Token " << token_count << "] "
         << "GROUP END ))\t" << yytext << endl;
}
"{{" {
    token_count++;
    cout << "[Line " << line_no << " | Token " << token_count << "] "
         << "BLOCK START {{\t" << yytext << endl;
}
"}}" {
    token_count++;
    cout << "[Line " << line_no << " | Token " << token_count << "] "
         << "BLOCK END }}\t" << yytext << endl;
}


[0-9]+\.[0-9]+ {
    token_count++;
    cout << "[Line " << line_no << " | Token " << token_count << "] "
         << "FLOAT LITERAL\t" << yytext << endl;
}

[0-9]+ {
    token_count++;
    cout << "[Line " << line_no << " | Token " << token_count << "] "
         << "INTEGER LITERAL\t" << yytext << endl;
}

`[^`]*` {
    token_count++;
    cout << "[Line " << line_no << " | Token " << token_count << "] "
         << "STRING LITERAL\t" << yytext << endl;
}

\|.\| {
    token_count++;
    cout << "[Line " << line_no << " | Token " << token_count << "] "
         << "CHARACTER LITERAL\t" << yytext << endl;
}


@[_a-zA-Z][_a-zA-Z0-9]* {
    token_count++;
    cout << "[Line " << line_no << " | Token " << token_count << "] "
         << "IDENTIFIER\t\t" << yytext << endl;
}


[ \t\r]+    {  }
\n          { line_no++; }


. { /* */ }

%%

int main() {
    cout << "\n NEO++ LEXICAL ANALYZER \n";
    cout << "Analyzing tokens with live counts...\n\n";

    yylex();

   
    cout << "Total Tokens Recognized: " << token_count << endl;
    cout << "Total Lines Scanned: " << line_no << endl;
    

    return 0;
}
