(defmodule ObsTimeMod "Este modulo calcula el tiempo de observacion de un cuadro."
    (import HeuristicMod deffunction ?ALL)
    (import HeuristicMod defclass ?ALL)
    (import HeuristicMod deftemplate ?ALL)
)

;///////////
;HECHOS ///
;/////////

(deftemplate ObsTimeMod::ObservationTime "Este hecho contiene el tiempo de observación abstraído de un cuadro."
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

(defrule ObsTimeMod::FirstFaseH "Tiene en cuenta la relevancia del cuadro y el conocimiento del visitante para calcular
                                el tiempo de observación alto"
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

(defrule ObsTimeMod::FirstPhaseM "Tiene en cuenta la relevancia del cuadro y el conocimiento del visitante para calcular
                                 el tiempo de observación medio"
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

(defrule ObsTimeMod::FirstPhaseL "Tiene en cuenta la relevancia del cuadro y el conocimiento del visitante para calcular
                                 el tiempo de observación bajo"
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

(defrule ObsTimeMod::SecondPhase1 "Se tienen en cuenta el resto de variables, en concreto si todas
                                    tienen valores muy altos el tiempo de observación será alto independientemente de
                                    de lo que era antes"
(declare (salience 2))
    ?f <- (ObservationTime(time Low))
    (GroupSize (size High))
    (Complexity (complexity High))
    (Preference (level High))
=>
    (modify ?f (time High))
    (assert (PhasesFinished))
)

(defrule ObsTimeMod::SecondPhase2 "Se tienen en cuenta el resto de variables para determinar si se tiene que aumentar
                                    el nivel cualitativo del tiempo de observación."
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

(defrule ObsTimeMod::SecondPhase3 "Esta es una regla auxiliar en caso de que las dos reglas anteriores
                                    no se ejecuten, ya que para acabar la asociación heurística
                                    es necesario el hecho PhasesFinished"
(declare (salience 0))
    (ObservationTime)
=>
    (assert (PhasesFinished))
)

;//////////////////////////
;REGLAS DE REFINAMIENTO //
;////////////////////////

(defrule ObsTimeMod::PreFinishModuleH "Se calcula el valor cuantitativo del tiempo de observación alto"
(declare (salience 10))
    (PhasesFinished)
    (ObservationTime(time High))
    (AnalyzeVisitor (visitor ?visitor))
    (AnalyzePainting (painting ?painting))
    (NumPreferences (number ?numPreferences))
=>
    (assert (FinalObservationTime (time (integer (ComputeObTime ?numPreferences ?visitor ?painting 120 44)))))
)

(defrule ObsTimeMod::PreFinishModuleM "Se calcula el valor cuantitativo del tiempo de observación medio"
(declare (salience 10))
    (PhasesFinished)
    (ObservationTime(time Medium))
    (AnalyzeVisitor (visitor ?visitor))
    (AnalyzePainting (painting ?painting))
    (NumPreferences (number ?numPreferences))
=>
    (assert (FinalObservationTime (time (integer(ComputeObTime ?numPreferences ?visitor ?painting 75 44)))))
)

(defrule ObsTimeMod::PreFinishModuleL "Se calcula el valor cuantitativo del tiempo de observación bajo"
(declare (salience 10))
    (PhasesFinished)
    (ObservationTime(time Low))
    (AnalyzeVisitor (visitor ?visitor))
    (AnalyzePainting (painting ?painting))
    (NumPreferences (number ?numPreferences))
=>
    (assert (FinalObservationTime (time (integer(ComputeObTime ?numPreferences ?visitor ?painting 30 44)))))
)

(defrule ObsTimeMod::GroupWithoutChildren1 "Se tiene en cuenta si hay niños en el grupo, ya que
                                            el tiempo de observación será menor"
(declare (salience 21))
    ?f <- (FinalObservationTime (time ?t))
    (object (is-a Visitor) (Children TRUE))
=>
    (modify ?f (time (integer (* 0.8 ?t))))
    (assert (FinishMod))
)

(defrule ObsTimeMod::GroupWithChildren2 "Regla auxiliar en caso de que no haya niños, ya que para acabar el módulo
                                         se necesita el hecho FinishMod"
(declare (salience 20))
    (FinalObservationTime (time ?t))
=>
    (assert (FinishMod))  
)

(defrule ObsTimeMod::FinishModule "Se eliminan todos los hechos creados por el módulo 
                                   (excepto el FinalObservationTime) y se acaba su ejecución"
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