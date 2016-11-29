(defmodule ResolMod 

)



(deffunction ResolMod::adjacentRooms (?room1 ?room2)
(bind $?adjacentsRooms (send ?room1 get-Adjacent+to))
(member ?room2 ?adjacentsRooms))



(deffunction ResolMod::divide(?start ?end $?paintings) 

 
    (bind ?pivot (nth$ ?start ?paintings))
    (bind ?left ?start)
    (bind ?right ?end)
 
    ; Mientras no se cruzen los índices
    (while (< ?left ?right) do
        (while (> (nth$ ?right ?paintings) ?pivot) do
            (bind ?right (- ?right 1))
        )
 
        (while (and (< ?left ?right) (<= (nth$ ?left ?paintings) ?pivot)) do
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


(deffunction ResolMod::quickSort (?start ?end $?paintings)
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

(defrule HOLA 
=>
(bind $?paintings (create$ 1 6 7 2 9 5 8))
(bind ?paintings (quickSort 1 7 ?paintings))
(printout t ?paintings  crlf)
)