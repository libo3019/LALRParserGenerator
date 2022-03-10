LALRParserGenerator, written by LiBo(me), is a parser generator for a compiler frontend whose grammar is LALR pattern.

It is like yacc/bison and lemon, and including the most features of theirs.

Unlike lemon, In LALRParserGenerator, tokens and non terminal symbols use same type YYSTYPE.

It is a big problem to use the same type for all token type, so LALRParserGenerator changes the situation.

Similar with yacc/bison, but LALRParserGenerator adds some extensions which are like lemon.

In yacc/bison, $N is so evil that the most developers can commit some mistakes because they count 
the index wrongly.

LALRParserGenerator can use the name of a symbol or its alias to refer the symbol's value.

Lemon doesn't allow a developer to define a start symbol which can occur at the right side.
LALRParserGenerator has no such restriction.

LALRParserGenerator provides two kinds of using mode: reentrant mode and non-reentrant mode.

One of reentrant mode is like lemon, but tokens and non terminal symbols use same type YYSTYPE.

Another reentrant mode is like yacc/bison, but you must provide a adaptable function to adapt any lexical scanner of reentrant flex mode or your customized reentrant lexical scanner.

LALRParserGenerator doesn't restrict any lexical scanner's mode that you use as long as 
you provide a adaptable function whose prototype is written at c code template file or a generated c code.

All examples are provided, which can run corrently.

The usage is like yacc, see these examples to understand everything.

Running method:
LALRParserGenerator [-vld] [-b prefix] [-L path] [-y prefix] [-Y prefix] yacc_file_name

-v: Output the trace file<br>
-d: Output the header file<br>
-b: Specify the prefix of output filename<br>
-Y: Specify "Y" prefix used by YYSTYPE and etc.<br>
-y: Specify "y" prefix used by yyunion and etc.<br>
-L: code template files' searching path<br>
-l: Not create #line instruction.<br>