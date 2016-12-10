(defmodule HeuristicMod "Este módulo ejecuta los módulos de los subproblemas de
                         asociación heurística y abstrae los elementos comunes"
    (import MAIN deftemplate AnalyzePainting AnalyzeVisitor FinalObservationTime FinalPaintingInterest)   

    (export deftemplate ?ALL)
    (export deffunction abstractNumber)
)

;//////////
;HECHOS///
;////////

(deftemplate HeuristicMod::PaintingRelevance "Este hecho contiene la relevancia abstraída de un cuadro."
    (slot relevance (type SYMBOL)
        (allowed-values Very_High High Medium Low Very_Low)
    )
)

(deftemplate HeuristicMod::Preference "Este hecho contiene la preferencia abstraída de un visitante por un cuadro."
    (slot level
        (type SYMBOL)
        (allowed-values Low High)
    )
)

(deftemplate HeuristicMod::NumPreferences "Este hecho contiene el número de preferencias que hay
                                           en común entre un visitante y un cuadro."
    (slot number
        (type INTEGER)
    )
)

;//////////////
;FUNCIONES ///
;////////////

(deffunction HeuristicMod::abstractNumber(?relevance) "Esta funcion abstrae el numero de preferencias que 
                                                       hay en común entre un visitante y un cuadro." 
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

(deffunction HeuristicMod::correctPreference(?actual ?painting) "Esta función nos dice si una preferencia de un visitante
                                                                 está en un cuadro."
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

(defrule HeuristicMod::HeuristicModComplete "Esta regla llama al módulo de cálculo del interés."
    (PaintingRelevance)
    (Preference)
=>
    (focus PaintIntMod)
)

(defrule HeuristicMod::AllHeuristicModComplete1 "Esta regla llama al módulo de cálculo del tiempo de observación."
(declare (salience 0))
    (FinalPaintingInterest)
=>
    (focus ObsTimeMod)
)

(defrule HeuristicMod::AllHeuristicModComplete2 "Esta regla acaba la ejecucion del módulo."
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

(defrule HeuristicMod::AbstractPreferences "Esta regla determina cuántas preferencias tiene
                                            un visitante sobre un cuadro"
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