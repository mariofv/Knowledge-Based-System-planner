(defmodule OrganizeMod
"Este módulo se encarga de ordenar los cuadros asignados a un día concreto, de manera
que estén agrupados por salas, ya que no es deseable mirar un cuadro en una sala, ir a
otra y luego volver a la primera para observar otro cuadro."

    (import VisitaMod defclass Room Painting)
    (import VisitaMod deftemplate OrganizeDay)
)

;///////////
;HECHOS ///
;/////////


(deftemplate OrganizeMod::RoomOrder 
"Hecho auxiliar para asignar las salas en orden creciente, ya que
están enumeradsa, y dos salas con números consecutivos son adyacentes (excepto la
primera y la última, ya que el museo es circular)."

    (slot order
        (type INTEGER)
    )
)

;///////////
;REGLAS ///
;/////////

(defrule OrganizeMod::GroupByRoom
"Esta regla elimina los cuadros asignados, para insertarlos en un  multi-slot auxiliar
de la clase Room. El propósito de esta regla es indicar, para cada sala, los cuadros
que se tienen que visitar en un día concreto."

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
"Una vez tenemos en cada sala los cuadros que se visitarán de ésta, hay que volver
a insertarlos en la instancia de la clase día. Además el orden de inserción lo determina
el número de la sala. De esta manera los cuadros que se insertan pertenecen a la misma sala."

(declare (salience 2))
    ?f <- (RoomOrder (order ?order))
    ?room <- (object (is-a Room) (Number ?n) (Asigned+paintings $?paintings))
    (test (= ?order ?n))
    (OrganizeDay (day ?day))
=>
    (loop-for-count (?i 1 (length$ ?paintings))
        (slot-insert$ ?day Asigned+paintings (+ 1 (length$ (send ?day get-Asigned+paintings))) (nth$ 1 (send ?room get-Asigned+paintings)))
        (slot-delete$ ?room Asigned+paintings 1 1)
    )
    (modify ?f (order (+ ?order 1)))
)

(defrule OrganizeMod::Finish 
"Regla para eliminar los hechos que no necesitan guardarse, una vez el módulo
ha cumplido con su función."

(declare (salience 1))
    ?fact <- (OrganizeDay (day ?day))
    ?fact2 <- (RoomOrder)
=>
    (retract ?fact)
    (retract ?fact2)
)