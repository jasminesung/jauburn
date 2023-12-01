Class {
	#name : #JbInputNumStatementNode,
	#superclass : #JbAbstractSyntaxTreeNode,
	#instVars : [
		'identifier'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbInputNumStatementNode >> identifier [

	^ identifier
]

{ #category : #accessing }
JbInputNumStatementNode >> identifier: anObject [

	identifier := anObject
]
