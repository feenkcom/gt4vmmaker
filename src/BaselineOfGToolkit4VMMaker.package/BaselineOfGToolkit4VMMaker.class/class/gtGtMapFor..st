ui
gtGtMapFor: aView
	<gtView>
	^ (self 
		gtMapFor: aView 
		selectRelationsThat: [ :a :b | 
			a spec project configuration class name beginsWith: 'BaselineOfGToolkit' ]
		nameDisplayedAs: [ :aString | 
			aString asRopedText foreground: ((aString beginsWith: 'GT') 
				ifTrue: [Color black] 
				ifFalse: [Color gray]) ])
			title: 'Gt Map'