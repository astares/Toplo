Class {
	#name : #ToPicsumPhotosGalleryImageElement,
	#superclass : #ToElement,
	#instVars : [
		'loader',
		'imageData',
		'label'
	],
	#category : #'Toplo-Examples'
}

{ #category : #layout }
ToPicsumPhotosGalleryImageElement >> applyLayoutIn: aBounds context: aBlElementBoundsUpdateContext [
	super applyLayoutIn: aBounds context: aBlElementBoundsUpdateContext
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageElement >> attached [

	imageData form ifNil: [ ^ self loadImage ].
	self setBackgroundFromData
]

{ #category : #'t - initialization dresser' }
ToPicsumPhotosGalleryImageElement >> defaultDresser [ 

	^ ToNodeDresser new
]

{ #category : #initialization }
ToPicsumPhotosGalleryImageElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #initialization }
ToPicsumPhotosGalleryImageElement >> defaultWidth [
	^ 500
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageElement >> detached [

	loader ifNotNil: #terminate.
	loader := nil
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageElement >> form: aForm [
	
	imageData form == aForm
		ifTrue: [ ^ self ].
	imageData form: aForm.
	self setBackgroundFromData
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageElement >> imageData: anImageData [

	imageData = anImageData
		ifTrue: [ ^ self ].
	imageData := anImageData.
	label text: ((anImageData id asString) asRopedText
		foreground: Color white;
		fontSize: 14)
]

{ #category : #initialization }
ToPicsumPhotosGalleryImageElement >> initialize [
	super initialize.
	label := ToLabel new hFitContent; yourself.
	label background: Color black.
	self addChild: label.
	self whenLayoutedDo: [ self loadImage ]
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageElement >> loadImage [

	loader ifNotNil: #terminate.	
	(imageData form isNotNil and: [ imageData form extent = self extent asIntegerPoint ])
		ifTrue: [ ^ self ].

	loader := [
		| aNewForm timesRetry aByteArray |
		timesRetry := 0.
		" wait a bit because the list may be scrolled and then the loader terminated without network access"
		50 milliSeconds wait.
		loader ifNotNil: [ 
			[ (aByteArray := ([(imageData loadUrl: self extent asIntegerPoint) asUrl retrieveContents] on: Error do: [] )) isNil and: [ loader notNil and: [ timesRetry < 5 ] ] ] 
				whileTrue: [ timesRetry := timesRetry + 1 ].
			aByteArray ifNotNil: [
				loader ifNotNil: [ 
					aNewForm := Form fromBinaryStream: aByteArray readStream.
					self enqueueTask: (BlTaskAction new action: [ self form: aNewForm ]) ] ] ] ] fork
]

{ #category : #layout }
ToPicsumPhotosGalleryImageElement >> onMeasure: anExtentMeasurementSpec [

	" ensure a 16/9 size "

	| aWidth aHeight aWidthSpec aHeightSpec |
	super onMeasure: anExtentMeasurementSpec.
	
	aWidthSpec := anExtentMeasurementSpec widthSpec.
	aHeightSpec := anExtentMeasurementSpec heightSpec.
	
	aWidth := aWidthSpec isUnspecified
		ifTrue: [ self defaultWidth ]
		ifFalse: [ aWidthSpec size ].
		"Unspecified means that layout may take as much space horizontally as it wishes"
	aHeight := aHeightSpec isUnspecified
		ifTrue: [ (aWidth / 16 * 9) ]
		ifFalse: [ aHeightSpec size ].

	self measuredExtent: aWidth @ aHeight
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageElement >> setBackgroundFromData [
	
	self background: (BlBackground image: imageData form).
	self requestLayout.
	self invalidate
]