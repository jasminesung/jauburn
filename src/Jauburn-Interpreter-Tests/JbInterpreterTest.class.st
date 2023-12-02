Class {
	#name : #JbInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'interpreter',
		'parser'
	],
	#category : #'Jauburn-Interpreter-Tests'
}

{ #category : #utilities }
JbInterpreterTest >> interpret: aString [

	^ interpreter interpret: aString
]

{ #category : #running }
JbInterpreterTest >> setUp [ 

	parser := JbParser new.
	interpreter := JbInterpreter new
]

{ #category : #running }
JbInterpreterTest >> testAssignmentChangesVariableToExpressionValue [

	self interpret: 'var x = 3 + 2 * 8; x = 99;'.
	self assert: (interpreter environment at: 'x') equals: 99.
]

{ #category : #running }
JbInterpreterTest >> testDeclarationBindsVariableToExpressionValue [

	self interpret: 'var x = 3 + 2 * 8;'.
	self assert: (interpreter environment at: 'x') equals: 19.
	
	self interpret: 'var x = 6;var y = 2*x;'.
	self assert: (interpreter environment at: 'y') equals: 12
]

{ #category : #running }
JbInterpreterTest >> testDeclarationCreatesVariable [

	self interpret: 'var x = 99;'.
	self assert: (interpreter environment includesKey: 'x')
]

{ #category : #running }
JbInterpreterTest >> testInterpretArithmeticExpressions [

	self interpret: 'var x = 6 % 3;'.
	self assert: (interpreter environment at: 'x') equals: 0.
	
	self interpret: 'var x = 100 / 25;'.
	self assert: (interpreter environment at: 'x') equals: 4.
	
	self interpret: 'var x = 300 - 100;'.
	self assert: (interpreter environment at: 'x') equals: 200.
]

{ #category : #running }
JbInterpreterTest >> testInterpretFunctionCallExpressions [
	| result |
	[self interpret: 'var f = function(x) { return x * 2; }; var y = 2 * f(3);'] on: JbReturnException do: [:ex | result := ex result].
	self assert: (interpreter environment at: 'y') equals: 12.
]

{ #category : #running }
JbInterpreterTest >> testInterpretFunctionCallStatement [
	| result |
	[self interpret: 'var y = 0; var f = function() { while (y < 10) { y = y + 1; } }; f();'] on: JbReturnException do: [:ex | result := ex result].
	self assert: (interpreter environment at: 'y') equals: 10.
]

{ #category : #running }
JbInterpreterTest >> testInterpretFunctionDefinitionNode [
	| variableF additionNode |
	self interpret: 'var f = function(a, b) {return a + b;};'.
	variableF := interpreter environment at: 'f'.
	self assert: variableF parameters size equals: 2.
	self assert: variableF parameters first identifier equals: #a.
	self assert: variableF parameters second identifier equals: #b.
	self assert: variableF body size equals: 1.
	additionNode := variableF body first expression.
	self assert: additionNode lhs identifier equals: #a.
	self assert: additionNode rhs identifier equals: #b.
	self assert: additionNode operator equals: $+.
]

{ #category : #running }
JbInterpreterTest >> testInterpretIfBlock [

	self interpret: 'var x = 2; if (x == 1) {var y = 2;}'.
	self assert: (interpreter environment includesKey: 'x').
	self assert: (interpreter environment includesKey: 'y') equals: false.
	
	self interpret: 'var x = 1; if (x == 1) {var y = 2;}'.
	self assert: (interpreter environment includesKey: 'x').
	self assert: (interpreter environment includesKey: 'y').
	self assert: (interpreter environment at: 'y') equals: 2.
]

{ #category : #running }
JbInterpreterTest >> testInterpretIfElseBlock [

	self interpret: 'var x = 2; if (x == 1) {var y = 1;} else {var z = 3;}'.
	self assert: (interpreter environment at: 'z') equals: 3.
	self assert: (interpreter environment includesKey: 'y') equals: false.
	
	self interpret: 'var a = 1; if (a == 1) {var b = 1;} else {var c = 3;}'.
	self assert: (interpreter environment at: 'b') equals: 1.
	self assert: (interpreter environment includesKey: 'c') equals: false.
]

{ #category : #running }
JbInterpreterTest >> testInterpretInputNumStatement [

	self interpret: 'inputnum x;'.
	self assert: (interpreter environment includesKey: 'x')
]

{ #category : #running }
JbInterpreterTest >> testInterpretReturnStatement [
	| result |
	[self interpret: 'return 3;'] on: JbReturnException do: [:ex | result := ex result].
	self assert: result equals: 3.
	
	[self interpret: 'return 3 + 2;'] on: JbReturnException do: [:ex | result := ex result].
	self assert: result equals: 5.
]

{ #category : #running }
JbInterpreterTest >> testInterpretWhileBlock [

	self interpret: 'var x = 0; while (x < 5) {x = x + 1;}'.
	self assert: (interpreter environment at: 'x') equals: 5.
	
	self interpret: 'var x = 100; while (x < 5) {x = x + 1;}'.
	self assert: (interpreter environment at: 'x') equals: 100.
]

{ #category : #running }
JbInterpreterTest >> testStandardLibrary [

| notFunc |
notFunc := JbInterpreter standardLibrary: 'not'.
notFunc inspect.
]
