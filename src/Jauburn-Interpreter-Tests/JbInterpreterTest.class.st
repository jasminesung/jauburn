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
