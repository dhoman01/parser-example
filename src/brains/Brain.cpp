#include "Brain.hpp"

#include <cassert>
#include <cctype>
#include <fstream>

pal::Brain::Brain()
{
    std::cout << "Brain Initialized..." << std::endl;
};

void pal::Brain::Parse(const char* const filename)
{
    assert(filename !=  nullptr);
    std::ifstream in(filename);
    if(!in.good())
        exit(EXIT_FAILURE);
    
    pal::Brain::ParseHelper(in);
    return;
}

void pal::Brain::Parse(std::istream& stream)
{
    if(!stream.good() && stream.eof())
        return;
    
    pal::Brain::ParseHelper(stream);
    return;
}

void pal::Brain::ParseHelper(std::istream& stream)
{
    scanner = std::make_shared<pal::Scanner>(&stream);
    parser = std::make_shared<pal::Parser>((*scanner.get()), (*this));
    parser->parse();
    return;
}