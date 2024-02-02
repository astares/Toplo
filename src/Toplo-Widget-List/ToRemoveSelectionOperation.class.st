Class {
	#name : #ToRemoveSelectionOperation,
	#superclass : #ToSelectionOperation,
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #dispatching }
ToRemoveSelectionOperation >> applyIndexesSelection: aSelectionCommand on: anObject [

	anObject removeIndexesSelectionCommand: aSelectionCommand
]

{ #category : #dispatching }
ToRemoveSelectionOperation >> applyIntervalSelection: aSelectionCommand on: anObject [

	anObject removeIntervalSelectionCommand: aSelectionCommand
]

{ #category : #dispatching }
ToRemoveSelectionOperation >> applyWholeSelection: aSelectionCommand on: anObject [

	anObject removeWholeSelectionCommand: aSelectionCommand
]

{ #category : #testing }
ToRemoveSelectionOperation >> isSelection [

	^ false
]