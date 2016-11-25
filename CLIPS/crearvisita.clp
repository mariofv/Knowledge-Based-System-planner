
;DEFFUNCTIONS

;(deffunction question-instance ()
;   (bind ?answer (readline))
;   (if (lexemep ?answer) 
;       then (bind ?answer ?answer))
;   (while (not (lexemep ?answer)) do
;        (printout t "Introduce a valid string" crlf)
;        bind ?answer (readline))
;?answer)
;
;(deffunction add-preference (?classtype ?slot ?count ?visitor_instance)
;    (bind ?answer (question-instance))
;    (while (not(eq ?answer "done")) do
;        (bind ?aux (find-instance ((?inst ?classtype)) (eq (lowcase ?inst:?slot) (lowcase ?answer))))
;        (bind ?mslot (send ?visitor_instance get-Preferences))
;        (bind ?already (member$ ?aux ?mslot))
;
;        (printout t ?aux crlf)
;        (if (not ?already) then    
;        (slot-insert$ ?visitor_instance Preferences ?count ?aux)
;        (bind ?count (+ ?count 1)))
;        (bind ?answer (question-instance))
;    )
;)
;
;(deffunction ask-question-with-values (?question $?allowed-values)
;   (printout t ?question crlf)
;   (printout t "Possible values: ")
;   (printout t $?allowed-values crlf)
;   (bind ?answer (readline))
;   (if (lexemep ?answer) 
;       then (bind ?answer ?answer))
;   (while (not (member ?answer ?allowed-values)) do
;      (printout t ?question crlf)
;      (printout t "Possible values: ")
;      (printout t $?allowed-values crlf)    
;      (bind ?answer (readline))
;      (if (lexemep ?answer) 
;          then (bind ?answer ?answer)))
;   ?answer)
;noob
;(deffunction ask-question-string (?question)
;   (printout t ?question)
;   (bind ?answer (readline))
;   (if (lexemep ?answer) 
;       then (bind ?answer ?answer))
;   (while (not (lexemep ?answer)) do
;      (printout t "Introduce a string, you idiot" crlf)
;      (printout t ?question)
;      (bind ?answer (readline))
;      (if (lexemep ?answer) 
;          then (bind ?answer ?answer)))
;   ?answer)
;
;(deffunction ask-question-integer (?question)
;   (printout t ?question)
;   (bind ?answer (read))
;   (if (integerp ?answer) 
;       then (if (> ?answer 1) then (bind ?answer ?answer))
;   )
;   (while (or(not (integerp ?answer)) (< ?answer 1))  do
;      (if (not (integerp ?answer)) then (printout t "Introduce an integer, dumbass" crlf)
;      else (if (< ?answer 1) then (printout t "Introduce an integer bigger than 0, dumbass" crlf) 
;       ))
;      (printout t ?question)
;      (bind ?answer (read))
;      (if (integerp ?answer) 
;          then (bind ?answer ?answer)))
;   ?answer)
;
;(deffunction yes-or-no-p (?question)
;   (bind ?response (ask-question-with-values ?question yes no y n))
;   (if (or (eq ?response yes) (eq ?response y))
;       then TRUE 
;       else FALSE))
;   
;DEFRULES
;
(defrule crear-visita ""
  (declare(salience -1000))
   =>
  ;TODODODODOO
  (bind ?visitors (find-all-instances((?n Visitor)) TRUE))
   (bind ?visitor (nth$ 1 ?visitors))    
  (printout t "Estoy en la regla crear-visita")  
  (printout t ?visitor crlf)  

  (bind ?days (send ?visitor get-Days))         
  (bind ?minutes (send ?visitor get-Duration))   
  (bind $?listaCuadros (find-all-instances((?m Painting)) TRUE)) 
  (printout t "Lista de cuadros: " $?listaCuadros crlf)
  (bind $?listaFinal (create$ test))
  (bind ?daysUsed 0)
  (while (< ?daysUsed ?days) do
      (printout t "Estoy en while dias usados: " ?daysUsed crlf) 
      (bind ?exitMinutes FALSE)
      (bind ?minutesUsed 0)
      
      (while (and (< ?minutesUsed ?minutes) (eq ?exitMinutes FALSE) ) do
          (bind ?rand (+ (mod (random) (length$ ?listaCuadros)) 1))
          (bind ?element (nth$ ?rand ?listaCuadros))
          (bind ?observationTime (send ?element get-Observation+Time))
          (bind ?possibleTime (+ ?observationTime ?minutesUsed))
          (if (<= ?possibleTime ?minutes) then
              (bind ?minutesUsed ?possibleTime)
              (bind ?listaFinal (insert$ ?listaFinal 1 ?element))
              (bind ?listaCuadros (delete$ ?listaCuadros ?rand ?rand))
           else 
              (bind ?index 1)
              (bind ?exit FALSE)
              (while (and (<= ?index (length$ ?listaCuadros)) (eq ?exit FALSE)) do
                   (bind ?element (nth$ ?index ?listaCuadros))
                   (bind ?observationTime (send ?element get-Observation+Time))
                   (bind ?possibleTime (+ ?observationTime ?minutesUsed))
                   (if (<= ?possibleTime ?minutes) then
                       (bind ?minutesUsed ?possibleTime)
                       (bind ?listaFinal (insert$ ?listaFinal 1 ?element))
                       (bind ?listaCuadros (delete$ ?listaCuadros ?index ?index))
                       (bind ?exit TRUE)
                   else (bind ?index (+ ?index 1))
                   )
               )
               (if (eq ?exit FALSE) then (bind ?exitMinutes TRUE))
            )
        )
       (bind ?daysUsed (+ ?daysUsed 1))
    )
   (printout t ?listaFinal crlf)
)
   
   
   



















