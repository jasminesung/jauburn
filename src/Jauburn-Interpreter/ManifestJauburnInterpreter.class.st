"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestJauburnInterpreter,
	#superclass : #PackageManifest,
	#category : #'Jauburn-Interpreter-Manifest'
}

{ #category : #'code-critics' }
ManifestJauburnInterpreter class >> ruleLongMethodsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'JbInterpreter class' #standardLibrary: #true)) #'2023-12-02T13:46:45.604893-05:00') )
]

{ #category : #'code-critics' }
ManifestJauburnInterpreter class >> ruleUnconditionalRecursionRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#JbWhileBlockNode #executeWhileBody: #false)) #'2023-12-01T17:41:56.896636-05:00') )
]
