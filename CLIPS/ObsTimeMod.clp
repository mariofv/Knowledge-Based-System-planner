(defmodule ObsTimeMod 
    (import HeuristicMod deffunction ?ALL)
    (import HeuristicMod defclass ?ALL)
    (import HeuristicMod deftemplate ?ALL)
)

;HECHOS

;Output modulo ObsTime
(deftemplate ObsTimeMod::ObservationTime
    (slot time (type SYMBOL)
    (allowed-values High Medium Low)
    )
)

(deftemplate ObsTimeMod::Knowledge
    (slot knowledge
        (type SYMBOL)
        (allowed-values Very_High High Medium Low Very_Low)
    )
)

(deftemplate ObsTimeMod::GroupSize
    (slot size 
        (type SYMBOL)
        (allowed-values High Medium Low)
    )
)

(deftemplate ObsTimeMod::Complexity
    (slot complexity
        (type SYMBOL)
        (allowed-values High Medium Low)
    )
)

;AQUI EMPIEZAN LAS FUNCIONES

(deffunction ObsTimeMod::AbstractComplexity (?complexity)
    (if (>= ?complexity 66) then High
        else (if (>= ?complexity 33) then Medium
            else Low
        )
    )
)

(deffunction ObsTimeMod::defineGroupSize(?size)
	(if (<= ?size 5) then Low
		else (if (<= ?size 10) then Medium
				else High
        )
	)
)

(deffunction ObsTimeMod::timeKnowledge(?knowledge)
	(if (or (eq ?knowledge Very_High) (eq ?knowledge High) (eq ?knowledge Medium)) then High
		else Medium
	)
)

(deffunction ObsTimeMod::timeKnowledge2(?knowledge)
	(if (or (eq ?knowledge Very_High) (eq ?knowledge High)) then High
		else (if (eq ?knowledge Medium) then Medium
            else Low)
	)
)

(deffunction ObsTimeMod::timeKnowledge3(?knowledge)
	(if (eq ?knowledge Very_High) 
        then 
            Medium
		else 
            Low
	)
)

(deffunction ObsTimeMod::upgradeObsTime(?obsTime)
    (if (eq ?obsTime Low)
        then
            Medium
        else
            (if (eq ?obsTime Medium)
                then
                    High
                else
                    High
            )
    )
)


(deffunction ObsTimeMod::ComputeObTime (?numPreferences ?visitor ?painting ?baseNumber ?superiorLimit)
    (+ 
        ?baseNumber 
        (min 
            ?superiorLimit 
            (+ 
                (* 0.2 (send ?visitor get-Number+of+people))
                (* 0.2 (send ?visitor get-Knowledge))
                (* 0.2 (send ?painting get-Complexity))
                (* 0.2 (send ?painting get-Relevance))
                (* 10 ?numPreferences)
            )
        )
    )
)

;Reglas de abstracción

(defrule ObsTimeMod::AbstractKnowledgeAndGroupSize "Abstrae el conocimiento sobre un cuadro"
    (AnalyzeVisitor (visitor ?visitor))
=>
    (assert (Knowledge(knowledge (abstractNumber (send ?visitor get-Knowledge)))))
    (assert (GroupSize(size (defineGroupSize (send ?visitor get-Number+of+people)))))
)
 
(defrule ObsTimeMod::AbstractComplexity
    (AnalyzePainting (painting ?painting))
=>
    (assert (Complexity(complexity (fAbstractComplexity (send ?painting get-Complexity)))))
)

;AQUI EMPEIZAN LAS REGLAS DE ASOCIACION HEURÍSTICA
 
(defrule ObsTimeMod::FirstFilter1 "Este filtro es el que te dice cuanto tiempo miras un cuadro dependiendo de su importancia y tu conocimiento"
    (PaintingRelevance(relevance Very_High))
=>
    (assert (ObservationTime (time High)))
)

(defrule ObsTimeMod::FirstFilter2 "Este filtro es el que te dice cuanto tiempo miras un cuadro dependiendo de su importancia y tu conocimiento"
    (PaintingRelevance(relevance High))
    (Knowledge (knowledge ?knowledge))
=>
    (assert (ObservationTime (time (timeKnowledge ?knowledge))))
)

(defrule ObsTimeMod::FirstFilter3 "Este filtro es el que te dice cuanto tiempo miras un cuadro dependiendo de su importancia y tu conocimiento"
    (PaintingRelevance(relevance Medium))
    (Knowledge (knowledge ?knowledge))
=>
    (assert (ObservationTime (time (timeKnowledge2 ?knowledge))))
)

(defrule ObsTimeMod::FirstFilter4 "Este filtro es el que te dice cuanto tiempo miras un cuadro dependiendo de su importancia y tu conocimiento"
    (PaintingRelevance(relevance Low))
    (Knowledge (knowledge ?knowledge))
=>
    (assert (ObservationTime (time (timeKnowledge3 ?knowledge))))
)

(defrule ObsTimeMod::FirstFilter5 "Este filtro es el que te dice cuanto tiempo miras un cuadro dependiendo de su importancia y tu conocimiento"
    (PaintingRelevance(relevance Very_Low))
=>
    (assert (ObservationTime (time Low)))
)

(defrule ObsTimeMod::SecondFilter1
(declare (salience 0))
    ?f <- (ObservationTime(time ?t))
    (GroupSize (size ?size))
    (Complexity (complexity ?complexity))
    (Preference (level ?level))
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
    (assert (FinishMod))
)

(defrule ObsTimeMod::SecondFilter2
(declare (salience 1))
    ?f <- (ObservationTime(time Low))
    (GroupSize (size High))
    (Complexity (complexity High))
    (Preference (level High))
=>
    (modify ?f (time High))
    (assert (FinishMod))
)

(defrule ObsTimeMod::AuxRule
(declare (salience -1))
    (ObservationTime)
=>
    (assert (FinishMod))
)

(defrule ObsTimeMod::FinishModuleH
(declare (salience 10))
    ?fact <- (FinishMod)
    ?obsTime <- (ObservationTime(time High))
    (AnalyzeVisitor (visitor ?visitor))
    (AnalyzePainting (painting ?painting))
    (NumPreferences (number ?numPreferences))
    ?comp <- (Complexity)
    ?knowledge <- (Knowledge)
    ?gs <- (GroupSize)
=>
    (assert (FinalObservationTime (time (integer (ComputeObTime ?numPreferences ?visitor ?painting 120 44)))))
    (retract ?obsTime)
    (retract ?comp)
    (retract ?knowledge)
    (retract ?gs)
    (retract ?fact)
    (return)
)

(defrule ObsTimeMod::FinishModuleM
(declare (salience 10))
    ?fact <- (FinishMod)
    ?obsTime <- (ObservationTime(time Medium))
    (AnalyzeVisitor (visitor ?visitor))
    (AnalyzePainting (painting ?painting))
    (NumPreferences (number ?numPreferences))
    ?comp <- (Complexity)
    ?knowledge <- (Knowledge)
    ?gs <- (GroupSize)
=>
    (assert (FinalObservationTime (time (integer(ComputeObTime ?numPreferences ?visitor ?painting 75 44)))))
    (retract ?obsTime)
    (retract ?comp)
    (retract ?knowledge)
    (retract ?gs)
    (retract ?fact)
    (return)
)

(defrule ObsTimeMod::FinishModuleL
(declare (salience 10))
    ?fact <- (FinishMod)
    ?obsTime <- (ObservationTime(time Low))
    (AnalyzeVisitor (visitor ?visitor))
    (AnalyzePainting (painting ?painting))
    (NumPreferences (number ?numPreferences))
    ?comp <- (Complexity)
    ?knowledge <- (Knowledge)
    ?gs <- (GroupSize)
=>
    (assert (FinalObservationTime (time (integer(ComputeObTime ?numPreferences ?visitor ?painting 30 44)))))
    (retract ?obsTime)
    (retract ?comp)
    (retract ?knowledge)
    (retract ?gs)
    (retract ?fact)
    (return)
)