(defmodule ObsTimeMod "Este modulo calcula el tiempo de observacion de un cuadro."
    (import HeuristicMod deffunction ?ALL)
    (import HeuristicMod defclass ?ALL)
    (import HeuristicMod deftemplate ?ALL)
)

;///////////
;HECHOS ///
;/////////

(deftemplate ObsTimeMod::ObservationTime "Este hecho contiene el tiempo de observacion abstraído de un cuadro."
    (slot time 
        (type SYMBOL)
        (allowed-values High Medium Low)
    )
)

(deftemplate ObsTimeMod::Knowledge "Este hecho contiene el conocimiento abstraído del visitante."
    (slot knowledge
        (type SYMBOL)
        (allowed-values Very_High High Medium Low Very_Low)
    )
)

(deftemplate ObsTimeMod::GroupSize "Este hecho contiene el tamaño de un grupo abstraído del visitante."
    (slot size 
        (type SYMBOL)
        (allowed-values High Medium Low)
    )
)

(deftemplate ObsTimeMod::Complexity "Este hecho contiene la complejidad abstraída de un cuadro."
    (slot complexity
        (type SYMBOL)
        (allowed-values High Medium Low)
    )
)

;//////////////
;FUNCIONES ///
;////////////


(deffunction ObsTimeMod::AbstractComplexity (?complexity) "Esta función complementa la regla de abstracción AbstractComplexity"
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

(deffunction ObsTimeMod::defineGroupSize(?size) "Esta función complementa la regla de abstracción AbstractKnowledgeAndGroupSize"
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

(deffunction ObsTimeMod::upgradeObsTime(?obsTime) "Esta función sube el nivel cualitativo del tiempo de observación abstraído
                                                    es decir, de Low a Medium o de Medium a High."
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
"Esta función sirve para refinar el tiempo de observación teniendo en cuenta el valor cuantitativo de las variables
usadas para calcularlo"
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

;/////////////////////////
;REGLAS DE ABSTRACCIÓN //
;///////////////////////

(defrule ObsTimeMod::AbstractKnowledgeAndGroupSize "Abstrae el conocimiento sobre un cuadro"
    (AnalyzeVisitor (visitor ?visitor))
=>
    (assert (Knowledge(knowledge (abstractNumber (send ?visitor get-Knowledge)))))
    (assert (GroupSize(size (defineGroupSize (send ?visitor get-Number+of+people)))))
)
 
(defrule ObsTimeMod::AbstractComplexity "Abstrae ls complejidad de un cuadro"
    (AnalyzePainting (painting ?painting))
=>
    (assert (Complexity(complexity (AbstractComplexity (send ?painting get-Complexity)))))
)

;///////////////////////////////////
;REGLAS DE ASOCIACIÓN HEURÍSTICA //
;/////////////////////////////////

(defrule ObsTimeMod::FirstFaseH "Tiene en cuenta la relevancia de un cuadro y el conocimiento "
    (PaintingRelevance (relevance ?relevance))
    (Knowledge (knowledge ?knowledge))
    (or
        (test (eq ?relevance Very_High))
        (and
            (test (eq ?relevance High))
            (or 
                (test (eq ?knowledge Very_High))
                (test (eq ?knowledge High))
                (test (eq ?knowledge Medium))
            )
        )
        (and
            (test (eq ?relevance Medium))
            (or
                (test (eq ?knowledge Very_High))
                (test (eq ?knowledge High))
            )
        )
    )
=>
    (assert (ObservationTime (time High)))
)

(defrule ObsTimeMod::FirstPhaseM
    (PaintingRelevance (relevance ?relevance))
    (Knowledge (knowledge ?knowledge))
    (or
        (and
            (test (eq ?relevance High))
            (or
                (test (eq ?knowledge Low))
                (test (eq ?knowledge Very_Low))
            )
        )
        (and
            (test (eq ?relevance Medium))
            (test (eq ?knowledge Medium))
        )
        (and
            (test (eq ?relevance Low))
            (test (eq ?knowledge Very_High))
        )
    )
=>
    (assert (ObservationTime (time Medium)))
)

(defrule ObsTimeMod::FirstPhaseL
    (PaintingRelevance (relevance ?relevance))
    (Knowledge (knowledge ?knowledge))
    (or
        (test (eq ?relevance Very_Low))
        (and
            (test (eq ?relevance Medium))
            (or
                (test (eq ?knowledge Low))
                (test (eq ?knowledge Very_Low))
            )
        )
        (and
            (test (eq ?relevance Low))
            (or
                (test (eq ?knowledge High))
                (test (eq ?knowledge Medium))
                (test (eq ?knowledge Low))
                (test (eq ?knowledge Very_Low))
            )
        )
    )
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