Class {
	#name : #JbIfBlockNode,
	#superclass : #JbAbstractSyntaxTreeNode,
	#instVars : [
		'condition',
		'body'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbIfBlockNode >> body [

	^ body
]

{ #category : #accessing }
JbIfBlockNode >> body: anObject [

	body := anObject
]

{ #category : #accessing }
JbIfBlockNode >> condition [

	^ condition
]

{ #category : #accessing }
JbIfBlockNode >> condition: anObject [

	condition := anObject
]
