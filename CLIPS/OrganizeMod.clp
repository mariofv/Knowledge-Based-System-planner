(defmodule OrganizeMod
    (import VisitaMod defclass Room Painting)
    (import VisitaMod deftemplate OrganizeDay)
)

(defrule GroupByRoom
(declare (salience 3))
    (OrganizeDay (day ?day))
=>
    (printout t "Dia " (send ?day get-number) crlf)
    (bind ?size (length$ (send ?day get-asignedPaintings)))
    (loop-for-count (?i 1 ?size)
        (bind ?painting (nth$ 1 (send ?day get-asignedPaintings)))
        (bind ?room (send ?painting get-Exhibited+in))
        (printout t ?i " " ?room " " (send ?painting get-Painting+Name) crlf)
        (slot-insert$ ?room Asigned+Paintings 1 ?painting)
        (slot-delete$ ?day asignedPaintings 1 1)
    )
    (printout t "Size del dia es " (length$ (send ?day get-asignedPaintings)) crlf)
)

(defrule ReorderPaintings
(declare (salience 2))
    (object (is-a Room) (Asigned+Paintings $?paintings))
    (OrganizeDay (day ?day))
=>
    (loop-for-count (?i 1 (length$ ?paintings))
        (slot-insert$ ?day asignedPaintings 1 (nth$ ?i ?paintings))
    )
)

(defrule FlushRoomsAndFinish
(declare (salience 1))
    ?fact <- (OrganizeDay (day ?day))
=>
    (do-for-all-instances ((?room Room)) TRUE
        
            (bind ?size (length$ (send ?room get-Asigned+Paintings)))
            (loop-for-count (?i 1 ?size)
                (slot-delete$ ?room Asigned+Paintings 1 1)
            )        
    )
    (retract ?fact)
    (return)
)