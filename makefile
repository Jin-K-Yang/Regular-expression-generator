CC = gcc
OUT = parser.out

all : 
	flex parser.l
	bison -vdty parser.y
	$(CC) -o $(OUT) lex.yy.c y.tab.c

clean : 
	rm -rf *.tab.c *.tab.h *.output lex.yy.c $(OUT)
