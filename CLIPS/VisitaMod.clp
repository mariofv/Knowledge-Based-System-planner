(defmodule VisitaMod
    (import MAIN defclass ?ALL)
    (import MAIN deftemplate YearFilters NationalityFilters)
    (export defclass ?ALL)
    (export deftemplate ?ALL)
)

(deftemplate VisitaMod::OrganizeDay
    (slot day (type INSTANCE) (allowed-classes Day))
)

(defclass VisitaMod::State
    (is-a USER)
    (role concrete)
    (multislot Paintings+to+asign 
        (type INSTANCE)
        (allowed-classes Painting)
    )
    (multislot Deleted+paintings
        (type INSTANCE)
        (allowed-classes Painting)
    )
)

(defrule VisitaMod::MakeStateEmpty
(declare (salience 3))
=>
    (make-instance STATE of State)
)

(defrule VisitaMod::InsertPaintingIntoState
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
(declare (salience 2))
=>
    (focus SortMod)
)

(defrule VisitaMod::CrearVisita
(declare (salience 0))
    (object (is-a State) (Paintings+to+asign $?paintingsToAsign))
    (object (is-a Visitor) (Days ?days))
=>
    (bind ?size (length$ ?paintingsToAsign))
    (loop-for-count (?i 1 ?size ) do
        (bind ?painting (nth$ ?i ?paintingsToAsign))
    )
    (loop-for-count (?i 1 ?days) do
        (make-instance (gensym) of Day (Number ?i))
    )
    (focus CrearVisitaMod)
    (assert (Organize))
)

(defrule VisitaMod::Organize
(declare (salience 2))
    (Organize)
    ?day <- (object (is-a Day))
=>
    (assert (OrganizeDay (day ?day)))
    (focus OrganizeMod)
)

(defrule VisitaMod::EndMod
(declare (salience 1))
    ?fact <- (Organize)
=>
    (retract ?fact)
    (return)
)