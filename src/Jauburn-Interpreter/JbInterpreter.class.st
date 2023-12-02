"
I am an interpreter for programs written in the Jauburn language.  My principle API methods are:

	interpret: anAST -- given an abstract syntax tree, interpret it
	run: aString -- parse and interpret the supplied string
"
Class {
	#name : #JbInterpreter,
	#superclass : #Object,
	#instVars : [
		'environment'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #library }
JbInterpreter class >> standardLibrary [

| not and or abs sqrt |
not := 'function not(b) {if (b) { return false;} else {return true;}}'.
and := 'function and(a, b) {if (a) {if (b) {return true;} else {return false;}} else {return false;}'.
or := 'function or(a, b) {if (a) {return true;} if (b) {return true;} else {return false;}'.
abs := 'function abs(f) {if (f < 0) { return -1 * f;} else {return f;}}'.
sqrt := 'function sqrt(x) {
			if (x == 0) {return x;}
			if (x == 1) {return x;}
			var i = 1;
			var result = 1;
			while (result <= x) {
			i = i + 1;
			result = i * 1;
			}
			return i - 1;
			}'.


]

{ #category : #library }
JbInterpreter class >> standardLibrary: functionName [

| not and or abs sqrt |
not := 'function not(b) {if (b) { return false;} else {return true;}}'.
and := 'function and(a, b) {if (a) {if (b) {return true;} else {return false;}} else {return false;}'.
or := 'function or(a, b) {if (a) {return true;} if (b) {return true;} else {return false;}'.
abs := 'function abs(f) {if (f < 0) { return -1 * f;} else {return f;}}'.
sqrt := 'function sqrt(x) {
			if (x == 0) {return x;}
			if (x == 1) {return x;}
			var i = 1;
			var result = 1;
			while (result <= x) {
			i = i + 1;
			result = i * 1;
			}
			return i - 1;
			}'.
[functionName equals: 'not'] ifTrue: [^not].
[functionName equals: 'and'] ifTrue: [^and].
[functionName equals: 'or'] ifTrue: [^or].
[functionName equals: 'abs'] ifTrue: [^abs].
[functionName equals: 'sqrt'] ifTrue: [^sqrt].
]

{ #category : #accessing }
JbInterpreter >> environment [ 

	^environment
]

{ #category : #initialization }
JbInterpreter >> initialize [ 

	super initialize.
	environment := JbEnvironment new
]

{ #category : #api }
JbInterpreter >> interpret: programString [

	| ast |
	ast := self parse: programString.
	self interpretAst: ast
]

{ #category : #api }
JbInterpreter >> interpretAst: ast [

	^ ast executeIn: environment
]

{ #category : #api }
JbInterpreter >> parse: programString [

	| parser |
	parser := JbParser new.
	^(parser parse: programString)
]

{ #category : #api }
JbInterpreter >> run: programString [

	"Just an alias for #interpret:"

	self interpret: programString
]
