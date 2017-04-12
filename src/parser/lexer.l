%{
#include <cstring>
#include <cstdlib>
#include <string>

#include "parser.tab.hh"
#include "location.hh"
#include "scanner.hpp"

#undef  YY_DECL
#define YY_DECL int pal::Scanner::yylex(pal::Parser::semantic_type* const lval, pal::Parser::location_type* loc)

using token = pal::Parser::token;

#define YY_NO_UNISTD_H

#define YY_USER_ACTION loc->step(); loc->columns(yyleng);

%}

%option debug
%option nodefault
%option yyclass="pal::Scanner"
%option noyywrap
%option c++

%%
%{
    yylval = lval;
%}

 /* remove whitespace */
[ \t]+                  {}

->                      {
                            return token::ASSIGN_KEY;
                        }

 /* Comments */
#.*\n                   { 
                            loc->lines();
                        }

 /* Increment line count */
\n                      {
                            loc->lines();
                        }

 /* All other lexeme are invalid */
.                       {
                            std::cerr << "Lexical Error (" << loc->begin.line << ":" << loc->begin.column << "): Invalid token " << yytext << std::endl;
                        }

%%