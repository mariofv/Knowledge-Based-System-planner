(defmodule OrganizeMod
    (import VisitaMod defclass Room Painting)
    (import VisitaMod deftemplate OrganizeDay)
)

(defrule OrganizeMod::GroupByRoom
(declare (salience 4))
    (OrganizeDay (day ?day))
=>
    (bind ?size (length$ (send ?day get-asignedPaintings)))
    (loop-for-count (?i 1 ?size)
        (bind ?painting (nth$ 1 (send ?day get-asignedPaintings)))
        (bind ?room (send ?painting get-Exhibited+in))
        (slot-insert$ ?room Asigned+Paintings 1 ?painting)
        (slot-delete$ ?day asignedPaintings 1 1)
    )
)

(defrule OrganizeMod::ReorderPaintingsInitial
(declare (salience 3))
    ?room <- (object (is-a Room) (Asigned+Paintings $?paintings) (Is+Initial+Room TRUE))
    (OrganizeDay (day ?day))
=>    
    (loop-for-count (?i 1 (length$ ?paintings))
        (slot-insert$ ?day asignedPaintings (+ 1 (length$ (send ?day get-asignedPaintings))) (nth$ ?i ?paintings))
    )
)

(defrule OrganizeMod::ReorderPaintings
(declare (salience 2))
    ?room <- (object (is-a Room) (Asigned+Paintings $?paintings) (Is+Initial+Room FALSE))
    (OrganizeDay (day ?day))
=>
    (loop-for-count (?i 1 (length$ ?paintings))
        (slot-insert$ ?day asignedPaintings (+ 1 (length$ (send ?day get-asignedPaintings))) (nth$ ?i ?paintings))
    )
)

(defrule OrganizeMod::FlushRoomsAndFinish
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