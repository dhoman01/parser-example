all: compile

compile: setup parser copy
	echo "Compiling final executable";
	cd build/brains; \
	g++ ../main.cpp Brain.cpp ../parser/*.cc --std=c++14 -o ../json

setup:
	mkdir -p build
	mkdir -p build/brains
	mkdir -p build/parser

parser:
	cd src/parser; \
	flex -o ../../build/parser/lexex.yy.cc lexer.l; \
	bison parser.yy; \
	mv parser.tab.* ../../build/parser/; \
	mv *.hh ../../build/parser/; \
	cp scanner.hpp ../../build/parser

copy:	
	cd src/brains; \
	cp Brain.* ../../build/brains
	cd src; \
	cp main.cpp ../build

clean:
	rm -r build/

test:
	echo -e "No Tests Yet..."