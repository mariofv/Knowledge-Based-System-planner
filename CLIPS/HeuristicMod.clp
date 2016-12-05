(defmodule HeuristicMod 
    (import MAIN deftemplate ?ALL) 
    (import MAIN defclass ?ALL) 

    (export deftemplate ?ALL)
    (export deffunction abstractNumber)
    (export defclass ?ALL)
)

;///////////
;HECHOS ///
;/////////

(deftemplate HeuristicMod::PaintingRelevance
    (slot relevance (type SYMBOL)
        (allowed-values Very_High High Medium Low Very_Low)
    )
)

(deftemplate HeuristicMod::Preference
    (slot level
        (type SYMBOL)
        (allowed-values Low High)
    )
)

(deftemplate HeuristicMod::NumPreferences
    (slot number
        (type INTEGER)
    )
)

;//////////////
;FUNCIONES ///
;////////////

(deffunction HeuristicMod::abstractNumber(?relevance)
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

(deffunction HeuristicMod::correctPreference(?actual ?painting)
	(if (eq (class ?actual) Author) then
		(if (eq (send ?actual get-Author+name) (send (send ?painting get-Created+by) get-Author+name)) 
            then 
				TRUE
		    else 
				FALSE
		)
	else
        (if (eq (class ?actual) Topic) then
    		(if (eq (send ?actual get-Topic+name)(send (send ?painting get-Painting+topic) get-Topic+name)) then 
    				TRUE
    		else 
    				FALSE
    		)
    	else 
           (if (eq (class ?actual) Style) then
    		    (if (eq (send ?actual get-Style+name) (send (send ?painting get-Painting+style) get-Style+name)) then 
    				TRUE
    		    else 
    				FALSE
    		    )
    	    else (if (eq (class ?actual) Period) then
    	    	(if (eq (send ?actual get-Period+name) (send (send ?painting get-Painted+in) get-Period+name)) then 
    	    			TRUE
    	    	else 
    	    			FALSE
    	    	)
    	    )
            )
    	    
        )
    	
    )
	
)

(defrule HeuristicMod::HeuristicModComplete 
    (PaintingRelevance)
    (Preference)
=>
    (focus PaintIntMod)
)

(defrule HeuristicMod::AllHeuristicModComplete1
(declare (salience 0))
    (FinalPaintingInterest)
=>
    (focus ObsTimeMod)
)

(defrule HeuristicMod::AllHeuristicModComplete2
(declare (salience 1))
    ?paintingRelevance <- (PaintingRelevance)
    ?preference <- (Preference)
    ?numPreference <- (NumPreferences)
    (FinalPaintingInterest)
    (FinalObservationTime)
=>
    (retract ?paintingRelevance)
    (retract ?preference)
    (retract ?numPreference)
)
;/////////////////////////
;REGLAS DE ABSTRACCIÓN //
;///////////////////////

(defrule HeuristicMod::AbstractPreferences "Esta regla determina cuantas preferencias tiene un visitante sobre un cuadro y crea los hechos convenientes"
    (AnalyzeVisitor (visitor ?visitor))
    (AnalyzePainting (painting ?painting))
=>
    (bind ?contador 0)
    (bind ?preferences (send ?visitor get-Preferences))
    (loop-for-count (?i 1 (length$ ?preferences)) do
	    (bind ?actual (nth$ ?i ?preferences))
	    (if (correctPreference ?actual ?painting) then
		    (bind ?contador(+ ?contador 1))
	    )
    )
    (assert (NumPreferences(number ?contador)))
)

(defrule HeuristicMod::AbstractPaintingRelevance "Abstrae la relevancia de un cuadro"
    (AnalyzePainting (painting ?painting))
=>
    (assert (PaintingRelevance(relevance (abstractNumber (send ?painting get-Relevance)))))
)

(defrule HeuristicMod::AbstractPreferencesHigh
    (NumPreferences (number ?n))
    (test (> ?n 1))
=>
    (assert (Preference (level High)))
)

(defrule HeuristicMod::AbstractPreferencesLow
    (NumPreferences (number ?n))
    (test (<= ?n 1))
=>
    (assert (Preference (level Low)))
)