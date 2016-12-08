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

;/////////////////////////
;REGLAS DE ABSTRACCIÓN //
;///////////////////////

(defrule ComplexityMod::FilterByArea
    (object (is-a Painting) (Width ?width) (Height ?height))
    (test (<= (* ?width ?height) 60000))
=>
    (assert (AreaFiltered (area (* ?width ?height))))
)

(defrule ComplexityMod::FindMinPaintingArea "Esta regla sirve para encontrar el area minima de todos los cuadros
                                             y crea el hecho conveniente."
(declare (salience -1))
    ;(object (is-a Painting) (Width ?width1) (Height ?height1))
    (AreaFiltered (area ?area1))
    (forall
        ;(object (is-a Painting) (Width ?width2) (Height ?height2))
        ;(test (<= (* ?width1 ?height1) (* ?width2 ?height2)))
        (AreaFiltered (area ?area2))
        (test (<= ?area1 ?area2))
    )
=>
    ;(assert (MinPaintingArea (min (* ?width1 ?height1))))
    (assert (MinPaintingArea (min ?area1)))
)

(defrule ComplexityMod::FindMaxPaintingArea "Esta regla sirve para encontrar el area maxima de todos los cuadros
                                             y crea el hecho conveniente."
(declare (salience -1))
    ;(object (is-a Painting) (Width ?width1) (Height ?height1))
    (AreaFiltered (area ?area1))
    (forall
        ;(object (is-a Painting) (Width ?width2) (Height ?height2))
        ;(test (>= (* ?width1 ?height1) (* ?width2 ?height2)))
        (AreaFiltered (area ?area2))
        (test (>= ?area1 ?area2))
    )
=>
    ;(assert (MaxPaintingArea (max (* ?width1 ?height1))))
    (assert (MaxPaintingArea (max ?area1)))
)

(defrule ComplexityMod::NormalizeComplexity "Esta regla normaliza la complejidad de los cuadros"
(declare (salience 1))
    ?painting <- (object (is-a Painting) (Width ?width) (Height ?height))
    (MaxPaintingArea (max ?max))
    (MinPaintingArea (min ?min))
=>
    (bind ?area (* ?width ?height))
    (printout t "Painting " ?painting " has complexity " (min 100 (*(/ (- ?area ?min) (- ?max ?min)) 100)) crlf)
    ;(send ?painting put-Complexity (*(/ (- ?area ?min) (- ?max ?min)) 100))
    (send ?painting put-Complexity (min 100 (*(/ (- ?area ?min) (- ?max ?min)) 100)))
)

(defrule ComplexityMod::EndMod "Esta regla sirve para acabar la ejecucion del modulo"
    (declare (salience 0))
    ?f1 <- (MaxPaintingArea)
    ?f2 <- (MinPaintingArea)
=>
    (retract ?f1)
    (retract ?f2)
    (return)
)