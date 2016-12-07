(defmodule ObsTimeMod 
    (import HeuristicMod deffunction ?ALL)
    (import HeuristicMod defclass ?ALL)
    (import HeuristicMod deftemplate ?ALL)
)

;HECHOS

;Output modulo ObsTime
(deftemplate ObsTimeMod::ObservationTime
    (slot time 
        (type SYMBOL)
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
    (if (>= ?complexity 66) 
        then 
            High
        else 
            (if (>= ?complexity 33)
                then
                    Medium
                else
                    Low
            )
    )
)

(deffunction ObsTimeMod::defineGroupSize(?size)
	(if (<= ?size 5)
            then
                Low
		else 
            (if (<= ?size 10)
                then
                    Medium
				else
                    High
            )
	)
)

(deffunction ObsTimeMod::timeKnowledge1(?knowledge)
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
    (assert (Complexity(complexity (AbstractComplexity (send ?painting get-Complexity)))))
)

;AQUI EMPEIZAN LAS REGLAS DE ASOCIACION HEURÍSTICA
 
(defrule ObsTimeMod::FirstPhase1
    (PaintingRelevance(relevance Very_High))
=>
    (assert (ObservationTime (time High)))
)

(defrule ObsTimeMod::FirstPhase2
    (PaintingRelevance(relevance High))
    (Knowledge (knowledge ?knowledge))
=>
    (assert (ObservationTime (time (timeKnowledge1 ?knowledge))))
)

(defrule ObsTimeMod::FirstPhase3
    (PaintingRelevance(relevance Medium))
    (Knowledge (knowledge ?knowledge))
=>
    (assert (ObservationTime (time (timeKnowledge2 ?knowledge))))
)

(defrule ObsTimeMod::FirstPhase4
    (PaintingRelevance(relevance Low))
    (Knowledge (knowledge ?knowledge))
=>
    (assert (ObservationTime (time (timeKnowledge3 ?knowledge))))
)

(defrule ObsTimeMod::FirstPhase5
    (PaintingRelevance(relevance Very_Low))
=>
    (assert (ObservationTime (time Low)))
)

(defrule ObsTimeMod::SecondPhase1
(declare (salience 2))
    ?f <- (ObservationTime(time Low))
    (GroupSize (size High))
    (Complexity (complexity High))
    (Preference (level High))
=>
    (modify ?f (time High))
    (assert (PhasesFinished))
)

(defrule ObsTimeMod::SecondPhase2
(declare (salience 1))
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
    (assert (PhasesFinished))
)

(defrule ObsTimeMod::SecondPhase3
(declare (salience 0))
    (ObservationTime)
=>
    (assert (PhasesFinished))
)

(defrule ObsTimeMod::PreFinishModuleH
(declare (salience 10))
    (PhasesFinished)
    (ObservationTime(time High))
    (AnalyzeVisitor (visitor ?visitor))
    (AnalyzePainting (painting ?painting))
    (NumPreferences (number ?numPreferences))
=>
    (assert (FinalObservationTime (time (integer (ComputeObTime ?numPreferences ?visitor ?painting 120 44)))))

)

(defrule ObsTimeMod::PreFinishModuleM
(declare (salience 10))
    (PhasesFinished)
    (ObservationTime(time Medium))
    (AnalyzeVisitor (visitor ?visitor))
    (AnalyzePainting (painting ?painting))
    (NumPreferences (number ?numPreferences))
=>
    (assert (FinalObservationTime (time (integer(ComputeObTime ?numPreferences ?visitor ?painting 75 44)))))
)

(defrule ObsTimeMod::PreFinishModuleL
(declare (salience 10))
    (PhasesFinished)
    (ObservationTime(time Low))
    (AnalyzeVisitor (visitor ?visitor))
    (AnalyzePainting (painting ?painting))
    (NumPreferences (number ?numPreferences))
=>
    (assert (FinalObservationTime (time (integer(ComputeObTime ?numPreferences ?visitor ?painting 30 44)))))
)

(defrule ObsTimeMod::GroupWithoutChildren1
(declare (salience 21))
    ?f <- (FinalObservationTime (time ?t))
    (object (is-a Visitor) (Children TRUE))
=>
    (modify ?f (time (integer (* 0.8 ?t))))
    (assert (FinishMod))
)

(defrule ObsTimeMod::GroupWithChildren2
(declare (salience 20))
    (FinalObservationTime (time ?t))
=>
    (assert (FinishMod))  
)

(defrule ObsTimeMod::FinishModule
(declare (salience 30))
    ?fact <- (FinishMod)
    ?phase <- (PhasesFinished)
    ?obsTime <- (ObservationTime)
    ?comp <- (Complexity)
    ?knowledge <- (Knowledge)
    ?groupSize <- (GroupSize)
=>
    (retract ?phase)
    (retract ?obsTime)
    (retract ?comp)
    (retract ?knowledge)
    (retract ?groupSize)
    (retract ?fact)
    (return)
)