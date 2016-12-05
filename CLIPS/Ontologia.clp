; Mon Dec 05 10:38:56 CET 2016
; 
;+ (version "3.5")
;+ (build "Build 663")


(defclass %3ACLIPS_TOP_LEVEL_SLOT_CLASS "Fake class to save top-level slot information"
	(is-a USER)
	(role abstract)
	(single-slot Created+by
;+		(comment "The author of the painting.")
		(type INSTANCE)
;+		(allowed-classes Author)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Room+Name
		(type STRING)
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
	(single-slot Starting+year
;+		(comment "Year in which the period started.")
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Painted+in
;+		(comment "The period in which a painting was painted.")
		(type INSTANCE)
;+		(allowed-classes Period)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(multislot Preferences
;+		(comment "The preferences of a visitor")
		(type INSTANCE)
;+		(allowed-classes Author Period Style Topic)
		(create-accessor read-write))
	(single-slot Type
;+		(comment "The kind of visitor.")
		(type SYMBOL)
		(allowed-values Family_with_children Family_without_children Not_a_family)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Author+Name
;+		(comment "The name of an author.")
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Height
;+		(comment "The height of a painting.")
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(multislot Asigned+Paintings
		(type INSTANCE)
;+		(allowed-classes Painting)
		(create-accessor read-write))
	(single-slot Painting+Topic
;+		(comment "The topic of a painting.")
		(type INSTANCE)
;+		(allowed-classes Topic)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Painting+Name
;+		(comment "The name of a painting.")
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Complexity
;+		(comment "The complexity of a painting.")
		(type INTEGER)
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
	(single-slot Visitor+Interest
		(type INTEGER)
		(default -1)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Number+of+People
;+		(comment "The number of people that composes a group.")
		(type INTEGER)
		(range 1 100)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(multislot Adjacent+to
;+		(comment "The rooms connected with a room.")
		(type INSTANCE)
;+		(allowed-classes Room)
		(create-accessor read-write))
	(multislot Paintings
;+		(comment "Paintings painted in a period.")
		(type INSTANCE)
;+		(allowed-classes Painting)
		(create-accessor read-write))
	(single-slot Active+Interval
;+		(comment "The interval of in which an author painted.")
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Topic+Name
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Visitor+Name
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Observation+Time
		(type INTEGER)
		(default -1)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Finishing+year
;+		(comment "Year in which the period finished.")
		(type INTEGER)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Is+Initial+Room
		(type SYMBOL)
		(allowed-values FALSE TRUE)
		(default FALSE)
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
	(single-slot Nationality
;+		(comment "The nationality of an author.")
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(multislot Authors+Style
;+		(comment "The styles of an author.")
		(type INSTANCE)
;+		(allowed-classes Style)
		(cardinality 1 ?VARIABLE)
		(create-accessor read-write))
	(single-slot Knowledge
;+		(comment "The knowledge of a visitor")
		(type INTEGER)
		(range 0 100)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Style+Name
;+		(comment "The name of an style.")
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Painting+Style
;+		(comment "The pictorial period in which the painting was painted.")
		(type INSTANCE)
;+		(allowed-classes Style)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Period+Name
;+		(comment "The name of the historical period.")
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write)))

(defclass Painting "A painting that is exposed in a museum."
	(is-a USER)
	(role concrete)
	(single-slot Painting+Topic
;+		(comment "The topic of a painting.")
		(type INSTANCE)
;+		(allowed-classes Topic)
;+		(cardinality 1 1)
		(create-accessor read-write))
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
	(single-slot Painting+Name
;+		(comment "The name of a painting.")
		(type STRING)
;+		(cardinality 1 1)
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
	(single-slot Observation+Time
		(type INTEGER)
		(default -1)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Painting+Style
;+		(comment "The pictorial period in which the painting was painted.")
		(type INSTANCE)
;+		(allowed-classes Style)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Visitor+Interest
		(type INTEGER)
		(default -1)
;+		(cardinality 0 1)
		(create-accessor read-write)))

(defclass Author "Person that creates art."
	(is-a USER)
	(role concrete)
	(single-slot Nationality
;+		(comment "The nationality of an author.")
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(multislot Authors+Style
;+		(comment "The styles of an author.")
		(type INSTANCE)
;+		(allowed-classes Style)
		(cardinality 1 ?VARIABLE)
		(create-accessor read-write))
	(single-slot Active+Interval
;+		(comment "The interval of in which an author painted.")
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Author+Name
;+		(comment "The name of an author.")
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write)))

(defclass Period "A period in history."
	(is-a USER)
	(role concrete)
	(multislot Paintings
;+		(comment "Paintings painted in a period.")
		(type INSTANCE)
;+		(allowed-classes Painting)
		(create-accessor read-write))
	(single-slot Starting+year
;+		(comment "Year in which the period started.")
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Finishing+year
;+		(comment "Year in which the period finished.")
		(type INTEGER)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Period+Name
;+		(comment "The name of the historical period.")
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write)))

(defclass Style "Style / School / Pictorial Period"
	(is-a USER)
	(role concrete)
	(single-slot Starting+year
;+		(comment "Year in which the period started.")
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Style+Name
;+		(comment "The name of an style.")
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Finishing+year
;+		(comment "Year in which the period finished.")
		(type INTEGER)
;+		(cardinality 0 1)
		(create-accessor read-write)))

(defclass Room "A room of the museum."
	(is-a USER)
	(role concrete)
	(multislot Asigned+Paintings
		(type INSTANCE)
;+		(allowed-classes Painting)
		(create-accessor read-write))
	(multislot Adjacent+to
;+		(comment "The rooms connected with a room.")
		(type INSTANCE)
;+		(allowed-classes Room)
		(create-accessor read-write))
	(single-slot Room+Name
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Is+Initial+Room
		(type SYMBOL)
		(allowed-values FALSE TRUE)
		(default FALSE)
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
	(single-slot Type
;+		(comment "The kind of visitor.")
		(type SYMBOL)
		(allowed-values Family_with_children Family_without_children Not_a_family)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Knowledge
;+		(comment "The knowledge of a visitor")
		(type INTEGER)
		(range 0 100)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Visitor+Name
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Duration
;+		(comment "The duration in hours of the visits of a visitor.")
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Number+of+People
;+		(comment "The number of people that composes a group.")
		(type INTEGER)
		(range 1 100)
;+		(cardinality 1 1)
		(create-accessor read-write)))

(defclass Topic "A topic."
	(is-a USER)
	(role concrete)
	(single-slot Topic+Name
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write)))


(definstances instances
; Mon Dec 05 10:38:57 CET 2016
; 
;+ (version "3.5")
;+ (build "Build 663")

([Ontologia_Class0] of  Painting

	(Created+by [Ontologia_Class1])
	(Exhibited+in [Ontologia_Class10002])
	(Height 77)
	(Observation+Time 20)
	(Painted+in [Ontologia_Class10000])
	(Painting+Name "La Gioconda")
	(Painting+Style [Ontologia_Class3])
	(Painting+Topic [Ontologia_Class10008])
	(Relevance 100)
	(Visitor+Interest -1)
	(Width 53)
	(Year+of+creation 1519))

([Ontologia_Class1] of  Author

	(Active+Interval "1452-1519")
	(Author+Name "Leonardo da Vinci")
	(Authors+Style [Ontologia_Class3])
	(Nationality "Italiano"))

([Ontologia_Class10000] of  Period

	(Finishing+year 1453)
	(Paintings [Ontologia_Class0])
	(Period+Name "Edad Media")
	(Starting+year 476))

([Ontologia_Class10002] of  Room

	(Is+Initial+Room TRUE)
	(Room+Name "Room 1"))

([Ontologia_Class10008] of  Topic

	(Topic+Name "Retrato"))

([Ontologia_Class20000] of  Painting

	(Created+by [Ontologia_Class20001])
	(Exhibited+in [Ontologia_Class10002])
	(Height 95)
	(Observation+Time 8)
	(Painted+in [Ontologia_Class20004])
	(Painting+Name "El caminante sobre el mar de nubes")
	(Painting+Style [Ontologia_Class20003])
	(Painting+Topic [Ontologia_Class20002])
	(Relevance 75)
	(Visitor+Interest -1)
	(Width 75)
	(Year+of+creation 1818))

([Ontologia_Class20001] of  Author

	(Active+Interval "1774-1840")
	(Author+Name "Caspar David Friedrich")
	(Authors+Style [Ontologia_Class20003])
	(Nationality "Alemana"))

([Ontologia_Class20002] of  Topic

	(Topic+Name "Paisaje"))

([Ontologia_Class20003] of  Style

	(Finishing+year 1870)
	(Starting+year 1770)
	(Style+Name "Romanticismo"))

([Ontologia_Class20004] of  Period

	(Finishing+year 1789)
	(Paintings [Ontologia_Class20000])
	(Period+Name "Edad Moderna")
	(Starting+year 1453))

([Ontologia_Class3] of  Style

	(Finishing+year 1660)
	(Starting+year 1400)
	(Style+Name "Renacimiento"))

([Ontologia_Class30000] of  Room

	(Adjacent+to [Ontologia_Class10002])
	(Is+Initial+Room FALSE)
	(Room+Name "Room 2"))

([Ontologia_Class30002] of  Period

	(Paintings [Ontologia_Class30013])
	(Period+Name "Edad Contemporanea")
	(Starting+year 1789))

([Ontologia_Class30003] of  Style

	(Finishing+year 1905)
	(Starting+year 1880)
	(Style+Name "PostImpresionismo"))

([Ontologia_Class30004] of  Style

	(Finishing+year 1925)
	(Starting+year 1905)
	(Style+Name "Expresionismo"))

([Ontologia_Class30005] of  Style

	(Starting+year 1880)
	(Style+Name "Simbolismo"))

([Ontologia_Class30006] of  Style

	(Finishing+year 1942)
	(Starting+year 1924)
	(Style+Name "Surrealismo"))

([Ontologia_Class30007] of  Style

	(Finishing+year 1830)
	(Starting+year 1760)
	(Style+Name "Neoclasicismo"))

([Ontologia_Class30008] of  Topic

	(Topic+Name "Amor"))

([Ontologia_Class30009] of  Topic

	(Topic+Name "Religion"))

([Ontologia_Class30010] of  Topic

	(Topic+Name "Muerte"))

([Ontologia_Class30011] of  Topic

	(Topic+Name "Juramento"))

([Ontologia_Class30012] of  Author

	(Active+Interval "1853-1890")
	(Author+Name "Vincent van Gogh")
	(Authors+Style
		[Ontologia_Class30003]
		[Ontologia_Class30004])
	(Nationality "Neerlandés"))

([Ontologia_Class30013] of  Painting

	(Created+by [Ontologia_Class30012])
	(Exhibited+in [Ontologia_Class10002])
	(Height 92)
	(Observation+Time 66)
	(Painted+in [Ontologia_Class30002])
	(Painting+Name "La noche estrellada")
	(Painting+Style [Ontologia_Class30003])
	(Painting+Topic [Ontologia_Class20002])
	(Relevance 100)
	(Visitor+Interest -1)
	(Width 74)
	(Year+of+creation 1889))

([Ontologia_Class30014] of  Painting

	(Created+by [Ontologia_Class30015])
	(Exhibited+in [Ontologia_Class10002])
	(Height 91)
	(Observation+Time 9)
	(Painted+in [Ontologia_Class30002])
	(Painting+Name "El Grito")
	(Painting+Style [Ontologia_Class30004])
	(Painting+Topic [Ontologia_Class10008])
	(Relevance 100)
	(Visitor+Interest -1)
	(Width 74)
	(Year+of+creation 1893))

([Ontologia_Class30015] of  Author

	(Active+Interval "1863-1944")
	(Author+Name "Edvard Munch")
	(Authors+Style [Ontologia_Class30004])
	(Nationality "Noruego"))

([Ontologia_Class30017] of  Author

	(Active+Interval "1862-1918")
	(Author+Name "Gustav Klimt")
	(Authors+Style [Ontologia_Class30005])
	(Nationality "Austohungaro"))

([Ontologia_Class30018] of  Painting

	(Created+by [Ontologia_Class30017])
	(Exhibited+in [Ontologia_Class10002])
	(Height 180)
	(Observation+Time 42)
	(Painted+in [Ontologia_Class30002])
	(Painting+Name "El beso")
	(Painting+Style [Ontologia_Class30005])
	(Painting+Topic [Ontologia_Class30008])
	(Relevance 70)
	(Visitor+Interest -1)
	(Width 180)
	(Year+of+creation 1907))

([Ontologia_Class30019] of  Author

	(Active+Interval "1904-1989")
	(Author+Name "Salvador Dali")
	(Authors+Style [Ontologia_Class30006])
	(Nationality "Española"))

([Ontologia_Class30020] of  Painting

	(Created+by [Ontologia_Class30019])
	(Exhibited+in [Ontologia_Class10002])
	(Height 33)
	(Observation+Time 69)
	(Painted+in [Ontologia_Class30002])
	(Painting+Name "La Persistencia de la Memoria")
	(Painting+Style [Ontologia_Class30006])
	(Painting+Topic [Ontologia_Class20002])
	(Relevance 90)
	(Visitor+Interest -1)
	(Width 24)
	(Year+of+creation 1931))

([Ontologia_Class30021] of  Author

	(Active+Interval "1445-1510")
	(Author+Name "Sandro Botticelli")
	(Authors+Style [Ontologia_Class3])
	(Nationality "Itailiana"))

([Ontologia_Class30022] of  Painting

	(Created+by [Ontologia_Class30021])
	(Exhibited+in [Ontologia_Class10002])
	(Height 173)
	(Observation+Time 90)
	(Painted+in [Ontologia_Class20004])
	(Painting+Name "El nacimiento de Venus")
	(Painting+Style [Ontologia_Class3])
	(Painting+Topic [Ontologia_Class30009])
	(Relevance 85)
	(Visitor+Interest -1)
	(Width 279)
	(Year+of+creation 1484))

([Ontologia_Class30023] of  Author

	(Active+Interval "1430-1479")
	(Author+Name "Antonello da Messina")
	(Authors+Style [Ontologia_Class3])
	(Nationality "Italiana"))

([Ontologia_Class30024] of  Painting

	(Created+by [Ontologia_Class30023])
	(Exhibited+in [Ontologia_Class10002])
	(Height 74)
	(Observation+Time 5)
	(Painted+in [Ontologia_Class20004])
	(Painting+Name "Cristo muerto sostenido por un angel")
	(Painting+Style [Ontologia_Class3])
	(Painting+Topic [Ontologia_Class30009])
	(Relevance 20)
	(Visitor+Interest -1)
	(Width 51)
	(Year+of+creation 1475))

([Ontologia_Class30025] of  Author

	(Active+Interval "1791-1824")
	(Author+Name "Theodore Gericault")
	(Authors+Style [Ontologia_Class20003])
	(Nationality "Francesa"))

([Ontologia_Class30026] of  Painting

	(Created+by [Ontologia_Class30025])
	(Exhibited+in [Ontologia_Class10002])
	(Height 491)
	(Observation+Time 50)
	(Painted+in [Ontologia_Class30002])
	(Painting+Name "La Balsa de la Medusa")
	(Painting+Style [Ontologia_Class20003])
	(Painting+Topic [Ontologia_Class30010])
	(Relevance 75)
	(Visitor+Interest -1)
	(Width 717)
	(Year+of+creation 1819))

([Ontologia_Class30027] of  Author

	(Active+Interval "1748-1825")
	(Author+Name "Jacques-Louis David")
	(Authors+Style [Ontologia_Class30007])
	(Nationality "Francesa"))

([Ontologia_Class30028] of  Painting

	(Created+by [Ontologia_Class30027])
	(Exhibited+in [Ontologia_Class10002])
	(Height 330)
	(Observation+Time 24)
	(Painted+in [Ontologia_Class20004])
	(Painting+Name "El Juramento de los Horacios")
	(Painting+Style [Ontologia_Class30007])
	(Painting+Topic [Ontologia_Class30011])
	(Relevance 45)
	(Visitor+Interest -1)
	(Width 425)
	(Year+of+creation 1784))
)