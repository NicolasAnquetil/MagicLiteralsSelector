"
Serialized version of an MLSMethod
Does not contain the AST tree of the method, but source code as text and information to recover the CompiledMethod (package name, class name, selector) in this image if it exists
"
Class {
	#name : #MLSSerializedMethod,
	#superclass : #Object,
	#instVars : [
		'methodPackageName',
		'methodClassName',
		'methodSelector',
		'literalCandidates',
		'sourceCode',
		'commentLength'
	],
	#category : #'MagicLiteralsSelector-serialization'
}

{ #category : #accessing }
MLSSerializedMethod >> commentLength [
	^commentLength
]

{ #category : #accessing }
MLSSerializedMethod >> commentLength: anInt [
	commentLength := anInt
]

{ #category : #converting }
MLSSerializedMethod >> compiledMethodIfFound: foundBlock ifAbsent: absentBlock [
	| clazz |
	clazz := (Smalltalk classNamed: methodClassName)
		ifNil: [ MLSClassExternal forPackage: methodPackageName name: methodClassName].
	^clazz
		compiledMethodAt: methodSelector
		ifPresent: [ :m | foundBlock value: m]
		ifAbsent: absentBlock

]

{ #category : #converting }
MLSSerializedMethod >> fixStonErrors [
	"correct ston issues in CanNotDecide statuses"
	literalCandidates do: #fixStonErrors.

]

{ #category : #accessing }
MLSSerializedMethod >> literalCandidates [
	^ literalCandidates
]

{ #category : #accessing }
MLSSerializedMethod >> literalCandidates: anObject [
	literalCandidates := anObject
]

{ #category : #accessing }
MLSSerializedMethod >> methodClassName [
	^ methodClassName
]

{ #category : #accessing }
MLSSerializedMethod >> methodClassName: anObject [
	methodClassName := anObject
]

{ #category : #accessing }
MLSSerializedMethod >> methodPackageName [
	^ methodPackageName
]

{ #category : #accessing }
MLSSerializedMethod >> methodPackageName: anObject [
	methodPackageName := anObject
]

{ #category : #accessing }
MLSSerializedMethod >> methodSelector [
	^ methodSelector
]

{ #category : #accessing }
MLSSerializedMethod >> methodSelector: anObject [
	methodSelector := anObject
]

{ #category : #accessing }
MLSSerializedMethod >> sourceCode [
	^ sourceCode
]

{ #category : #accessing }
MLSSerializedMethod >> sourceCode: anObject [
	sourceCode := anObject.
	self commentLength
]
