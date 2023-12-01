Extension { #name : #JbIfBlockNode }

{ #category : #'*Jauburn-Interpreter' }
JbIfBlockNode >> executeIn: environment [
	| conditionTrue |
	conditionTrue := self condition evaluateIn: environment.
	conditionTrue ifTrue: [self body do: [ :each | each executeIn: environment ]].

]
