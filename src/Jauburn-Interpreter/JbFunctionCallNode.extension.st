Extension { #name : #JbFunctionCallNode }

{ #category : #'*Jauburn-Interpreter' }
JbFunctionCallNode >> evaluateIn: environment [
	| innerEnvironment function argumentsAndParametersMatch |
	innerEnvironment := JbEnvironment new.
	innerEnvironment outerEnvironment: environment.
	function := (environment at: self identifier).
	argumentsAndParametersMatch := (function parameters) size = self arguments size.
	argumentsAndParametersMatch ifFalse: [self error: 'Number of arguments and parameters do not match!'].
	self arguments withIndexDo: [:each :index | innerEnvironment at: ((function parameters at: index) identifier) put: (each value).].
	function body do: [:each | [each executeIn: innerEnvironment] on: JbReturnException do: [:e | ^(e result)]].
]

{ #category : #'*Jauburn-Interpreter' }
JbFunctionCallNode >> executeIn: environment [
	| innerEnvironment function argumentsAndParametersMatch |
	innerEnvironment := JbEnvironment new.
	innerEnvironment outerEnvironment: environment.
	function := (environment at: self identifier).
	argumentsAndParametersMatch := (function parameters) size = self arguments size.
	argumentsAndParametersMatch ifFalse: [self error: 'Number of arguments and parameters do not match!'].
	self arguments withIndexDo: [:each :index | innerEnvironment at: ((function parameters at: index) identifier) put: (each value).].
	function body do: [:each | [each executeIn: innerEnvironment] on: JbReturnException do: [:e | ^(e result)]].
]
