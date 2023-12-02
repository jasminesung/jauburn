"
Just a place to house a few sample programs
"
Class {
	#name : #JbSamplePrograms,
	#superclass : #Object,
	#category : #'Jauburn-Interpreter-SamplePrograms'
}

{ #category : #'sample programs' }
JbSamplePrograms class >> assignAndPrint [

	"self run: self assignAndPrint"

	^ '
var x = 19;
var y = 32 * ( x + 5 ) * x;
print x;
print y;
print 5*y;'
]

{ #category : #'sample programs' }
JbSamplePrograms class >> gcd [

	"self run: self gcd"
	| num1 num2 |
	num1 := UIManager default request: 'Enter the first number'.
	num2 := UIManager default request: 'Enter the second number'.
	^'var gcd = function(a, b) {
	if (a == 0) {
		return b;
	}
	return gcd(b % a, a);
	};
	var result = gcd(', num1, ', ', num2, ');
	print result;'
]

{ #category : #'sample programs' }
JbSamplePrograms class >> noFunctions [

	"self run: self noFunctions"

	^ 'var x = 4;
var y = 10 * x + 2;
print y;
'
]

{ #category : #utilities }
JbSamplePrograms class >> run: aString [

	"Look at sample programs for examples of using this method."

	^ JbInterpreter newWithStandardLibrary run: aString
]

{ #category : #'sample programs' }
JbSamplePrograms class >> sqrt [

	"self run: self sqrt"
	| inputNum |
	inputNum := UIManager default request: 'Enter a number'.
	^'var result = sqrt(', inputNum, ');'
]
