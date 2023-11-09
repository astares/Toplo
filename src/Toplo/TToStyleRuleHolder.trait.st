Trait {
	#name : 'TToStyleRuleHolder',
	#category : 'Toplo-Core-StyleSheet',
	#package : 'Toplo',
	#tag : 'Core-StyleSheet'
}

{ #category : 't - style rule holder - accessing' }
TToStyleRuleHolder >> addAllStyleRules: aStyleRuleCollection [

	self rawStyleRules: (self rawStyleRules copyWithAll: aStyleRuleCollection)
]

{ #category : 't - style rule holder - accessing' }
TToStyleRuleHolder >> addStyleRule: aStyleRule [

	self rawStyleRules: (self rawStyleRules copyWith: aStyleRule)
]

{ #category : 't - style rule holder - accessing' }
TToStyleRuleHolder >> rawStyleRules [

	^ self explicitRequirement 
]

{ #category : 't - style rule holder - accessing' }
TToStyleRuleHolder >> rawStyleRules: aStyleRuleCollection [

	self explicitRequirement
]

{ #category : 't - style rule holder - accessing' }
TToStyleRuleHolder >> styleRules [

	^ self rawStyleRules 
]

{ #category : 't - style rule holder - accessing' }
TToStyleRuleHolder >> styleRules: aStyleRuleCollection [

	self rawStyleRules: aStyleRuleCollection
]