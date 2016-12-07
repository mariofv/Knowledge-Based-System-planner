(defmodule CrearVisitaMod "Este modulo sirve para crear la visita del visitante."
    (import VisitaMod defclass State Day Visitor)
)

(deffunction CrearVisitaMod::first ($?list) "Esta funcion nos devuelve el primer elemento de una lista"
    (nth$ 1 ?list)
)

(defrule CrearVisitaMod::OperatorAsign
(declare (salience 20))
    ?state <- (object (is-a State) (Paintings+to+asign $?paintingsToAsign))
    (test (> (length$ ?paintingsToAsign) 0))
    (object (is-a Visitor) (Duration ?duration))
    ?day <- (object (is-a Day) (Asigned+paintings $?asignedPaintings) (Asigned+time ?dayTime))
    (test 
        (<=
            (+ ?dayTime (send (first ?paintingsToAsign) get-Observation+time))
            ?duration
        )
    )
    (forall 
        (object (is-a Day) (Asigned+paintings $?paintings)(Asigned+time ?asignedTime)) 
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
    (slot-insert$ ?day Asigned+paintings 1 ?maxPainting)
    (send ?day put-Asigned+time (+ ?dayTime (send ?maxPainting get-Observation+time)))
    (slot-delete$ ?state Paintings+to+asign 1 1)
)

(defrule CrearVisitaMod::OperatorErase
(declare (salience 10))
    ?state <- (object (is-a State) (Paintings+to+asign $?paintingsToAsign) (Deleted+paintings $?deletedPaintings))
    (test (> (length$ ?paintingsToAsign) 0))
    (object (is-a Visitor) (Duration ?duration))
=>
    (printout t "Ejecutando operador eliminar" crlf)
    (slot-insert$ ?state Deleted+paintings (+ (length$ ?deletedPaintings) 1) (first ?paintingsToAsign))
    (slot-delete$ ?state Paintings+to+asign 1 1)
)

(defrule CrearVisitaMod::FinishAlgorithm
(declare (salience 30))
    (object (is-a State) (Paintings+to+asign $?paintingsToAsign))
    (test (= (length$ ?paintingsToAsign) 0))
=>
    (printout t "CrearVisitaMod acabado" crlf)
    (return)
)