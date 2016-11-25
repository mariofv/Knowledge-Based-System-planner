;hECHOS
(deftemplate ObservationTime
(slot time (type SYMBOL)
(allowed-values High Medium Low)))

(deftemplate Complexity
(slot complexity (type SYMBOL))
(allowed-values High Medium Low))

;AQUI EMPIEZAN LAS FUNCIONES


(deffunction defineGroupSize(?size)
	(if (<= ?size 5) then Low
		else (if (<= ?size 10) then Medium
				else High
			  )
	)
)

(deffunction timeKnowledge(?knowledge)
	(if (or (eq ?knowledge Very_High) (eq ?knowledge High) (eq ?knowledge Medium)) then High
		else Medium
	)
)

(deffunction timeKnowledge2(?knowledge)
	(if (or (eq ?knowledge Very_High) (eq ?knowledge High)) then High
		else (if (eq ?knowledge Medium) then Medium
            else Low)
	)
)

(deffunction timeKnowledge3(?knowledge)
	(if (eq ?knowledge Very_High) then Medium
		else Low
	)
)

;Reglas de abstracción

(defrule AbstractComplexity
(object (is-a Painting) (Complexity ?complexity)
=>
(assert )
)

(defrule AbstractPaintingRelevance "Abstrae la relevancia de un cuadro"
(object (is-a Painting) (Relevance ?relevance))
=>
(assert (PaintingRelevance(relevance (abstractNumber ?relevance)))
))

(defrule AbstractKnowledge "Abstrae el conocimiento sobre un cuadro"
(object (is-a Visitor) (Knowledge ?knowledge))
=>
(assert (Knowledge(knowledge (abstractNumber ?knowledge)))
))

(defrule AbstractGroupSize "Abstrae el tamaño del grupo"
(object (is-a Visitor) (Number+of+People ?size))
=>
(assert (GroupSize(size (defineGroupSize ?size)))
))

(defrule AbstractPreferencesHigh ""
(NumPreferences (number ?n)) (test (> ?n 1))
=>
(assert (Preferences (level High)))
)

(defrule AbstractPreferencesLow ""
(NumPreferences (number ?n)) (test (<= ?n 1))
=>
(assert (Preferences (level Low)))
)
 
;AQUI EMPEIZAN LAS REGLAS DE ASOCIACION HEURÍSTICA
 
(defrule FirstFilter1 "Este filtro es el que te dice cuanto tiempo miras un cuadro dependiendo de su importancia y tu conocimiento"
(PaintingRelevance(relevance Very_High))
=>
(assert (ObservationTime (time High))))

(defrule FirstFilter2 "Este filtro es el que te dice cuanto tiempo miras un cuadro dependiendo de su importancia y tu conocimiento"
(PaintingRelevance(relevance High)) (Knowledge (knowledge ?knowledge))
=>
(assert (ObservationTime (time (timeKnowledge ?knowledge)))))

(defrule FirstFilter3 "Este filtro es el que te dice cuanto tiempo miras un cuadro dependiendo de su importancia y tu conocimiento"
(PaintingRelevance(relevance Medium)) (Knowledge (knowledge ?knowledge))
=>
(assert (ObservationTime (time (timeKnowledge2 ?knowledge)))))

(defrule FirstFilter4 "Este filtro es el que te dice cuanto tiempo miras un cuadro dependiendo de su importancia y tu conocimiento"
(PaintingRelevance(relevance Low)) (Knowledge (knowledge ?knowledge))
=>
(assert (ObservationTime (time (timeKnowledge3 ?knowledge)))))

(defrule FirstFilter5 "Este filtro es el que te dice cuanto tiempo miras un cuadro dependiendo de su importancia y tu conocimiento"
(PaintingRelevance(relevance Very_Low))
=>
(assert (ObservationTime (time Low))))

(defrule SecondFilter
(PaintingRelevance(relevance Very_Low))
=>
(assert (ObservationTime (time Low))))
