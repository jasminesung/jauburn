"
I parse arithmetic expressions
"
Class {
	#name : #JbArithmeticExpressionParser,
	#superclass : #PPCompositeParser,
	#instVars : [
		'arithmeticExpression',
		'numberExpression',
		'identifierExpression',
		'identifier',
		'arithmeticTerm',
		'arithmeticFactor',
		'functionCallExpression'
	],
	#category : #'Jauburn-Parser-Core'
}

{ #category : #accessing }
JbArithmeticExpressionParser class >> dependencies [

	^ { JbNumberParser. JbParser }
]

{ #category : #'non-terminals' }
JbArithmeticExpressionParser >> arithmeticExpression [

	^ arithmeticTerm, (('+' asParser trim / '-' asParser trim) , arithmeticTerm) star
	  ==> [ :arr |
		| current |
		current := arr first.
		arr second do: [ :pair |
			pair first = '+' ifTrue: [current := JbAdditionNode new
				             lhs: current;
				             rhs: pair second;
				             yourself].
			pair first = '-' ifTrue: [current := JbSubtractionNode new
				             lhs: current;
				             rhs: pair second;
				             yourself].
			].
		current
		]
]

{ #category : #'non-terminals' }
JbArithmeticExpressionParser >> arithmeticFactor [

	^ '(' asParser trim , arithmeticExpression , ')' asParser trim
	  ==> [ :arr | arr second ] / functionCallExpression / numberExpression
	   / identifierExpression
]

{ #category : #'non-terminals' }
JbArithmeticExpressionParser >> arithmeticTerm [

	^ arithmeticFactor, (($* asParser trim / $/ asParser trim / $% asParser trim), arithmeticFactor) star
	  ==> [ :arr | |current|
		current := arr first.
		arr second do: [ :pair |
			pair first = $* ifTrue: [current := JbMultiplicationNode new
			  lhs: current;
			  rhs: pair second
			  yourself].
			pair first = $/ ifTrue: [current := JbDivisionNode new
			  lhs: current;
			  rhs: pair second
			  yourself].
			pair first = $% ifTrue: [current := JbModulusNode new
			  lhs: current;
			  rhs: pair second
			  yourself]].
		current ]
]

{ #category : #'non-terminals' }
JbArithmeticExpressionParser >> functionCallExpression [

	^(self dependencyAt: JbParser) functionCallExpression
]

{ #category : #'non-terminals' }
JbArithmeticExpressionParser >> identifier [

	^ (#letter asParser
	   , (#letter asParser / #digit asParser / $_ asParser) star) flatten
		  trim
]

{ #category : #'non-terminals' }
JbArithmeticExpressionParser >> identifierExpression [

	^ identifier ==> [ :arr | 
	  JbIdentifierExpressionNode new
		  identifier: arr;
		  yourself ]
]

{ #category : #'non-terminals' }
JbArithmeticExpressionParser >> numberExpression [

	^ (self dependencyAt: JbNumberParser) number ==> [ :n | 
	  JbConstantExpressionNode new
		  value: n;
		  yourself ]
]

{ #category : #accessing }
JbArithmeticExpressionParser >> start [ 

	^arithmeticExpression
]
