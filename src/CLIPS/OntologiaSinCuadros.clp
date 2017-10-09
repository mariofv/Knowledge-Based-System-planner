
(defclass %3ACLIPS_TOP_LEVEL_SLOT_CLASS "Fake class to save top-level slot information"
	(is-a USER)
	(role abstract)
	(single-slot Created+by
;+		(comment "The author of the painting.")
		(type INSTANCE)
;+		(allowed-classes Author)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Days
;+		(comment "The number of days in which the visitor visits the museum.")
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Year+of+creation
;+		(comment "The year in wich the painting was created.")
		(type INTEGER)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Asigned+time
;+		(comment "The time asigned to a day.")
		(type INTEGER)
;+		(cardinality 0 1)
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
	(single-slot Period+name
;+		(comment "The name of the historical period.")
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Visitor+name
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Country+name
;+		(comment "The name of a country.")
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
	(single-slot Number
;+		(comment "The number of a day.")
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Painting+topic
;+		(comment "The topic of a painting.")
		(type INSTANCE)
;+		(allowed-classes Topic)
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
		(type INSTANCE)
;+		(allowed-classes Country)
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
	(single-slot Relevance
;+		(comment "The relevance of a painting.")
		(type INTEGER)
		(range 0 100)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Painted+in
;+		(comment "The period in which a painting was painted.")
		(type INSTANCE)
;+		(allowed-classes Period)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Complexity
;+		(comment "The complexity of a painting.")
		(type INTEGER)
;+		(cardinality 0 1)
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
	(single-slot Observation+time
		(type INTEGER)
		(default -1)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Painting+topic
;+		(comment "The topic of a painting.")
		(type INSTANCE)
;+		(allowed-classes Topic)
;+		(cardinality 1 1)
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
		(type INSTANCE)
;+		(allowed-classes Country)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Author+name
;+		(comment "The name of an author.")
		(type STRING)
;+		(cardinality 1 1)
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

(defclass Country "A country of the world."
	(is-a USER)
	(role concrete)
	(single-slot Country+name
;+		(comment "The name of a country.")
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write)))

(definstances Instances

([Ontologia_Class1] of  Author

	(Author+name "Leonardo da Vinci")
	(Nationality [Ontologia_Class50003]))

([Ontologia_Class10000] of  Period

	(Period+name "Edad Media"))

([Ontologia_Class10002] of  Room

	(Number 1))

([Ontologia_Class10008] of  Topic

	(Topic+name "Retrato"))

([Ontologia_Class20001] of  Author

	(Author+name "Caspar David Friedrich")
	(Nationality [Ontologia_Class50004]))

([Ontologia_Class20002] of  Topic

	(Topic+name "Paisaje"))

([Ontologia_Class20003] of  Style

	(Style+name "Romanticismo"))

([Ontologia_Class20004] of  Period

	(Period+name "Edad Moderna"))

([Ontologia_Class3] of  Style

	(Style+name "Renacimiento"))

([Ontologia_Class30000] of  Room

	(Number 2))

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
	(Nationality [Ontologia_Class50014]))


([Ontologia_Class30015] of  Author

	(Author+name "Edvard Munch")
	(Nationality [Ontologia_Class50006]))

([Ontologia_Class30017] of  Author

	(Author+name "Gustav Klimt")
	(Nationality [Ontologia_Class50008]))

([Ontologia_Class30019] of  Author

	(Author+name "Salvador Dali")
	(Nationality [Ontologia_Class50009]))

([Ontologia_Class30021] of  Author

	(Author+name "Sandro Botticelli")
	(Nationality [Ontologia_Class50003]))


([Ontologia_Class30023] of  Author

	(Author+name "Antonello da Messina")
	(Nationality [Ontologia_Class50003]))

([Ontologia_Class30025] of  Author

	(Author+name "Theodore Gericault")
	(Nationality [Ontologia_Class50010]))


([Ontologia_Class30027] of  Author

	(Author+name "Jacques-Louis David")
	(Nationality [Ontologia_Class50010]))


([Ontologia_Class40002] of  Topic

	(Topic+name "Flores"))

([Ontologia_Class40003] of  Room

	(Number 3))

([Ontologia_Class40004] of  Room

	(Number 4))

([Ontologia_Class40006] of  Author

	(Author+name "Diego Rivera")
	(Nationality [Ontologia_Class50005]))

([Ontologia_Class40007] of  Style

	(Style+name "Realismo"))


([Ontologia_Class40009] of  Author

	(Author+name "Grant Wood")
	(Nationality [Ontologia_Class50007]))

([Ontologia_Class40010] of  Style

	(Style+name "Regionalismo"))

([Ontologia_Class40013] of  Author

	(Author+name "Rene Magritte")
	(Nationality [Ontologia_Class50013]))

([Ontologia_Class40015] of  Author

	(Author+name "Jackson Pollock")
	(Nationality [Ontologia_Class50007]))

([Ontologia_Class40016] of  Style

	(Style+name "Abstracto"))

([Ontologia_Class40017] of  Topic

	(Topic+name "Abstracto"))


([Ontologia_Class40019] of  Style

	(Style+name "Impresionismo"))

([Ontologia_Class40020] of  Author

	(Author+name "Pierre-August Renoir")
	(Nationality [Ontologia_Class50010]))


([Ontologia_Class40022] of  Author

	(Author+name "Kasimir Malevich")
	(Nationality [Ontologia_Class50011]))

([Ontologia_Class40023] of  Style

	(Style+name "Supermatismo"))

([Ontologia_Class50003] of  Country

	(Country+name "Italy"))

([Ontologia_Class50004] of  Country

	(Country+name "German"))

([Ontologia_Class50005] of  Country

	(Country+name "Mexico"))

([Ontologia_Class50006] of  Country

	(Country+name "Norway"))

([Ontologia_Class50007] of  Country

	(Country+name "United States of America"))

([Ontologia_Class50008] of  Country

	(Country+name "Hungary"))

([Ontologia_Class50009] of  Country

	(Country+name "Spain"))

([Ontologia_Class50010] of  Country

	(Country+name "France"))

([Ontologia_Class50011] of  Country

	(Country+name "Russia"))

([Ontologia_Class50013] of  Country

	(Country+name "Belgium"))

([Ontologia_Class50014] of  Country

	(Country+name "Netherlands"))

)