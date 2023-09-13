Class {
	#name : #ToSpaceRootSkin,
	#superclass : #ToWidgetSkin,
	#category : #'Toplo-Widget-Pane-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToSpaceRootSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement".
	self addLook: (ToLookDep new applyWith: [ :e :v | e background: v asBlBackground ];
			 whenInitialized: anElement toTheme backgroundColor;
			 yourself)"
]