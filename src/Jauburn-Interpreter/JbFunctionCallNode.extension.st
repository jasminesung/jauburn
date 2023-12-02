Extension { #name : #JbFunctionCallNode }

{ #category : #'*Jauburn-Interpreter' }
JbFunctionCallNode >> evaluateIn: environment [
	| innerEnvironment function index argumentsAndParametersMatch |
	innerEnvironment := JbEnvironment new.
	innerEnvironment outerEnvironment: environment.
	function := (environment at: self identifier).
	argumentsAndParametersMatch := (function parameters) size = self arguments size.
	argumentsAndParametersMatch ifFalse: [self error: 'Number of arguments and parameters do not match!'].
	index := 1.
	"get return value from exception"
	self arguments do: [:each | innerEnvironment at: ((function parameters at: index) identifier) put: (each value). index = (index + 1).].
	function body do: [:each | [each executeIn: innerEnvironment] on: JbReturnException do: [:e | ^(e result)]].
]

{ #category : #'*Jauburn-Interpreter' }
JbFunctionCallNode >> executeIn: environment [
	| innerEnvironment function index argumentsAndParametersMatch |
	innerEnvironment := JbEnvironment new.
	innerEnvironment outerEnvironment: environment.
	function := (environment at: self identifier).
	argumentsAndParametersMatch := (function parameters) size = self arguments size.
	argumentsAndParametersMatch ifFalse: [self error: 'Number of arguments and parameters do not match!'].
	index := 1.
	self arguments do: [:each | innerEnvironment at: ((function parameters at: index) identifier) put: (each value). index = (index + 1).].
	function body do: [:each | [each executeIn: innerEnvironment] on: JbReturnException do: [:e | ^(e result)]].
]
