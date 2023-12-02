Class {
	#name : #JbReturnException,
	#superclass : #Error,
	#instVars : [
		'result'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #accessing }
JbReturnException >> result [

	^ result
]

{ #category : #accessing }
JbReturnException >> result: anObject [

	result := anObject
]
