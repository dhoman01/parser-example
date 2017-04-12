#ifndef BRAIN_HPP
#define BRAIN_HPP 1

#include <istream>
#include <memory>

#include "../parser/parser.tab.hh"
#include "../parser/scanner.hpp"

#include "Actions.hpp"

namespace json
{

class Brain
{
public:
    Brain(){};
    virtual ~Brain() = default;

    void Parse(const char* const filename);
    void Parse(std::istream& iss);
    
    Actions actions;
private:
    void ParseHelper(std::istream& stream);


    std::shared_ptr<Parser> parser = nullptr;
    std::shared_ptr<Scanner> scanner = nullptr;
};

}

#endif