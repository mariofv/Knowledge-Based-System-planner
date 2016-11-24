(defrule PaintingInterest "Este filtro es el que te dice cuanto le interesa un cuadro a un visitante"
(PaintingRelevance(relevance ?relevance)) ()
=>
(assert (ObservationTime (time High))))


(deffunction correctPreference(?actual, ?painting)
	(if (= (class ?actual) Author) then
		(if (= ?actual:Author+Name ?painting:Created+By:Author+Name) then 
				(assert (AuthorPreference(preference yes)))
				TRUE
		else 
				(assert (AuthorPreference(preference no)))
				FALSE
		)
	)
	(if (= (class ?actual) Topic) then
		(if (= ?actual:Topic+Name ?painting:Painting+Topic:Topic+Name) then 
				(assert (TopicPreference(preference yes)))
				TRUE
		else 
				(assert (TopicPreference(preference no)))
				FALSE
		)
	)
	(if (= (class ?actual) Style) then
		(if (= ?actual:Style+Name ?painting:Painting+Style:Style+Name) then 
				(assert (StylePreference(preference yes)))
				TRUE
		else 
				(assert (StylePreference(preference no)))
				FALSE
		)
	)
	(if (= (class ?actual) Period) then
		(if (= ?actual:Period+Name ?painting:Painted+in:Period+Name) then 
				(assert (PeriodPreference(preference yes)))
				TRUE
		else 
				(assert (PeriodPreference(preference no)))
				FALSE
		)
	)
)


(defrule FindPreferences "Esta regla determina cuantos interes tiene un visitante sobre un cuadro y crea los hechos convenientes"
((object (is-a Visitor) (Preferences ?preferences)) ?painting<-(object (is-a Painting))
=>
(bind ?contadorCoincidencias 0)
(loop-for-count (?i 1 (length$ ?preferences)) do
	(bind ?actual (nth$ ?i ?preferences))
;aquí hacemos lo que queramos
	(if (correctPreference ?actual ?painting) then
		(+ ?contador 1)
	)
)))
