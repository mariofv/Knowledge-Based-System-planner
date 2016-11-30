(defmodule VisitaMod
    (import MAIN defclass ?ALL)
    (import MAIN deftemplate ?ALL)
    (export deftemplate ?ALL)
    (export defclass ?ALL)
)

(deftemplate VisitaMod::InitialState
    (multislot paintingsToAsign 
        (type INSTANCE)
        (allowed-classes Painting)
    )
)

(defclass VisitaMod::State
    (is-a USER)
    (role concrete)
    (multislot paintingsToAsign 
        (type INSTANCE)
        (allowed-classes Painting)
    )
    (multislot deletedPaintings
        (type INSTANCE)
        (allowed-classes Painting)
    )
)

(defrule VisitaMod::StartMod
(object (is-a Visitor) (Days ?days))
=>
    (printout t "Hola :3" crlf)
    (make-instance STATE of State (paintingsToAsign (find-all-instances ((?x Painting)) TRUE)))
    (assert (InitialState (paintingsToAsign (find-all-instances ((?x Painting)) TRUE))))
    (loop-for-count (?i 1 ?days) do
        (assert (Day (number ?i) (asignedTime 0)))
    )
    (focus SortMod)
)