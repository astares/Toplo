Class {
	#name : #ToSelectReadOnlyMode,
	#superclass : #ToSelectMode,
	#instVars : [
		'listSelectionChangedEventHandler'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'accessing selection' }
ToSelectReadOnlyMode >> deselectIndex: anIndex [

	select listElement selectionStrategy deselectIndex: anIndex.
]

{ #category : #'api - hooks' }
ToSelectReadOnlyMode >> onInstalledIn: aSelect [

	super onInstalledIn: aSelect.
	
	listSelectionChangedEventHandler := BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | select strategy refreshHeaderNodeContainer ].
	select listElement addEventHandler: listSelectionChangedEventHandler.
	select data: select listElement data.
	select selectionModel: select listElement selectionStrategy selectionModel
]

{ #category : #'api - hooks' }
ToSelectReadOnlyMode >> onUninstalledIn: aSelect [

	select listElement removeEventHandler: listSelectionChangedEventHandler.
	listSelectionChangedEventHandler := nil.
	select selectionModel: nil.
	super onUninstalledIn: aSelect.

]

{ #category : #'accessing selection' }
ToSelectReadOnlyMode >> selectIndex: anIndex [

	select isMultipleSelection ifTrue: [ select listElement selectionStrategy deselectAll ].
	select listElement selectionStrategy selectIndex: anIndex
]