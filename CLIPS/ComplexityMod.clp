(defmodule ComplexityMod "Este modulo calcula la complejidad de cada cuadro"
    (import MAIN defclass Painting)
)

;///////////
;HECHOS ///
;/////////

(deftemplate ComplexityMod::MaxPaintingArea "Este hecho sirve para guardar el area maxima de todos los cuadros"
    (slot max 
        (type INTEGER)
    )
)

(deftemplate ComplexityMod::MinPaintingArea "Este hecho sirve para guardar el area minima de todos los cuadros"
    (slot min
        (type INTEGER)
    )
)

(deftemplate ComplexityMod::AreaFiltered
    (slot area
        (type FLOAT)
    )
)

;///////////
;REGLAS ///
;/////////

(defrule ComplexityMod::FilterByArea
(declare (salience 10))
    (object (is-a Painting) (Width ?width) (Height ?height))
    (test (<= (* ?width ?height) 60000))
=>
    (assert (AreaFiltered (area (* ?width ?height))))
)

(defrule ComplexityMod::FindMinPaintingArea "Esta regla sirve para encontrar el area minima de todos los cuadros
                                             y crea el hecho conveniente."
(declare (salience 5))
    (AreaFiltered (area ?area1))
    (forall
        (AreaFiltered (area ?area2))
        (test (<= ?area1 ?area2))
    )
=>
    (assert (MinPaintingArea (min ?area1)))
)

(defrule ComplexityMod::FindMaxPaintingArea "Esta regla sirve para encontrar el area maxima de todos los cuadros
                                             y crea el hecho conveniente."
(declare (salience 5))
    (AreaFiltered (area ?area1))
    (forall
        (AreaFiltered (area ?area2))
        (test (>= ?area1 ?area2))
    )
=>
    (assert (MaxPaintingArea (max ?area1)))
)

(defrule ComplexityMod::NormalizeComplexity "Esta regla normaliza la complejidad de los cuadros"
(declare (salience 5))
    ?painting <- (object (is-a Painting) (Width ?width) (Height ?height))
    (MaxPaintingArea (max ?max))
    (MinPaintingArea (min ?min))
=>
    (bind ?area (* ?width ?height))
    (printout t "Painting " ?painting " has complexity " (min 100 (*(/ (- ?area ?min) (- ?max ?min)) 100)) crlf)
    (send ?painting put-Complexity (min 100 (*(/ (- ?area ?min) (- ?max ?min)) 100)))
)

(defrule ComplexityMod::FinishNormalizing
(declare (salience 4))
    (MaxPaintingArea (max ?max))
    (MinPaintingArea (min ?min))
=>
    (assert (FinishNormalizing))
)

(defrule ComplexityMod::DeleteFilters
(declare (salience 10))
    (FinishNormalizing)
    ?f <- (AreaFiltered)
=>
    (retract ?f)
)

(defrule ComplexityMod::EndMod "Esta regla sirve para acabar la ejecución del modulo"
    (declare (salience 9))
    ?f1 <- (MaxPaintingArea)
    ?f2 <- (MinPaintingArea)
    ?f3 <- (FinishNormalizing)
=>
    (retract ?f1)
    (retract ?f2)
    (retract ?f3)
    (return)
)