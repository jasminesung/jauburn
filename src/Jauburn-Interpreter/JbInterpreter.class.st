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
JbInterpreter class >> newWithStandardLibrary [
	| functions interpreter |
	interpreter := self new.
	functions := self standardLibrary.
	interpreter interpret: functions.
	^interpreter
]

{ #category : #library }
JbInterpreter class >> standardLibrary [
^'var not = function(b) {if (b) { return false;} else {return true;}};
var and = function(a, b) {if (a) {if (b) {return true;} else {return false;}} else {return false;}};
var or = function(a, b) {if (a) {return true;} if (b) {return true;} else {return false;}};
var abs = function(f) {if (f < 0) { return -1 * f;} else {return f;}};
var sqrt = function(x) {
			if (x == 0) {return x;}
			if (x == 1) {return x;}
			var i = 1;
			var result = 1;
			while (result <= x) {
			i = i + 1;
			result = i * i;
			}
			return i - 1;
			};'
]

{ #category : #library }
JbInterpreter class >> standardLibrary: functionName [

| not and or abs sqrt |
not := 'function(b) {if (b) { return false;} else {return true;}}'.
and := 'function(a, b) {if (a) {if (b) {return true;} else {return false;}} else {return false;}}'.
or := 'function(a, b) {if (a) {return true;} if (b) {return true;} else {return false;}}'.
abs := 'function(f) {if (f < 0) { return -1 * f;} else {return f;}}'.
sqrt := 'function(x) {
			if (x == 0) {return x;}
			if (x == 1) {return x;}
			var i = 1;
			var result = 1;
			while (result <= x) {
			i = i + 1;
			result = i * i;
			}
			return i - 1;
			}'.
functionName = 'not' ifTrue: [^not].
functionName = 'and' ifTrue: [^and].
functionName = 'or' ifTrue: [^or].
functionName = 'abs' ifTrue: [^abs].
functionName = 'sqrt' ifTrue: [^sqrt].
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
