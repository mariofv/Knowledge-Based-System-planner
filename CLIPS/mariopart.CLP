(defrule PaintingInterest "Este filtro es el que te dice cuanto le interesa un cuadro a un visitante"
(PaintingRelevance(relevance ?relevance)) ()
=>
(assert (ObservationTime (time High))))


(deffunction correctPreference(?actual, ?painting)
	(if () then
		(if () then 
				(assert (AuthorPreference(preference yes)))
				TRUE
		else 
				(assert (AuthorPreference(preference no)))
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
