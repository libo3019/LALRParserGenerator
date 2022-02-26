/* Definitions */

digit           [0-9]
letter          [a-zA-Z]
alphanum        [a-zA-Z0-9]
identifier      [a-zA-Z_][a-zA-Z0-9_]+
integer         [0-9]+
natural         [0-9]*[1-9][0-9]*
decimal         ([0-9]+\\.|\\.[0-9]+|[0-9]+\\.[0-9]+)

%{
    #include <stdio.h>

    #define ECHO fwrite(yytext, yyleng, 1, yyout)

    int totalNums = 0;
%}

%option reentrant
%option prefix="simpleit_"

%%

^(.*)? printf("%d\\t%s", yylineno++, yytext);

%%
/* Routines */

int yywrap(yyscan_t yyscanner)
{
    return 1;
}

int main(int argc, char* argv[])
{
	yyscan_t scanner;
	yylex_init(&scanner);
	yyset_in(fopen(argv[1],"r"), scanner);
	
    if(argc < 2) {
        printf("Usage: %s fileName\
", argv[0]);
        return -1;
    }
    

    yylex(scanner);
	yylex_destroy(scanner);
    return 0;
}