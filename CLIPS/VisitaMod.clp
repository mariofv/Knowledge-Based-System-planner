(defmodule VisitaMod
    (import MAIN defclass ?ALL)
    (export defclass ?ALL)
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
=>
    (printout t "Hola :3" crlf)
    (make-instance STATE of State (paintingsToAsign (find-all-instances ((?x Painting)) TRUE)))
    (printout t "focuseando SortMod" crlf)
    (focus SortMod)
)

(defrule VisitaMod::CrearVisita
(declare (salience 0))
    (object (is-a State) (paintingsToAsign $?paintingsToAsign))
    (object (is-a Visitor) (Days ?days))
=>
    (printout t "SortMod acabado, he vuelto a VisitaMod" crlf)
    (bind ?size (length$ ?paintingsToAsign))
    (loop-for-count (?i 1 ?size ) do
        (bind ?painting (nth$ ?i ?paintingsToAsign))
        (printout t "El cuadro " (send ?painting get-Painting+Name) " tiene un interes de " (send ?painting get-Visitor+Interest)  crlf)
    )
    (printout t "He acabado, la lista es " $?paintingsToAsign crlf)
    (printout t "Focuseando CrearVisitaMod" crlf)
    (loop-for-count (?i 1 ?days) do
        (make-instance (gensym) of Day (number ?i))
    )
    (focus CrearVisitaMod)
    (assert (Finish-Fact))
)

(defrule VisitaMod::EndMod
(declare (salience 1))
    ?fact <- (Finish-Fact)
=>
    (printout t "Acabando VisitaMod, vuelvo a MAIN" crlf)
    (retract ?fact)
    (return)
)