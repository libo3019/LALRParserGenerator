#pragma once
#include "calc5.tab.h"

#ifndef YY_TYPEDEF_YY_SCANNER_T
#define YY_TYPEDEF_YY_SCANNER_T
typedef void* yyscan_t;
#endif

struct yy_lexer_state
{
	yyscan_t scanner;
	FILE* yyrin;
	YYSTYPE val;
};

#undef  YY_DECL
#define YY_DECL int yylex(yyscan_t yyscanner)
#define YY_EXTRA_TYPE struct yy_lexer_state *

YY_EXTRA_TYPE yyget_extra  (yyscan_t yyscanner);
int yylex_init_extra(YY_EXTRA_TYPE user_defined, yyscan_t* scanner);
void yyset_in(FILE* _in_str, yyscan_t yyscanner);
int yylex_destroy();