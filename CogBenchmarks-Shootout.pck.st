'From Cuis 4.2 of 25 July 2013 [latest update: #2972] on 5 November 2016 at 4:35:21 pm'!
'Description CogBenchmarks-Shootout contains some benchmark code intended to be cross-platform.'!
!provides: 'CogBenchmarks-Shootout' 1 2!
!requires: 'SqueakCompatibility' 1 24 nil!
!requires: 'Cuis-Base' 42 2972 nil!
!classDefinition: #ShootoutBody category: #'CogBenchmarks-Shootout'!
Object subclass: #ShootoutBody
	instanceVariableNames: 'x y z vx vy vz mass'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CogBenchmarks-Shootout'!
!classDefinition: 'ShootoutBody class' category: #'CogBenchmarks-Shootout'!
ShootoutBody class
	instanceVariableNames: ''!

!classDefinition: #ShootoutChameneosColour category: #'CogBenchmarks-Shootout'!
Object subclass: #ShootoutChameneosColour
	instanceVariableNames: 'color'
	classVariableNames: 'Blue Red Yellow'
	poolDictionaries: ''
	category: 'CogBenchmarks-Shootout'!
!classDefinition: 'ShootoutChameneosColour class' category: #'CogBenchmarks-Shootout'!
ShootoutChameneosColour class
	instanceVariableNames: ''!

!classDefinition: #ShootoutCreature category: #'CogBenchmarks-Shootout'!
Object subclass: #ShootoutCreature
	instanceVariableNames: 'creatureName colour selfMet creaturesMet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CogBenchmarks-Shootout'!
!classDefinition: 'ShootoutCreature class' category: #'CogBenchmarks-Shootout'!
ShootoutCreature class
	instanceVariableNames: ''!

!classDefinition: #ShootoutMall category: #'CogBenchmarks-Shootout'!
Object subclass: #ShootoutMall
	instanceVariableNames: 'guard maxRendezvous open process queue cache pairCache'
	classVariableNames: 'Units'
	poolDictionaries: ''
	category: 'CogBenchmarks-Shootout'!
!classDefinition: 'ShootoutMall class' category: #'CogBenchmarks-Shootout'!
ShootoutMall class
	instanceVariableNames: ''!

!classDefinition: #ShootoutNBodySystem category: #'CogBenchmarks-Shootout'!
Object subclass: #ShootoutNBodySystem
	instanceVariableNames: 'bodies'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CogBenchmarks-Shootout'!
!classDefinition: 'ShootoutNBodySystem class' category: #'CogBenchmarks-Shootout'!
ShootoutNBodySystem class
	instanceVariableNames: ''!

!classDefinition: #ShootoutPair category: #'CogBenchmarks-Shootout'!
Object subclass: #ShootoutPair
	instanceVariableNames: 'partner me sema'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CogBenchmarks-Shootout'!
!classDefinition: 'ShootoutPair class' category: #'CogBenchmarks-Shootout'!
ShootoutPair class
	instanceVariableNames: ''!

!classDefinition: #ShootoutTests category: #'CogBenchmarks-Shootout'!
Object subclass: #ShootoutTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CogBenchmarks-Shootout'!
!classDefinition: 'ShootoutTests class' category: #'CogBenchmarks-Shootout'!
ShootoutTests class
	instanceVariableNames: ''!

!classDefinition: #ShootoutThread category: #'CogBenchmarks-Shootout'!
Object subclass: #ShootoutThread
	instanceVariableNames: 'name nextThread token semaphore done output'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CogBenchmarks-Shootout'!
!classDefinition: 'ShootoutThread class' category: #'CogBenchmarks-Shootout'!
ShootoutThread class
	instanceVariableNames: ''!

!classDefinition: #ShootoutTreeNode category: #'CogBenchmarks-Shootout'!
Object subclass: #ShootoutTreeNode
	instanceVariableNames: 'left right item'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CogBenchmarks-Shootout'!
!classDefinition: 'ShootoutTreeNode class' category: #'CogBenchmarks-Shootout'!
ShootoutTreeNode class
	instanceVariableNames: ''!


!ShootoutBody methodsFor: 'nbody'!
addMomentumTo: anArray
	anArray at: 1 put: (anArray at: 1) + (vx * mass).
	anArray at: 2 put: (anArray at: 2) + (vy * mass).
	anArray at: 3 put: (anArray at: 3) + (vz * mass).
	^anArray! !

!ShootoutBody methodsFor: 'nbody'!
and: aBody velocityAfter: dt
	| dx dy dz distance mag |
	dx := x - aBody x.
	dy := y - aBody y.
	dz := z - aBody z.

	distance := ((dx*dx) + (dy*dy) + (dz*dz)) sqrt.
	mag := dt / (distance * distance * distance).

	self decreaseVelocity: dx y: dy z: dz m: aBody mass * mag.
	aBody increaseVelocity: dx y: dy z: dz m: mass * mag! !

!ShootoutBody methodsFor: 'nbody'!
decreaseVelocity: dx y: dy z: dz m: m
	vx := vx - (dx * m).
	vy := vy - (dy * m).
	vz := vz - (dz * m)! !

!ShootoutBody methodsFor: 'nbody'!
increaseVelocity: dx y: dy z: dz m: m
	vx := vx + (dx * m).
	vy := vy + (dy * m).
	vz := vz + (dz * m)! !

!ShootoutBody methodsFor: 'nbody' stamp: 'eem 7/28/2008 12:44'!
kineticEnergy
	^0.5 * mass * ((vx * vx) + (vy * vy) + (vz * vz))! !

!ShootoutBody methodsFor: 'accessing'!
mass
	^mass! !

!ShootoutBody methodsFor: 'nbody'!
offsetMomentum: anArray
	| m |
	m := self class solarMass.
	vx := (anArray at: 1) negated / m.
	vy := (anArray at: 2) negated / m.
	vz := (anArray at: 3) negated / m! !

!ShootoutBody methodsFor: 'nbody'!
positionAfter: dt
	x := x + (dt * vx).
	y := y + (dt * vy).
	z := z + (dt * vz)! !

!ShootoutBody methodsFor: 'nbody'!
potentialEnergy: aBody
	| dx dy dz distance |
	dx := x - aBody x.
	dy := y - aBody y.
	dz := z - aBody z.

	distance := ((dx*dx) + (dy*dy) + (dz*dz)) sqrt.
	^mass * aBody mass / distance! !

!ShootoutBody methodsFor: 'accessing'!
x
	^x! !

!ShootoutBody methodsFor: 'accessing'!
x: d1 y: d2 z: d3 vx: d4 vy: d5 vz: d6 mass: d7
	x := d1.
	y := d2.
	z := d3.
	vx := d4.
	vy := d5.
	vz := d6.
	mass := d7! !

!ShootoutBody methodsFor: 'accessing'!
y
	^y! !

!ShootoutBody methodsFor: 'accessing'!
z
	^z! !

!ShootoutBody class methodsFor: 'constants'!
daysPerYear
	^365.24! !

!ShootoutBody class methodsFor: 'constants'!
jupiter
	^self new
		x: 4.84143144246472090
		y: -1.16032004402742839
		z: -1.03622044471123109e-1
		vx: 1.66007664274403694e-3 * self daysPerYear
		vy: 7.69901118419740425e-3 * self daysPerYear
		vz: -6.90460016972063023e-5 * self daysPerYear
		mass: 9.54791938424326609e-4 * self solarMass! !

!ShootoutBody class methodsFor: 'constants'!
neptune
	^self new
		x: 1.53796971148509165e1
		y: -2.59193146099879641e1
		z: 1.79258772950371181e-1
		vx: 2.68067772490389322e-3 * self daysPerYear
		vy: 1.62824170038242295e-3 * self daysPerYear
		vz: -9.51592254519715870e-5 * self daysPerYear
		mass: 5.15138902046611451e-5 * self solarMass! !

!ShootoutBody class methodsFor: 'constants'!
pi
	^3.141592653589793! !

!ShootoutBody class methodsFor: 'constants'!
saturn
	^self new
		x: 8.34336671824457987
		y: 4.12479856412430479
		z: -4.03523417114321381e-1
		vx: -2.76742510726862411e-3 * self daysPerYear
		vy: 4.99852801234917238e-3 * self daysPerYear
		vz: 2.30417297573763929e-5 * self daysPerYear
		mass: 2.85885980666130812e-4 * self solarMass! !

!ShootoutBody class methodsFor: 'constants' stamp: 'eem 7/28/2008 12:42'!
solarMass
	^4.0 * self pi * self pi! !

!ShootoutBody class methodsFor: 'constants'!
sun
	^self new
		x: 0.0
		y: 0.0
		z: 0.0
		vx: 0.0
		vy: 0.0
		vz: 0.0
		mass: self solarMass! !

!ShootoutBody class methodsFor: 'constants'!
uranus
	^self new
		x: 1.28943695621391310e1
		y: -1.51111514016986312e1
		z: -2.23307578892655734e-1
		vx: 2.96460137564761618e-3 * self daysPerYear
		vy: 2.37847173959480950e-3 * self daysPerYear
		vz: -2.96589568540237556e-5 * self daysPerYear
		mass: 4.36624404335156298e-5 * self solarMass! !

!ShootoutChameneosColour methodsFor: 'accessing'!
color
   ^color! !

!ShootoutChameneosColour methodsFor: 'accessing'!
color: aColor
   color := aColor! !

!ShootoutChameneosColour methodsFor: 'as yet unclassified'!
complementaryColourFor: aChameneosColour
   "determine the complementary colour defined as..."

   self == aChameneosColour ifTrue: [^self].
   self isBlue
      ifTrue:
         [aChameneosColour isRed
            ifTrue: [^self class yellow]
            ifFalse: [^self class red]].
   self isRed
      ifTrue:
         [aChameneosColour isBlue
            ifTrue: [^self class yellow]
            ifFalse: [^self class blue]].
   aChameneosColour isBlue
      ifTrue: [^self class red]
      ifFalse: [^self class blue]! !

!ShootoutChameneosColour methodsFor: 'testing'!
hasSameColorAs: aChameneos
   ^self color == aChameneos color! !

!ShootoutChameneosColour methodsFor: 'testing'!
isBlue
   ^self == self class blue! !

!ShootoutChameneosColour methodsFor: 'testing'!
isRed
   ^self == self class red! !

!ShootoutChameneosColour methodsFor: 'testing'!
isYellow
   ^self == self class yellow! !

!ShootoutChameneosColour methodsFor: 'printing'!
printOn: aStream
   aStream nextPutAll: self color! !

!ShootoutChameneosColour class methodsFor: 'accessing'!
blue
   ^Blue! !

!ShootoutChameneosColour class methodsFor: 'accessing'!
blue: anObject
   Blue := anObject! !

!ShootoutChameneosColour class methodsFor: 'initialize-release'!
createBlue
   "comment stating purpose of message"

   ^super new color: #blue! !

!ShootoutChameneosColour class methodsFor: 'initialize-release'!
createRed
   "comment stating purpose of message"

   ^super new color: #red! !

!ShootoutChameneosColour class methodsFor: 'initialize-release'!
createYellow
   "comment stating purpose of message"

   ^super new color: #yellow! !

!ShootoutChameneosColour class methodsFor: 'printing' stamp: 'KenD 11/5/2016 16:13:40'!
generateReportOfColoursOn: readOut
   | colours |
   colours := Array
            with: Blue
            with: Red
            with: Yellow.
   colours do:
         [:aColour |
         colours do:
               [:anotherColour |
               aColour printOn: readOut.
               readOut nextPutAll: ' + '.
               anotherColour printOn: readOut.
               readOut nextPutAll: ' -> '.
               (aColour complementaryColourFor: anotherColour) printOn: readOut.
               readOut newLine]].
   ^readOut! !

!ShootoutChameneosColour class methodsFor: 'initialize-release'!
initialize
   "self initialize"

   Red := self createRed.
   Blue := self createBlue.
   Yellow := self createYellow! !

!ShootoutChameneosColour class methodsFor: 'accessing'!
red
   ^Red! !

!ShootoutChameneosColour class methodsFor: 'accessing'!
red: anObject
   Red := anObject! !

!ShootoutChameneosColour class methodsFor: 'accessing'!
yellow
   ^Yellow! !

!ShootoutChameneosColour class methodsFor: 'accessing'!
yellow: anObject
   Yellow := anObject! !

!ShootoutCreature methodsFor: 'accessing'!
colour
   ^colour! !

!ShootoutCreature methodsFor: 'accessing'!
colour: anObject
   colour := anObject! !

!ShootoutCreature methodsFor: 'accessing'!
creaturesMet
   ^creaturesMet! !

!ShootoutCreature methodsFor: 'accessing'!
creaturesMet: anObject
   creaturesMet := anObject! !

!ShootoutCreature methodsFor: 'initialize-release'!
initialize
   selfMet := 0.
   creaturesMet := 0! !

!ShootoutCreature methodsFor: 'accessing'!
name
   ^creatureName! !

!ShootoutCreature methodsFor: 'accessing'!
name: anObject
   creatureName := anObject! !

!ShootoutCreature methodsFor: 'accessing'!
selfMet
   ^selfMet! !

!ShootoutCreature methodsFor: 'accessing'!
selfMet: anObject
   ^selfMet := anObject! !

!ShootoutCreature methodsFor: 'controlling'!
visitMall: mall

   [| partner |
   partner := mall visitWith: self.
   partner ifNotNil:
         [colour := colour complementaryColourFor: partner colour.
         self == partner ifTrue: [selfMet := selfMet + 1].
         creaturesMet := creaturesMet + 1].
   partner isNil]
         whileFalse! !

!ShootoutCreature class methodsFor: 'initialize-release' stamp: 'eem 8/1/2008 16:15'!
withName: aName colour: aColour
   ^(ShootoutCreature new initialize)
      name: aName;
      colour: aColour! !

!ShootoutMall methodsFor: 'controlling'!
close
   open := false! !

!ShootoutMall methodsFor: 'initialize-release' stamp: 'eem 8/1/2008 16:14'!
initialize
   guard := Semaphore forMutualExclusion.
   queue := SharedQueue new.
   cache := OrderedCollection new.
   1 to: 10 do: [:x | cache add: ShootoutPair new]! !

!ShootoutMall methodsFor: 'accessing'!
maxRendezvous: max
   maxRendezvous := max! !

!ShootoutMall methodsFor: 'private'!
obtainPair
   ^cache removeFirst! !

!ShootoutMall methodsFor: 'private'!
processVisitors
   [open] whileTrue:
         [1 to: maxRendezvous
            do:
               [:x |
               | first second |
               first := queue next.
               second := queue next.
               self setPartnersOn: first and: second.
               first signal.
               second signal].
         [queue isEmpty] whileFalse: [queue next signal]].
   process terminate.
   process := nil! !

!ShootoutMall methodsFor: 'private'!
releasePair: pair
   pair release.
   cache addFirst: pair! !

!ShootoutMall methodsFor: 'initialize-release'!
run
   open := true.
   process ifNil:
         [process := [self processVisitors] newProcess.
         process priority: Processor userBackgroundPriority -1 ].
   process resume! !

!ShootoutMall methodsFor: 'private'!
setPartnersOn: first and: second
   first partner: second me.
   second partner: first me.
! !

!ShootoutMall methodsFor: 'private'!
shutdown
   [queue isEmpty] whileFalse: [queue next signal].
   process terminate.
   process := nil! !

!ShootoutMall methodsFor: 'controlling'!
visitWith: aChameneos
   | pair partner |
   pair := self obtainPair.
   pair me: aChameneos.
   queue nextPut: pair.
   pair wait.
   partner := pair partner.
   self releasePair: pair.
   ^partner! !

!ShootoutMall class methodsFor: 'initialize-release'!
createAllowing: maxRendezvous
   "Private"

   ^self basicNew initialize maxRendezvous: maxRendezvous! !

!ShootoutMall class methodsFor: 'initialize-release' stamp: 'eem 8/1/2008 16:15'!
createCreaturesWith: aCollectionOfColours
   "Private"

   | aName |
   aName := 0.
   ^aCollectionOfColours collect:
         [:aColour |
         aName := aName + 1.
         ShootoutCreature withName: aName colour: aColour]! !

!ShootoutMall class methodsFor: 'printing' stamp: 'KenD 11/5/2016 16:14:11'!
generateReportFor: creatures printOn: stream
   | sum |
   sum := creatures inject: 0 into: [:accum :each | accum + each creaturesMet].
   creatures do:
         [:aCreature |
         aCreature creaturesMet printOn: stream.
         stream
            space;
            nextPutAll: (self units at: aCreature selfMet + 1);
            newLine].
   stream space.
   sum printString
      do: [:el | stream nextPutAll: (self units at: el digitValue + 1)]
      separatedBy: [stream space].
   ^stream! !

!ShootoutMall class methodsFor: 'printing'!
generateReportForColours: colours printOn: stream
   stream space.
   colours do: [:colour | colour printOn: stream] separatedBy: [stream space].
   ^stream! !

!ShootoutMall class methodsFor: 'initialize-release'!
initialize
   "self initialize"

   Units := #('zero' 'one' 'two' 'three' 'four' 'five' 'six' 'seven' 'eight' 'nine')! !

!ShootoutMall class methodsFor: 'initialize-release'!
new
   ^self shouldNotImplement! !

!ShootoutMall class methodsFor: 'private'!
openMall: aMall forCreatures: creatures usingGuard: sema
   | processes |
   processes := creatures
            collect: [:aCreature |
               [aCreature visitMall: aMall.
               sema signal] newProcess].
   processes do:
         [:proc |
         proc priority: Processor userBackgroundPriority.
         proc resume]! !

!ShootoutMall class methodsFor: 'initialize-release'!
openMallWith: aCollectionOfColours forNumberOfMeets: aNumber
   | mall creatures guard |
   mall := self createAllowing: aNumber.
   mall run.
   creatures := self createCreaturesWith: aCollectionOfColours.
   guard := Semaphore new.
   self
      openMall: mall
      forCreatures: creatures
      usingGuard: guard.
   self
      waitForClosingOfMall: mall
      withCreatures: creatures
      usingGuard: guard.
   ^creatures! !

!ShootoutMall class methodsFor: 'public' stamp: 'KenD 11/5/2016 16:15:07'!
runBenchMark: number on: anOutputStream
   "self runBenchMark: 60000 on: Transcript."

   | firstTestColours secondTestColours blue red yellow creatures |
   blue := ShootoutChameneosColour blue.
   red := ShootoutChameneosColour red.
   yellow := ShootoutChameneosColour yellow.
   firstTestColours := Array
            with: blue
            with: red
            with: yellow.
   secondTestColours := (OrderedCollection new)
            add: blue;
            add: red;
            add: yellow;
            add: red;
            add: yellow;
            add: blue;
            add: red;
            add: yellow;
            add: red;
            add: blue;
            yourself.
   (ShootoutChameneosColour generateReportOfColoursOn: anOutputStream) newLine.
   (self generateReportForColours: firstTestColours printOn: anOutputStream)
      newLine.
   creatures := ShootoutMall openMallWith: firstTestColours forNumberOfMeets: number.
   (self generateReportFor: creatures printOn: anOutputStream)
      newLine;
      newLine.
   (self generateReportForColours: secondTestColours printOn: anOutputStream)
      newLine.
   creatures := ShootoutMall openMallWith: secondTestColours forNumberOfMeets: number.
   (self generateReportFor: creatures printOn: anOutputStream)
      newLine;
      newLine! !

!ShootoutMall class methodsFor: 'accessing'!
units
   ^Units! !

!ShootoutMall class methodsFor: 'private'!
waitForClosingOfMall: aMall withCreatures: creatures usingGuard: guard
   creatures size timesRepeat: [guard wait].
   aMall close! !

!ShootoutNBodySystem methodsFor: 'nbody'!
after: dt
	1 to: bodies size do: [:i|
		i+1 to: bodies size do: [:j|
			(bodies at: i) and: (bodies at: j) velocityAfter: dt].
	].
	bodies do: [:each| each positionAfter: dt]! !

!ShootoutNBodySystem methodsFor: 'nbody'!
energy
	| e |
	e := 0.0.
	1 to: bodies size do: [:i|
		e := e + (bodies at: i) kineticEnergy.

		i+1 to: bodies size do: [:j|
			e := e - ((bodies at: i) potentialEnergy: (bodies at: j))].
	].
	^e! !

!ShootoutNBodySystem methodsFor: 'initialize-release' stamp: 'eem 8/1/2008 16:08'!
initialize
	bodies := (OrderedCollection new
		add: ShootoutBody sun; add: ShootoutBody jupiter; add: ShootoutBody saturn;
		add: ShootoutBody uranus; add: ShootoutBody neptune; yourself) asArray.

	bodies first offsetMomentum:
		(bodies inject: (Array with: 0.0 with: 0.0 with: 0.0)
			into: [:m :each | each addMomentumTo: m])! !

!ShootoutPair methodsFor: 'initialize-release'!
initialize
   "Initialize a newly created instance. This method must answer the receiver."

   partner := nil.
   me := nil.
   sema := Semaphore new.
   ^self! !

!ShootoutPair methodsFor: 'accessing'!
me
   ^me! !

!ShootoutPair methodsFor: 'accessing'!
me: anObject
   me := anObject! !

!ShootoutPair methodsFor: 'accessing'!
partner
   ^partner! !

!ShootoutPair methodsFor: 'accessing'!
partner: anObject
   partner := anObject! !

!ShootoutPair methodsFor: 'initialize-release'!
release
partner:=nil.! !

!ShootoutPair methodsFor: 'initialize-release'!
signal
   sema signal! !

!ShootoutPair methodsFor: 'initialize-release'!
wait
   sema wait! !

!ShootoutPair class methodsFor: 'instance creation'!
new
   "Answer a newly created and initialized instance."
   ^super new initialize.! !

!ShootoutPair class methodsFor: 'instance creation'!
with: me
   "Answer a newly created and initialized instance."
self halt.
   ^super new initialize me: me! !

!ShootoutTests class methodsFor: 'platform' stamp: 'eem 11/17/2008 12:37'!
arg
	3 to: 5 do:
		[:i|
		(SmalltalkImage current getSystemAttribute: i) ifNotNil:
			[:aString|
			aString asInteger ifNotNil:
				[:arg| ^arg]]].
	^nil! !

!ShootoutTests class methodsFor: 'benchmark scripts'!
binarytrees
	self binarytrees: self arg to: self stdout.
	^''! !

!ShootoutTests class methodsFor: 'benchmarking' stamp: 'KenD 11/5/2016 16:13:24'!
binarytrees: n to: output
	| minDepth maxDepth stretchDepth check longLivedTree iterations |
	minDepth := 4.
	maxDepth := minDepth + 2 max: n.
	stretchDepth := maxDepth + 1.

	check := (ShootoutTreeNode bottomUpTree: 0 depth: stretchDepth) itemCheck.
	output
		nextPutAll: 'stretch tree of depth '; print: stretchDepth; tab;
		nextPutAll: ' check: '; print: check; newLine.

	longLivedTree := ShootoutTreeNode bottomUpTree: 0 depth: maxDepth.
	minDepth to: maxDepth by: 2 do: [:depth|
		iterations := 1 bitShift: maxDepth - depth + minDepth.

		check := 0.
		1 to: iterations do: [:i|
			check := check + (ShootoutTreeNode bottomUpTree: i depth: depth) itemCheck.
			check := check + (ShootoutTreeNode bottomUpTree: -1*i depth: depth) itemCheck
			].
		output
			print:  (2*iterations); tab;
			nextPutAll: ' trees of depth '; print: depth; tab;
			nextPutAll: ' check: '; print: check; newLine
		].

	output
		nextPutAll: 'long lived tree of depth '; print: maxDepth; tab;
		nextPutAll: ' check: '; print: longLivedTree itemCheck; newLine! !

!ShootoutTests class methodsFor: 'benchmark scripts' stamp: 'eem 8/1/2008 16:26'!
chameneosredux2
	self chameneosredux: self arg to: self stdout.
	^''! !

!ShootoutTests class methodsFor: 'benchmarking' stamp: 'eem 8/1/2008 16:26'!
chameneosredux: arg to: aStream
   ShootoutMall runBenchMark: arg on: aStream! !

!ShootoutTests class methodsFor: 'benchmark scripts' stamp: 'eem 5/4/2010 11:46'!
collectReferenceTimes
	"Run the benchmarks 3 times and take their average, e.g. suitable
	 for filling in values for referenceTimesForClosureInterpreter"

	"ShootoutTests collectReferenceTimes"
	| n refs |
	Transcript clear.
	n := 3.
	refs := (1 to: n) collect: [:i| ShootoutTests runAllToInternalStream].
	^{	refs.
		(1 to: refs first size) collect:
			[:i|
			((refs inject: 0 into: [:sum :ref| (ref at: i) + sum]) / n) rounded] }! !

!ShootoutTests class methodsFor: 'benchmark scripts'!
nbody
	self nbody: self arg to: self stdout! !

!ShootoutTests class methodsFor: 'benchmarking' stamp: 'KenD 11/5/2016 16:12:38'!
nbody: count to: output
	| bodies |
	bodies := ShootoutNBodySystem new initialize.

	output print: bodies energy digits: 9; newLine.
	count timesRepeat: [bodies after: 0.01].
	output print: bodies energy digits: 9; newLine.
	^''! !

!ShootoutTests class methodsFor: 'profiling' stamp: 'KenD 11/5/2016 16:27:09'!
profileAll
	"self profileAll"
	| stream |
	stream := DummyStream on: 'ignored'.
	^[ self nbody: 200000 "20000000" to: stream.
	   self binarytrees: 15 to: stream.
 	   self chameneosredux: 260000 to: stream.
	   self threadring: 10000000 to: stream ] 
		timeToRun ! !

!ShootoutTests class methodsFor: 'benchmark scripts' stamp: 'eem 6/15/2014 19:03'!
referenceArgs
	^self referenceTimesAndArgsForClosureInterpreter collect: [:ea| ea last]! !

!ShootoutTests class methodsFor: 'benchmark scripts' stamp: 'eem 6/15/2014 19:08'!
referenceTimesAndArgsForClosureInterpreter
	 "Interpreter + Closures VM (Mac Cocoa 5.7b3 27-Aug-10 >7BCAB029-A835-4D12-946D-4AB7083D2955< VMMaker versionString 4.4.9)
	  on Eliot's 2012 vintage 2.2GHz Intel (quad) Core i7 MacBook Pro"
	^Dictionary new
		at: #nbody				put: #(40903	2000000);
		at: #binarytrees		put: #(30573	17);
		at: #chameneosredux	put: #(30722	2000000);
		at: #threadring			put: #(9148		30000000);
		yourself! !

!ShootoutTests class methodsFor: 'benchmark scripts' stamp: 'eem 6/15/2014 19:03'!
referenceTimesForClosureInterpreter
	^self referenceTimesAndArgsForClosureInterpreter collect: [:ea| ea first]! !

!ShootoutTests class methodsFor: 'reporting' stamp: 'eem 10/24/2008 16:44'!
report: name time: millisecs reference: reference on: aStream
	aStream
		cr;
		nextPutAll: name; cr;
		nextPutAll: ' took '; print: millisecs / 1000.0; nextPutAll: ' seconds'; cr; flush;
		nextPutAll: 'ratio: '; print: ((millisecs / reference) roundTo: 0.001);
		nextPutAll: '   % change: '; print: ((millisecs - reference * 100 / reference) roundTo: 0.01); nextPut: $%;
		cr; flush! !

!ShootoutTests class methodsFor: 'benchmark scripts' stamp: 'eem 6/24/2010 20:01'!
runAllToDummyStream
	"Transcript clear.
	 self runAllToDummyStream"
	^self runAllToDummyStreamVs: self referenceTimesForClosureInterpreter! !

!ShootoutTests class methodsFor: 'benchmark scripts' stamp: 'eem 7/19/2014 04:40'!
runAllToDummyStreamVs: referenceTimes
	"Transcript clear.
	 self runAllToDummyStreamVs: self referenceTimesForClosureInterpreter"
	"Transcript clear.
	 self runAllToDummyStreamVs: self referenceTimesForSqueakVM"
	^self runAllToDummyStreamVs: referenceTimes reportTo: Transcript! !

!ShootoutTests class methodsFor: 'benchmark scripts' stamp: 'eem 7/19/2014 04:40'!
runAllToDummyStreamVs: referenceTimes reportTo: aStream
	"Transcript clear.
	 self runAllToDummyStreamVs: self referenceTimesForClosureInterpreter"
	"Transcript clear.
	 self runAllToDummyStreamVs: self referenceTimesForSqueakVM"
	| times ratios geometricMean |
	times := Array new writeStream.
	ratios := Array new writeStream.
	(self standardSuiteTo: DummyStream basicNew) do:
		[:block | | benchmark reference t |
		benchmark := (self selectorForSimpleBlock: block) copyUpTo: $:.
		reference := referenceTimes at: benchmark asSymbol.
		Smalltalk garbageCollect.
		times nextPut: (t := Time millisecondsToRun: block).
		ratios nextPut: t asFloat / reference.
		self report: block decompile printString time: t reference: reference on: aStream].
	geometricMean := (ratios contents inject: 1 into: [:m :n| m * n]) raisedTo: 1 / ratios position.
	aStream
		nextPutAll: 'geometric mean '; print: (geometricMean roundTo: 0.001);
		nextPutAll: '   average speedup '; print: ((geometricMean - 1 * 100) roundTo: 0.01); nextPut: $%; cr; cr; flush.
	^times contents! !

!ShootoutTests class methodsFor: 'benchmark scripts' stamp: 'eem 6/24/2010 20:01'!
runAllToInternalStream
	"Transcript clear.
	 self runAllToInternalStream"
	^self runAllToInternalStreamVs: self referenceTimesForClosureInterpreter! !

!ShootoutTests class methodsFor: 'benchmark scripts' stamp: 'eem 6/15/2014 18:23'!
runAllToInternalStreamVs: referenceTimes
	"Transcript clear.
	 self runAllToInternalStreamVs: self referenceTimesForClosureInterpreter"
	"Transcript clear.
	 self runAllToInternalStreamVs: self referenceTimesForSqueakVM"
	| times ratios geometricMean |
	times := Array new writeStream.
	ratios := Array new writeStream.
	(self standardSuiteTo: (ByteString new: 10000) writeStream) do:
		[:block | | benchmark reference t |
		benchmark := (self selectorForSimpleBlock: block) copyUpTo: $:.
		reference := referenceTimes at: benchmark asSymbol.
		Smalltalk garbageCollect.
		times nextPut: (t := Time millisecondsToRun: block).
		ratios nextPut: t asFloat / reference.
		self report: block decompile printString time: t reference: reference on: Transcript].
	geometricMean := (ratios contents inject: 1 into: [:m :n| m * n]) raisedTo: 1 / ratios position.
	Transcript
		nextPutAll: 'geometric mean '; print: (geometricMean roundTo: 0.001);
		nextPutAll: '   average speedup '; print: ((geometricMean - 1 * 100) roundTo: 0.01); nextPut: $%; cr; cr; flush.
	^times contents! !

!ShootoutTests class methodsFor: 'benchmark scripts' stamp: 'KenD 11/5/2016 16:34:15'!
runAllToTranscript
	"TranscriptWindow openTranscript.
	 Transcript clear.
	 self runAllToTranscript"
	^self runAllToTranscriptVs: self referenceTimesForClosureInterpreter! !

!ShootoutTests class methodsFor: 'benchmark scripts' stamp: 'eem 6/15/2014 18:22'!
runAllToTranscriptVs: referenceTimes
	"Transcript clear.
	 self runAllToTranscriptVs: self referenceTimesForClosureInterpreter"
	"Transcript clear.
	 self runAllToTranscriptVs: self referenceTimesForSqueakVM"
	| times ratios geometricMean |
	times := Array new writeStream.
	ratios := Array new writeStream.
	(self standardSuiteTo: Transcript) do:
		[:block | | benchmark reference t |
		benchmark := (self selectorForSimpleBlock: block) copyUpTo: $:.
		reference := referenceTimes at: benchmark asSymbol.
		Smalltalk garbageCollect.
		times nextPut: (t := Time millisecondsToRun: block).
		ratios nextPut: t asFloat / reference.
		self report: block decompile printString time: t reference: reference on: Transcript].
	geometricMean := (ratios contents inject: 1 into: [:m :n| m * n]) raisedTo: 1 / ratios position.
	Transcript
		nextPutAll: 'geometric mean '; print: (geometricMean roundTo: 0.001);
		nextPutAll: '   average speedup '; print: ((geometricMean - 1 * 100) roundTo: 0.01); nextPut: $%; cr; cr; flush.
	^times contents! !

!ShootoutTests class methodsFor: 'benchmark scripts' stamp: 'eem 10/30/2008 10:43'!
selectorForSimpleBlock: aBlock
	| is |
	is := InstructionStream on: aBlock method.
	is pc: aBlock startpc.
	is scanFor:
		[:x| | selectorOrScanner |
		(selectorOrScanner := is selectorToSendOrSelf) ~~ is ifTrue:
			[^selectorOrScanner].
		false].
	^nil! !

!ShootoutTests class methodsFor: 'benchmark scripts' stamp: 'eem 6/15/2014 19:07'!
standardSuiteTo: aStream
	"revised up from
		{ [self nbody: 200000 to: stream].
		   [self binarytrees: 15 to: stream].
		   [self chameneosredux: 260000 to: stream].
		   [self threadring: 10000000 to: stream] }
	 on 6/15/2014"
	| reference nbodyCount binaryTreeDepth chameneosCount threadringCount |
	reference := self referenceTimesAndArgsForClosureInterpreter.
	nbodyCount := (reference at: #nbody) last.
	binaryTreeDepth := (reference at: #binarytrees) last.
	chameneosCount := (reference at: #chameneosredux) last.
	threadringCount := (reference at: #threadring) last.
	^{ [self nbody: nbodyCount to: aStream].
	     [self binarytrees: binaryTreeDepth to: aStream].
	     [self chameneosredux: chameneosCount to: aStream].
	     [self threadring: threadringCount to: aStream] }! !

!ShootoutTests class methodsFor: 'platform' stamp: 'eem 12/22/2010 14:59'!
stdin
   ^StandardFileStream stdIn! !

!ShootoutTests class methodsFor: 'platform' stamp: 'eem 7/19/2014 04:42'!
stdout
   ^StandardFileStream stdout! !

!ShootoutTests class methodsFor: 'benchmarking' stamp: 'eem 6/9/2009 12:25'!
threadRing: aSemaphore output: output
   | first last |
   503 to: 1 by: -1 do: [:i|
      first := ShootoutThread named: i next: first done: aSemaphore output: output.
      last isNil ifTrue: [ last := first ].
   ].
   last nextThread: first.
   ^first ! !

!ShootoutTests class methodsFor: 'benchmark scripts' stamp: 'eem 6/9/2009 12:30'!
threadring
  self threadring: self arg to: self stdout.
   ^''! !

!ShootoutTests class methodsFor: 'benchmarking' stamp: 'eem 6/9/2009 12:29'!
threadring: arg to: output
   | done |
   (self threadRing: (done := Semaphore new) output: output) takeToken: arg.
   done wait! !

!ShootoutThread methodsFor: 'accessing'!
done: aSemaphore
   done := aSemaphore ! !

!ShootoutThread methodsFor: 'accessing'!
fork
   [ self run ] fork ! !

!ShootoutThread methodsFor: 'accessing'!
name: anInteger
   name := anInteger ! !

!ShootoutThread methodsFor: 'accessing'!
nextThread: aThread
   nextThread := aThread ! !

!ShootoutThread methodsFor: 'accessing' stamp: 'eem 6/9/2009 12:26'!
output: anObject
	"Set the value of output"

	output := anObject! !

!ShootoutThread methodsFor: 'accessing' stamp: 'KenD 11/5/2016 16:14:39'!
run
   [ self tokenNotDone ] whileTrue: [ nextThread takeToken: token - 1 ].
   output print: name.
   output name = 'stdout'
	ifTrue: [output newLine]
	ifFalse: [output cr; flush].
   done signal ! !

!ShootoutThread methodsFor: 'accessing'!
semaphore: aSemaphore
   semaphore := aSemaphore ! !

!ShootoutThread methodsFor: 'accessing'!
takeToken: x
   token := x.
   semaphore signal ! !

!ShootoutThread methodsFor: 'accessing'!
tokenNotDone
   semaphore wait.
   ^token > 0 ! !

!ShootoutThread class methodsFor: 'instance creation' stamp: 'eem 6/9/2009 12:28'!
named: anInteger next: aThread done: aSemaphore output: aStream
   ^self new name: anInteger; nextThread: aThread; done: aSemaphore; output: aStream; fork ! !

!ShootoutThread class methodsFor: 'instance creation'!
new
   ^self basicNew semaphore: Semaphore new ! !

!ShootoutTreeNode methodsFor: 'accessing'!
itemCheck
	^left isNil
		ifTrue: [item] ifFalse: [item + (left itemCheck - right itemCheck)]! !

!ShootoutTreeNode methodsFor: 'initialize-release'!
left: leftChild right: rightChild item: anItem
	left := leftChild.
	right := rightChild.
	item := anItem! !

!ShootoutTreeNode class methodsFor: 'instance creation'!
bottomUpTree: anItem depth: anInteger
	^(anInteger > 0)
		ifTrue: [
			self
				left: (self bottomUpTree: 2*anItem - 1 depth: anInteger - 1)
				right: (self bottomUpTree: 2*anItem depth: anInteger - 1) 
				item: anItem
			]
		ifFalse: [self left: nil right: nil item: anItem]! !

!ShootoutTreeNode class methodsFor: 'instance creation'!
left: leftChild right: rightChild item: anItem
	^(super new) left: leftChild right: rightChild item: anItem! !
ShootoutChameneosColour initialize!
ShootoutMall initialize!
