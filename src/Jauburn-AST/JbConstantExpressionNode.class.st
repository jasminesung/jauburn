Class {
	#name : #JbConstantExpressionNode,
	#superclass : #JbAbstractSyntaxTreeNode,
	#instVars : [
		'value'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #'as yet unclassified' }
JbConstantExpressionNode class >> standardLibrary [

	| not |
	not := 'function not(b) { if (b == true) {return false;} else {return true;}}'.
]

{ #category : #accessing }
JbConstantExpressionNode >> value [
	^ value
]

{ #category : #accessing }
JbConstantExpressionNode >> value: anObject [
	value := anObject
]
