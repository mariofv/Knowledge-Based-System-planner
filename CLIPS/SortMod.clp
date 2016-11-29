(defmodule SortMod 
    (import MAIN defclass ?ALL)
    (import MAIN deftemplate State)
)

(deffunction SortMod::adjacentRooms (?room1 ?room2)
(bind $?adjacentsRooms (send ?room1 get-Adjacent+to))
(member ?room2 ?adjacentsRooms))

(deffunction SortMod::getInterest (?index $?paintings) 
    (send  (nth$ ?index ?paintings) get-Interest)
)


(deffunction SortMod::divide(?start ?end $?paintings) 

 
    (bind ?pivot (getInterest ?start ?paintings))
    (bind ?left ?start)
    (bind ?right ?end)
 
    ; Mientras no se cruzen los índices
    (while (< ?left ?right) do
        (while (> (getInterest ?right ?paintings) ?pivot) do
            (bind ?right (- ?right 1))
        )
 
        (while (and (< ?left ?right) (<= (getInterest ?left ?paintings) ?pivot)) do
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

(defrule start
    ?state <- (State (paintingsToAsign $?paintingsToAsign))
=>
    (bind ?paintingsToAsiignSorted (quickSort 1 (length$ ?paintingsToAsign) ?paintingsToAsign))

    (modify ?state (paintingsToAsign ?paintingsToAsiignSorted))
    (printout t "He acabado, la lista es " ?paintingsToAsiignSorted crlf)
)