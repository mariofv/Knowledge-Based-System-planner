(defmodule OrganizeMod
    (import VisitaMod defclass Room Painting)
    (import VisitaMod deftemplate OrganizeDay)
)

(deftemplate RoomOrder
    (slot order
        (type INTEGER)
    )
)

(defrule OrganizeMod::GroupByRoom
(declare (salience 2))
    (OrganizeDay (day ?day))
=>
    (bind ?size (length$ (send ?day get-Asigned+paintings)))
    (loop-for-count (?i 1 ?size)
        (bind ?painting (nth$ 1 (send ?day get-Asigned+paintings)))
        (bind ?room (send ?painting get-Exhibited+in))
        (slot-insert$ ?room Asigned+paintings 1 ?painting)
        (slot-delete$ ?day Asigned+paintings 1 1)
    )
    (assert (RoomOrder (order 1)))
)

(defrule OrganizeMod::ReorderPaintings
(declare (salience 2))
    ?f <- (RoomOrder (order ?order))
    (object (is-a Room) (Number ?n) (Asigned+paintings $?paintings))
    (test (= ?order ?n))
    (OrganizeDay (day ?day))
=>
    (loop-for-count (?i 1 (length$ ?paintings))
        (slot-insert$ ?day Asigned+paintings (+ 1 (length$ (send ?day get-Asigned+paintings))) (nth$ ?i ?paintings))
    )
    (modify ?f (order (+ ?order 1)))
)

(defrule OrganizeMod::FlushRoomsAndFinish
(declare (salience 1))
    ?fact <- (OrganizeDay (day ?day))
    ?fact2 <- (RoomOrder)
=>
    (do-for-all-instances ((?room Room)) TRUE
        (bind ?size (length$ (send ?room get-Asigned+paintings)))
        (loop-for-count (?i 1 ?size)
            (slot-delete$ ?room Asigned+paintings 1 1)
        )
    )
    (retract ?fact)
    (retract ?fact2)
    (return)
)