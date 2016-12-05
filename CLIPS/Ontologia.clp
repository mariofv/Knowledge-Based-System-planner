

(defclass %3ACLIPS_TOP_LEVEL_SLOT_CLASS "Fake class to save top-level slot information"
	(is-a USER)
	(role abstract)
	(single-slot Created+by
;+		(comment "The author of the painting.")
		(type INSTANCE)
;+		(allowed-classes Author)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Year+of+creation
;+		(comment "The year in wich the painting was created.")
		(type INTEGER)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Days
;+		(comment "The number of days in which the visitor visits the museum.")
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Asigned+time
;+		(comment "The time asigned to a day.")
		(type INTEGER)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Room+name
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(multislot Asigned+paintings
		(type INSTANCE)
;+		(allowed-classes Painting)
		(create-accessor read-write))
	(single-slot Painted+in
;+		(comment "The period in which a painting was painted.")
		(type INSTANCE)
;+		(allowed-classes Period)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Painting+name
;+		(comment "The name of a painting.")
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(multislot Preferences
;+		(comment "The preferences of a visitor")
		(type INSTANCE)
;+		(allowed-classes Author Period Style Topic)
		(create-accessor read-write))
	(single-slot Height
;+		(comment "The height of a painting.")
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Style+name
;+		(comment "The name of an style.")
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Painting+style
;+		(comment "The pictorial period in which the painting was painted.")
		(type INSTANCE)
;+		(allowed-classes Style)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Complexity
;+		(comment "The complexity of a painting.")
		(type INTEGER)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Number+of+people
;+		(comment "The number of people that composes a group.")
		(type INTEGER)
		(range 1 100)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(multislot Authors+style
;+		(comment "The styles of an author.")
		(type INSTANCE)
;+		(allowed-classes Style)
		(cardinality 1 ?VARIABLE)
		(create-accessor read-write))
	(single-slot Period+name
;+		(comment "The name of the historical period.")
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Visitor+name
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Observation+time
		(type INTEGER)
		(default -1)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Exhibited+in
;+		(comment "The room in which a painting was exhibited.")
		(type INSTANCE)
;+		(allowed-classes Room)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Duration
;+		(comment "The duration in hours of the visits of a visitor.")
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Children
;+		(comment "Whether the visiting group has children or no.")
		(type SYMBOL)
		(allowed-values FALSE TRUE)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Topic+name
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Painting+topic
;+		(comment "The topic of a painting.")
		(type INSTANCE)
;+		(allowed-classes Topic)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Number
;+		(comment "The number of a day.")
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Visitor+interest
		(type INTEGER)
		(default -1)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Relevance
;+		(comment "The relevance of a painting.")
		(type INTEGER)
		(range 0 100)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Width
;+		(comment "The width of a painting.")
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Nationality
;+		(comment "The nationality of an author.")
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Knowledge
;+		(comment "The knowledge of a visitor")
		(type INTEGER)
		(range 0 100)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Author+name
;+		(comment "The name of an author.")
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write)))

(defclass Painting "A painting that is exposed in a museum."
	(is-a USER)
	(role concrete)
	(single-slot Created+by
;+		(comment "The author of the painting.")
		(type INSTANCE)
;+		(allowed-classes Author)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Year+of+creation
;+		(comment "The year in wich the painting was created.")
		(type INTEGER)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Complexity
;+		(comment "The complexity of a painting.")
		(type INTEGER)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Painted+in
;+		(comment "The period in which a painting was painted.")
		(type INSTANCE)
;+		(allowed-classes Period)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Relevance
;+		(comment "The relevance of a painting.")
		(type INTEGER)
		(range 0 100)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Width
;+		(comment "The width of a painting.")
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Painting+name
;+		(comment "The name of a painting.")
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Painting+topic
;+		(comment "The topic of a painting.")
		(type INSTANCE)
;+		(allowed-classes Topic)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Observation+time
		(type INTEGER)
		(default -1)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Visitor+interest
		(type INTEGER)
		(default -1)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Exhibited+in
;+		(comment "The room in which a painting was exhibited.")
		(type INSTANCE)
;+		(allowed-classes Room)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Height
;+		(comment "The height of a painting.")
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Painting+style
;+		(comment "The pictorial period in which the painting was painted.")
		(type INSTANCE)
;+		(allowed-classes Style)
;+		(cardinality 1 1)
		(create-accessor read-write)))

(defclass Author "Person that creates art."
	(is-a USER)
	(role concrete)
	(single-slot Nationality
;+		(comment "The nationality of an author.")
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Author+name
;+		(comment "The name of an author.")
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(multislot Authors+style
;+		(comment "The styles of an author.")
		(type INSTANCE)
;+		(allowed-classes Style)
		(cardinality 1 ?VARIABLE)
		(create-accessor read-write)))

(defclass Period "A period in history."
	(is-a USER)
	(role concrete)
	(single-slot Period+name
;+		(comment "The name of the historical period.")
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write)))

(defclass Style "Style / School / Pictorial Period"
	(is-a USER)
	(role concrete)
	(single-slot Style+name
;+		(comment "The name of an style.")
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write)))

(defclass Room "A room of the museum."
	(is-a USER)
	(role concrete)
	(single-slot Number
;+		(comment "The number of a day.")
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(multislot Asigned+paintings
		(type INSTANCE)
;+		(allowed-classes Painting)
		(create-accessor read-write))
	(single-slot Room+name
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write)))

(defclass Visitor "A visitor of a museum."
	(is-a USER)
	(role concrete)
	(multislot Preferences
;+		(comment "The preferences of a visitor")
		(type INSTANCE)
;+		(allowed-classes Author Period Style Topic)
		(create-accessor read-write))
	(single-slot Days
;+		(comment "The number of days in which the visitor visits the museum.")
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Knowledge
;+		(comment "The knowledge of a visitor")
		(type INTEGER)
		(range 0 100)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Number+of+people
;+		(comment "The number of people that composes a group.")
		(type INTEGER)
		(range 1 100)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Duration
;+		(comment "The duration in hours of the visits of a visitor.")
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Visitor+name
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Children
;+		(comment "Whether the visiting group has children or no.")
		(type SYMBOL)
		(allowed-values FALSE TRUE)
;+		(cardinality 1 1)
		(create-accessor read-write)))

(defclass Topic "A topic."
	(is-a USER)
	(role concrete)
	(single-slot Topic+name
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write)))

(defclass Day "A day of the visit."
	(is-a USER)
	(role concrete)
	(single-slot Number
;+		(comment "The number of a day.")
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Asigned+time
;+		(comment "The time asigned to a day.")
		(type INTEGER)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(multislot Asigned+paintings
		(type INSTANCE)
;+		(allowed-classes Painting)
		(create-accessor read-write)))

(definstances Instances

([Ontologia_Class0] of  Painting

	(Created+by [Ontologia_Class1])
	(Exhibited+in [Ontologia_Class40004])
	(Height 77)
	(Observation+time 20)
	(Painted+in [Ontologia_Class10000])
	(Painting+name "La Gioconda")
	(Painting+style [Ontologia_Class3])
	(Painting+topic [Ontologia_Class10008])
	(Relevance 100)
	(Visitor+interest -1)
	(Width 53)
	(Year+of+creation 1519))

([Ontologia_Class1] of  Author

	(Author+name "Leonardo da Vinci")
	(Authors+style [Ontologia_Class3])
	(Nationality "Italiano"))

([Ontologia_Class10000] of  Period

	(Period+name "Edad Media"))

([Ontologia_Class10002] of  Room

	(Number 1)
	(Room+name "Room 1"))

([Ontologia_Class10008] of  Topic

	(Topic+name "Retrato"))

([Ontologia_Class20000] of  Painting

	(Created+by [Ontologia_Class20001])
	(Exhibited+in [Ontologia_Class40003])
	(Height 95)
	(Observation+time 8)
	(Painted+in [Ontologia_Class20004])
	(Painting+name "El caminante sobre el mar de nubes")
	(Painting+style [Ontologia_Class20003])
	(Painting+topic [Ontologia_Class20002])
	(Relevance 75)
	(Visitor+interest -1)
	(Width 75)
	(Year+of+creation 1818))

([Ontologia_Class20001] of  Author

	(Author+name "Caspar David Friedrich")
	(Authors+style [Ontologia_Class20003])
	(Nationality "Alemana"))

([Ontologia_Class20002] of  Topic

	(Topic+name "Paisaje"))

([Ontologia_Class20003] of  Style

	(Style+name "Romanticismo"))

([Ontologia_Class20004] of  Period

	(Period+name "Edad Moderna"))

([Ontologia_Class3] of  Style

	(Style+name "Renacimiento"))

([Ontologia_Class30000] of  Room

	(Number 2)
	(Room+name "Room 2"))

([Ontologia_Class30002] of  Period

	(Period+name "Edad Contemporanea"))

([Ontologia_Class30003] of  Style

	(Style+name "PostImpresionismo"))

([Ontologia_Class30004] of  Style

	(Style+name "Expresionismo"))

([Ontologia_Class30005] of  Style

	(Style+name "Simbolismo"))

([Ontologia_Class30006] of  Style

	(Style+name "Surrealismo"))

([Ontologia_Class30007] of  Style

	(Style+name "Neoclasicismo"))

([Ontologia_Class30008] of  Topic

	(Topic+name "Amor"))

([Ontologia_Class30009] of  Topic

	(Topic+name "Religion"))

([Ontologia_Class30010] of  Topic

	(Topic+name "Muerte"))

([Ontologia_Class30011] of  Topic

	(Topic+name "Juramento"))

([Ontologia_Class30012] of  Author

	(Author+name "Vincent van Gogh")
	(Authors+style
		[Ontologia_Class30003]
		[Ontologia_Class30004])
	(Nationality "Neerlandés"))

([Ontologia_Class30013] of  Painting

	(Created+by [Ontologia_Class30012])
	(Exhibited+in [Ontologia_Class40003])
	(Height 92)
	(Observation+time 66)
	(Painted+in [Ontologia_Class30002])
	(Painting+name "La noche estrellada")
	(Painting+style [Ontologia_Class30003])
	(Painting+topic [Ontologia_Class20002])
	(Relevance 100)
	(Visitor+interest -1)
	(Width 74)
	(Year+of+creation 1889))

([Ontologia_Class30014] of  Painting

	(Created+by [Ontologia_Class30015])
	(Exhibited+in [Ontologia_Class10002])
	(Height 91)
	(Observation+time 9)
	(Painted+in [Ontologia_Class30002])
	(Painting+name "El Grito")
	(Painting+style [Ontologia_Class30004])
	(Painting+topic [Ontologia_Class10008])
	(Relevance 100)
	(Visitor+interest -1)
	(Width 74)
	(Year+of+creation 1893))

([Ontologia_Class30015] of  Author

	(Author+name "Edvard Munch")
	(Authors+style [Ontologia_Class30004])
	(Nationality "Noruego"))

([Ontologia_Class30017] of  Author

	(Author+name "Gustav Klimt")
	(Authors+style [Ontologia_Class30005])
	(Nationality "Austohungaro"))

([Ontologia_Class30018] of  Painting

	(Created+by [Ontologia_Class30017])
	(Exhibited+in [Ontologia_Class10002])
	(Height 180)
	(Observation+time 42)
	(Painted+in [Ontologia_Class30002])
	(Painting+name "El beso")
	(Painting+style [Ontologia_Class30005])
	(Painting+topic [Ontologia_Class30008])
	(Relevance 70)
	(Visitor+interest -1)
	(Width 180)
	(Year+of+creation 1907))

([Ontologia_Class30019] of  Author

	(Author+name "Salvador Dali")
	(Authors+style [Ontologia_Class30006])
	(Nationality "Española"))

([Ontologia_Class30020] of  Painting

	(Created+by [Ontologia_Class30019])
	(Exhibited+in [Ontologia_Class30000])
	(Height 33)
	(Observation+time 69)
	(Painted+in [Ontologia_Class30002])
	(Painting+name "La Persistencia de la Memoria")
	(Painting+style [Ontologia_Class30006])
	(Painting+topic [Ontologia_Class20002])
	(Relevance 90)
	(Visitor+interest -1)
	(Width 24)
	(Year+of+creation 1931))

([Ontologia_Class30021] of  Author

	(Author+name "Sandro Botticelli")
	(Authors+style [Ontologia_Class3])
	(Nationality "Itailiana"))

([Ontologia_Class30022] of  Painting

	(Created+by [Ontologia_Class30021])
	(Exhibited+in [Ontologia_Class40003])
	(Height 173)
	(Observation+time 90)
	(Painted+in [Ontologia_Class20004])
	(Painting+name "El nacimiento de Venus")
	(Painting+style [Ontologia_Class3])
	(Painting+topic [Ontologia_Class30009])
	(Relevance 85)
	(Visitor+interest -1)
	(Width 279)
	(Year+of+creation 1484))

([Ontologia_Class30023] of  Author

	(Author+name "Antonello da Messina")
	(Authors+style [Ontologia_Class3])
	(Nationality "Italiana"))

([Ontologia_Class30024] of  Painting

	(Created+by [Ontologia_Class30023])
	(Exhibited+in [Ontologia_Class10002])
	(Height 74)
	(Observation+time 5)
	(Painted+in [Ontologia_Class20004])
	(Painting+name "Cristo muerto sostenido por un angel")
	(Painting+style [Ontologia_Class3])
	(Painting+topic [Ontologia_Class30009])
	(Relevance 20)
	(Visitor+interest -1)
	(Width 51)
	(Year+of+creation 1475))

([Ontologia_Class30025] of  Author

	(Author+name "Theodore Gericault")
	(Authors+style [Ontologia_Class20003])
	(Nationality "Francesa"))

([Ontologia_Class30026] of  Painting

	(Created+by [Ontologia_Class30025])
	(Exhibited+in [Ontologia_Class10002])
	(Height 491)
	(Observation+time 50)
	(Painted+in [Ontologia_Class30002])
	(Painting+name "La Balsa de la Medusa")
	(Painting+style [Ontologia_Class20003])
	(Painting+topic [Ontologia_Class30010])
	(Relevance 75)
	(Visitor+interest -1)
	(Width 717)
	(Year+of+creation 1819))

([Ontologia_Class30027] of  Author

	(Author+name "Jacques-Louis David")
	(Authors+style [Ontologia_Class30007])
	(Nationality "Francesa"))

([Ontologia_Class30028] of  Painting

	(Created+by [Ontologia_Class30027])
	(Exhibited+in [Ontologia_Class10002])
	(Height 330)
	(Observation+time 24)
	(Painted+in [Ontologia_Class20004])
	(Painting+name "El Juramento de los Horacios")
	(Painting+style [Ontologia_Class30007])
	(Painting+topic [Ontologia_Class30011])
	(Relevance 45)
	(Visitor+interest -1)
	(Width 425)
	(Year+of+creation 1784))

([Ontologia_Class40000] of  Painting

	(Created+by [Ontologia_Class30012])
	(Exhibited+in [Ontologia_Class30000])
	(Height 71)
	(Observation+time -1)
	(Painted+in [Ontologia_Class30002])
	(Painting+name "Lirios de agua")
	(Painting+style [Ontologia_Class30003])
	(Painting+topic [Ontologia_Class40002])
	(Relevance 80)
	(Visitor+interest -1)
	(Width 93)
	(Year+of+creation 1889))

([Ontologia_Class40002] of  Topic

	(Topic+name "Flores"))

([Ontologia_Class40003] of  Room

	(Number 3)
	(Room+name "Room 3"))

([Ontologia_Class40004] of  Room

	(Number 4)
	(Room+name "Room 4"))

([Ontologia_Class40005] of  Painting

	(Created+by [Ontologia_Class40006])
	(Exhibited+in [Ontologia_Class40003])
	(Height 121)
	(Observation+time -1)
	(Painted+in [Ontologia_Class30002])
	(Painting+name "El portador de flores")
	(Painting+style [Ontologia_Class40007])
	(Painting+topic [Ontologia_Class40002])
	(Relevance 40)
	(Visitor+interest -1)
	(Width 121)
	(Year+of+creation 1935))

([Ontologia_Class40006] of  Author

	(Author+name "Diego Rivera")
	(Authors+style [Ontologia_Class40007])
	(Nationality "Mejicano"))

([Ontologia_Class40007] of  Style

	(Style+name "Realismo"))

([Ontologia_Class40008] of  Painting

	(Created+by [Ontologia_Class40009])
	(Exhibited+in [Ontologia_Class40004])
	(Height 74)
	(Observation+time -1)
	(Painted+in [Ontologia_Class30002])
	(Painting+name "Gotico estadounidense")
	(Painting+style [Ontologia_Class40010])
	(Painting+topic [Ontologia_Class10008])
	(Relevance 52)
	(Visitor+interest -1)
	(Width 62)
	(Year+of+creation 1930))

([Ontologia_Class40009] of  Author

	(Author+name "Grant Wood")
	(Authors+style [Ontologia_Class40010])
	(Nationality "Estadounidense"))

([Ontologia_Class40010] of  Style

	(Style+name "Regionalismo"))

([Ontologia_Class40011] of  Painting

	(Created+by [Ontologia_Class30012])
	(Exhibited+in [Ontologia_Class40004])
	(Height 81)
	(Observation+time -1)
	(Painted+in [Ontologia_Class30002])
	(Painting+name "Terraza de cafe por la noche")
	(Painting+style [Ontologia_Class30003])
	(Painting+topic [Ontologia_Class20002])
	(Relevance 90)
	(Visitor+interest -1)
	(Width 65)
	(Year+of+creation 1888))

([Ontologia_Class40012] of  Painting

	(Created+by [Ontologia_Class40013])
	(Exhibited+in [Ontologia_Class30000])
	(Height 116)
	(Observation+time -1)
	(Painted+in [Ontologia_Class30002])
	(Painting+name "El hijo del hombre")
	(Painting+style [Ontologia_Class30006])
	(Painting+topic [Ontologia_Class10008])
	(Relevance 60)
	(Visitor+interest -1)
	(Width 89)
	(Year+of+creation 1964))

([Ontologia_Class40013] of  Author

	(Author+name "Rene Magritte")
	(Authors+style [Ontologia_Class30006])
	(Nationality "Belga"))

([Ontologia_Class40014] of  Painting

	(Created+by [Ontologia_Class40015])
	(Exhibited+in [Ontologia_Class40003])
	(Height 240)
	(Observation+time -1)
	(Painted+in [Ontologia_Class30002])
	(Painting+name "No. 5, 1948")
	(Painting+style [Ontologia_Class30004])
	(Painting+topic [Ontologia_Class40017])
	(Relevance 50)
	(Visitor+interest -1)
	(Width 120)
	(Year+of+creation 1948))

([Ontologia_Class40015] of  Author

	(Author+name "Jackson Pollock")
	(Authors+style [Ontologia_Class30004])
	(Nationality "Estadounidense"))

([Ontologia_Class40016] of  Style

	(Style+name "Abstracto"))

([Ontologia_Class40017] of  Topic

	(Topic+name "Abstracto"))

([Ontologia_Class40018] of  Painting

	(Created+by [Ontologia_Class40020])
	(Exhibited+in [Ontologia_Class30000])
	(Height 131)
	(Observation+time -1)
	(Painted+in [Ontologia_Class30002])
	(Painting+name "Baile en el Moulin de la Galette")
	(Painting+style [Ontologia_Class40019])
	(Painting+topic [Ontologia_Class20002])
	(Relevance 40)
	(Visitor+interest -1)
	(Width 174)
	(Year+of+creation 1876))

([Ontologia_Class40019] of  Style

	(Style+name "Impresionismo"))

([Ontologia_Class40020] of  Author

	(Author+name "Pierre-August Renoir")
	(Authors+style [Ontologia_Class40019])
	(Nationality "Francés"))

([Ontologia_Class40021] of  Painting

	(Created+by [Ontologia_Class40022])
	(Exhibited+in [Ontologia_Class40004])
	(Height 80)
	(Observation+time -1)
	(Painted+in [Ontologia_Class30002])
	(Painting+name "Blanco sobre Blanco")
	(Painting+style [Ontologia_Class40023])
	(Painting+topic [Ontologia_Class40017])
	(Relevance 0)
	(Visitor+interest -1)
	(Width 80)
	(Year+of+creation 1918))

([Ontologia_Class40022] of  Author

	(Author+name "Kasimir Malevich")
	(Authors+style [Ontologia_Class40023])
	(Nationality "Ruso"))

([Ontologia_Class40023] of  Style

	(Style+name "Supermatismo"))

)