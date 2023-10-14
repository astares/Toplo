"
A ToTooltipWindowTest is a test class for testing the behavior of ToTooltipWindow
"
Class {
	#name : 'ToTooltipWindowTest',
	#superclass : 'BlParameterizedHostTest',
	#category : 'Toplo-Tests-Core-Tooltip',
	#package : 'Toplo-Tests',
	#tag : 'Core-Tooltip'
}

{ #category : 'tests' }
ToTooltipWindowTest >> testContent [

	| e space windowHandler |
	space := BlSpace new.
	e := ToElement new  size: 100@100.
	e tooltipContent: (ToLabel text: 'Tooltip content').
	windowHandler := e tooltipWindowHandler.
	self assert: (windowHandler isKindOf: ToTooltipWindowHandler).
	space root addChild: e.
	BlSpace simulateMouseMoveInside: e.
	(windowHandler popupDelay + 100 milliSecond ) wait.
	space pulse.
	self assert: windowHandler currentWindow root firstChild identicalTo: windowHandler element tooltip.
	^  windowHandler currentWindow
]

{ #category : 'tests' }
ToTooltipWindowTest >> testCurrentWindow [

	| window |
	
	window := self testContent.
	self assert: window isOpened.
	self assert: window notNil.
	self assert: window isOpened.

]

{ #category : 'tests' }
ToTooltipWindowTest >> testElevation [

	| window |
	window := self testContent.
	self
		assert: window  elevation elevation
		equals: window  defaultElevation elevation
]

{ #category : 'tests' }
ToTooltipWindowTest >> testInitialize [

	| w |
	w := ToTooltipWindow new.
	self assert: w element isNil.
	self assert: (w eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: w defaultEventHandlerClass ])
]