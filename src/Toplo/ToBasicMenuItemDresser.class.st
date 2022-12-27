Class {
	#name : #ToBasicMenuItemDresser,
	#superclass : #ToDresser,
	#instVars : [
		'enterHandler'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToBasicMenuItemDresser >> installEventListenersIn: anElement [

	enterHandler := BlEventHandler
		                          on: BlMouseEnterEvent
		                          do: [ :event | self onEnterEvent: event in: anElement].
	anElement addEventHandler: enterHandler
]

{ #category : #'api - install/uninstall  hook' }
ToBasicMenuItemDresser >> onEnterEvent: anEvent in: anElement [

	| parentWindow |

	" check event and current target "
	(anEvent anyButtonPressed and: [ anEvent currentTarget ~= anElement ]) 
		ifTrue: [ ^ self ].
	" the element is visible in a window "
	anElement parentMenuWindow ifNil: [ ^ self ].
	parentWindow := anElement parentMenuWindow.

	" a submenu is opened "
	parentWindow openedSubmenuWindow ifNil: [ ^ self ].

	" the submenu is not mine "
	parentWindow openedSubmenuWindow == anElement menuWindow 
		ifTrue: [ ^ self ].

	" ok, I can close other item submenu window"
	parentWindow openedSubmenuWindow close.
	parentWindow openedSubmenuWindow: nil
]

{ #category : #'api - install/uninstall  hook' }
ToBasicMenuItemDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement background: Color transparent.
	anElement border: BlBorder empty.
	anElement padding: (BlInsets top: 2; bottom: 2).
	self installEventListenersIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToBasicMenuItemDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	self uninstallEventListenersIn: anElement.
	

]

{ #category : #'api - install/uninstall  hook' }
ToBasicMenuItemDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: enterHandler
]