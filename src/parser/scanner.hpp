#ifndef json_LEXER_HPP
#define json_LEXER_HPP 1

#if ! defined(yyFlexLexerOnce)
#include <FlexLexer.h>
#endif

#include "parser.tab.hh"
#include "location.hh"

namespace json
{

class Scanner : public yyFlexLexer
{
public:
    Scanner(std::istream* in) : yyFlexLexer(in)
    {
        loc = new json::Parser::location_type();
    };

    virtual ~Scanner()
    {
        delete loc;
    };

    using FlexLexer::yylex;

    virtual int yylex(json::Parser::semantic_type* const lval,
              json::Parser::location_type* location);
private:
    json::Parser::semantic_type* yylval = nullptr;
    json::Parser::location_type* loc = nullptr;
};

}

#endif