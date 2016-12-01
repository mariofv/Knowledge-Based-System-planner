(defmodule MAIN
(export defclass ?ALL)
(export deftemplate ?ALL)
)

(defclass %3ACLIPS_TOP_LEVEL_SLOT_CLASS "Fake class to save top-level slot information"
	(is-a USER)
	(role abstract)
	(single-slot Room+Name
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
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
	(multislot Painted
;+		(comment "The paintings that an author painted.")
		(type INSTANCE)
;+		(allowed-classes)
		(cardinality 1 ?VARIABLE)
		(create-accessor read-write))
	(single-slot Painted+in
;+		(comment "The period in which a painting was painted.")
		(type INSTANCE)
;+		(allowed-classes Period)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Starting+year
;+		(comment "Year in which the period started.")
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(multislot Prefered+by
;+		(comment "The visitors that prefer the instance.")
		(type INSTANCE)
;+		(allowed-classes Visitor)
		(create-accessor read-write))
	(multislot Authors+with+style
;+		(comment "The authors that painted paintings in a pictorial period.")
		(type INSTANCE)
;+		(allowed-classes Author)
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
	(multislot Paintings+with+style
;+		(comment "The paintings that were painted in a pictorial period.")
		(type INSTANCE)
;+		(allowed-classes Painting)
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
	(multislot Paintings+with+topic
;+		(comment "The paintings inspired by a topic")
		(type INSTANCE)
;+		(allowed-classes Painting)
		(create-accessor read-write))
	(single-slot Finishing+year
;+		(comment "Year in which the period finished.")
		(type INTEGER)
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
;+		(cardinality 0 1)
		(create-accessor read-write))
	(multislot Exhibits
;+		(comment "The paintings which are exhibited in a room.")
		(type INSTANCE)
;+		(allowed-classes Painting)
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
	(single-slot Period+Name
;+		(comment "The name of the historical period.")
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Painting+Style
;+		(comment "The pictorial period in which the painting was painted.")
		(type INSTANCE)
;+		(allowed-classes Style)
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
	(single-slot Painting+Topic
;+		(comment "The topic of a painting.")
		(type INSTANCE)
;+		(allowed-classes Topic)
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
	(single-slot Observation+Time
		(type INTEGER)
		(default -1)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Height
;+		(comment "The height of a painting.")
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Visitor+Interest
		(type INTEGER)
		(default -1)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Painting+Style
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
;+		(cardinality 0 1)
		(create-accessor read-write))
	(multislot Authors+Style
;+		(comment "The styles of an author.")
		(type INSTANCE)
;+		(allowed-classes Style)
		(cardinality 1 ?VARIABLE)
		(create-accessor read-write))
	(multislot Painted
;+		(comment "The paintings that an author painted.")
		(type INSTANCE)
;+		(allowed-classes)
		(cardinality 1 ?VARIABLE)
		(create-accessor read-write))
	(single-slot Active+Interval
;+		(comment "The interval of in which an author painted.")
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(multislot Prefered+by
;+		(comment "The visitors that prefer the instance.")
		(type INSTANCE)
;+		(allowed-classes Visitor)
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
	(multislot Prefered+by
;+		(comment "The visitors that prefer the instance.")
		(type INSTANCE)
;+		(allowed-classes Visitor)
		(create-accessor read-write))
	(single-slot Period+Name
;+		(comment "The name of the historical period.")
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Finishing+year
;+		(comment "Year in which the period finished.")
		(type INTEGER)
;+		(cardinality 0 1)
		(create-accessor read-write)))

(defclass Style "Style / School / Pictorial Period"
	(is-a USER)
	(role concrete)
	(multislot Paintings+with+style
;+		(comment "The paintings that were painted in a pictorial period.")
		(type INSTANCE)
;+		(allowed-classes Painting)
		(create-accessor read-write))
	(single-slot Starting+year
;+		(comment "Year in which the period started.")
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(multislot Prefered+by
;+		(comment "The visitors that prefer the instance.")
		(type INSTANCE)
;+		(allowed-classes Visitor)
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
		(create-accessor read-write))
	(multislot Authors+with+style
;+		(comment "The authors that painted paintings in a pictorial period.")
		(type INSTANCE)
;+		(allowed-classes Author)
		(create-accessor read-write)))

(defclass Room "A room of the museum."
	(is-a USER)
	(role concrete)
	(single-slot Room+Name
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(multislot Adjacent+to
;+		(comment "The rooms connected with a room.")
		(type INSTANCE)
;+		(allowed-classes Room)
		(create-accessor read-write))
	(multislot Exhibits
;+		(comment "The paintings which are exhibited in a room.")
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
	(single-slot Type
;+		(comment "The kind of visitor.")
		(type SYMBOL)
		(allowed-values Family_with_children Family_without_children Not_a_family)
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
		(create-accessor read-write))
	(multislot Prefered+by
;+		(comment "The visitors that prefer the instance.")
		(type INSTANCE)
;+		(allowed-classes Visitor)
		(create-accessor read-write))
	(multislot Paintings+with+topic
;+		(comment "The paintings inspired by a topic")
		(type INSTANCE)
;+		(allowed-classes Painting)
		(create-accessor read-write)))
(definstances instances


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
	(Nationality "Italiano")
	(Painted [Ontologia_Class0]))

([Ontologia_Class10000] of  Period

	(Finishing+year 1453)
	(Paintings [Ontologia_Class0])
	(Period+Name "Edad Media")
	(Starting+year 476))

([Ontologia_Class10002] of  Room

	(Exhibits
		[Ontologia_Class30013]
		[Ontologia_Class0]
		[Ontologia_Class30014]
		[Ontologia_Class20000])
	(Room+Name "Room 1"))

([Ontologia_Class10008] of  Topic

	(Paintings+with+topic [Ontologia_Class0])
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
	(Nationality "Alemana")
	(Painted [Ontologia_Class20000]))

([Ontologia_Class20002] of  Topic

	(Paintings+with+topic [Ontologia_Class20000])
	(Topic+Name "Paisaje"))

([Ontologia_Class20003] of  Style

	(Authors+with+style [Ontologia_Class20001])
	(Finishing+year 1870)
	(Paintings+with+style [Ontologia_Class20000])
	(Starting+year 1770)
	(Style+Name "Romanticismo"))

([Ontologia_Class20004] of  Period

	(Finishing+year 1789)
	(Paintings [Ontologia_Class20000])
	(Period+Name "Edad Moderna")
	(Starting+year 1453))

([Ontologia_Class3] of  Style

	(Authors+with+style [Ontologia_Class1])
	(Finishing+year 1660)
	(Paintings+with+style [Ontologia_Class0])
	(Starting+year 1400)
	(Style+Name "Renacimiento"))

([Ontologia_Class30002] of  Period

	(Paintings [Ontologia_Class30013])
	(Period+Name "Edad Contemporanea")
	(Starting+year 1789))

([Ontologia_Class30003] of  Style

	(Authors+with+style [Ontologia_Class30012])
	(Finishing+year 1905)
	(Paintings+with+style [Ontologia_Class30013])
	(Starting+year 1880)
	(Style+Name "PostImpresionismo"))

([Ontologia_Class30004] of  Style

	(Authors+with+style [Ontologia_Class30012])
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
	(Nationality "Neerlandés")
	(Painted [Ontologia_Class30013]))

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
	(Nationality "Noruego")
	(Painted [Ontologia_Class30014]))

([Ontologia_Class30017] of  Author

	(Active+Interval "1862-1918")
	(Author+Name "Gustav Klimt")
	(Authors+Style [Ontologia_Class30005])
	(Nationality "Austohungaro")
	(Painted [Ontologia_Class30018]))

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
	(Nationality "Española")
	(Painted [Ontologia_Class30020]))

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
	(Nationality "Itailiana")
	(Painted [Ontologia_Class30022]))

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
	(Nationality "Italiana")
	(Painted [Ontologia_Class30024]))

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
	(Nationality "Francesa")
	(Painted [Ontologia_Class30026]))

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
	(Nationality "Francesa")
	(Painted [Ontologia_Class30028]))

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

([Ontologia_Class36] of  Author

	(Active+Interval "1423-1429")
	(Author+Name "Fra Giovanni de Fiesole")
	(Nationality "Italiano"))

)

(defclass Day
    (is-a USER)
    (role concrete)
    (slot number
        (type INTEGER)
    )
    (slot asignedTime
        (type INTEGER)
        (default 0)
    )
    (multislot asignedPaintings
        (type INSTANCE)
        (allowed-classes Painting)
    )
)

(deftemplate AnalyzePainting
(slot painting (type INSTANCE) (allowed-classes Painting)))

(deftemplate AnalyzeVisitor
(slot visitor (type INSTANCE) (allowed-classes Visitor)))

(deftemplate PaintingFact
(slot paintingFact (type INSTANCE) (allowed-classes Painting)))

(deftemplate MaxMinPaintingArea
(slot max (type INTEGER))
(slot min (type INTEGER)))

(deftemplate FinalObservationTime
(slot time (type INTEGER)))

(deftemplate FinalPaintingInterest
(slot interest (type INTEGER)))

(defrule FindMaxMinPaintingArea "Esta regla determina el area maxima y minima de los cuadros"
(declare(salience 100))
(object (is-a Painting) (Width ?width) (Height ?height)) ?limit <-(MaxMinPaintingArea (max ?max) (min ?min))
=>
(bind ?area (* ?width ?height))
    (if (< ?max ?area) then
	    (modify ?limit (max ?area))
    else
        (if (> ?min ?area) then
	        (modify ?limit (min ?area))
        )
    )
)

(defrule NormalizeComplexity "Esta regla normaliza la complejidad de los cuadros"
(declare(salience 50))
?painting<-(object (is-a Painting) (Width ?width) (Height ?height))
(MaxMinPaintingArea (max ?max) (min ?min))
=>
(bind ?area (* ?width ?height))
(send ?painting put-Complexity (*(/ (- ?area ?min) (- ?max ?min)) 100))
)

(defrule InitializeMaxMinPaintingArea "Inicializa MaxMinPaintingArea"
(declare (salience 150))
=>
(assert (MaxMinPaintingArea(max 0) (min 999999)))
)

(defrule changePreguntasModul
(declare (salience 25))
    ?fact <- (MaxMinPaintingArea)
=>
    (retract ?fact)
    (focus PreguntasMod)
)

(defrule StartRule
(declare (salience 0))
=>
(bind ?paintings (find-all-instances ((?inst Painting)) TRUE))

    (loop-for-count (?i 1 (length$ ?paintings)) do
        (assert (PaintingFact (paintingFact (nth$ ?i ?paintings))))
    )
)

(defrule AnalyzePainting ""
(declare (salience 0))
?f <- (PaintingFact (paintingFact ?painting))
=>
(assert (AnalyzeVisitor(visitor (nth$ 1 (find-all-instances ((?inst Visitor)) TRUE)))))
(assert (AnalyzePainting (painting ?painting)))
(focus HeuristicMod)
(retract ?f)
)

(defrule FinishAnalyzing
(declare (salience 1))
    ?f1 <- (FinalObservationTime (time ?time))
    ?f2 <- (FinalPaintingInterest (interest ?interest))
    ?f3 <- (AnalyzePainting (painting ?painting))
    ?f4 <- (AnalyzeVisitor)
=>
    (printout t "El cuadro " (send ?painting get-Painting+Name) " tiene un interes de " ?interest " y un tiempo de observacion de " ?time " segundos." crlf)
    (send ?painting put-Visitor+Interest ?interest)
    (send ?painting put-Observation+Time ?time)
    (retract ?f1)
    (retract ?f2)
    (retract ?f3)
    (retract ?f4)
)

(defrule FinishProgram
(declare (salience 10000))
    ?fact <- (Day (number ?number) (asignedPaintings $?asignedPaintings))
=>
    (printout t "Los cuadros a visitar en el día " ?number " son " crlf)
    (loop-for-count (?i 1 (length$ ?asignedPaintings) ) do
        (bind ?painting (nth$ ?i ?asignedPaintings))
        (printout t "El cuadro " (send ?painting get-Painting+Name) " tiene un interes de " (send ?painting get-Visitor+Interest)  crlf)
    )
    (printout t crlf)
    (retract ?fact)
)

(defrule StartVisita
(declare (salience -1))
=>
    (printout t "Empieza VisitaMod" crlf)
    (focus VisitaMod)
    (assert (Finish-Fact))
)

(defrule END
(declare (salience 9999))
    ?fact <- (Finish-Fact)
=>
    (printout t "Acabe" crlf)
    (retract ?fact)
    (return)
)