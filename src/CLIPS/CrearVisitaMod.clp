(defmodule CrearVisitaMod
"Este módulo sirve para crear la visita del visitante, es decir,
escoger los cuadros a visitar cada día, sin tener en cuenta el orden de visita."

    (import VisitaMod defclass State Day Visitor)
)

;//////////////
;FUNCIONES ///
;////////////

(deffunction CrearVisitaMod::first ($?list) 
"Esta función nos devuelve el primer elemento de una lista"

    (nth$ 1 ?list)
)

;/////////
;REGLAS//
;///////

(defrule CrearVisitaMod::OperatorAsign 
"Este operador asigna el cuadro con mayor interés al día que tenga menos tiempo 
asignado, es decir, que tenga más tiempo libre. De esta manera se reparten equitativamente entre cada día."

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
        (object (is-a Day) (Asigned+paintings $?paintings) (Asigned+time ?asignedTime)) 
        (test (<= ?dayTime ?asignedTime))
    )
=>
    (bind ?maxPainting (first ?paintingsToAsign))
    (slot-insert$ ?day Asigned+paintings 1 ?maxPainting)
    (send ?day put-Asigned+time (+ ?dayTime (send ?maxPainting get-Observation+time)))
    (slot-delete$ ?state Paintings+to+asign 1 1)
)

(defrule CrearVisitaMod::OperatorErase 
"Este operador solo se ejecuta en caso de que el anterior no pueda hacerlo, 
ya que puede pasar que el tiempo de observación del cuadro más interesante sea demasiado grande y no podamos
asignarlo a ningún día, pero sí se pueda asignar otro que sea menos interesante pero tenga un tiempo menor.
De esta manera se aprovecha al máximo el tiempo de visita."

(declare (salience 10))
    ?state <- (object (is-a State) (Paintings+to+asign $?paintingsToAsign))
    (test (> (length$ ?paintingsToAsign) 0))
    (object (is-a Visitor) (Duration ?duration))
=>
    (slot-delete$ ?state Paintings+to+asign 1 1)
)