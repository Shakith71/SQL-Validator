This project of lex and yacc aims to validate the sql syntax along with giving the parsed result.
It works for select, update, insert and delete statements along with join queries.

How to run this:

lex lex.l
yacc -d yacc.y
gcc lex.yy.c y.tab.c
./a.out inp.txt

where inp.txt consists of the sql query.
