;hECHOS
(deftemplate ObservationTime
(slot time (type SYMBOL)
(allowed-values High Medium Low)))

(deftemplate Complexity
(slot complexity (type SYMBOL)
(allowed-values High Medium Low)))

;AQUI EMPIEZAN LAS FUNCIONES


(deffunction fAbstractComplexity (?complexity)
    (if (>= ?complexity 66) then HIGH
        else (if (>= ?complexity 33) then Medium
            else Low
        )
    )
)

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

(deffunction upgradeObsTime(?obsTime)
    (if (eq ?obsTime Low) then Medium
        else (if (eq ?obsTime Medium) then High
            else High
        )
    )
)

;Reglas de abstracción

(defrule AbstractComplexity
(AnalyzePainting)
(object (is-a Painting) (Complexity ?complexity))
=>
(assert (Complexity(complexity (fAbstractComplexity ?complexity))))
)



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

;AQUI EMPEIZAN LAS REGLAS DE ASOCIACION HEURÍSTICA
 
(defrule FirstFilter1 "Este filtro es el que te dice cuanto tiempo miras un cuadro dependiendo de su importancia y tu conocimiento"
(PaintingRelevance(relevance Very_High))
=>
(assert (ObservationTime (time High)))
(assert (First))
)

(defrule FirstFilter2 "Este filtro es el que te dice cuanto tiempo miras un cuadro dependiendo de su importancia y tu conocimiento"
(PaintingRelevance(relevance High))
(Knowledge (knowledge ?knowledge))
=>
(assert (ObservationTime (time (timeKnowledge ?knowledge))))
)

(defrule FirstFilter3 "Este filtro es el que te dice cuanto tiempo miras un cuadro dependiendo de su importancia y tu conocimiento"
(PaintingRelevance(relevance Medium))
(Knowledge (knowledge ?knowledge))
=>
(assert (ObservationTime (time (timeKnowledge2 ?knowledge))))
)

(defrule FirstFilter4 "Este filtro es el que te dice cuanto tiempo miras un cuadro dependiendo de su importancia y tu conocimiento"
(PaintingRelevance(relevance Low))
(Knowledge (knowledge ?knowledge))
=>
(assert (ObservationTime (time (timeKnowledge3 ?knowledge))))
)

(defrule FirstFilter5 "Este filtro es el que te dice cuanto tiempo miras un cuadro dependiendo de su importancia y tu conocimiento"
(PaintingRelevance(relevance Very_Low))
=>
(assert (ObservationTime (time Low)))
)

(defrule SecondFilter1
?f <- (ObservationTime(time ?t))
(GroupSize (size ?size))
(Complexity (complexity ?complexity))
(Preference (level ?level))
(not (and
    (test (eq ?t Low))
    (test (eq ?size High))
    (test (eq ?complexity High))
    (test (eq ?level High))
))
(or
    (test (eq ?size High))
    (test (eq ?complexity High))
    (test (eq ?level High))
    (and
        (test (eq ?size Medium))
        (or
            (test (eq ?complexity Medium))
            (test (eq ?level Medium))
        )
    )
    (and
        (test (eq ?complexity Medium))
        (test (eq ?level Medium))
    )
)
=>
(modify ?f (time (upgradeObsTime ?t)))
)

(defrule SecondFilter2
?f <- (ObservationTime(time Low))
(GroupSize (size High))
(Complexity (complexity High))
(Preference (level High))
=>
(modify ?f (time High))
)