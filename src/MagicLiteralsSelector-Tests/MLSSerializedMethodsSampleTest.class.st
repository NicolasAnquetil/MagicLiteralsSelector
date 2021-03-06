"
A MLSSerializedMethodsSampleTest is a test class for testing the behavior of MLSSerializedMethodsSample
"
Class {
	#name : #MLSSerializedMethodsSampleTest,
	#superclass : #MLSAbstractSerializationClassTest,
	#category : #'MagicLiteralsSelector-Tests-serialization'
}

{ #category : #tests }
MLSSerializedMethodsSampleTest >> testAsSerializedMethodsSample [
	| sample serialized |
	sample := MLSMethodsSample new
		name: 'test sample' ;
		methods: { 
			self mlsMethodFor: #sampleMethodWithLiterals1.
			self mlsMethodFor: #sampleMethodWithLiterals2 }.
	
	serialized := sample asSerializedMethodsSample.
	
	self assert: serialized methods size equals: 2.
	self assert: serialized name equals: 'test sample'.
]
