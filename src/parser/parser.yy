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

%token TRUE_KEY
%token FALSE_KEY
%token NULL_KEY
%token STRING_VALUE
%token INTEGER_VALUE
%token OPEN_OBJ
%token CLOSE_OBJ
%token OPEN_ARR
%token CLOSE_ARR
%token COMMA
%token COLON
%token FRACTION
%token NEGATIVE
%token EXP

%locations

%%

program: TRUE_KEY
       |
       ;

%%

void pal::Parser::error(const location_type& loc, const std::string& err_message)
{
    std::cerr << "Syntax Error: " << err_message << " at ";
    std::cerr << loc.begin.line << ":" << loc.begin.column << " - ";
    std::cerr << loc.end.line << ":" << loc.end.column << "\n";
}