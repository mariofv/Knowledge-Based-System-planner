;DEFFUNCTIONS
(defmodule CrearVisitaMod 
    (import MAIN defclass ?ALL)
    (import MAIN deftemplate State)
)

(deffunction CrearVisitaMod::first ($?list)
    (nth$ 1 ?list)
)

(deftemplate CrearVisitaMod::Day
    (slot number
        (type INTEGER)
    )
    (slot asignedTime
        (type INTEGER)
    )
    (multislot asignedPaintings
        (type INSTANCE)
        (allowed-classes Painting)
    )
)

(defrule CrearVisitaMod::OperatorAsign
(declare (salience 20))
    ?state <- (State (paintingsToAsign $?paintingsToAsign))
    (object (is-a Visitor) (Duration ?duration))
    ?day <- (Day (asignedTime ?dayTime))
    (test 
        (<=
            (+ ?dayTime (send (first ?paintingsToAsign) get-Observation+Time))
            ?duration
        )
    )
    (forall 
        (Day (asignedPaintings $?paintings)(asignedTime ?asignedTime)) 
        (test
            (<=
                ?dayTime
                ?asignedTime
            )
        )
    )
=>
    (bind ?maxPainting (first ?paintingsToAsign))
    (slot-insert$ ?day paintingsToAsign 1 ?maxPainting)
    (modify ?day (asignedTime (+ ?dayTime (send ?maxPainting get-Observation+Time))))
    (slot-delete$ ?state paintingsToAsign 1 1)
)

(defrule CrearVisitaMod::OperatorErase
(declare (salience 10))
    ?state <- (State (paintingsToAsign $?paintingsToAsign) (deletedPaintings $?deletedPaintings))
    (object (is-a Visitor) (Duration ?duration))
=>
    (slot-insert$ ?state deletedPaintings (length$ ?deletedPaintings) (first ?paintingsToAsign))
    (slot-delete$ ?state paintingsToAsign 1 1)
)

(defrule CrearVisitaMod::FinishAlgorithm
(declare (salience 30))
    (State (paintingsToAsign $?paintingsToAsign))
    (test (= (length$ ?paintingsToAsign) 0))
=>
(printout t "He acabado" crlf)
)

;(defrule CrearVisitaMod::crear-visita ""
;  (declare(salience -1000))
;   =>
;  (bind ?visitors (find-all-instances((?n Visitor)) TRUE))
;  (bind ?visitor (nth$ 1 ?visitors))     
;
;  (bind ?days (send ?visitor get-Days))         
;  (bind ?minutes (send ?visitor get-Duration))   
;  (bind $?listaCuadros (find-all-instances((?m Painting)) TRUE)) 
;  (bind $?listaFinal (create$))
;  (bind ?daysUsed 0)
;  (while (< ?daysUsed ?days) do
;      (bind ?exitMinutes FALSE)
;      (bind ?minutesUsed 0)
;      
;      (while (and (< ?minutesUsed ?minutes) (eq ?exitMinutes FALSE) ) do
;          (bind ?rand (+ (mod (random) (length$ ?listaCuadros)) 1))
;          (bind ?element (nth$ ?rand ?listaCuadros))
;          (bind ?observationTime (send ?element get-Observation+Time))
;          (bind ?possibleTime (+ ?observationTime ?minutesUsed))
;          (if (<= ?possibleTime ?minutes) 
;           then
;              (bind ?minutesUsed ?possibleTime)
;              (bind ?listaFinal (insert$ ?listaFinal 1 ?element))
;              (bind ?listaCuadros (delete$ ?listaCuadros ?rand ?rand))
;           else 
;              (bind ?index 1)
;              (bind ?exit FALSE)
;              (while (and (<= ?index (length$ ?listaCuadros)) (eq ?exit FALSE)) do
;                   (bind ?element (nth$ ?index ?listaCuadros))
;                   (bind ?observationTime (send ?element get-Observation+Time))
;                   (bind ?possibleTime (+ ?observationTime ?minutesUsed))
;                   (if (<= ?possibleTime ?minutes) then
;                       (bind ?minutesUsed ?possibleTime)
;                       (bind ?listaFinal (insert$ ?listaFinal 1 ?element))
;                       (bind ?listaCuadros (delete$ ?listaCuadros ?index ?index))
;                       (bind ?exit TRUE)
;                   else (bind ?index (+ ?index 1))
;                   )
;               )
;               (if (eq ?exit FALSE) then (bind ?exitMinutes TRUE))
;            )
;        )
;       (bind ?daysUsed (+ ?daysUsed 1))
;    )
;    (printout t crlf "Los cuadros elegidos han sido :" crlf)
;    (loop-for-count (?i 1 (length$ ?listaFinal)) do
;	(bind ?actual (nth$ ?i ?listaFinal))
;	   (printout t (send ?actual get-Painting+Name) crlf)
;
;    )
;)