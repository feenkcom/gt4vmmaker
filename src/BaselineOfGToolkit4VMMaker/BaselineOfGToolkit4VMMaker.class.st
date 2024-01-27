Class {
	#name : #BaselineOfGToolkit4VMMaker,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkit4VMMaker
}

{ #category : #baseline }
BaselineOfGToolkit4VMMaker >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'GToolkit4VMMaker'
		]
]
