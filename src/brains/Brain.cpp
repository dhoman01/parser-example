#include "Brain.hpp"

#include <cassert>
#include <cctype>
#include <fstream>

json::Brain::Brain()
{
    std::cout << "Brain Initialized..." << std::endl;
};

void json::Brain::Parse(const char* const filename)
{
    assert(filename !=  nullptr);
    std::ifstream in(filename);
    if(!in.good())
        exit(EXIT_FAILURE);
    
    json::Brain::ParseHelper(in);
    return;
};

void json::Brain::Parse(std::istream& stream)
{
    if(!stream.good() && stream.eof())
        return;
    
    json::Brain::ParseHelper(stream);
    return;
};

void json::Brain::ParseHelper(std::istream& stream)
{
    scanner = std::make_shared<json::Scanner>(&stream);
    parser = std::make_shared<json::Parser>((*scanner.get()), (*this));
    parser->parse();
    return;
};