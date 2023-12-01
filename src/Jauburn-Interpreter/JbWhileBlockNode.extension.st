Extension { #name : #JbWhileBlockNode }

{ #category : #'*Jauburn-Interpreter' }
JbWhileBlockNode >> executeIn: environment [
	| conditionTrue |
	conditionTrue := self condition evaluateIn: environment.
	conditionTrue ifTrue: [self executeWhileBody: environment].
]

{ #category : #'*Jauburn-Interpreter' }
JbWhileBlockNode >> executeWhileBody: environment [
	| conditionTrue |
	conditionTrue := self condition evaluateIn: environment.
	conditionTrue ifTrue: [self body do: [ :each | each executeIn: environment ]].
	conditionTrue ifFalse: [^ nil].
	self executeWhileBody: environment
	
]
