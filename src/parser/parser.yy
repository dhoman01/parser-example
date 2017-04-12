%skeleton "lalr1.cc"
%require  "3.0"
%debug 
%defines 
%define api.namespace {pal}
%define parser_class_name {Parser}

%code requires{
    namespace pal {
        class Brain;
        class Scanner;
    }

}

%parse-param { Scanner& scanner }
%parse-param { Brain& brain     }

%code{
    #include <iostream>
    #include <cstdlib>
    #include <fstream>

    #include "../brains/Brain.hpp"

#undef yylex
#define yylex scanner.yylex
}

%define api.value.type variant
%define parse.assert

%error-verbose

%token ASSIGN_KEY


%locations

%%

program: ASSIGN_KEY
    ;

%%

void pal::Parser::error(const location_type& loc, const std::string& err_message)
{
    std::cerr << "Syntax Error: " << err_message << " at ";
    std::cerr << loc.begin.line << ":" << loc.begin.column << " - ";
    std::cerr << loc.end.line << ":" << loc.end.column << "\n";
}