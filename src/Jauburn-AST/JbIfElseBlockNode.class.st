Class {
	#name : #JbIfElseBlockNode,
	#superclass : #JbAbstractSyntaxTreeNode,
	#instVars : [
		'condition',
		'ifBody',
		'elseBody'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbIfElseBlockNode >> condition [

	^ condition
]

{ #category : #accessing }
JbIfElseBlockNode >> condition: anObject [

	condition := anObject
]

{ #category : #accessing }
JbIfElseBlockNode >> elseBody [

	^ elseBody
]

{ #category : #accessing }
JbIfElseBlockNode >> elseBody: anObject [

	elseBody := anObject
]

{ #category : #accessing }
JbIfElseBlockNode >> ifBody [

	^ ifBody
]

{ #category : #accessing }
JbIfElseBlockNode >> ifBody: anObject [

	ifBody := anObject
]
