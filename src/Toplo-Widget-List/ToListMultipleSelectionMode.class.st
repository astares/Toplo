Class {
	#name : #ToListMultipleSelectionMode,
	#superclass : #ToListSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #testing }
ToListMultipleSelectionMode >> allowRequestFocusOnMouseDown [

	( self selectedIndexesCount > 1 )
		ifTrue: [ self preserveSelectionOnFocused ifTrue: [ ^ false ] ].
	^ super allowRequestFocusOnMouseDown
]

{ #category : #testing }
ToListMultipleSelectionMode >> isMultipleSelection [

	^ true
]

{ #category : #'instance creation' }
ToListMultipleSelectionMode >> newSelecterIn: anElement [

	^ ToMultiSelectionModelSelecter new 
]

{ #category : #accessing }
ToListMultipleSelectionMode >> nodeEventHandlerClasses [ 

	^ { ToListNodeMultiSelectionClickEventHandler }
]

{ #category : #'event handling' }
ToListMultipleSelectionMode >> onClickEvent: anEvent onNode: aNode [

	super onClickEvent: anEvent onNode: aNode.
	anEvent modifiers isShift ifTrue: [
		| curr |
		curr := self selecter currentIndex.
		self selecter selectIndex: curr to: aNode holder position.
		^ self ].
	(anEvent modifiers isPrimaryModifier or: [ self selectOnMouseDown ])
		ifTrue: [
			self selectOrDeselectOnNode: aNode.
			^ self ].
	self selecter selectOnlyIndex: aNode holder position
]

{ #category : #'event handling' }
ToListMultipleSelectionMode >> selectOrDeselectOnNode: aNode [

	| index target |
	index := aNode holder position.
	target := aNode holder listElement.
	(target selectionModel containsIndex: index)
		ifTrue: [ self selecter deselectIndex: index ]
		ifFalse: [ self selecter selectIndex: index ]
]