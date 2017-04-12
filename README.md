# Palindrome Parser using flex/bison and C++
The goal of this project is to provide a simple tutorial to introduce the concepts of parsing a file given a simple language. The tools required for this tutorial are [flex](https://github.com/westes/flex) (v2.6.0), [bison](https://www.gnu.org/software/bison/manual/html_node/index.html) (v3.0.4), and a C++14 capable compiler.

I also use [make](https://www.gnu.org/software/make/) to build the project, but that is not required (it is assumed that you are using some flavor of UNIX). In lue of [make](https://www.gnu.org/software/make/) you can use the command line tools directly. Please reference my Makefile and the tool's docs for usage.

We will be building a JSON (with C++-style comments) parser. See [http://www.json.org/](http://www.json.org/).