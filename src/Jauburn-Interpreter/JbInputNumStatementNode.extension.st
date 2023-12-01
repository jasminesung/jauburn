Extension { #name : #JbInputNumStatementNode }

{ #category : #'*Jauburn-Interpreter' }
JbInputNumStatementNode >> executeIn: environment [

	| inputNum |
	inputNum := UIManager default request: 'Enter a number'.
	inputNum := inputNum asNumber.
	environment at: self identifier put: inputNum.
]
