Class {
	#name : #ToCommandApplier,
	#superclass : #ToBasicCommandApplier,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'eventDispatcher',
		'sharedEventDistributor'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'applied command handling' }
ToCommandApplier >> actionCommand: aCommand for: aTarget [

	aCommand action cull: aTarget
]

{ #category : #accessing }
ToCommandApplier >> addCommand: aCommand [

	self dispatchEvent: (ToCommandAddedEvent new
			 command: aCommand;
			 operator: self;
			 yourself)
]

{ #category : #accessing }
ToCommandApplier >> applyAll [

	self dispatchEvent: ToCommandApplicationRequestEvent new
]

{ #category : #'event management accessing' }
ToCommandApplier >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher 
]

{ #category : #initialization }
ToCommandApplier >> initialize [ 

	super initialize.
	eventDispatcher := BlDirectEventDispatcher on: self
]

{ #category : #'api - hooks' }
ToCommandApplier >> onInstalledIn: anEventTarget [

	sharedEventDistributor ifNotNil: [ Error signal: 'A CommandTarget can be installed only once' ].
	sharedEventDistributor := BlSharedEventDistributor new
		                          shareEvents: self sharedEvents;
		                          yourself.
	self addEventHandler: sharedEventDistributor.
	anEventTarget addEventHandler: sharedEventDistributor
]

{ #category : #'api - hooks' }
ToCommandApplier >> onUninstalledIn: anEventTarget [

	sharedEventDistributor ifNil: [ Error signal: 'Not installed' ].
	self removeEventHandler: sharedEventDistributor.
	anEventTarget removeEventHandler: sharedEventDistributor.
	sharedEventDistributor := nil
]

{ #category : #accessing }
ToCommandApplier >> sharedEvents [ 

	^ { ToCommandAddedEvent }
]