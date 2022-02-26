%{
	#include <stdio.h>
	#include <ctype.h>
	int yylex(void);
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
FILE *yyin;
int yylex() 
{
	int ch = fgetc(yyin);	
	while (isspace(ch))
	{
	  ch = fgetc(yyin);
	  printf("every ch = %c\n", ch);
	  if (ch == EOF)
	  {
		break;
	  }
	}
	if (ch == EOF)
	   return 0;
	else if ('*' == ch || '/' == ch || '+' == ch || '-' == ch || '(' == ch || ')' == ch)
	{		
		return ch;
	}
	else if (isdigit(ch))
	{
		int val = 0;
		do
		{
		  val = val * 10 + ch - '0';
		  ch = fgetc(yyin);
		  if (ch == EOF)
		  {
		   break;
		  }
		}
		while (isdigit(ch));
		if (ch != EOF)
		{
		 ungetc(ch, yyin);
		}
		yylval.int_value = val;		
		return INT;
	}
	else
	{
	  printf("error %c %d.\n", ch, ch);
	  return EOF;
	}	
}
int main(int argc, char *argv[]) 
{ 
  yyin = fopen(argv[1], "r");
  if (!yyin)
  {
    return 1;
 }
 void* parser = yy_parser_alloc();
 int tok_type;
 int ret;
 while (tok_type = yylex())
 {
	ret = yy_step_parse(parser, tok_type, yylval);
	printf("ret = %d\n", ret);
 }
 ret = yy_step_parse(parser, 0, yylval);
 printf("ret = %d\n", ret);
 yy_parser_free(parser);
 rewind(yyin);
 return yyparse(); 
}
int yyerror(const char *str)
{
	fprintf(stderr, "%s", str);
	return 0;
}