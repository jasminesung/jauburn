Extension { #name : #JbFunctionDefinitionNode }

{ #category : #'*Jauburn-Interpreter' }
JbFunctionDefinitionNode >> evaluateIn: environment [
| jbFunction |
	jbFunction := JbFunction new.
	jbFunction body: self body.
	jbFunction parameters: self parameters.
	jbFunction environment: environment.
	^jbFunction
]
