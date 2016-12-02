(defmodule OrganizeMod
    (import VisitaMod defclass Room Painting)
    (import VisitaMod deftemplate OrganizeDay)
)

(defclass OrganizeMod::AuxClass
    (is-a USER)
    (role concrete)
    (slot room (type INSTANCE) (allowed-classes Room))
    (slot visited (type INTEGER) (default 0))
)


(deffunction DFS (?room ?day)
    (bind ?paintings (send ?room get-asignedPaintings))
    (loop-for-count (?i 1 (length$ ?paintings))
        (slot-insert$ ?day asignedPaintings 1 (nth$ ?i ?paintings))
    )
    (bind ?adjacents (send ?room get-Adjacent+To))
    (loop-for-count (?i 1 (length$ ?adjacents))
        (DFS (nth ?i ?adjacents) ?day)
    )
)

(defrule GroupByRoom
(declare (salience 1))
    (OrganizeDay (day ?day))
=>
    (bind ?paintings (send ?day get-asignedPaintings))
    (bind ?size (length$ ?paintings))
    (loop-for-count (?i 1 ?size)
        (bind ?painting (nth$ 1 ?paintings))
        (bind ?room (send ?painting get-Exhibited+in))
        (slot-insert$ ?room Asigned+Paintings 1 ?painting)
        (slot-delete$ ?day asignedPaintings 1 1)
        (make-instance (gensym) of AuxClass (room ?room))
    )
    (DFS (find-instance ((?r Room)) (send ?r get-Is+Initial+Room)) ?day)
)

(defrule DeleteAuxClass
(declare (salience 0))
    ?auxClass <- (object (is-a AuxClass))
=>
    (send ?auxClass delete)
)

(defrule End
(declare (salience 0))
    ?room <- (object (is-a Room) (Asigned+Paintings ?paintings))
    ?fact <- (OrganizeDay)
=>
    (bind ?size (length$ ?paintings))
    (loop-for-count (?i 1 ?size)
        (slot-delete$ ?room asignedPaintings 1 1)
    )
    (retract ?fact)
)