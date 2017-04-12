%skeleton "lalr1.cc"
%require  "3.0"
%debug 
%defines 
%define api.namespace {json}
%define parser_class_name {Parser}

%code requires{
    #include "../brains/Values.hpp"
    namespace json {
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

%type<std::string> STRING_VALUE INTEGER_VALUE EXP string number int frac exp e
%type<std::shared_ptr<json::ObjectValue>> object
%type<std::shared_ptr<json::ArrayValue>> array
%type<std::shared_ptr<json::Value>> value
%type<std::vector<std::shared_ptr<json::Value>>> elements
%type<std::vector<json::Pair>> members
%type<json::Pair> pair

%locations

%%

start: object                           { std::cout << $1->ToString() << std::endl; }
     | array                            { std::cout << $1->ToString() << std::endl; }
     ;

object: OPEN_OBJ members CLOSE_OBJ      { $$ = brain.actions.CreateObjectValue($2); }
      ;

members: members COMMA pair             { $1.push_back($3); $$ = $1; }
       | pair                           { std::vector<json::Pair> list; list.push_back($1); $$ = list; }
       |                                { $$ = std::vector<json::Pair>(); }
       ;

pair: string COLON value                { $$ = brain.actions.CreatePair($1, $3); }
    ;

array: OPEN_ARR elements CLOSE_ARR      { $$ = brain.actions.CreateArrayValue($2); }
     ;

elements: elements COMMA value          { $1.push_back($3); $$ = $1; }
        | value                         { std::vector<std::shared_ptr<json::Value>> list; list.push_back($1); $$ = list;}
        |                               { $$ = std::vector<std::shared_ptr<json::Value>>(); }
        ;

value: string                           { $$ = brain.actions.CreateStringValue($1); }
     | number                           { $$ = brain.actions.CreateNumberValue($1); }
     | object                           { $$ = $1; }
     | array                            { $$ = $1; }
     | TRUE_KEY                         { $$ = brain.actions.CreateBooleanValue(true); }
     | FALSE_KEY                        { $$ = brain.actions.CreateBooleanValue(false); }
     | NULL_KEY                         { $$ = brain.actions.CreateNullValue(); }
     ;

string: STRING_VALUE                    { $$ = $1; }
      ;

number: int                             { $$ = $1; }
      | int frac                        { $$ = $1 + $2; }
      | int exp                         { $$ = $1 + $2; }
      | int frac exp                    { $$ = $1 + $2 + $3; }
      ;

int: INTEGER_VALUE                      { $$ = $1; }
   | NEGATIVE INTEGER_VALUE             { $$ = "-" + $2; }
   ;

frac: FRACTION INTEGER_VALUE            { $$ = "." + $2; }
    ;

exp: e INTEGER_VALUE                    { $$ = $1 + $2; }
   ;

e: EXP                                  { $$ = $1; }
 ;

%%

void json::Parser::error(const location_type& loc, const std::string& err_message)
{
    std::cerr << "Syntax Error: " << err_message << " at ";
    std::cerr << loc.begin.line << ":" << loc.begin.column << " - ";
    std::cerr << loc.end.line << ":" << loc.end.column << "\n";
}