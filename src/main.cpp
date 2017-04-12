#include <cstdlib>
#include <cstring>
#include <fstream>
#include <iostream>
#include <string>

#include "brains/Brain.hpp"

bool matchArgs(const char* arg, std::string opt)
{
    return std::strncmp(arg, opt.c_str(), opt.size()) == 0;
}

void printUsage(std::ostream& iss)
{
    iss << "usage: pal [/path/to/file/target | --stdio | --help] [options]" << std::endl;
    iss << "Options: " << std::endl;
    iss << "\t\u2022 use --help to get this menu" << std::endl;
    iss << "\t\u2022 use --stdio for pipe to std::cin" << std::endl;
    iss << "\t\u2022 use --output[=filename] for output filename" << std::endl;
}

int main(const int argc, const char** argv)
{
    if(argc >= 2)
    {
        if(matchArgs(argv[1], std::string("--help")) || matchArgs(argv[1], std::string("-h")))
        {
            printUsage(std::cout);
            return EXIT_SUCCESS;
        }

        // Redirect std::cout to file if --output has a filename
        std::streambuf* buffer = std::cout.rdbuf();
        bool coutRestore = false;
        std::ofstream asmOut;

        if(argc >= 4 && (matchArgs(argv[2], std::string("--output")) || matchArgs(argv[2], std::string("-o"))))
        {
            asmOut.open(argv[3], std::ofstream::trunc);
            std::cout.rdbuf(asmOut.rdbuf());
            coutRestore = true;
        }

        pal::Brain brain;
        try
        {
            if(matchArgs(argv[1], std::string("--stdio")))
                brain.Parse(std::cin);
            else
                brain.Parse(argv[1]);              
        }
        catch (const std::exception& ex)
        {
            std::cerr << "Compile Error: " << ex.what() << std::endl;
            if(coutRestore)
                std::cout.rdbuf(buffer);
            return EXIT_FAILURE;
        }

        if(coutRestore)
            std::cout.rdbuf(buffer);
    }
    else
    {
        printUsage(std::cerr);
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}