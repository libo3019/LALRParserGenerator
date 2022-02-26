%head {
#ifndef YY_TYPEDEF_YY_SCANNER_T
#define YY_TYPEDEF_YY_SCANNER_T
typedef void* yyscan_t;
#endif
int yylex(yyscan_t yyscanner);
}

%{
	#include <stdio.h>
	#include <ctype.h>
	#include <string.h>
	#include "lexer_state.h"
%}

%union {
	int int_value;
	int exp_value;
}
%stack_size 1000
%token <int_value> INT
%type <exp_value> expr
%left '+' '-'
%left '*' '/'

%scanner_param {yyscan_t scanner}

%%
prog: expr     /*A calc
					prog*/     { printf("-> %d\n", $1); } ;
expr(a): INT {expr = $1;}
    | '(' expr ')'  { $$ = $2; } 
    | expr(b) '*' expr(c) { /*a = expr * c;*/ a = b * c; }  //good
    | expr(b) '+' expr(c) { a = b + c; }
	| expr(b) '/' expr(c) { a = b / c; } 
    | expr '-' expr { $$ = $1 - $3; }
	;
%%

int main(int argc, char *argv[]) 
{ 
	if (argc < 2)
	{
		const char *filename = strrchr(argv[0], '\\');
		if (filename == NULL) filename = argv[0];
		else ++filename;
		printf("Usage: %s <filename>\n", filename);
		return 1;
	}
	void* parser = yy_parser_alloc();
	int tok_type;
	int ret;
	 
	struct yy_lexer_state state1;
	state1.yyrin = fopen(argv[1], "r");
	if (!state1.yyrin)
	{
		return 1;
	}
	if (yylex_init_extra(&state1, &state1.scanner)) {
		perror("init alloc failed");
		return 1;
	}
	yyset_in(state1.yyrin, state1.scanner);
	
	while (tok_type = yylex(state1.scanner))
	{
		ret = yy_step_parse(parser, tok_type, state1.val, state1.scanner);
		printf("ret = %d\n", ret);
	}
	ret = yy_step_parse(parser, 0, state1.val, state1.scanner);
	printf("ret = %d\n", ret);
	yy_parser_free(parser);
	yylex_destroy(state1.scanner);
	fclose(state1.yyrin);
	
	struct yy_lexer_state state2;
	state2.yyrin = fopen(argv[1], "r");
	if (!state2.yyrin)
	{
		return 1;
	}	 
	if (yylex_init_extra(&state2, &state2.scanner)) {
		perror("init alloc failed");
		return 1;
	}
	yyset_in(state2.yyrin, state2.scanner);
		
	ret = yyparse(state2.scanner);
	printf("ret = %d\n", ret);
	return ret;
}

int yyerror(const char *str)
{
	fprintf(stderr, "%s", str);
	return 0;
}