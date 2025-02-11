Extension { #name : #JbReturnStatementNode }

{ #category : #'*Jauburn-Interpreter' }
JbReturnStatementNode >> executeIn: environment [
	| result ex |
	result := expression evaluateIn: environment.
	ex := JbReturnException new.
	ex result: result.
	ex signal: 'returning'.
]
