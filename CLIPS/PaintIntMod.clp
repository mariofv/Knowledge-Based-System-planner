(defmodule PaintIntMod "Este módulo calcula el interés del visitante para un cuadro"
    (import HeuristicMod deftemplate AnalyzePainting FinalPaintingInterest PaintingRelevance Preference NumPreferences)
)

;///////////
;HECHOS ///
;/////////

(deftemplate PaintIntMod::Interest ""
    (slot level
        (type SYMBOL)
        (allowed-values Very_Low Low High Very_High)
    )
)

;//////////////
;FUNCIONES ///
;////////////

(deffunction ComputePaintInt (?painting ?preferenceLevel ?baseNumber ?superiorLimit) "Esta función sirve
para refinar el interés teniendo en cuenta el valor cuantitativo de las variables usadas para calcularlo"
    (+ 
        ?baseNumber 
        (min 
            ?superiorLimit 
            (+ 
                (* 4 ?preferenceLevel)
                (* 0.2 (send ?painting get-Relevance))
            )
        )
    )
)

(defrule PaintIntMod::FindInterestInPaintingVeryHigh "Comprueba si el interes de un visitante por un cuadro es muy alto"
    (PaintingRelevance (relevance ?relevance)) 
    (Preference (level ?preferenceLevel)) 
    (or 
        (test (eq ?relevance Very_High)) 
        (and 
            (test (eq ?relevance High))
            (test (eq ?preferenceLevel High))
        )
    )
=>
    (assert (Interest (level Very_High)))
)


(defrule PaintIntMod::FindInterestInPaintingHigh "Comprueba si el interes de un visitante por un cuadro es alto"
    (PaintingRelevance (relevance ?relevance))
    (Preference (level ?preferenceLevel)) 
    (or 
        (and 
            (test (eq ?relevance High))
            (test(eq ?preferenceLevel Low))
        )
        (and 
            (test(eq ?relevance Medium))
            (test(eq ?preferenceLevel High))
        )
    )
=>
    (assert (Interest (level High)))
)

(defrule PaintIntMod::FindInterestInPaintingLow "Comprueba si el interes de un visitante por un cuadro es bajo"
    (PaintingRelevance (relevance ?relevance))
    (Preference (level ?preferenceLevel)) 
    (or
        (and 
            (test(eq ?relevance Medium))
            (test(eq ?preferenceLevel Low))
        )
        (and 
            (test (eq ?relevance Low))
            (test(eq ?preferenceLevel High))
        )
    )
=>
    (assert (Interest (level Low)))
)

(defrule PaintIntMod::FindInterestInPaintingVeryLow "Comprueba si el interes de un visitante por un cuadro es muy bajo"
    (PaintingRelevance (relevance ?relevance))
    (Preference (level ?preferenceLevel)) 
    (or
        (and
            (test (eq ?relevance Low))
            (test(eq ?preferenceLevel Low))
        )
        (test (eq ?relevance Very_Low))
    )
=>
    (assert (Interest (level Very_Low)))
)



(defrule PaintIntMod::FinishModuleVH
(declare (salience 0))
    ?f <- (Interest (level Very_High))
    (AnalyzePainting (painting ?painting))
    (NumPreferences (number ?numPreferences))
=>
    (assert (FinalPaintingInterest (interest (integer(ComputePaintInt ?painting ?numPreferences 75 25)))))
    (retract ?f)
)

(defrule PaintIntMod::FinishModuleH
(declare (salience 0))
    ?f <- (Interest (level High))
    (AnalyzePainting (painting ?painting))
    (NumPreferences (number ?numPreferences))
=>
    (assert (FinalPaintingInterest (interest (integer(ComputePaintInt ?painting ?numPreferences 50 24)))))
    (retract ?f)
)

(defrule PaintIntMod::FinishModuleL
(declare (salience 0))
    ?f <- (Interest (level Low))
    (AnalyzePainting (painting ?painting))
    (NumPreferences (number ?numPreferences))
=>
    (assert (FinalPaintingInterest (interest (integer(ComputePaintInt ?painting ?numPreferences 25 24)))))
    (retract ?f)
)

(defrule PaintIntMod::FinishModuleVL
(declare (salience 0))
    ?f <- (Interest (level Very_Low))
    (AnalyzePainting (painting ?painting))
    (NumPreferences (number ?numPreferences))
=>
    (assert (FinalPaintingInterest (interest (integer(ComputePaintInt ?painting ?numPreferences 0 24)))))
    (retract ?f)
)
