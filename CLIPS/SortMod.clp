(defmodule SortMod 
    (import VisitaMod defclass State)
)

(deffunction SortMod::getPainting (?index ?auxClass)
    (nth$ ?index (send ?auxClass get-Paintings+to+asign))
)

(deffunction SortMod::getInterest (?index ?auxClass) 
    (send  (getPainting ?index ?auxClass) get-Visitor+interest)
)

(deffunction SortMod::divide(?start ?end ?auxClass) 
 
    (bind ?pivot (getInterest ?start ?auxClass))
    (bind ?left ?start)
    (bind ?right ?end)
 
    ; Mientras no se cruzen los índices
    (while (< ?left ?right) do
        (while (< (getInterest ?right ?auxClass) ?pivot) do
            (bind ?right (- ?right 1))
        )
 
        (while (and (< ?left ?right) (>= (getInterest ?left ?auxClass) ?pivot)) do
            (bind ?left (+ ?left 1))
        )
 
        ; Si todavía no se cruzan los indices seguimos intercambiando
        (if (< ?left ?right) then
            (bind ?temp (getPainting ?left ?auxClass))
            (slot-replace$ ?auxClass Paintings+to+asign ?left ?left (getPainting ?right ?auxClass))
            (slot-replace$ ?auxClass Paintings+to+asign ?right ?right ?temp)
        )
    )
 
    ; Los índices ya se han cruzado, ponemos el pivot en el lugar que le corresponde
    (bind ?temp (getPainting ?right ?auxClass))
    (slot-replace$ ?auxClass Paintings+to+asign ?right ?right (getPainting ?start ?auxClass))
    (slot-replace$ ?auxClass Paintings+to+asign ?start ?start ?temp)
    ; La nueva posición del pivot
    ?right
)


(deffunction SortMod::quickSort (?start ?end ?auxClass)
    (if (< ?start ?end) then 
        (bind ?pivot (divide ?start ?end ?auxClass))
        ; Ordeno la lista de los menores
        (quickSort ?start (- ?pivot 1) ?auxClass)
        ; Ordeno la lista de los mayores
        (quickSort (+ ?pivot 1) ?end ?auxClass)
       
    )
)

(defrule SortMod::Sort
    ?state <- (object (is-a State) (Paintings+to+asign $?paintingsToAsign))
=>
    (quickSort 1 (length$ ?paintingsToAsign) ?state)
    (return)
)