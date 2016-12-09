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

(deftemplate NationalityFilters
    (slot nationality
        (type INSTANCE)
        (allowed-classes Nationality)
    )
)

(defrule InitializeMaxMinPaintingArea "Inicializa MaxMinPaintingArea"
(declare (salience 200))
=>
    (focus ComplexityMod)
)

(defrule changePreguntasModul
(declare (salience 25))
=>
    (focus PreguntasMod)
)

(defrule AnalyzePainting
(declare (salience 0))
    (YearFilters (firstYear ?fy) (lastYear ?ly))
    (NationalityFilters (nationality ?nationality))
    ?painting <- (object (is-a Painting) (Year+of+creation ?year) (Created+By ?author))
    ?visitor <- (object (is-a Visitor))
    (test (>= ?year ?fy))
    (test (<= ?year ?ly))
    (test (eq ?nationality (send ?author get-Nationality)))
=>
    (assert (AnalyzeVisitor (visitor ?visitor)))
    (assert (AnalyzePainting (painting ?painting)))
    (focus HeuristicMod)
)

(defrule StartVisita
(declare (salience -1))
=>
    (printout t "Focuseando VisitaMod" crlf)
    (focus VisitaMod)
    (assert (Finish-Fact))
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
    (loop-for-count (?i 1 (length$ ?asignedPaintings)) do
        (bind ?painting (nth$ ?i ?asignedPaintings))
        (printout t "Sala " (send (send ?painting get-Exhibited+in) get-Room+name) " El cuadro " (send ?painting get-Painting+name) " tiene un interes de " (send ?painting get-Visitor+interest) " y un tiempo de observacion de " (send ?painting get-Observation+time) " segundos." crlf)
    )
    (printout t crlf)
)

(defrule END
(declare (salience 9999))
    ?f1 <- (Finish-Fact)
    ?f2 <- (YearFilters)
=>
    (printout t "Acaba MAIN" crlf)
    (retract ?f1)
    (retract ?f2)
)