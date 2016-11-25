(defmodule PaintIntMod
(import HeuristicMod defclass ?ALL) 
(import HeuristicMod deffunction ?ALL)
(import HeuristicMod deftemplate ?ALL)
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

(defrule PaintIntModFinish
?f <- (Interest)
=>
(assert (FinalPaintingInterest (interest 50)))
(retract ?f)
)
