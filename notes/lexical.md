# Lexical Analysis
## Terminology
* Token
    * Type of word
    * Part of speech
    * Implemented as enumeration
* Lexeme
    * Token with dependant data
    * value derived from matched text
* Pattern
    * Regular Expressions used to recoginze tokens

### Keywords
* Reserved identifiers
* Only token kind is significant

### Literal
* String, character, or numberic
* lexeme

### Operators
* Seperators
* Not needed for lexical analysis

### Identifiers
* Rules for identifiers very by langauge
* variable name in programming languages

### Comments
* No token
* Scanner (lexer) skips
* For multi-line comments an open and no close is an error

## Finite Automata
All finite automata can be expressed as a regular expression and vice versa.

## Further Study
[wiki](https://en.wikipedia.org/wiki/Lexical_analysis#Lexeme)
[http://www.pling.org.uk/cs/lsa.html](http://www.pling.org.uk/cs/lsa.html)