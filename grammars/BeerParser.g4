parser grammar BeerParser;

options {
    tokenVocab=BeerLexer;
    superClass=BeerBaseParser;
}

program
    : importExpression* (initClass | begin)? EOF
    ;

importExpression
    : Import StringLiteral SemiColon
    ;

initClass
    : Class Identifier OpenBrace method* CloseBrace
    ;

method
    : type Identifier SemiColon
    | function
    | constructor
    ;

constructor
    : Identifier OpenParent parameters CloseParent OpenBrace command* CloseBrace
    ;

begin
    : MainInit command* MainFinish
    ;

command
    : simpleCommand
    | whileExpression
    | ifExpression
    | forExpression
    | switchExpression
    | print
    | read
    | tryExpression
    | functionCall
    | throwExpression
    | (Break | Return expression) SemiColon
    ;

simpleCommand
    : expression SemiColon
    | declaration (Assign expression)? SemiColon
    | (This Dot)? Identifier (Assign | MultiplyAssign | DivideAssign | ModulusAssign | PlusAssign | MinusAssign) expression SemiColon
    ;

function
    :  Function (typeFunction | typeArray) Identifier OpenParent parameters CloseParent OpenBrace command* CloseBrace
    ;

parameters
    :  ((declaration Comma)*declaration)?
    ;

declaration
    :  type Identifier
    |  typeArray Identifier
    ;

newObjectInit
    : New Identifier OpenParent ((Identifier Comma)*Identifier)? CloseParent
    ;

type
    : Int
    | Float
    | Boolean
    | String
    | Identifier
    ;

typeFunction
    : Int
    | Float
    | Boolean
    | String
    | Void
    | Identifier
;

typeArray
    : Array LessThan Identifier MoreThan
    ;

expression
    : Not expression
    | OpenParent expression CloseParent
    | expression binary expression
    | functionCall
    | value
    | Identifier
    | newObjectInit
    | initArray
    ;

initArray
    : OpenBrace (value Comma)* value? CloseBrace
    ;

binary
    : Plus
    | Minus
    | Multiply
    | Divide
    | Modulus
    | MoreThan
    | LessThan
    | GreaterThanEquals
    | LessThanEquals
    | EqualsSymbol
    | NotEquals
    | And
    | Or
    ;

functionCall
    : Identifier OpenParent ((Identifier Comma)*Identifier)? CloseParent
    | Identifier Dot Identifier OpenParent ((Identifier Comma)*Identifier)? CloseParent
    ;

value
    : DecimalLiteral
    | BooleanLiteral
    | StringLiteral
    ;

whileExpression
    : While OpenParent expression CloseParent OpenBrace command* CloseBrace
    ;

forExpression
    : For OpenParent simpleCommand? expression? SemiColon simpleCommand? CloseParent OpenBrace command* CloseBrace
    | For OpenParent declaration In Identifier CloseParent OpenBrace command* CloseBrace
    ;

switchExpression
    : Switch OpenParent Identifier CloseParent OpenBrace caseExpression* defaultExpression? CloseBrace
    ;

caseExpression
    : Case expression Colon command*
    ;

defaultExpression
    : Default OpenBrace command* CloseBrace
    ;

ifExpression
    : If OpenParent expression CloseParent QuestionMark OpenBrace command* CloseBrace (ElseIf OpenParent expression CloseParent QuestionMark OpenBrace command* CloseBrace)* ( Else OpenBrace command* CloseBrace)?
    ;

print
    : Print OpenParent expression CloseParent SemiColon
    ;

read
    : Read OpenParent Identifier CloseParent SemiColon
    ;

tryExpression
    : Try OpenBrace command* CloseBrace catchExpression
    ;

catchExpression
    : Catch OpenParent Identifier CloseParent OpenBrace command* CloseBrace
    ;

throwExpression
    : Throw expression SemiColon
    ;

comment
    : MultiLineComment
    | SingleLineComment
    ;
