(defmodule SortMod 
    (import VisitaMod defclass ?ALL)
    (import VisitaMod deftemplate ?ALL)
)

(deffunction SortMod::adjacentRooms (?room1 ?room2)
(bind $?adjacentsRooms (send ?room1 get-Adjacent+to))
(member ?room2 ?adjacentsRooms))

(deffunction SortMod::getInterest (?index $?paintings) 
    (send  (nth$ ?index ?paintings) get-Visitor+Interest)
)

(deffunction SortMod::divide(?start ?end $?paintings) 

 
    (bind ?pivot (getInterest ?start ?paintings))
    (bind ?left ?start)
    (bind ?right ?end)
 
    ; Mientras no se cruzen los índices
    (while (< ?left ?right) do
        (while (< (getInterest ?right ?paintings) ?pivot) do
            (bind ?right (- ?right 1))
        )
 
        (while (and (< ?left ?right) (>= (getInterest ?left ?paintings) ?pivot)) do
            (bind ?left (+ ?left 1))
        )
 
        ; Si todavía no se cruzan los indices seguimos intercambiando
        (if (< ?left ?right) then
            (bind ?temp (nth$ ?left ?paintings))
            (bind ?paintings (replace$ ?paintings ?left ?left (nth$ ?right ?paintings)))
            (bind ?paintings (replace$ ?paintings ?right ?right ?temp))
        )
    )
 
    ; Los índices ya se han cruzado, ponemos el pivot en el lugar que le corresponde
     (bind ?temp (nth$ ?right ?paintings))
    (bind ?paintings (replace$ ?paintings ?right ?right (nth$ ?start ?paintings))) 
    (bind ?paintings (replace$ ?paintings ?start ?start ?temp))
    ; La nueva posición del pivot
    (create$ ?right $?paintings)
)


(deffunction SortMod::quickSort (?start ?end $?paintings)
    (if (< ?start ?end) then 
        (bind $?aux (divide ?start ?end $?paintings))
        (bind ?pivot (nth$ 1 (first$ ?aux)))
        (bind ?paintings (rest$ ?aux))
        ; Ordeno la lista de los menores
        (bind ?paintings (quickSort ?start (- ?pivot 1) $?paintings))
        ; Ordeno la lista de los mayores
        (bind ?paintings (quickSort (+ ?pivot 1) ?end $?paintings))
       
    )
    $?paintings
)

(defrule SortMod::Start
    ?state <- (InitialState (paintingsToAsign $?paintingsToAsign))
=>
    (bind ?paintingsToAsignSorted (quickSort 1 (length$ ?paintingsToAsign) ?paintingsToAsign))
     
    (assert (State (paintingsToAsign ?paintingsToAsignSorted)))
    (retract ?state)
    (bind ?size (length$ ?paintingsToAsignSorted))
    (focus CrearVisitaMod)
    (assert (FinishSort))
    ;(loop-for-count (?i 1 ?size ) do
     ;   (bind ?painting (nth$ ?i ?paintingsToAsignSorted))
      ;  (printout t "El cuadro " (send ?painting get-Painting+Name) " tiene un interes de " (send ?painting get-Visitor+Interest)  crlf)
    ;)
    ;(printout t "He acabado, la lista es " ?paintingsToAsignSorted crlf)
)

(defrule SortMod::EndMod
(declare (salience 10000))
(FinishSort)
=>
(printout t "He acabado SORTMOD" crlf)
(return)
)