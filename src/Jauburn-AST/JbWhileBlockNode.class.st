Class {
	#name : #JbWhileBlockNode,
	#superclass : #JbAbstractSyntaxTreeNode,
	#instVars : [
		'condition',
		'body'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbWhileBlockNode >> body [

	^ body
]

{ #category : #accessing }
JbWhileBlockNode >> body: anObject [

	body := anObject
]

{ #category : #accessing }
JbWhileBlockNode >> condition [

	^ condition
]

{ #category : #accessing }
JbWhileBlockNode >> condition: anObject [

	condition := anObject
]
