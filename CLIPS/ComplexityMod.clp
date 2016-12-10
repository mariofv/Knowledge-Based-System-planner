(defmodule ComplexityMod "Este modulo calcula la complejidad de cada cuadro a partir de las áreas, escogiendo
el máxmimo, el mínimo y normalizando para que el resultado sea de 0 a 100"
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

(deftemplate ComplexityMod::AreaFiltered "Este hecho contiene áreas filtradas, es decir, áreas de cuadros existentes
que cumplen alguna condición."
    (slot area
        (type FLOAT)
    )
)

;///////////
;REGLAS ///
;/////////

(defrule ComplexityMod::FilterByArea "Para el cálculo y normalización de la complejidad de un cuadro los filtramos por área, en
concreto los que tiengan un área menor de 60000. De esta manera los cuadros que sean demasiado grandes no influirán, ya que si lo hicieran,
la mayoría de cuadros tendrían una complejidad muy baja."
(declare (salience 10))
    (object (is-a Painting) (Width ?width) (Height ?height))
    (test (<= (* ?width ?height) 60000))
=>
    (assert (AreaFiltered (area (* ?width ?height))))
)

(defrule ComplexityMod::FindMinPaintingArea "Esta regla sirve para encontrar el área mínima de todos los cuadros
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

(defrule ComplexityMod::FindMaxPaintingArea "Esta regla sirve para encontrar el area máxima de todos los cuadros
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
    (send ?painting put-Complexity (min 100 (*(/ (- ?area ?min) (- ?max ?min)) 100)))
)

(defrule ComplexityMod::FinishNormalizing "Una vez se acaba la normalización, se crea un hecho
indicando que se quiere acabar el módulo"
(declare (salience 4))
    (MaxPaintingArea (max ?max))
    (MinPaintingArea (min ?min))
=>
    (assert (FinishMod))
)

(defrule ComplexityMod::DeleteFilters "Antes de acabar con la ejecución del módulo, se eliminan
los hechos que contienen las áreas filtradas, ya que no se requiere guardarlos."
(declare (salience 10))
    (FinishMod)
    ?f <- (AreaFiltered)
=>
    (retract ?f)
)

(defrule ComplexityMod::EndMod "Esta regla sirve para acabar la ejecución del módulo"
    (declare (salience 9))
    ?f1 <- (MaxPaintingArea)
    ?f2 <- (MinPaintingArea)
    ?f3 <- (FinishMod)
=>
    (retract ?f1)
    (retract ?f2)
    (retract ?f3)
    (return)
)