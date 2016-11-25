(deftemplate MaxMinPaintingArea
(slot max (type INTEGER))
(slot min (type INTEGER)))

(defrule FindMaxMinPaintingArea "Esta regla determina el area maxima y minima de los cuadros"
(salience 100)
(object (is-a Painting) (Width ?width) (Height ?height)) ?limit <-(MaximumPaintingArea (max ?max) (min ?min))
=>
(bind ?area (* ?width ?height))
(if ((< ?max ?area) 
	(modify ?limit (max ?area)
)
(if ((> ?min ?area) 
	(modify ?limit (min ?area)
)
)


(defrule NormalizeComplexity "Esta regla normaliza la complejidad de los cuadros"
(salience 50)
(object (is-a Painting) (Width ?width) (Height ?height) (Complexity ?complexity) (MaximumPaintingArea (max ?max) (min ?min))
=>
(bind ?area (* ?width ?height))
(bind ?complexity (/ (- ?area ?min) (- ?max ?min)))
)




