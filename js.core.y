/*
Name    : (Untitled)
Author  : (Unknown)
Version : (Not Specified)

About :


Generated by the GOLD Parser Builder
*/
/*
These token converted is wrong because ignoring casesentiveness.

%token Minus
%token Minusminus
%token Exclam
%token Exclameq
%token Percent
%token Percenteq
%token Amp
%token Ampamp
%token Ampeq
%token Lparen
%token Rparen
%token Times
%token Timeseq
%token Comma
%token Dot
%token Div
%token Diveq
%token Colon
%token Semi
%token Question
%token Lbracket
%token Rbracket
%token Caret
%token Careteq
%token Lbrace
%token Pipe
%token Pipepipe
%token Pipeeq
%token Rbrace
%token Tilde
%token Plus
%token Plusplus
%token Pluseq
%token Lt
%token Ltlt
%token Lteq
%token Eq
%token Minuseq
%token Eqeq
%token Gt
%token Gteq
%token Gtgt
%token Baseword
%token Breakword
%token Caseword
%token Catchword
%token Classword
%token Continueword
%token Decliteralterminal
%token Defaultword
%token Doword
%token Elseword
%token Finallyword
%token Floatliteralterminal
%token Forword
%token Functionword
%token Gotoword
%token Identifiername
%token If
%token In
%token Newword
%token Privateword
%token Protectedword
%token Publicword
%token Returnword
%token Stringliteralterminalwithapostroph
%token Stringliteralterminalwithquote
%token Switchword
%token Throwword
%token Tryword
%token Usingword
%token Varword
%token Whileword
%token Withword
*/

%start program

%%

decliteral : DECLITERALTERMINAL 
           ;

floatliteral : FLOATLITERALTERMINAL 
             ;

stringliteral : STRINGLITERALTERMINALWITHQUOTE 
              | STRINGLITERALTERMINALWITHAPOSTROPH 
              ;

literal : decliteral 
        | floatliteral 
        | stringliteral 
        ;

identifier : IDENTIFIERNAME 
           ;

program : 
        | sourceelements 
        ;

sourceelements : sourceelement 
               | sourceelement sourceelements 
               ;

sourceelement : functiondeclaration 
              | statement 
              | classdeclaration 
              | usingstatement 
              ;

usingstatement : USINGWORD usingprefix SEMI 
               ;

usingprefix : singleusingprefix 
            | multipleusingprefix 
            ;

singleusingprefix : identifier 
                  ;

multipleusingprefix : identifier DOT usingprefix 
                    ;

functiondeclaration : FUNCTIONWORD identifier LPAREN functionparameterlist RPAREN block 
                    ;

functionparameterlist : emptyfunctionparameterlist 
                      | nonemptyfunctionparameterlist 
                      ;

nonemptyfunctionparameterlist : multiplefunctionparameterlist 
                              | singlefunctionparameterlist 
                              ;

multiplefunctionparameterlist : nonemptyfunctionparameterlist COMMA identifier 
                              ;

singlefunctionparameterlist : identifier 
                            ;

emptyfunctionparameterlist : 
                           ;

statementlist : statement 
              | statement statementlist 
              ;

statement : variablestatement 
          | ifstatement 
          | thenstatement 
          | emptystatement 
          | ifelsestatement 
          | switchstatement 
          | withstatement 
          | exceptionstatement 
          | label 
          ;

thenstatement : forstatement 
              | forinstatement 
              | whilestatement 
              | dowhilestatement 
              | normalstatement 
              ;

normalstatement : block 
                | throwstatement 
                | expressionstatement 
                | returnstatement 
                | breakstatement 
                | continuestatement 
                | gotostatement 
                ;

emptystatement : SEMI 
               ;

expressionstatement : assignmentexpression SEMI 
                    ;

block : LBRACE RBRACE 
      | LBRACE statementlist RBRACE 
      ;

exceptionstatement : trycatchstatement 
                   | tryfinallystatement 
                   | trycatchfinallystatement 
                   ;

trycatchstatement : TRYWORD block CATCHWORD LPAREN identifier RPAREN catchpart 
                  ;

tryfinallystatement : TRYWORD block FINALLYWORD finallypart 
                    ;

trycatchfinallystatement : TRYWORD block CATCHWORD LPAREN identifier RPAREN catchpart FINALLYWORD finallypart 
                         ;

finallypart : block 
            ;

catchpart : block 
          ;

throwstatement : THROWWORD expression SEMI 
               ;

withstatement : WITHWORD LPAREN expression RPAREN block 
              ;

returnstatement : RETURNWORD expression SEMI 
                | RETURNWORD SEMI 
                ;

breakstatement : BREAKWORD SEMI 
               ;

continuestatement : CONTINUEWORD SEMI 
                  ;

ifstatement : IF LPAREN expression RPAREN statement 
            ;

ifelsestatement : IF LPAREN expression RPAREN thenstatement ELSEWORD statement 
                ;

gotostatement : GOTOWORD identifier SEMI 
              ;

label : identifier COLON 
      ;

switchstatement : SWITCHWORD LPAREN expression RPAREN LBRACE caselabellist RBRACE 
                ;

caselabellist : notemptycaselabellist 
              | defaultlabel 
              | emptycaselabellist 
              ;

emptycaselabellist : 
                   ;

notemptycaselabellist : caselabel caselabellist 
                      ;

caselabel : CASEWORD literal COLON statementlist 
          | CASEWORD literal COLON 
          ;

defaultlabel : DEFAULTWORD COLON statementlist 
             ;

forstatement : FORWORD LPAREN firstforexpression SEMI secondforexpression SEMI thirdforexpression RPAREN thenstatement 
             ;

firstforexpression : forexpression 
                   ;

secondforexpression : forexpression 
                    ;

thirdforexpression : forexpression 
                   ;

forexpression : expression 
              | 
              ;

forinstatement : FORWORD LPAREN identifier IN expression RPAREN thenstatement 
               ;

whilestatement : WHILEWORD LPAREN expression RPAREN thenstatement 
               ;

dowhilestatement : DOWORD statement WHILEWORD LPAREN expression RPAREN 
                 ;

classdeclaration : singleclassdeclaration 
                 | derivedclassdeclaration 
                 ;

singleclassdeclaration : CLASSWORD identifier LBRACE classmembers RBRACE 
                       ;

derivedclassdeclaration : CLASSWORD identifier COLON baseclassname LBRACE classmembers RBRACE 
                        ;

baseclassname : identifier 
              ;

classmembers : notemptyclassmembers 
             | emptyclassmembers 
             ;

emptyclassmembers : 
                  ;

notemptyclassmembers : classmembers classmember 
                     ;

classmember : methoddeclaration 
            | fielddeclaration 
            | constructordeclaration 
            ;

methoddeclaration : accessmodifier identifier LPAREN functionparameterlist RPAREN block 
                  ;

fielddeclaration : accessmodifier identifier SEMI 
                 ;

constructordeclaration : accessmodifier identifier LPAREN functionparameterlist RPAREN baseconstructorcalling block 
                       ;

baseconstructorcalling : COLON BASEWORD arguments 
                       ;

accessmodifier : publicmodifier 
               | protectedmodifier 
               | privatemodifier 
               ;

publicmodifier : PUBLICWORD 
               ;

protectedmodifier : PROTECTEDWORD 
                  ;

privatemodifier : PRIVATEWORD 
                | 
                ;

newexpression : NEWWORD identifier arguments 
              ;

variablestatement : VARWORD variabledeclarationlist SEMI 
                  ;

variabledeclarationlist : singlevariabledeclarationlist 
                        | multiplevariabledeclarationlist 
                        ;

multiplevariabledeclarationlist : variabledeclarationlist COMMA variabledeclaration 
                                ;

singlevariabledeclarationlist : variabledeclaration 
                              ;

expression : assignmentexpression 
           | variableexpression 
           ;

variableexpression : VARWORD variabledeclaration 
                   ;

variabledeclaration : singlevariabledeclaration 
                    | usualvariabledeclaration 
                    ;

usualvariabledeclaration : identifier EQ assignmentexpression 
                         ;

singlevariabledeclaration : identifier 
                          ;

assignmentexpression : singleassignmentexpression 
                     | ifoperation 
                     ;

singleassignmentexpression : singleassignmentexpressionequality 
                           | singleassignmentexpressionplus 
                           | singleassignmentexpressionminus 
                           | singleassignmentexpressionmultiply 
                           | singleassignmentexpressiondivide 
                           | singleassignmentexpressionxor 
                           | singleassignmentexpressionbinaryand 
                           | singleassignmentexpressionbinaryor 
                           | singleassignmentexpressionremainder 
                           ;

singleassignmentexpressionequality : leftvalue EQ assignmentexpression 
                                   ;

singleassignmentexpressionplus : leftvalue PLUSEQ assignmentexpression 
                               ;

singleassignmentexpressionminus : leftvalue MINUSEQ assignmentexpression 
                                ;

singleassignmentexpressionmultiply : leftvalue TIMESEQ assignmentexpression 
                                   ;

singleassignmentexpressiondivide : leftvalue DIVEQ assignmentexpression 
                                 ;

singleassignmentexpressionxor : leftvalue CARETEQ assignmentexpression 
                              ;

singleassignmentexpressionbinaryand : leftvalue AMPEQ assignmentexpression 
                                    ;

singleassignmentexpressionbinaryor : leftvalue PIPEEQ assignmentexpression 
                                   ;

singleassignmentexpressionremainder : leftvalue PERCENTEQ assignmentexpression 
                                    ;

ifoperation : oroperation QUESTION leftifoperation COLON rightifoperation 
            | oroperation 
            ;

leftifoperation : ifoperation 
                ;

rightifoperation : ifoperation 
                 ;

oroperation : operatoror 
            | andoperation 
            ;

operatoror : oroperation PIPEPIPE andoperation 
           ;

andoperation : operatorand 
             | binoroperation 
             ;

operatorand : andoperation AMPAMP binoroperation 
            ;

binoroperation : operatorbinaryor 
               | binxoroperation 
               ;

operatorbinaryor : binoroperation PIPE binxoroperation 
                 ;

binxoroperation : operatorbinaryxor 
                | binandoperation 
                ;

operatorbinaryxor : binxoroperation CARET binandoperation 
                  ;

binandoperation : operatorbinaryand 
                | equateoperation 
                ;

operatorbinaryand : binandoperation AMP equateoperation 
                  ;

equateoperation : operatorequality 
                | operatorinequality 
                | compareoperation 
                ;

operatorequality : equateoperation EQEQ compareoperation 
                 ;

operatorinequality : equateoperation EXCLAMEQ compareoperation 
                   ;

compareoperation : operatorless 
                 | operatormore 
                 | operatorlessorequal 
                 | operatormoreorequal 
                 | shiftoperation 
                 ;

operatorless : compareoperation LT shiftoperation 
             ;

operatormore : compareoperation GT shiftoperation 
             ;

operatorlessorequal : compareoperation LTEQ shiftoperation 
                    ;

operatormoreorequal : compareoperation GTEQ shiftoperation 
                    ;

shiftoperation : operatorshiftleft 
               | operatorshiftright 
               | addoperation 
               ;

operatorshiftleft : shiftoperation LTLT addoperation 
                  ;

operatorshiftright : shiftoperation GTGT addoperation 
                   ;

addoperation : operatorplus 
             | operatorminus 
             | multiplicationoperation 
             ;

operatorplus : addoperation PLUS multiplicationoperation 
             ;

operatorminus : addoperation MINUS multiplicationoperation 
              ;

multiplicationoperation : operatormultiply 
                        | operatordivide 
                        | operatorremainder 
                        | otheroperation 
                        ;

operatormultiply : multiplicationoperation TIMES otheroperation 
                 ;

operatordivide : multiplicationoperation DIV otheroperation 
               ;

operatorremainder : multiplicationoperation PERCENT otheroperation 
                  ;

otheroperation : unaryoperatornot 
               | unaryoperatorbinarynot 
               | unaryoperatorprefixinc 
               | unaryoperatorpostfixinc 
               | unaryoperatorprefixdec 
               | unaryoperatorpostfixdec 
               | unaryoperatorminus 
               | rightvalue 
               ;

unaryoperatornot : EXCLAM otheroperation 
                 ;

unaryoperatorbinarynot : TILDE otheroperation 
                       ;

unaryoperatorprefixinc : PLUSPLUS leftvalue 
                       ;

unaryoperatorpostfixinc : leftvalue PLUSPLUS 
                        ;

unaryoperatorprefixdec : MINUSMINUS leftvalue 
                       ;

unaryoperatorpostfixdec : leftvalue MINUSMINUS 
                        ;

unaryoperatorminus : MINUS otheroperation 
                   ;

rightvalue : bracedexpression 
           | callexpression 
           | newexpression 
           | literal 
           | leftvalue 
           ;

leftvalue : memberexpression 
          | indexexpression 
          ;

primaryexpression : bracedexpression 
                  | memberexpression 
                  | callexpression 
                  ;

bracedexpression : LPAREN expression RPAREN 
                 ;

callexpression : primaryexpression arguments 
               ;

indexexpression : memberexpression LBRACKET expression RBRACKET 
                ;

memberexpression : singlememberexpression 
                 | multiplememberexpression 
                 ;

multiplememberexpression : primaryexpression DOT identifier 
                         ;

singlememberexpression : identifier 
                       ;

arguments : LPAREN argumentlist RPAREN 
          ;

argumentlist : emptyargumentlist 
             | nonemptyargumentlist 
             ;

nonemptyargumentlist : nonemptyargumentlist COMMA expression 
                     | expression 
                     ;

emptyargumentlist : 
                  ;

