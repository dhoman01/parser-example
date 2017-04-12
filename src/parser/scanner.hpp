#ifndef PAL_LEXER_HPP
#define PAL_LEXER_HPP 1

#if ! defined(yyFlexLexerOnce)
#include <FlexLexer.h>
#endif

#include "parser.tab.hh"
#include "location.hh"

namespace pal
{

class Scanner : public yyFlexLexer
{
public:
    Scanner(std::istream* in) : yyFlexLexer(in)
    {
        loc = new pal::Parser::location_type();
    };

    virtual ~Scanner()
    {
        delete loc;
    };

    using FlexLexer::yylex;

    virtual int yylex(pal::Parser::semantic_type* const lval,
              pal::Parser::location_type* location);
private:
    pal::Parser::semantic_type* yylval = nullptr;
    pal::Parser::location_type* loc = nullptr;
};

}

#endif