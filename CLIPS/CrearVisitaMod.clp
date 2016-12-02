(defmodule CrearVisitaMod 
    (import VisitaMod defclass ?ALL)
)

(deffunction CrearVisitaMod::first ($?list)
    (nth$ 1 ?list)
)

(defrule CrearVisitaMod::OperatorAsign
(declare (salience 20))
    ?state <- (object (is-a State) (paintingsToAsign $?paintingsToAsign))
    (test (> (length$ ?paintingsToAsign) 0))
    (object (is-a Visitor) (Duration ?duration))
    ?day <- (object (is-a Day) (asignedPaintings $?asignedPaintings) (asignedTime ?dayTime))
    (test 
        (<=
            (+ ?dayTime (send (first ?paintingsToAsign) get-Observation+Time))
            ?duration
        )
    )
    (forall 
        (object (is-a Day) (asignedPaintings $?paintings)(asignedTime ?asignedTime)) 
        (test
            (<=
                ?dayTime
                ?asignedTime
            )
        )
    )
=>
    (printout t "Ejecutando operador Asignar" crlf)
    (bind ?maxPainting (first ?paintingsToAsign))
    (slot-insert$ ?day asignedPaintings 1 ?maxPainting)
    (send ?day put-asignedTime (+ ?dayTime (send ?maxPainting get-Observation+Time)))
    (slot-delete$ ?state paintingsToAsign 1 1)
)

(defrule CrearVisitaMod::OperatorErase
(declare (salience 10))
    ?state <- (object (is-a State) (paintingsToAsign $?paintingsToAsign) (deletedPaintings $?deletedPaintings))
    (test (> (length$ ?paintingsToAsign) 0))
    (object (is-a Visitor) (Duration ?duration))
=>
    (printout t "Ejecutando operador eliminar" crlf)
    (slot-insert$ ?state deletedPaintings (+ (length$ ?deletedPaintings) 1) (first ?paintingsToAsign))
    (slot-delete$ ?state paintingsToAsign 1 1)
)

(defrule CrearVisitaMod::FinishAlgorithm
(declare (salience 30))
    (object (is-a State) (paintingsToAsign $?paintingsToAsign))
    (test (= (length$ ?paintingsToAsign) 0))
=>
    (printout t "CrearVisitaMod acabado" crlf)
    (return)
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