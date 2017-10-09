(defmodule VisitaMod
"Este módulo se encarga de ejecutar los módulos encargados de crear la visita."

    (import MAIN defclass Painting Day Visitor Room)
    (import MAIN deftemplate YearFilters NationalityFilters)

    (export defclass ?ALL)
    (export deftemplate OrganizeDay)
)

;//////////
;HECHOS///
;////////

(deftemplate VisitaMod::OrganizeDay
"Este hecho contiene un día los cuadros del cual tienen que ordenarse por salas consecutivas."

    (slot day (type INSTANCE) (allowed-classes Day))
)

;//////////
;CLASES //
;////////

(defclass VisitaMod::State
"Esta es una clase auxiliar que contiene los cuadros a asignar, ordenados por interés."

    (is-a USER)
    (role concrete)
    (multislot Paintings+to+asign 
        (type INSTANCE)
        (allowed-classes Painting)
    )
)

;/////////
;REGLAS//
;///////

(defrule VisitaMod::MakeStateEmpty
"Regla inicial que crea una instancia de la clase State vacía."

(declare (salience 3))
=>
    (make-instance STATE of State)
)

(defrule VisitaMod::InsertPaintingIntoState
"Regla que añade a la instancia de la clase estado todos los cuadros que cumplen
las condiciones de los filtros determinados por el visitante."

(declare (salience 3))
    (YearFilters (firstYear ?fy) (lastYear ?ly))
    ?painting <- (object (is-a Painting) (Year+of+creation ?year) (Created+by ?author))
    ?state <- (object (is-a State))
    (test (>= ?year ?fy))
    (test (<= ?year ?ly))
    (or
        (not (exists (NationalityFilters)))
        (exists 
            (NationalityFilters (nationality ?nationality))
            (test (eq ?nationality (send ?author get-Nationality)))
        )
    )
=>
    (slot-insert$ ?state Paintings+to+asign 1 ?painting)
)

(defrule VisitaMod::StartSortMod
"Hecho que ejecuta el módulo para ordenar los cuadros por interés."

(declare (salience 2))
=>
    (focus SortMod)
)

(defrule VisitaMod::CrearVisita
"Se crean las instancias de la clase día y se ejecuta el módulo que determinará
los cuadros a visitar cada día."

(declare (salience 0))
    (object (is-a State) (Paintings+to+asign $?paintingsToAsign))
    (object (is-a Visitor) (Days ?days))
=>
    (loop-for-count (?i 1 ?days) do
        (make-instance (gensym) of Day (Number ?i))
    )
    (focus CrearVisitaMod)
    (assert (Organize))
)

(defrule VisitaMod::Organize
"Cuando acaba la ejecución del módulo CrearVisitaMod, se ejecuta el módulo que
organizará los cuadros a visitar por salas. Éste se ejecutará una vez por cada día."

(declare (salience 2))
    (Organize)
    ?day <- (object (is-a Day))
=>
    (assert (OrganizeDay (day ?day)))
    (focus OrganizeMod)
)

(defrule VisitaMod::EndMod
"Hecho para finalizar la ejecución del módulo."

(declare (salience 1))
    ?fact <- (Organize)
    ?state <- (object (is-a State))
=>
    (retract ?fact)
    (send ?state delete)
    (return)
)