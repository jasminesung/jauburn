Class {
	#name : #JbParserTest,
	#superclass : #JbAbstractParserTest,
	#category : #'Jauburn-Parser-Tests'
}

{ #category : #accessing }
JbParserTest >> parserClass [

	^JbParser
]

{ #category : #'tests-statements' }
JbParserTest >> testAnonymousFunctionDefinitionWithAssignment [

	| func |
	func := self
		        parse: 'function () {x = 22;}'
		        rule: #anonymousFunctionExpression.
	self assert: func body notEmpty.
	self assert: func body first identifier equals: 'x'.

	func := self
		        parse: 'function(    ) {x = 22;}'
		        rule: #anonymousFunctionExpression.
	self assert: func body notEmpty.
	self assert: func body first identifier equals: 'x'.
	
	func := self parse: 'function(a, b) {if (a) {if (b) {return true;} else {return false;}} else {return false;}}' rule: #anonymousFunctionExpression.
	self assert: func parameters size equals: 2.
	self assert: func body first condition identifier equals: #a.
]

{ #category : #'tests-expressions' }
JbParserTest >> testAnonymousFunctionExpression [

	| f |
	f := self parse: 'function (x,y,z) { }' rule: #anonymousFunctionExpression.
	self assert: f body isEmpty.
	self assert: f parameters size equals: 3.
	f := self parse: 'function (a,b,something,nothing) { }' rule: #anonymousFunctionExpression.
	self assert: f body isEmpty.
	self assert: f parameters size equals: 4.
	self fail: 'function (x+1) { }' rule: #anonymousFunctionExpression.
]

{ #category : #'tests-expressions' }
JbParserTest >> testArithmeticExpression [

	"Arithmetic expressions are tested in the appropriate parser test.  Just make sure our parser has access to these expressions"

	| expression |
	expression := self parse: 'monkey*13' rule: #arithmeticExpression.
	self assertNode: expression lhs isIdentifier: 'monkey'.
	self assertNode: expression rhs isConstant: 13.
	self assertNode: expression  isOperator: $*
]

{ #category : #'tests-statements' }
JbParserTest >> testAssignmentStatement [
	| exp |
	exp := self parse: 'x = 33;' rule: #assignmentStatement.
	self assert: exp identifier equals: 'x'.
	self assert: exp expression value equals: 33
]

{ #category : #'tests-expressions' }
JbParserTest >> testBooleanExpression [

	| expression |
	expression := self parse: 'true' rule: #booleanExpression.
	self assert: expression value.
	
	expression := self parse: 'false' rule: #booleanExpression.
	self deny: expression value.
	
]

{ #category : #'tests-expressions' }
JbParserTest >> testComparisonExpression [

	| exp |
	exp := self parse: 'falafel==1' rule: #comparisonExpression.
	self assert: exp lhs identifier equals: #falafel.
	self assert: exp operator equals: '=='.
	exp := self parse: 'falafel<1' rule: #comparisonExpression.
	self assert: exp lhs identifier equals: #falafel.
	self assert: exp operator equals: '<'.
	exp := self parse: 'falafel<=1' rule: #comparisonExpression.
	self assert: exp lhs identifier equals: #falafel.
	self assert: exp operator equals: '<='.
	exp := self parse: 'falafel>1' rule: #comparisonExpression.
	self assert: exp lhs identifier equals: #falafel.
	self assert: exp operator equals: '>'.
	exp := self parse: 'falafel>=1' rule: #comparisonExpression.
	self assert: exp lhs identifier equals: #falafel.
	self assert: exp operator equals: '>='.
	exp := self parse: 'falafel!=1' rule: #comparisonExpression.
	self assert: exp lhs identifier equals: #falafel.
	self assert: exp operator equals: '!='.

]

{ #category : #'tests-expressions' }
JbParserTest >> testExpression [

	"Arithmetic expressions are tested elsewhere.  This test includes one such expression but otherwise focuses on other types of expressions."

	| exp |
	exp := self parse: '3+4' rule: #expression.
	self assertNode: exp lhs isConstant: 3.
	self assertNode: exp isOperator: $+.
	self assertNode: exp rhs isConstant: 4.
	exp := self
		       parse: 'function (a,b,something,nothing) { }'
		       rule: #expression.
	self assert: exp parameters size equals: 4.
	exp := self parse: 'x == 1' rule: #expression.
	self assert: exp operator equals: '=='.
	exp := self parse: 'true' rule: #expression.
	self assert: exp value.
	exp := self parse: 'false' rule: #expression.
	self deny: exp value.
	exp := self parse: 'foo(1,2,3)' rule: #expression.
	self assert: exp identifier equals: 'foo'
]

{ #category : #'tests-expressions' }
JbParserTest >> testExpressionList [

	| vals |
	vals := self parse: '1,23,monkey,18+2*5' rule: #expressionList.
	self assert: vals first value equals: 1.
	self assert: vals second value equals: 23.
	self assert: vals third identifier equals: 'monkey'.
	self assert: vals fourth operator equals: $+.
]

{ #category : #'tests-expressions' }
JbParserTest >> testFunctionCallExpression [

	| call |
	call := self parse: 'f(a,b+c,c)' rule: #functionCallExpression.
	self assert: call identifier equals: 'f'.
	self assert: call arguments first identifier equals: 'a'.
	self assert: call arguments second operator equals: $+.
	self assert: call arguments third identifier equals: 'c'.

	call := self parse: 'speak()' rule: #functionCallExpression.
	self assert: call identifier equals: 'speak'.
	self assert: call arguments isEmpty.

	call := self parse: 'speak (    )' rule: #functionCallExpression.
	self assert: call identifier equals: 'speak'.
	self assert: call arguments isEmpty
]

{ #category : #'tests-expressions' }
JbParserTest >> testFunctionCallStatement [

	| stmt |
	stmt := self
		        parse: 'banana("monkey", 12, 3+2);'
		        rule: #functionCallStatement.
	self assert: stmt identifier equals: 'banana'.
	self assert: stmt arguments size equals: 3.

	stmt := self parse: 'monkey  ( )   ;' rule: #functionCallStatement.
	self assert: stmt identifier equals: 'monkey'.
	self assert: stmt arguments size equals: 0
]

{ #category : #'tests-expressions' }
JbParserTest >> testIdentifierExpression [

	self assert: (self parse: 's1mpl3' rule: #identifierExpression) identifier equals: 's1mpl3'.
	self assert: (self parse: 'a___11bADWQ' rule: #identifierExpression) identifier equals: 'a___11bADWQ'.
	self fail: 'a?' rule: #identifierExpression.
	self fail: '12monkeys' rule: #identifierExpression
]

{ #category : #'tests-expressions' }
JbParserTest >> testIdentifierExpressionList [

	self assert: (self parse: 'apple,banana,monkey' rule: #identifierExpressionList) size equals: 3.
	self assert: (self parse: '' rule: #identifierExpressionList) size equals: 0
]

{ #category : #'tests-statements' }
JbParserTest >> testIfBlock [
	| expression |
	expression := self parse: 'if (x == 1) {
	x = x + 1;
	y = y - 5;
	}' rule: #ifBlock.
	self assert: expression condition operator equals: '=='.
	self assert: expression body size equals: 2.
	
	expression := self parse: 'if (x <= 1) {}' rule: #ifBlock.
	self assert: expression condition operator equals: '<='.
	self assert: expression body size equals: 0.
	
	expression := self parse: 'if (true) {}' rule: #ifBlock.
	self assert: expression condition value.
	self assert: expression body size equals: 0.
	
	expression := self parse: 'if ("abc" == "def") {return 2;}' rule: #ifBlock.
	self assert: expression condition operator equals: '=='.
	self assert: expression body size equals: 1.
	
	expression := self parse: 'if (b) {return 2;}' rule: #ifBlock.
	self assert: expression condition identifier equals: #b.
	self assert: expression body size equals: 1.
]

{ #category : #'tests-statements' }
JbParserTest >> testIfElseBlock [
	| expression |
	expression := self parse: 'if (x == 1) {
	x = x + 1;
	} else {
	y = y - 5;
	z = 2;
	}' rule: #ifElseBlock.
	self assert: expression condition operator equals: '=='.
	self assert: expression ifBody size equals: 1.
	self assert: expression elseBody size equals: 2.
	
	expression := self parse: 'if (x > 1) {
	x = x + 1;
	} else {    }' rule: #ifElseBlock.
	self assert: expression condition operator equals: '>'.
	self assert: expression ifBody size equals: 1.
	self assert: expression elseBody size equals: 0.
	
	expression := self parse: 'if (a) {if (b) {return true;} else {return false;}} else {return false;}' rule: #ifElseBlock.
	self assert: expression condition identifier equals: #a.
	self deny: expression elseBody first expression value.
	self assert: expression ifBody first condition identifier equals: #b.
	self assert: expression ifBody first ifBody first expression value.
	self deny: expression ifBody first elseBody first expression value.
]

{ #category : #'tests-statements' }
JbParserTest >> testInputNumStatement [
	| func |
	func := self parse: 'inputnum a;' rule: #inputNumStatement.
	self assert: func identifier equals: #a
]

{ #category : #'tests-statements' }
JbParserTest >> testInvalidIfBlock [
	self fail: 'if x == 1 { }' rule: #ifBlock
]

{ #category : #'tests-statements' }
JbParserTest >> testInvalidIfElseBlock [
	self fail: 'if (x == 1) x = x + 1; else {}' rule: #ifElseBlock
]

{ #category : #'tests-statements' }
JbParserTest >> testInvalidInputNumStatement [
	self fail: 'inputnum 45;' rule: #inputNumStatement.
	self fail: 'inputnum "hello";' rule: #inputNumStatement.
]

{ #category : #'tests-statements' }
JbParserTest >> testInvalidWhileBlock [
	self fail: 'while a > b {}' rule: #whileBlock
]

{ #category : #'tests-program' }
JbParserTest >> testProgram [ 

	| pgm |
	pgm := self parse: 'var x = function(x) { var z = 22; var y = z + 1; return x*z; };
var lmnop123 = 9 * 2 + 44; var z = x(99);'.
	self assert: pgm statements size equals: 3.
	self assert: pgm statements first identifier equals: 'x'.
	self assert: pgm statements second identifier equals: 'lmnop123'.
	self assert: pgm statements third identifier equals: 'z'.
	self assert: pgm statements third expression identifier equals: 'x'.
	
	pgm := self parse: '
var x = 2;'.
		self assert: pgm statements size equals: 1.
	self assert: pgm statements first identifier equals: 'x'.
]

{ #category : #'tests-statements' }
JbParserTest >> testReturnStatement [
	| func |
	func := self parse: 'return 37;' rule: #returnStatement.
	self assert: func expression value equals: 37.
	
	func := self parse: 'return 3*2;' rule: #returnStatement.
	self assert: func expression operator equals: $*.
]

{ #category : #'tests-statements' }
JbParserTest >> testStatement [

	| stmt |
	stmt := self parse: 'var monkey = -1231 + x;' rule: #statement.
	self assert: stmt identifier equals: 'monkey'.
	stmt := self parse: 'zebra = 3 *x + 1;' rule: #statement.
	self assert: stmt identifier equals: 'zebra'.
	stmt := self parse: 'return x*y+1;' rule: #statement.
	self assert: stmt expression lhs lhs identifier equals: 'x'
]

{ #category : #'tests-statements' }
JbParserTest >> testStatementBlock [ 

	| blk |
	blk := self parse: '{ x = 1; var y = 23 * x; }' rule: #statementBlock.
	self assert: blk size equals: 2.
	self assert: blk first identifier equals: 'x'.
	self assert: blk second identifier equals: 'y'
]

{ #category : #'tests-expressions' }
JbParserTest >> testStringComparisonExpression [

	| exp |
	exp := self parse: '"foo bar" == "biz baz"' rule: #stringComparisonExpression.
	self assert: exp lhs value equals: 'foo bar'.
	self assert: exp operator equals: '=='.
	self assert: exp rhs value equals: 'biz baz'.

]

{ #category : #'tests-expressions' }
JbParserTest >> testStringExpression [
	"Numbers are tested in JbNumberParserTest.  Here we just make sure that
	we can parse a number."
	
	self assert: (self parse: '"abc124 hello"' rule: #stringExpression) value equals: 'abc124 hello'.
	self fail: 'abc' rule: #stringExpression
]

{ #category : #'tests-statements' }
JbParserTest >> testVariableDeclarationStatement [

	| stmt |
	stmt := self parse: 'var x = 22;' rule: #variableDeclarationStatement.
	self assert: stmt identifier equals: 'x'.
	stmt := self parse: 'var monkey = 37*x;' rule: #variableDeclarationStatement.
	self assert: stmt identifier equals: 'monkey'
]

{ #category : #'tests-statements' }
JbParserTest >> testWhileBlock [
	| expression |
	expression := self parse: 'while(x < 5) {
		x = x + 1;
	}' rule: #whileBlock.
	self assert: expression condition operator equals: '<'.
	self assert: expression body size equals: 1.
	
	expression := self parse: 'while(x > y) {
	
	
	}' rule: #whileBlock.
	self assert: expression condition operator equals: '>'.
	self assert: expression body size equals: 0.

]
