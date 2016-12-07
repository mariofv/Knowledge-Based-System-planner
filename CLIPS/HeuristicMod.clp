(defmodule HeuristicMod "Este modulo abstrae diferentes atributos de las clases."
    (import MAIN deftemplate ?ALL) 
    (import MAIN defclass ?ALL) 

    (export deftemplate ?ALL)
    (export deffunction abstractNumber)
    (export defclass ?ALL)
)

;///////////
;HECHOS ///
;/////////

(deftemplate HeuristicMod::PaintingRelevance "Este hecho contiene la relevanca abstraida de un cuadro."
    (slot relevance (type SYMBOL)
        (allowed-values Very_High High Medium Low Very_Low)
    )
)

(deftemplate HeuristicMod::Preference "Este hecho contiene la preferencia abstraida de un visitante por un cuadro."
    (slot level
        (type SYMBOL)
        (allowed-values Low High)
    )
)

(deftemplate HeuristicMod::NumPreferences "Este hecho contiene el numero de preferencias que hay
                                           en comun entre un visitante y un cuadro."
    (slot number
        (type INTEGER)
    )
)

;//////////////
;FUNCIONES ///
;////////////

(deffunction HeuristicMod::abstractNumber(?relevance) "Esta funcion abstrae el numero de preferencias que 
                                                       hay en comun entre un visitante y un cuadro." 
	(if (>= ?relevance 80)
    then 
        Very_High
	else 
        (if (>= ?relevance 60) 
        then 
            High
	     else
            (if  (>= ?relevance 40) 
            then 
                Medium
  			else 
                (if (>= ?relevance 20)
                then 
                    Low
				else 
                    Very_Low					
  			    )
    	    )
		 )
	)
)

(deffunction HeuristicMod::correctPreference(?actual ?painting) "Esta funcion nos dice si una preferencia de un visitante
                                                                 esta en un cuadro."
	(if (eq (class ?actual) Author) 
    then
		(if (eq (send ?actual get-Author+name) (send (send ?painting get-Created+by) get-Author+name)) 
            then 
				TRUE
		    else 
				FALSE
		)
	else
        (if (eq (class ?actual) Topic) 
        then
    		(if (eq (send ?actual get-Topic+name)(send (send ?painting get-Painting+topic) get-Topic+name))
            then 
    				TRUE
    		else 
    				FALSE
    		)
    	else 
           (if (eq (class ?actual) Style) 
           then
    		    (if (eq (send ?actual get-Style+name) (send (send ?painting get-Painting+style) get-Style+name)) 
                then 
    				TRUE
    		    else 
    				FALSE
    		    )
    	    else 
                (if (eq (class ?actual) Period)
                then
    	    	    (if (eq (send ?actual get-Period+name) (send (send ?painting get-Painted+in) get-Period+name))
                    then 
    	    			TRUE
    	    	    else 
    	    			FALSE
    	    	    )
    	        )
            )  
        )
    )
)

;/////////
;REGLAS//
;///////

(defrule HeuristicMod::HeuristicModComplete "Esta regla llama al modulo de calculo del interes."
    (PaintingRelevance)
    (Preference)
=>
    (focus PaintIntMod)
)

(defrule HeuristicMod::AllHeuristicModComplete1 "Esta regla llama al modulo de calculo del tiempo de observacion."
(declare (salience 0))
    (FinalPaintingInterest)
=>
    (focus ObsTimeMod)
)

(defrule HeuristicMod::AllHeuristicModComplete2 "Esta regla acaba la ejecucion del modulo."
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

(defrule HeuristicMod::AbstractPreferences "Esta regla determina cuantas preferencias tiene
                                            un visitante sobre un cuadro y crea los hechos convenientes"
    (AnalyzeVisitor (visitor ?visitor))
    (AnalyzePainting (painting ?painting))
=>
    (bind ?contador 0)
    (bind ?preferences (send ?visitor get-Preferences))
    (loop-for-count (?i 1 (length$ ?preferences)) do
	    (bind ?actual (nth$ ?i ?preferences))
	    (if (correctPreference ?actual ?painting)
        then
		    (bind ?contador(+ ?contador 1))
	    )
    )
    (assert (NumPreferences(number ?contador)))
)

(defrule HeuristicMod::AbstractPaintingRelevance "Esta regla abstrae la relevancia de un cuadro"
    (AnalyzePainting (painting ?painting))
=>
    (assert (PaintingRelevance(relevance (abstractNumber (send ?painting get-Relevance)))))
)

(defrule HeuristicMod::AbstractPreferencesHigh "Esta regla abstrae la preferencia por un cuadro alta."
    (NumPreferences (number ?n))
    (test (> ?n 1))
=>
    (assert (Preference (level High)))
)

(defrule HeuristicMod::AbstractPreferencesLow "Esta regla abstrae la preferencia por un cuadro baja."
    (NumPreferences (number ?n))
    (test (<= ?n 1))
=>
    (assert (Preference (level Low)))
)