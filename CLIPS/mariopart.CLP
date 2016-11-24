(deffunction correctPreference(?actual ?painting)

	(if (eq (class ?actual) Author) then
		(if (eq (send ?actual get-Author+Name) (send (send ?painting get-Created+By) get-Author+Name)) then 
				(assert (AuthorPreference(preference yes)))
				TRUE
		else 
				(assert (AuthorPreference(preference no)))
				FALSE
		)
	)
	(if (eq (class ?actual) Topic) then
		(if (eq (send ?actual get-Topic+Name)(send (send ?painting get-Painting+Topic) get-Topic+Name)) then 
				(assert (TopicPreference(preference yes)))
				TRUE
		else 
				(assert (TopicPreference(preference no)))
				FALSE
		)
	)
	(if (eq (class ?actual) Style) then
		(if (eq (send ?actual get-Style+Name) (send (send ?painting get-Painting+Style) get-Style+Name)) then 
				(assert (StylePreference(preference yes)))
				TRUE
		else 
				(assert (StylePreference(preference no)))
				FALSE
		)
	)
	(if (eq (class ?actual) Period) then
		(if (eq (send ?actual get-Period+Name) (send (send ?painting get-Painted+in) get-Period+Name)) then 
				(assert (PeriodPreference(preference yes)))
				TRUE
		else 
				(assert (PeriodPreference(preference no)))
				FALSE
		)
	)
)


(defrule FindPreferences "Esta regla determina cuantos interes tiene un visitante sobre un cuadro y crea los hechos convenientes"
(object (is-a Visitor) (Preferences ?preferences)) ?painting<-(object (is-a Painting))
=>
(bind ?contadorCoincidencias 0)
(loop-for-count (?i 1 (length$ ?preferences)) do
	(bind ?actual (nth$ ?i ?preferences))
;aquí hacemos lo que queramos
	(if (correctPreference ?actual ?painting) then
		(+ ?contador 1)
	)
))
