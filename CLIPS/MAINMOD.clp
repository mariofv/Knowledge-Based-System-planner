(defmodule MAIN
    (export defclass ?ALL)
    (export deftemplate ?ALL)
)

(deftemplate AnalyzePainting
    (slot painting 
        (type INSTANCE)
        (allowed-classes Painting)
    )
)

(deftemplate AnalyzeVisitor
    (slot visitor 
        (type INSTANCE)
        (allowed-classes Visitor)
    )
)

(deftemplate PaintingFact
    (slot paintingFact 
        (type INSTANCE)
        (allowed-classes Painting)
    )
)

(deftemplate FinalObservationTime
    (slot time
        (type INTEGER)
    )
)

(deftemplate FinalPaintingInterest
    (slot interest
        (type INTEGER)
    )
)

(deftemplate YearFilters
    (slot firstYear
        (type INTEGER)
    )
    (slot lastYear
        (type INTEGER)
    )
)

(defrule InitializeMaxMinPaintingArea "Inicializa MaxMinPaintingArea"
(declare (salience 200))
=>
    (assert (YearFilters (firstYear -1) (lastYear 9999999)))
    ;(assert (MaxMinPaintingArea(max 0) (min 999999)))
    (focus ComplexityMod)
)

(defrule changePreguntasModul
(declare (salience 25))
=>
    (focus PreguntasMod)
)

(defrule StartRule
(declare (salience 1))
    (YearFilters (firstYear ?fy) (lastYear ?ly))
    ?painting <- (object (is-a Painting) (Year+of+creation ?year))
    
    (test (>= ?year ?fy))
    (test (<= ?year ?ly))
=>
    (assert (PaintingFact (paintingFact ?painting)))
)

;(defrule StartRule
;(declare (salience 0))
;=>
;    (bind ?paintings (find-all-instances ((?inst Painting)) TRUE))
;    (loop-for-count (?i 1 (length$ ?paintings)) do
;        (assert (PaintingFact (paintingFact (nth$ ?i ?paintings))))
;    )
;)

(defrule AnalyzePainting
(declare (salience 0))
    ?f <- (PaintingFact (paintingFact ?painting))
=>
    (assert (AnalyzeVisitor(visitor (nth$ 1 (find-all-instances ((?inst Visitor)) TRUE)))))
    (assert (AnalyzePainting (painting ?painting)))
    (focus HeuristicMod)
    (retract ?f)
)

(defrule FinishAnalyzing
(declare (salience 1))
    ?f1 <- (FinalObservationTime (time ?time))
    ?f2 <- (FinalPaintingInterest (interest ?interest))
    ?f3 <- (AnalyzePainting (painting ?painting))
    ?f4 <- (AnalyzeVisitor)
=>
    (printout t "El cuadro " (send ?painting get-Painting+name) " tiene un interes de " ?interest " y un tiempo de observacion de " ?time " segundos." crlf)
    (send ?painting put-Visitor+interest ?interest)
    (send ?painting put-Observation+time ?time)
    (retract ?f1)
    (retract ?f2)
    (retract ?f3)
    (retract ?f4)
)

(defrule FinishProgram
(declare (salience 10000))
    ?object <- (object (is-a Day) (Number ?number) (Asigned+paintings $?asignedPaintings) (Asigned+time ?asignedTime))
=>
    (printout t "Los cuadros a visitar en el dia " ?number " con tiempo asignado " ?asignedTime " son" crlf)
    (loop-for-count (?i 1 (length$ ?asignedPaintings) ) do
        (bind ?painting (nth$ ?i ?asignedPaintings))
        (printout t "Sala " (send (send ?painting get-Exhibited+in) get-Room+name) " El cuadro " (send ?painting get-Painting+name) " tiene un interes de " (send ?painting get-Visitor+interest) " y un tiempo de observacion de " (send ?painting get-Observation+time) " segundos." crlf)
    )
    (printout t crlf)
)

(defrule StartVisita
(declare (salience -1))
=>
    (printout t "Focuseando VisitaMod" crlf)
    (focus VisitaMod)
    (assert (Finish-Fact))
)

(defrule END
(declare (salience 9999))
    ?f1 <- (Finish-Fact)
    ?f2 <- (YearFilters)
=>
    (printout t "Acaba MAIN" crlf)
    (retract ?f1)
    (retract ?f2)
    (return)
)