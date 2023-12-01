"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestJauburnInterpreter,
	#superclass : #PackageManifest,
	#category : #'Jauburn-Interpreter-Manifest'
}

{ #category : #'code-critics' }
ManifestJauburnInterpreter class >> ruleUnconditionalRecursionRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#JbWhileBlockNode #executeWhileBody: #false)) #'2023-12-01T17:41:56.896636-05:00') )
]
