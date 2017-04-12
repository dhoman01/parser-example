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
%s comment

%%
%{
    yylval = lval;
%}

 /* Keywords */
true                    {
                            return token::TRUE_KEY;
                        }

false                   {
                            return token::FALSE_KEY;
                        }

null                    {
                            return token::NULL_KEY;
                        }

 /* Values */
\"(\\.|[^"\n])*\"       {
                            return token::STRING_VALUE;
                        }

[0-9]+                  {
                            return token::INTEGER_VALUE;
                        }

 /* Delimiters */

"{"                     {
                            return token::OPEN_OBJ;
                        }

"}"                     {
                            return token::CLOSE_OBJ;
                        }

"["                     {   
                            return token::OPEN_ARR;
                        }

"]"                     {
                            return token::CLOSE_ARR;
                        }

","                     {
                            return token::COMMA;
                        }

":"                     {
                            return token::COLON;   
                        }

"."                     {
                            return token::FRACTION;
                        }

"-"                     {
                            return token::NEGATIVE;
                        }

(?i:"e"|"e+"|"e-")      {
                            return token::EXP;
                        }

 /* remove whitespace */
[ \t]+                  {}

 /* Comments */
"//".*\n                { 
                            loc->lines();
                        }

"/*"                    {
                            BEGIN(comment);
                        }

<comment>"*/"           {
                            BEGIN(INITIAL);
                        }

<comment>.              {}

<comment>\n             {
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