%{
	#include <stdio.h>
	#include "y.tab.h"
	struct Scanner
	{
		int tok_type;
		YYSTYPE val;
	};
%}
%token INT
%left '+' '-'
%left '*' '/'
%scanner_param {struct Scanner* scanner}
%%
prog: expr          { printf("-> %d\n", $1); } ;
expr: INT
    | '(' expr ')'  { $$ = $2; }
    | expr '+' expr { $$ = $1 + $3; }
    | expr '*' expr { $$ = $1 * $3; } 
	 | expr '-' expr { $$ = $1 - $3; }
    | expr '/' expr { $$ = $1 / $3; } ;
%%
int yylex_reentrant(struct Scanner* scanner, YYSTYPE * yylval) {    /* crude lexer */
	int c = getchar();
	if (c >= '0' && c <= '9') {
		*yylval = c-'0';
		return INT;
	}
	return c == EOF ? 0 : c;
}
int yyerror(const char *msg)
{
	printf("%s\n", msg);
	return 0;
}
int main() { struct Scanner scanner; return yyparse(&scanner); }