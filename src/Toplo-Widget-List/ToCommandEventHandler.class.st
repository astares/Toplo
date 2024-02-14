Class {
	#name : #ToCommandEventHandler,
	#superclass : #BlCustomEventHandler,
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'applicationTask',
		'commandQueue'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'event handling' }
ToCommandEventHandler >> addComand: aCommand fromOperator: anOperator forTarget: aTarget [

	| targetedCommand |
	aTarget isAttachedToSceneGraph ifFalse: [
		anOperator applyCommand: aCommand for: aTarget.
		^ self ].
	targetedCommand := ToTargetedCommand new
		                   operator: anOperator;
		                   target: aTarget;
		                   command: aCommand;
		                   yourself.
	commandQueue nextPut: targetedCommand.
	applicationTask ifNotNil: [ ^ self ].
	applicationTask := BlTaskAction new action: [ 
								applicationTask := nil.
								" use of an event to make sure the target is still on the scene graph "
		                   aTarget dispatchEvent: ToCommandApplicationRequestEvent new ].
	aTarget enqueueTask: applicationTask.
	aTarget requestLayout
]

{ #category : #'event handling' }
ToCommandEventHandler >> applyAllCommands [

	| nextInQueue |
	[ (nextInQueue := commandQueue nextOrNil) isNotNil ] whileTrue: [
		nextInQueue apply ]
]

{ #category : #'event handling' }
ToCommandEventHandler >> commandAddedEvent: aCommandAddedEvent [

	self
		addComand: aCommandAddedEvent command
		fromOperator: aCommandAddedEvent operator
		forTarget: aCommandAddedEvent currentTarget
]

{ #category : #'event handling' }
ToCommandEventHandler >> commandApplicationRequestEvent: aCommandApplicationRequestEvent [

	applicationTask ifNotNil: [
		aCommandApplicationRequestEvent currentTarget dequeueTask:
			applicationTask.
		applicationTask := nil ].
	self applyAllCommands
]

{ #category : #'api - accessing' }
ToCommandEventHandler >> eventsToHandle [

	^ { ToCommandAddedEvent. ToCommandApplicationRequestEvent }
]

{ #category : #initialization }
ToCommandEventHandler >> initialize [ 

	super initialize.
	commandQueue := WaitfreeQueue new.
]