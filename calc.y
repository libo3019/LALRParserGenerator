%head {
struct Compiler
{
	int tok_type;
};
}
%{
	#include <stdio.h>
	struct Compiler
	{
		int tok_type;
	};
%}
%token INT
%left '+' '-'
%left '*' '/'
%parser_param {struct Compiler* compiler}
%%
prog: expr          { printf("-> %d\n", $1); } ;
expr: INT
    | '(' expr ')'  { $$ = $2; }
    | expr '+' expr { $$ = $1 + $3; }
    | expr '*' expr { $$ = $1 * $3; } 
	 | expr '-' expr { $$ = $1 - $3; }
    | expr '/' expr { $$ = $1 / $3; } ;
%%
int yylex() {    /* crude lexer */
	int c = getchar();
	if (c >= '0' && c <= '9') {
		yylval = c-'0';
		return INT;
	}
	return c == EOF ? 0 : c;
}
int yyerror(const char *msg)
{
	printf("%s\n", msg);
	return 0;
}
int main() { struct Compiler compiler; return yyparse(&compiler); }