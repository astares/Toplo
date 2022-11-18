Class {
	#name : #ToCheckbox,
	#superclass : #ToButton,
	#instVars : [
		'#threeSteps => ObservableSlot'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #'toggle group' }
ToCheckbox >> addToGroup: aToggleGroup [

	aToggleGroup addButton: self
]

{ #category : #'api - change hook' }
ToCheckbox >> check [

	self changeToToggleStateNamed: #checked
]

{ #category : #initialization }
ToCheckbox >> checkedIconImage [

	^ BlElement new
		  size: 16 @ 16;
		  border: (BlBorder paint: Color gray width: 2);
		  background: Color gray;
		  yourself
]

{ #category : #initialization }
ToCheckbox >> defaultStates [

	^ threeSteps ifTrue: [ self defaultThreeStates  ] ifFalse: [ self defaultTwoStates  ]
]

{ #category : #initialization }
ToCheckbox >> defaultThreeStates [

	^ { 
		  (ToToggleState new
			   name: #indeterminate;
			   buttonStencil: [ :button | 
				   button iconImage: self inderterminateIconImage ];
			   yourself).
		  (ToToggleState new
			   name: #checked;
			   buttonStencil: [ :button | 
				   button iconImage: self checkedIconImage ];
			   yourself).
		  (ToToggleState new
			   name: #unchecked;
			   buttonStencil: [ :button | 
				   button iconImage: self uncheckedIconImage ];
			   yourself) }
]

{ #category : #initialization }
ToCheckbox >> defaultTwoStates [

	^ { 
		  (ToToggleState new
			   name: #unchecked;
			   buttonStencil: [ :button | 
				   button iconImage: self uncheckedIconImage ];
			   yourself).
		  (ToToggleState new
			   name: #checked;
			   buttonStencil: [ :button | 
				   button iconImage: self checkedIconImage ];
			   yourself) }
]

{ #category : #initialization }
ToCheckbox >> inderterminateIconImage [

	| bar im |
	bar := BlElement new
		       size: 10 @ 3;
		       border: (BlBorder paint: Color gray width: 1);
		       background: Color gray.
	bar constraintsDo: [ :c | 
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	im := BlElement new
		      size: 16 @ 16;
		      border: (BlBorder paint: Color gray width: 1);
		      yourself.
	im layout: BlFrameLayout new.
	im addChild: bar.
	^ im
]

{ #category : #'api - change hook' }
ToCheckbox >> indeterminate [

	self changeToToggleStateNamed: #indeterminate
]

{ #category : #initialization }
ToCheckbox >> initialize [ 
	super initialize.
	self whenThreeStepsChangedDo: [ self toggleStates: self defaultStates ].
	threeSteps := false
	
]

{ #category : #testing }
ToCheckbox >> isChecked [

	^ toggleState notNil and: [ toggleState name = #checked ]
]

{ #category : #testing }
ToCheckbox >> isIndeterminate [

	^ toggleState notNil and: [ toggleState name = #indeterminate ]
]

{ #category : #testing }
ToCheckbox >> isUnchecked [

	^ toggleState notNil and: [ toggleState name = #unchecked ]
]

{ #category : #'toggle group' }
ToCheckbox >> removeFromGroup: aToggleGroup [

	aToggleGroup removeButton: self
]

{ #category : #'api - change hook' }
ToCheckbox >> uncheck [

	self changeToToggleStateNamed: #unchecked
]

{ #category : #initialization }
ToCheckbox >> uncheckedIconImage [

	^ (BlElement new
		  size: 16 @ 16;
		  border: (BlBorder paint: Color gray width: 1);
		  background: (Color gray alpha: 0.2);
		  yourself ).
]

{ #category : #'api - change hook' }
ToCheckbox >> whenCheckedDo: aBlock [

	self
		whenChangedDo: [ :s | s name = #checked ifTrue: [ aBlock value ] ]
]

{ #category : #'api - change hook' }
ToCheckbox >> whenIndeterminateDo: aBlock [

	self
		whenChangedDo: [ :s | s name = #indeterminate ifTrue: [ aBlock value ] ]
]

{ #category : #'api - change hook' }
ToCheckbox >> whenThreeStepsChangedDo: aBlock [
	"Inform when the threeSteps boolean has been changed. 
	 `aBlock` receives two optional arguments: 
	 - new  value
	 - old  value"

	self property: #threeSteps whenChangedDo: aBlock
]

{ #category : #'api - change hook' }
ToCheckbox >> whenUncheckedDo: aBlock [

	self
		whenChangedDo: [ :s | s name = #unchecked ifTrue: [ aBlock value ] ]
]

{ #category : #initialization }
ToCheckbox >> withTreeStates [

	threeSteps := true
]

{ #category : #initialization }
ToCheckbox >> withTwoStates [

	threeSteps := false
]