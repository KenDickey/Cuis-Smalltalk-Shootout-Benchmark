Cuis-Smalltalk-Shootout-Benchmark
=================================
Tested in Cuis 4.2  rev 2972

Simple port of CogBenchmarks-Shootout to Cuis.

Requires package SqueakCompatibility

To load the package
````Smalltalk
	Feature require: #'CogBenchmarks-Shootout'.
````

WorldMenu->Open->Transcript
````Smalltalk
	TranscriptWindow openTranscript.
	Transcript clear.
	ShootoutTests runAllToTranscript.
	
````
