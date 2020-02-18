# Regular Expression Generator
Use regular expression to generate random number or alphabet through flex and bison.

# Usage
```cmd
make
./paser.out
[5-9]{5}	//input
//output will be like : 56869
```
# Delete
```cmd
make clean
```
# Test
```C
#include <stdio.h>
#include "y.tab.c"
#include "lex.yy.c"

yyparse();
```
```cmd
gcc test.c
./a.out
```
