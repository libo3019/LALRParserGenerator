/* Definitions */

digit           [0-9]
integer         [0-9]+

%{
    #include <stdio.h>
	#include "lexer_state.h"
%}

%option reentrant

%%

{integer} {
			yyextra->val.int_value = atoi(yytext);			
			return INT;
}

[ \t\r\n]+ {}
. return yytext[0];

%%
/* Routines */

int yywrap(yyscan_t yyscanner)
{
    return 1;
}

int yylex_reentrant(void *scanner, YYSTYPE* val)
{
	int tok_type = yylex(scanner);
	*val = yyget_extra(scanner)->val;	
	return tok_type;
}
