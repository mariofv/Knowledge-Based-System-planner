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

(deffunction visited(?room)
    (bind ?aux (find-instance ((?a AuxClass)) (eq (send ?a get-room) ?room)))
    (send ?aux get-visited)
)

(deffunction visit(?room)
    (bind ?aux (find-instance ((?a AuxClass)) (eq (send ?a get-room) ?room)))
    (send ?aux put-visited 1)
)

(deffunction DFS (?room ?day)
    (visit ?room)
    (bind ?paintings (send ?room get-asignedPaintings))
    (loop-for-count (?i 1 (length$ ?paintings))
        (slot-insert$ ?day asignedPaintings 1 (nth$ ?i ?paintings))
    )
    (bind ?adjacents (send ?room get-Adjacent+To))
    (loop-for-count (?i 1 (length$ ?adjacents))
        (if (= (visited ?room) 1)
            then (DFS (nth ?i ?adjacents) ?day)
        )
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
        (bind ?room (send ?painting get-room))
        (slot-insert$ ?room asignedPaintings 1 ?painting)
        (slot-delete$ ?day asignedPaintings 1 1)
        (make-instance (gensym) of AuxClass (room ?room))
    )
    (DFS (find-instance ((?r Room)) (= (send ?r get-is+Initial+Room) 1)) ?day)
)

(defrule End
(declare (salience 0))
    ?room <- (object (is-a Room) (asignedPaintings ?paintings))
    ?fact <- (OrganizeDay)
=>
    (bind ?size (length$ ?paintings))
    (loop-for-count (?i 1 ?size)
        (slot-delete$ ?room asignedPaintings 1 1)
    )
    (retract ?fact)
)