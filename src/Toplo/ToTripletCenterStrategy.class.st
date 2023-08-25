Class {
	#name : #ToTripletCenterStrategy,
	#superclass : #ToTripletWithoutInterspaceStrategy,
	#category : #'Toplo-Core-Triplet'
}

{ #category : #'api - install/uninstall  hook' }
ToTripletCenterStrategy >> onInstalledIn: aTriplet [

	super onInstalledIn: aTriplet.
	(aTriplet layout isKindOf: BlFrameLayout) ifTrue: [ ^ self ].
	aTriplet layout: BlFrameLayout new.
]