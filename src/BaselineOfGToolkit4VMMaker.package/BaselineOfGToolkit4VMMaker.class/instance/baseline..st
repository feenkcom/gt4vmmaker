baseline
baseline: spec
	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'GToolkit' with: [ 
				spec repository: 'github://feenkcom/gtoolkit/src' ];
			package: 'GToolkit-VMMaker' with: [ spec 
				requires: #(GToolkit) ]
	]