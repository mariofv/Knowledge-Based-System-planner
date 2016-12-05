(defmodule MAIN
    (export defclass ?ALL)
    (export deftemplate ?ALL)
)

(defclass Day
    (is-a USER)
    (role concrete)
    (slot number
        (type INTEGER)
    )
    (slot asignedTime
        (type INTEGER)
        (default 0)
    )
    (multislot asignedPaintings
        (type INSTANCE)
        (allowed-classes Painting)
    )
)

(deftemplate AnalyzePainting
(slot painting (type INSTANCE) (allowed-classes Painting)))

(deftemplate AnalyzeVisitor
(slot visitor (type INSTANCE) (allowed-classes Visitor)))

(deftemplate PaintingFact
(slot paintingFact (type INSTANCE) (allowed-classes Painting)))

(deftemplate MaxMinPaintingArea
(slot max (type INTEGER))
(slot min (type INTEGER)))

(deftemplate FinalObservationTime
(slot time (type INTEGER)))

(deftemplate FinalPaintingInterest
(slot interest (type INTEGER)))

(defrule FindMaxMinPaintingArea "Esta regla determina el area maxima y minima de los cuadros"
(declare(salience 100))
(object (is-a Painting) (Width ?width) (Height ?height)) ?limit <-(MaxMinPaintingArea (max ?max) (min ?min))
=>
(bind ?area (* ?width ?height))
    (if (< ?max ?area) then
	    (modify ?limit (max ?area))
    else
        (if (> ?min ?area) then
	        (modify ?limit (min ?area))
        )
    )
)

(defrule NormalizeComplexity "Esta regla normaliza la complejidad de los cuadros"
(declare(salience 50))
    ?painting<-(object (is-a Painting) (Width ?width) (Height ?height))
    (MaxMinPaintingArea (max ?max) (min ?min))
=>
    (bind ?area (* ?width ?height))
    (printout t "Painting " ?painting " has complexity " (*(/ (- ?area ?min) (- ?max ?min)) 100) crlf)
    (send ?painting put-Complexity (*(/ (- ?area ?min) (- ?max ?min)) 100))
)

(defrule InitializeMaxMinPaintingArea "Inicializa MaxMinPaintingArea"
(declare (salience 150))
=>
    (assert (MaxMinPaintingArea(max 0) (min 999999)))
)

(defrule changePreguntasModul
(declare (salience 25))
    ?fact <- (MaxMinPaintingArea)
=>
    (retract ?fact)
    (focus PreguntasMod)
)

(defrule StartRule
(declare (salience 0))
=>
    (bind ?paintings (find-all-instances ((?inst Painting)) TRUE))
    (loop-for-count (?i 1 (length$ ?paintings)) do
        (assert (PaintingFact (paintingFact (nth$ ?i ?paintings))))
    )
)

(defrule AnalyzePainting ""
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
    (printout t "El cuadro " (send ?painting get-Painting+Name) " tiene un interes de " ?interest " y un tiempo de observacion de " ?time " segundos." crlf)
    (send ?painting put-Visitor+Interest ?interest)
    (send ?painting put-Observation+Time ?time)
    (retract ?f1)
    (retract ?f2)
    (retract ?f3)
    (retract ?f4)
)

(defrule FinishProgram
(declare (salience 10000))
    ?object <- (object (is-a Day) (number ?number) (asignedPaintings $?asignedPaintings) (asignedTime ?asignedTime))
=>
    (printout t "Los cuadros a visitar en el dia " ?number " con tiempo asignado " ?asignedTime " son" crlf)
    (loop-for-count (?i 1 (length$ ?asignedPaintings) ) do
        (bind ?painting (nth$ ?i ?asignedPaintings))
        (printout t "Sala " (send (send ?painting get-Exhibited+in) get-Room+Name) " El cuadro " (send ?painting get-Painting+Name) " tiene un interes de " (send ?painting get-Visitor+Interest) " y un tiempo de observacion de " (send ?painting get-Observation+Time) " segundos." crlf)
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
    ?fact <- (Finish-Fact)
=>
    (printout t "Acaba MAIN" crlf)
    (retract ?fact)
    (return)
)