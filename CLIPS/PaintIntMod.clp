(defmodule PaintIntMod
(import HeuristicMod defclass ?ALL) 
(import HeuristicMod deffunction ?ALL)
(import HeuristicMod deftemplate ?ALL)
)


(deffunction ComputePaintInt (?painting ?preferenceLevel ?baseNumber ?superiorLimit)
    (+ 
        ?baseNumber 
        (min 
            ?superiorLimit 
            (+ 
                (* 0.5 ?preferenceLevel)
                (* 0.5 (send ?painting get-Relevance))
            )
        )
    )
)

;Output modulo PaintInt
(deftemplate PaintIntMod::Interest
(slot level (type SYMBOL)
(allowed-values Very_Low Low High Very_High)))

(defrule PaintIntMod::FindInterestInPaintingVeryHigh "Comprueba si el interes de un visitante por un cuadro es muy alto"
(PaintingRelevance (relevance ?relevance)) (Preference (level ?preferenceLevel)) 
(or 
(test (eq ?relevance Very_High)) 
(and (test (eq ?relevance High)) (test (eq ?preferenceLevel High)))
)
=>
(assert (Interest (level Very_High)))
)

(defrule PaintIntMod::FindInterestInPaintingHigh "Comprueba si el interes de un visitante por un cuadro es alto"
(PaintingRelevance (relevance ?relevance)) (Preference (level ?preferenceLevel)) 
(or 
(and (test (eq ?relevance High)) (test(eq ?preferenceLevel Low)))
(and (test(eq ?relevance Medium)) (test(eq ?preferenceLevel High)))
)
=>
(assert (Interest (level High)))
)

(defrule PaintIntMod::FindInterestInPaintingLow "Comprueba si el interes de un visitante por un cuadro es bajo"
(PaintingRelevance (relevance ?relevance)) (Preference (level ?preferenceLevel)) 
(or
(and (test(eq ?relevance Medium)) (test(eq ?preferenceLevel Low)))
(and (test (eq ?relevance Low)) (test(eq ?preferenceLevel High)))
)
=>
(assert (Interest (level Low)))
)

(defrule PaintIntMod::FindInterestInPaintingVeryLow "Comprueba si el interes de un visitante por un cuadro es muy bajo"
(PaintingRelevance (relevance ?relevance)) (Preference (level ?preferenceLevel)) 
(or
(and (test (eq ?relevance Low)) (test(eq ?preferenceLevel Low)))
(test (eq ?relevance Very_Low))
)
=>
(assert (Interest (level Very_Low)))
)



(defrule PaintIntMod:::FinishModuleVH
(declare (salience 0))
?f <- (Interest (level Very_High))
(AnalyzePainting (painting ?painting))
(NumPreferences (number ?numPreferences))
=>
(assert (FinalPaintingInterest (interest (integer(ComputePaintInt ?painting ?numPreferences 75 25)))))
(retract ?f)
)

(defrule PaintIntMod:::FinishModuleH
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
