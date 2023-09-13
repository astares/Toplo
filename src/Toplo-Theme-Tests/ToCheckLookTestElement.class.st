Class {
	#name : #ToCheckLookTestElement,
	#superclass : #BlElement,
	#traits : 'TToCheckable + TToLabeledIcon + TToTriplet + TToDressable',
	#classTraits : 'TToCheckable classTrait + TToLabeledIcon classTrait + TToTriplet classTrait + TToDressable classTrait',
	#instVars : [
		'first',
		'second',
		'third'
	],
	#category : #'Toplo-Theme-Tests-LookUpdater'
}

{ #category : #'t - triplet - accessing' }
ToCheckLookTestElement >> first [

	^ first
]

{ #category : #'t - triplet - accessing' }
ToCheckLookTestElement >> first: anElement [

	first := anElement
]

{ #category : #'t - triplet - accessing' }
ToCheckLookTestElement >> second [

	^ second
]

{ #category : #'t - triplet - accessing' }
ToCheckLookTestElement >> second: anElement [

	second := anElement
]

{ #category : #'t - triplet - accessing' }
ToCheckLookTestElement >> third [

	^ third 
]

{ #category : #'t - triplet - accessing' }
ToCheckLookTestElement >> third: anElement [

	third := anElement
]