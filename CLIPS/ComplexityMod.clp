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

;/////////////////////////
;REGLAS DE ABSTRACCIÓN //
;///////////////////////

<<<<<<< HEAD
(defrule ComplexityMod::FindMinPaintingArea "Esta regla sirve para encontrar el area minima de todos los cuadros
                                             y crea el hecho conveniente."
    (not (exists (MinPaintingArea)))
=======
(defrule ComplexityMod::FindMinPaintingArea
(declare (salience -1))
>>>>>>> 6afb8901fe495b9225591f24972a889f71b6c77a
    (object (is-a Painting) (Width ?width1) (Height ?height1))
    (forall
        (object (is-a Painting) (Width ?width2) (Height ?height2))
        (test (<= (* ?width1 ?height1) (* ?width2 ?height2)))
    )
=>
    (assert (MinPaintingArea (min (* ?width1 ?height1))))
)

<<<<<<< HEAD
(defrule ComplexityMod::FindMaxPaintingArea "Esta regla sirve para encontrar el area maxima de todos los cuadros
                                             y crea el hecho conveniente."
    (not (exists (MaxPaintingArea)))
=======
(defrule ComplexityMod::FindMaxPaintingArea
(declare (salience -1))
>>>>>>> 6afb8901fe495b9225591f24972a889f71b6c77a
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

(defrule ComplexityMod::EndMod "Esta regla sirve para acabar la ejecucion del modulo"
    (declare (salience 0))
    ?f1 <- (MaxPaintingArea)
    ?f2 <- (MinPaintingArea)
=>
    (retract ?f1)
    (retract ?f2)
    (return)
)