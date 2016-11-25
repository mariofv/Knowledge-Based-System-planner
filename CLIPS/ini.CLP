
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
	(multislot Painted
;+		(comment "The paintings that an author painted.")
		(type INSTANCE)
;+		(allowed-classes)
		(cardinality 1 ?VARIABLE)
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
	(multislot Preference
;+		(comment "The preferences of a visitor")
		(type INSTANCE)
;+		(allowed-classes Author Period Style Topic)
		(create-accessor read-write))
	(single-slot Number+of+People
;+		(comment "The number of people that composes a group.")
		(type INTEGER)
		(range 1 100)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(multislot Paintings+with+style
;+		(comment "The paintings that were painted in a pictorial period.")
		(type INSTANCE)
;+		(allowed-classes Painting)
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
	(multislot Authors+Style
;+		(comment "The styles of an author.")
		(type INSTANCE)
;+		(allowed-classes Style)
		(cardinality 1 ?VARIABLE)
		(create-accessor read-write))
	(multislot Exhibits
;+		(comment "The paintings which are exhibited in a room.")
		(type INSTANCE)
;+		(allowed-classes Painting)
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
	(single-slot Painted+in
;+		(comment "The period in which a painting was painted.")
		(type INSTANCE)
;+		(allowed-classes Period)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Exhibited+in
;+		(comment "The room in which a painting was exhibited.")
		(type INSTANCE)
;+		(allowed-classes Room)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Relevance
;+		(comment "The relevance of a painting.")
		(type INTEGER)
		(range 0 100)
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
	(single-slot Height
;+		(comment "The height of a painting.")
		(type INTEGER)
;+		(cardinality 1 1)
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
	(multislot Adjacent+to
;+		(comment "The rooms connected with a room.")
		(type INSTANCE)
;+		(allowed-classes Room)
		(create-accessor read-write))
	(single-slot Room+Name
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(multislot Exhibits
;+		(comment "The paintings which are exhibited in a room.")
		(type INSTANCE)
;+		(allowed-classes Painting)
		(create-accessor read-write)))

(defclass Visitor "A visitor of a museum."
	(is-a USER)
	(role concrete)
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
	(multislot Preferences
;+		(comment "The preferences of a visitor")
		(type INSTANCE)
;+		(allowed-classes Author Period Style Topic)
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

	(Complexity 1)
	(Created+by [Ontologia_Class1])
	(Exhibited+in [Ontologia_Class10006])
	(Height 77)
	(Painted+in [Ontologia_Class10000])
	(Painting+Name "La Gioconda")
	(Painting+Style [Ontologia_Class3])
	(Painting+Topic [Ontologia_Class10008])
	(Relevance 1)
	(Width 53)
	(Year+of+creation 1519))

([Ontologia_Class1] of  Author

	(Active+Interval "1452-1519")
	(Author+Name "Leonardo da Vinci")
	(Authors+Style [Ontologia_Class3])
	(Nationality "Italiano")
	(Painted [Ontologia_Class0]))

([Ontologia_Class10000] of  Period

	(Finishing+year 1492)
	(Paintings [Ontologia_Class0])
	(Period+Name "Edad Media")
	(Starting+year 476))

([Ontologia_Class10002] of  Room

	(Adjacent+to
		[Ontologia_Class10004]
		[Ontologia_Class10005])
	(Room+Name "Room 1"))

([Ontologia_Class10004] of  Room

	(Adjacent+to
		[Ontologia_Class10002]
		[Ontologia_Class10005])
	(Room+Name "Room 2"))

([Ontologia_Class10005] of  Room

	(Adjacent+to
		[Ontologia_Class10006]
		[Ontologia_Class10004]
		[Ontologia_Class10002])
	(Room+Name "Room 3"))

([Ontologia_Class10006] of  Room

	(Adjacent+to [Ontologia_Class10005])
	(Exhibits [Ontologia_Class0])
	(Room+Name "Room 4"))

([Ontologia_Class10008] of  Topic

	(Paintings+with+topic [Ontologia_Class0])
	(Topic+Name "Retrato"))

([Ontologia_Class3] of  Style

	(Authors+with+style [Ontologia_Class1])
	(Finishing+year 1660)
	(Paintings+with+style [Ontologia_Class0])
	(Starting+year 1400)
	(Style+Name "Renacimiento"))

([Ontologia_Class36] of  Author

	(Active+Interval "1423-1429")
	(Author+Name "Fra Giovanni de Fiesole")
	(Nationality "Italiano"))

)

;///////////////////////////////
;/// AQUI ACABA LA ONTOLOGIA////
;///////////////////////////////

;///////////////////////////////
;/// AQUI EMPIEZAN HECHOS   ////
;///////////////////////////////

(deftemplate PaintingRelevance
(slot relevance (type SYMBOL)
(allowed-values Very_High High Medium Low Very_Low)))

(deftemplate Knowledge
(slot knowledge (type SYMBOL)
(allowed-values Very_High High Medium Low Very_Low)))

(deftemplate GroupSize
(slot size (type SYMBOL)
(allowed-values High Medium Low)))

(deftemplate AuthorPreference
(slot preference (type SYMBOL) (allowed-values yes no)))

(deftemplate TopicPreference
(slot preference (type SYMBOL)(allowed-values yes no)))

(deftemplate StylePreference
(slot preference (type SYMBOL)(allowed-values yes no)))

(deftemplate PeriodPreference
(slot preference (type SYMBOL)(allowed-values yes no)))

(deftemplate Preference
(slot level (type SYMBOL) (allowed-values Low High)))

(deftemplate NumPreferences
(slot number (type INTEGER)))

(deftemplate Interest
(slot level (type SYMBOL) (allowed-values Very_Low Low High Very_High)))

;///////////////////////////////
;/// AQUI EMPIEZAN REGLAS   ////
;///////////////////////////////

(deffunction abstractNumber(?relevance)
	(if (>= ?relevance 80) then Very_High
		else (if (>= ?relevance 60) then High
				else (if  (>= ?relevance 40) then Medium
					else (if (>= ?relevance 20) then Low
						else Very_Low					
						    )
					  )
			  )
	)
)

(deffunction correctPreference(?actual ?painting)

	(if (eq (class ?actual) Author) then
		(if (eq (send ?actual get-Author+Name) (send (send ?painting get-Created+by) get-Author+Name)) then 
				(assert (AuthorPreference(preference yes)))
                (printout t "SDfisdjfj" crlf)
				TRUE
		else 
				(assert (AuthorPreference(preference no)))
				FALSE
		)
	else
        (if (eq (class ?actual) Topic) then
    		(if (eq (send ?actual get-Topic+Name)(send (send ?painting get-Painting+Topic) get-Topic+Name)) then 
    				(assert (TopicPreference(preference yes)))
    				TRUE
    		else 
    				(assert (TopicPreference(preference no)))
    				FALSE
    		)
    	else 
           (if (eq (class ?actual) Style) then
    		    (if (eq (send ?actual get-Style+Name) (send (send ?painting get-Painting+Style) get-Style+Name)) then 
    				(assert (StylePreference(preference yes)))
    				TRUE
    		    else 
    				(assert (StylePreference(preference no)))
    				FALSE
    		    )
    	    else (if (eq (class ?actual) Period) then
    	    	(if (eq (send ?actual get-Period+Name) (send (send ?painting get-Painted+in) get-Period+Name)) then 
    	    			(assert (PeriodPreference(preference yes)))
    	    			TRUE
    	    	else 
    	    			(assert (PeriodPreference(preference no)))
    	    			FALSE
    	    	)
    	    )
            )
    	    
        )
    	
    )
	
)

(defrule FindPreferences "Esta regla determina cuantas preferencias tiene un visitante sobre un cuadro y crea los hechos convenientes"
(object (is-a Visitor) (Preferences $?preferences)) ?painting<-(object (is-a Painting))
=>
(bind ?contador 0)
(loop-for-count (?i 1 (length$ ?preferences)) do
	(bind ?actual (nth$ ?i ?preferences))
	(if (correctPreference ?actual ?painting) then
		(bind ?contador(+ ?contador 1))
	)
)
(assert (NumPreferences(number ?contador)))
)

(defrule AbstractPaintingRelevance "Abstrae la relevancia de un cuadro"
(object (is-a Painting) (Relevance ?relevance))
=>
(assert (PaintingRelevance(relevance (abstractNumber ?relevance)))
))

(defrule AbstractPreferencesHigh ""
(NumPreferences (number ?n)) (test (> ?n 1))
=>
(assert (Preference (level High)))
)

(defrule AbstractPreferencesLow ""
(NumPreferences (number ?n)) (test (<= ?n 1))
=>
(assert (Preference (level Low)))
)

(defrule FindInterestInPaintingVeryHigh "Comprueba si el interes de un visitante por un cuadro es muy alto"
(PaintingRelevance (relevance ?relevance)) (Preference (level ?preferenceLevel)) 
(or 
(test (eq ?relevance Very_High)) 
(and (test (eq ?relevance High)) (test (eq ?preferenceLevel High)))
)
=>
(assert (Interest (level Very_High)))
)

(defrule FindInterestInPaintingHigh "Comprueba si el interes de un visitante por un cuadro es alto"
(PaintingRelevance (relevance ?relevance)) (Preference (level ?preferenceLevel)) 
(or 
(and (test (eq ?relevance High)) (test(eq ?preferenceLevel Low)))
(and (test(eq ?relevance Medium)) (test(eq ?preferenceLevel High)))
)
=>
(assert (Interest (level High)))
)

(defrule FindInterestInPaintingLow "Comprueba si el interes de un visitante por un cuadro es bajo"
(PaintingRelevance (relevance ?relevance)) (Preference (level ?preferenceLevel)) 
(or
(and (test(eq ?relevance Medium)) (test(eq ?preferenceLevel Low)))
(and (test (eq ?relevance Low)) (test(eq ?preferenceLevel High)))
)
=>
(assert (Interest (level Low)))
)

(defrule FindInterestInPaintingVeryLow "Comprueba si el interes de un visitante por un cuadro es muy bajo"
(PaintingRelevance (relevance ?relevance)) (Preference (level ?preferenceLevel)) 
(or
(and (test (eq ?relevance Low)) (test(eq ?preferenceLevel Low)))
(test (eq ?relevance Very_Low))
)
=>
(assert (Interest (level Very_Low)))
)




