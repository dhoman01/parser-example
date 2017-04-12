#ifndef BRAIN_HPP
#define BRAIN_HPP 1

#include <istream>
#include <memory>

#include "../parser/parser.tab.hh"
#include "../parser/scanner.hpp"

namespace pal
{

class Brain
{
public:
    Brain();
    virtual ~Brain() = default;

    void Parse(const char* const filename);
    void Parse(std::istream& iss);
private:
    void ParseHelper(std::istream& stream);

    std::shared_ptr<Parser> parser = nullptr;
    std::shared_ptr<Scanner> scanner = nullptr;
};

}

#endif