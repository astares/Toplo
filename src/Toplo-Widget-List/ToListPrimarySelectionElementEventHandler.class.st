Class {
	#name : #ToListPrimarySelectionElementEventHandler,
	#superclass : #ToListSelectionElementEventHandler,
	#instVars : [
		'differedUpdateTask'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'selection managing' }
ToListPrimarySelectionElementEventHandler >> addNewSelectionElementsFrom: target [

	| selectionModel nodesArray |
	selectionModel := self selectionModelFrom: target.
	super addNewSelectionElementsFrom: target.
	" Dispatch the event that is used by the skin state generator to generate the selection state "
	nodesArray := target infinite children asArray.
	nodesArray do: [ :node |
		node dispatchEvent: (ToListNodeSelectedEvent new
				 listElement: target;
				 selected: (selectionModel containsIndex: node holder position)) ]
]

{ #category : #'element handlers' }
ToListPrimarySelectionElementEventHandler >> blurEvent: anEvent [

	" Don't update the selection when the element is removed from the scene 
	This is the case if the event reason is for element removal "
	anEvent isDueToRemoval ifTrue: [ ^ self ].
	self updateSelectionFromEvent: anEvent
]

{ #category : #'selection managing' }
ToListPrimarySelectionElementEventHandler >> differUpdateSelectionFrom: anElement [

	differedUpdateTask ifNotNil: [ ^ self ].
	differedUpdateTask := BlTaskAction new action: [
		                       anElement dispatchEvent:
			                       ToListPrimarySelectionDirtyEvent new.
		                       differedUpdateTask := nil ].
	anElement enqueueTask: differedUpdateTask
]

{ #category : #'api - accessing' }
ToListPrimarySelectionElementEventHandler >> eventsToHandle [

	^ super eventsToHandle, {
		  BlFocusEvent.
		  BlBlurEvent.
		  ToListPrimarySelectionDirtyEvent.
		  ToListPrimarySelectionChangedEvent }
]

{ #category : #'element handlers' }
ToListPrimarySelectionElementEventHandler >> focusEvent: anEvent [

	self updateSelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListPrimarySelectionElementEventHandler >> listPrimarySelectionChangedEvent: anEvent [

	self updateSelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListPrimarySelectionElementEventHandler >> listPrimarySelectionDirtyEvent: anEvent [

	self updateSelectionFromEvent: anEvent
]

{ #category : #'selection managing' }
ToListPrimarySelectionElementEventHandler >> newSelectionElementsFrom: target [
	" return a collection with instances of ToListPrimarySelectionElement "

	| adjacentNodeGroups  |

	adjacentNodeGroups := target infinite nodeGroupsSatisfying: [ :n |
		                      n holder isSelected and: [ n height > 0 ] ].
	^ adjacentNodeGroups collect: [ :g |
		  ToListPrimarySelectionElement new
			  listElement: target;
			  nodes: g;
			  yourself ]
]

{ #category : #'selection managing' }
ToListPrimarySelectionElementEventHandler >> previousSelectionElementsFrom: aTarget [
	
	^ aTarget primarySelectionElements
]

{ #category : #'selection managing' }
ToListPrimarySelectionElementEventHandler >> selectionModelFrom: target [

	^ target selectionModel
]
