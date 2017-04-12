# Palindrome Parser using flex/bison and C++
The goal of this project is to provide a simple tutorial to introduce the concepts of parsing a file given a simple language. The tools required for this tutorial are [flex](https://github.com/westes/flex) (v2.6.0), [bison](https://www.gnu.org/software/bison/manual/html_node/index.html) (v3.0.4), and a C++14 capable compiler.

I also use [make](https://www.gnu.org/software/make/) to build the project, but that is not required (it is assumed that you are using some flavor of UNIX). In lue of [make](https://www.gnu.org/software/make/) you can use the command line tools directly. Please reference my Makefile and the tool's docs for usage.

# Language
## Lexical Structure - ([notes](notes/lexical.md))
### Introduction
The following sections describe a language that allows you to assign palindromes to numbers, then write those numbers to the console.

### Keywords
write begin end

### Identifers
Identifiers in this language are the natural numbers [1,infinty).

### Operators
<pre>->  ;   ,   (   )</pre>

### Comments
A comment in this language begins with a # and continues to the end of the line.

### Blanks, Tabs, Spaces, and New Lines
All white space is ignored in this language.

## Syntactic Structure - ([notes](notes/syntax.md))
### Palindrome
<pre>
{Palindrome} --> a{Palindrome}a
            |    b{Palindrome}b
            |    c{Palindrome}c
            .
            .
            .
            |    z{Palindrome}z
            |    A{Palindrome}A
            .
            .
            .
            |    Z{Palindrome}Z
            |    {empty}
</pre>

### Statements
<pre>
{statementList} --> {statementList}[; {statement}]*;
{statement} --> {assignment}
            | {writeStatement}
</pre>

#### Assignment
<pre>
{assignmentList} --> {assignmentList}[, {asssignment}]*
{assignment} --> {ident} -> {Palindrome}
</pre>

#### Write Statment
<pre>{writeStatement} --> write({assignmentList})</pre>

### Identifer Declaration

<pre>{ident} --> [1-9][0-9]*</pre>

### Program
<pre>{program} --> begin {statementList} end</pre>

## Semantic Structure
### Write
The write function prints the identifier and its assigned palindrome. When a list of assignments is passed in, write prints each assignment on a seperate line.
#### Example
##### Code
<pre>
1 -> aba;
2 -> cdc;
3 -> aaa;
4 -> ;
write(1,2,3,4);
</pre>

##### Output
<pre>
1: aba
2: cdc
3: aaa
4:
</pre>