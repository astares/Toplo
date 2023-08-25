Class {
	#name : #ToTripletJustifiedStrategy,
	#superclass : #ToTripletWithInterspaceStrategy,
	#category : #'Toplo-Core-Triplet'
}

{ #category : #accessing }
ToTripletJustifiedStrategy >> canHaveInterspaceAsChildIn: aTriplet [

	^ true
]

{ #category : #initialization }
ToTripletJustifiedStrategy >> initialize [

	super initialize.
	interspace constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ]

]

{ #category : #testing }
ToTripletJustifiedStrategy >> isJustified [

	^ true
]

{ #category : #layout }
ToTripletJustifiedStrategy >> onMeasure: anExtentMeasurementSpec in: aTriplet [

	" nothing to do, interspace is setup in #initialize "

	^ true 
]