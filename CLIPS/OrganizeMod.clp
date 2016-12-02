(defmodule OrganizeMod
    (import VisitaMod defclass Room Day Painting)
    (import VisitaMod deftemplate OrganizeDay)
)

(defrule GroupByRoom
(declare (salience 0))
    (object (is-a Day) (asignedPaintings $?asignedPaintings))
=>
    
)