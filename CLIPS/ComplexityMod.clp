(defmodule ComplexityMod
    (import MAIN defclass Painting)
)

(deftemplate ComplexityMod::MaxPaintingArea
    (slot max 
        (type INTEGER)
    )
)

(deftemplate ComplexityMod::MinPaintingArea
    (slot min
        (type INTEGER)
    )
)

;(deftemplate MaxMinPaintingArea
;    (slot max 
;        (type INTEGER)
;    )
;    (slot min
;        (type INTEGER)
;    )
;)

;(defrule FindMaxMinPaintingArea "Esta regla determina el area maxima y minima de los cuadros"
;(declare(salience 100))
;    (object (is-a Painting) (Width ?width) (Height ?height)) 
;    ?limit <-(MaxMinPaintingArea (max ?max) (min ?min))
;=>
;    (bind ?area (* ?width ?height))
;    (if (< ?max ?area) then
;	    (modify ?limit (max ?area))
;    else
;        (if (> ?min ?area) then
;	        (modify ?limit (min ?area))
;        )
;    )
;)


;(defrule NormalizeComplexity "Esta regla normaliza la complejidad de los cuadros"
;(declare(salience 50))
;    ?painting <- (object (is-a Painting) (Width ?width) (Height ?height))
;    (MaxMinPaintingArea (max ?max) (min ?min))
;=>
;    (bind ?area (* ?width ?height))
;    (printout t "Painting " ?painting " has complexity " (*(/ (- ?area ?min) (- ?max ?min)) 100) crlf)
;    (send ?painting put-Complexity (*(/ (- ?area ?min) (- ?max ?min)) 100))
;)

(defrule ComplexityMod::FindMinPaintingArea
    (not (exists (MinPaintingArea)))
    (object (is-a Painting) (Width ?width1) (Height ?height1))
    (forall
        (object (is-a Painting) (Width ?width2) (Height ?height2))
        (test (<= (* ?width1 ?height1) (* ?width2 ?height2)))
    )
=>
    (assert (MinPaintingArea (min (* ?width1 ?height1))))
)

(defrule ComplexityMod::FindMaxPaintingArea
    (not (exists (MaxPaintingArea)))
    (object (is-a Painting) (Width ?width1) (Height ?height1))
    (forall
        (object (is-a Painting) (Width ?width2) (Height ?height2))
        (test (>= (* ?width1 ?height1) (* ?width2 ?height2)))
    )
=>
    (assert (MaxPaintingArea (max (* ?width1 ?height1))))
)

(defrule ComplexityMod::NormalizeComplexity "Esta regla normaliza la complejidad de los cuadros"
(declare (salience 1))
    ?painting <- (object (is-a Painting) (Width ?width) (Height ?height))
    (MaxPaintingArea (max ?max))
    (MinPaintingArea (min ?min))
=>
    (bind ?area (* ?width ?height))
    (printout t "Painting " ?painting " has complexity " (*(/ (- ?area ?min) (- ?max ?min)) 100) crlf)
    (send ?painting put-Complexity (*(/ (- ?area ?min) (- ?max ?min)) 100))
)

(defrule ComplexityMod::EndMod
    (declare (salience 0))
    ?f1 <- (MaxPaintingArea)
    ?f2 <- (MinPaintingArea)
=>
    (retract ?f1)
    (retract ?f2)
    (return)
)