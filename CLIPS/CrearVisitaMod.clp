(defmodule CrearVisitaMod 
    (import VisitaMod defclass ?ALL)
)

(deffunction CrearVisitaMod::first ($?list)
    (nth$ 1 ?list)
)

(defrule CrearVisitaMod::OperatorAsign
(declare (salience 20))
    ?state <- (object (is-a State) (paintingsToAsign $?paintingsToAsign))
    (test (> (length$ ?paintingsToAsign) 0))
    (object (is-a Visitor) (Duration ?duration))
    ?day <- (object (is-a Day) (asignedPaintings $?asignedPaintings) (asignedTime ?dayTime))
    (test 
        (<=
            (+ ?dayTime (send (first ?paintingsToAsign) get-Observation+Time))
            ?duration
        )
    )
    (forall 
        (object (is-a Day) (asignedPaintings $?paintings)(asignedTime ?asignedTime)) 
        (test
            (<=
                ?dayTime
                ?asignedTime
            )
        )
    )
=>
    (printout t "Ejecutando operador Asignar" crlf)
    (bind ?maxPainting (first ?paintingsToAsign))
    (slot-insert$ ?day asignedPaintings 1 ?maxPainting)
    (send ?day put-asignedTime (+ ?dayTime (send ?maxPainting get-Observation+Time)))
    (slot-delete$ ?state paintingsToAsign 1 1)
)

(defrule CrearVisitaMod::OperatorErase
(declare (salience 10))
    ?state <- (object (is-a State) (paintingsToAsign $?paintingsToAsign) (deletedPaintings $?deletedPaintings))
    (test (> (length$ ?paintingsToAsign) 0))
    (object (is-a Visitor) (Duration ?duration))
=>
    (printout t "Ejecutando operador eliminar" crlf)
    (slot-insert$ ?state deletedPaintings (+ (length$ ?deletedPaintings) 1) (first ?paintingsToAsign))
    (slot-delete$ ?state paintingsToAsign 1 1)
)

(defrule CrearVisitaMod::FinishAlgorithm
(declare (salience 30))
    (object (is-a State) (paintingsToAsign $?paintingsToAsign))
    (test (= (length$ ?paintingsToAsign) 0))
=>
    (printout t "CrearVisitaMod acabado" crlf)
    (return)
)