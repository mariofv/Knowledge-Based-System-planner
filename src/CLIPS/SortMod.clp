(defmodule SortMod
"Este módulo sirve para ordenar todos los cuadros por interés descendiente."

    (import VisitaMod defclass State)
)

;//////////////
;FUNCIONES ///
;////////////

(deffunction SortMod::getPainting (?index ?auxClass)
"Función para acceder a un cuadro guardado en un multi-slot de una clase."

    (nth$ ?index (send ?auxClass get-Paintings+to+asign))
)

(deffunction SortMod::getInterest (?index ?auxClass)
"Función para conseguir el interés de un cuadro guardado en un multi-slot de una clase."

    (send  (getPainting ?index ?auxClass) get-Visitor+interest)
)

(deffunction SortMod::divide(?start ?end ?auxClass)
"Función que pertenece a la implementación del QuickSort en CLIPS."
 
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
"Función recursiva de la implementación del QuickSort en CLIPS."

    (if (< ?start ?end) then 
        (bind ?pivot (divide ?start ?end ?auxClass))
        ; Ordeno la lista de los menores
        (quickSort ?start (- ?pivot 1) ?auxClass)
        ; Ordeno la lista de los mayores
        (quickSort (+ ?pivot 1) ?end ?auxClass)
       
    )
)

;///////////
;REGLAS ///
;/////////

(defrule SortMod::Sort
"Regla que ejecuta el QuickSort sobre la instancia de State creada en el módulo
VisitaMod y luego finaliza la ejecución del módulo."

    ?state <- (object (is-a State) (Paintings+to+asign $?paintingsToAsign))
=>
    (quickSort 1 (length$ ?paintingsToAsign) ?state)
    (return)
)