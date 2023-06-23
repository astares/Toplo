Class {
	#name : #ToStateEvent,
	#superclass : #ToWidgetEvent,
	#instVars : [
		'widget',
		'state'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToStateEvent >> state [

	^ state
]

{ #category : #accessing }
ToStateEvent >> state: aWidgetState [

	state := aWidgetState
]

{ #category : #accessing }
ToStateEvent >> widget [

	^ widget
]

{ #category : #accessing }
ToStateEvent >> widget: aWidget [

	widget := aWidget
]