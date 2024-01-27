Class {
	#name : #BaselineOfGToolkit4VMMaker,
	#superclass : #BaselineOf,
	#classVars : [
		'Preloaded'
	],
	#category : #BaselineOfGToolkit4VMMaker
}

{ #category : #baseline }
BaselineOfGToolkit4VMMaker >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec preLoadDoIt: #preLoadVMMaker:.
			spec package: 'GToolkit4VMMaker' ]
]

{ #category : #accessing }
BaselineOfGToolkit4VMMaker >> loadPackage: aPackage fromRepo: repo [
	| reader |
	reader := TonelReader on: repo / 'pharo-vm' / 'smalltalksrc' fileName: aPackage.
	reader loadPackage.
	reader loadDefinitions.
	^ reader snapshot install
]

{ #category : #accessing }
BaselineOfGToolkit4VMMaker >> preLoadVMMaker: spec [
	"Manually installs VMMaker from the sources in gtoolkit-vm/pharo-vm"
	| repo |
	(Preloaded isNotNil and: [ Preloaded ]) ifTrue: [ ^ self ].

	repo := (FileLocator localDirectory / 'iceberg' / 'feenkcom' / 'gtoolkit-vm')
			resolve.
	repo exists
		ifFalse: [ (GtExternalProcessBuilder new: 'git')
				workingDirectory: repo parent;
				arguments: {'clone'.
						'git@github.com:feenkcom/gtoolkit-vm.git'.
						'--recursive'.
						'--shallow-submodules'.
						'--depth'.
						'1'};
				status ].

	{'CAST'.
		'Slang'.
		'Slang-Tests'.
		'Printf'.
		'Melchor'.
		'VMMakerLoadingDependencies'}
		do: [ :eachPackage | self loadPackage: eachPackage fromRepo: repo ].

	[ self loadPackage: 'VMMaker' fromRepo: repo ]
		on: Warning
		do: [ :e | e resume ].

	Preloaded := true
]
