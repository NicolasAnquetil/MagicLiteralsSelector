Class {
	#name : #MLSExperimentPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'methodsList',
		'methodPresenter',
		'progressBar',
		'methodsSample',
		'saveSelectionsButton'
	],
	#category : #'MagicLiteralsSelector-Spec'
}

{ #category : #specs }
MLSExperimentPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: (SpPanedLayout newHorizontal
					add: #methodsList;
					add: #methodPresenter;
					yourself);
		add: 'Progress:' expand: false;
		add: #progressBar expand: false;
		add: #saveSelectionsButton expand: false;
		yourself
]

{ #category : #specs }
MLSExperimentPresenter class >> openOnPharoMethods: aCollection [
	self openOnSample: (MLSMethodsSample methods: (aCollection collect: [ :m | MLSMethod compiledMethod: m ]))
]

{ #category : #specs }
MLSExperimentPresenter class >> openOnSample: aMethodSample [
	self new 
		methodsSample: aMethodSample ;
    	openWithSpec.
]

{ #category : #initialization }
MLSExperimentPresenter >> initializePresenters [
	methodsList := self instantiate: MLSMethodListPresenter.
	methodPresenter := self instantiate: MLSMethodPresenter.
	
	methodsList whenSelectionChangedDo: [ :selection |
		selection selectedItem ifNotNil: [ :item | methodPresenter method: item] ].
	
	progressBar := self newProgressBar.
	progressBar progress: [ methodsSample ifNil: [ 0 ] ifNotNil: #completionPercentage ] every: 0.5 second.
	
	saveSelectionsButton := self newButton
		label: 'Save selections to file';
		icon: ((self iconNamed: #smallSaveAsIcon ));
		help: 'Saves the results of the classifications (selections) in a file';
		action: [ self saveExperimentResults ]
		yourself.

]

{ #category : #initialization }
MLSExperimentPresenter >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'MagicLiterals Experiment' ;
		initialExtent: 900@600
]

{ #category : #accessing }
MLSExperimentPresenter >> methodsSample: aMethodsSample [
	methodsSample := aMethodsSample asMethodsSample.
	methodsList methodsSample: aMethodsSample.

]

{ #category : #actions }
MLSExperimentPresenter >> saveExperimentResults [
	| fileSavedIn |
	fileSavedIn := methodsSample asSerializedMethodsSample saveInImageDirectory.
	UIManager default inform: ('Results saved in "{1}"' format: {fileSavedIn}).
]
