(deftemplate MaxMinPaintingArea
(slot max (type INTEGER))
(slot min (type INTEGER)))

(defrule InitializeMaxMinPaintingArea "Inicializa MaxMinPaintingArea"
(initial-fact)
=>
(printout t "Ejecuto la regla de inicializar" crlf)
(assert (MaxMinPaintingArea(max 0) (min 999999)))
)

(defrule FindMaxMinPaintingArea "Esta regla determina el area maxima y minima de los cuadros"
(declare(salience 100))
(object (is-a Painting) (Width ?width) (Height ?height)) ?limit <-(MaxMinPaintingArea (max ?max) (min ?min))
=>
(bind ?area (* ?width ?height))
(if (< ?max ?area) then
	(modify ?limit (max ?area))
)
(if (> ?min ?area) then
	(modify ?limit (min ?area))
)
)


(defrule NormalizeComplexity "Esta regla normaliza la complejidad de los cuadros"
(declare(salience 50))
(object (is-a Painting) (Width ?width) (Height ?height) (Complexity ?complexity)) (MaxMinPaintingArea (max ?max) (min ?min))
=>
(bind ?area (* ?width ?height))
(bind ?complexity (/ (- ?area ?min) (- ?max ?min)))
)




