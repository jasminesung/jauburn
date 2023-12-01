Extension { #name : #JbIfElseBlockNode }

{ #category : #'*Jauburn-Interpreter' }
JbIfElseBlockNode >> executeIn: environment [
| conditionTrue |
	conditionTrue := self condition evaluateIn: environment.
	conditionTrue ifTrue: [self ifBody do: [ :each | each executeIn: environment ]].
	conditionTrue ifFalse: [self elseBody do: [ :each | each executeIn: environment ]].
]
