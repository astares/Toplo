"
A TToElementWithPlaceholderTest is a test class for testing the behavior of TToElementWithPlaceholder
"
Class {
	#name : 'TToElementWithPlaceholderTest',
	#superclass : 'ToParameterizedHostTest',
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core',
	#package : 'Toplo-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
TToElementWithPlaceholderTest >> setUp [ 

	super setUp.
	space := self newTestingSpace. 

]

{ #category : 'tests' }
TToElementWithPlaceholderTest >> testCurrentPlaceholderLayer [

	self testHidePlaceholder 
]

{ #category : 'tests' }
TToElementWithPlaceholderTest >> testHidePlaceholder [

	| e ph |
	e := ToElementWithPlaceholderForTest new size: 100 asPoint.
	e rawPlaceholderBuilder: [ :thePlaceholder :theElement |
		thePlaceholder addChild: (BlElement new id: #child) ].
	e showPlaceholder.
	ph := e currentPlaceholderLayer.
	self assert: ph notNil.
	self assert: ph parent identicalTo: e.
	e hidePlaceholder.
	self assert: e currentPlaceholderLayer isNil.
	self assert: ph parent isNil.
]

{ #category : 'tests' }
TToElementWithPlaceholderTest >> testPlaceholderBuilder [

	| e builder |
	e := self testRawPlaceholderBuilder.
	builder := e rawPlaceholderBuilder.
	e placeholderBuilder: [ :thePlaceholder :theElement |
		thePlaceholder addChild: (BlElement new id: #child) ].
	self assert: builder ~~ e rawPlaceholderBuilder.
	self assert: e rawPlaceholderBuilder notNil.
	self assert: e  currentPlaceholderLayer isNil.
	self assert: (e userData includesKey: #placeholderBuilder).
	e placeholderBuilder: nil.
	self assert: e rawPlaceholderBuilder isNil.
	self assert: (e userData includesKey: #placeholderBuilder) not
]

{ #category : 'tests' }
TToElementWithPlaceholderTest >> testPlaceholderClass [

	| e |
	e := ToElementWithPlaceholderForTest new.
	self assert: (e placeholderClass inheritsFrom: BlOverlayElement)
]

{ #category : 'tests' }
TToElementWithPlaceholderTest >> testPlaceholderElevation [

	| e |
	e := ToElementWithPlaceholderForTest new.
	self assert: e placeholderElevation equals: e elevation
]

{ #category : 'tests' }
TToElementWithPlaceholderTest >> testRawPlaceholderBuilder [

	| e |
	e := ToElementWithPlaceholderForTest new.
	self assert: e rawPlaceholderBuilder isNil.
	e rawPlaceholderBuilder: [ :thePlaceholder :theElement |
		thePlaceholder addChild: (BlElement new id: #child) ].
	self assert: e rawPlaceholderBuilder notNil.
	self assert: (e rawPlaceholderBuilder isKindOf: BlockClosure ).
	^ e

]

{ #category : 'tests' }
TToElementWithPlaceholderTest >> testShowPlaceholder [

	| e ph |
	e := ToElementWithPlaceholderForTest new size: 100 asPoint.
	e rawPlaceholderBuilder: [ :thePlaceholder :theElement |
		thePlaceholder addChild: (BlElement new id: #child) ].
	e showPlaceholder.
	ph := e currentPlaceholderLayer.
	self assert: ph notNil.
	self assert: ph parent identicalTo: e.
	e forceLayout.
	self assert: ph bounds inSpace bounds equals: e bounds inSpace bounds.
	self assert: ph bounds extent equals: 100 asPoint.
	e showPlaceholder.
	self assert: e currentPlaceholderLayer identicalTo: ph.
	space root addChild: e.
	self assert: ph space identicalTo: e space.
	e position: 200@100.
	e forceLayout.
	self assert: ph bounds inSpace bounds equals: e bounds inSpace bounds.
	self assert: ph bounds inSpace bounds origin equals: 200@100.
]