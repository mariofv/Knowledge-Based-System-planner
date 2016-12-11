(defmodule PreguntasMod 
"Este módulo se ocupa de adquirir la información necesaria del visitante."

    (import MAIN defclass ?ALL)
    (import MAIN deftemplate YearFilters NationalityFilters)
)

;//////////////
;FUNCIONES ///
;////////////

(deffunction PreguntasMod::question-instance () 
"Función para una pregunta que se responde con string"

   (bind ?answer (readline))
   (if (lexemep ?answer) 
       then (bind ?answer ?answer))
   (while (not (lexemep ?answer)) do
        (printout t "Introduce a valid string" crlf)
        bind ?answer (readline))
?answer)

;Añade preferencias de un tipo a la clase visitante
;(deffunction PreguntasMod::add-preference (?classtype ?slot ?count ?visitor_instance)
;    (bind ?answer (question-instance))
;    (while (not(eq ?answer "done")) do
;        (bind ?aux (find-instance ((?inst ?classtype)) (eq (lowcase ?inst:?slot) (lowcase ?answer))))
;        (bind ?mslot (send ?visitor_instance get-Preferences))
;        (bind ?already (member$ ?aux ?mslot))
;        (printout t ?aux crlf)
;        (if (not ?already) then    
;        (slot-insert$ ?visitor_instance Preferences ?count ?aux)
;        (bind ?count (+ ?count 1)))
;        (bind ?answer (question-instance))
;    )
;)


(deffunction PreguntasMod::add-question-with-values-int-extra (?maxindex) 
"Función para las preguntas con múltiples opciones que se responden por enteros"

   (bind ?answer (read))
   (bind ?out 0)
   (if (lexemep ?answer) then
       (if (eq ?answer done) then
            (bind ?out -1)
            (bind ?answer -1)
       )
   )
   (if (integerp ?answer) 
       then (bind ?answer ?answer)
       else (bind ?answer 0)
   )
   (while (and (not(= ?out -1)) (or (< ?answer 1) (> ?answer ?maxindex)) ) do 
      (printout t "Possible values: [" 1 "," ?maxindex "]" crlf)
      (bind ?answer (read))
      (if (lexemep ?answer) then
          (if (eq ?answer done) then 
            (bind ?out -1)
            (bind ?answer -1)
          )
      (if (integerp ?answer) 
          then (bind ?answer ?answer)
          else (bind ?answer 0))
      )
   )
   (if (eq ?out -1) then
        (bind ?answer -1))
   ?answer
)


(deffunction PreguntasMod::add-preference-number (?classtype ?slot ?count ?visitor_instance $?array) 
"Añade preferencias de un tipo a la instancia de visitante. La pregunta se responde con números"

    (bind ?answer (add-question-with-values-int-extra (length$ ?array)))
    (while (not(= ?answer -1)) do
        (bind ?aux (nth$ ?answer ?array))
        (bind ?mslot (send ?visitor_instance get-Preferences))
        (bind ?already (member$ ?aux ?mslot))

        (printout t ?aux crlf)
        (if (not ?already) then    
            (slot-insert$ ?visitor_instance Preferences ?count ?aux)
            (bind ?count (+ ?count 1))
        )
        (bind ?answer (add-question-with-values-int-extra (length$ ?array)))
    )
)

(deffunction PreguntasMod::nationality-filter($?array) 
"Filtro de nacionalidades de autor"

    (printout t "Possible values:" crlf)
    (printout t "------------------------------------" crlf)
    (loop-for-count (?i 1 (length$ ?array)) do
        (printout t ?i ". ")
        (printout t (send (nth$ ?i ?array) get-Country+name) crlf)
    )
    (printout t "------------------------------------" crlf)
   
    (bind $?bools (create$ 0))
    (loop-for-count (?i 2 (length$ ?array)) do
        (bind $?bools (insert$ ?bools 1 0))
    )
    (bind ?answer (add-question-with-values-int-extra (length$ ?array)))
    (while (not(= ?answer -1)) do
        (bind ?aux (nth$ ?answer ?array))
        (if (eq (nth$ ?answer ?bools) 0) then
            (assert (NationalityFilters (nationality ?aux)))
            (bind $?bools (replace$ ?bools ?answer ?answer 1))
        )
        (printout t "Possible values:" crlf)
        (printout t "------------------------------------" crlf)
        (loop-for-count (?i 1 (length$ ?array)) do
            (printout t ?i ". ")
            (printout t (send (nth$ ?i ?array) get-Country+name) crlf)
        )
        (printout t "------------------------------------" crlf)
        (bind ?answer (add-question-with-values-int-extra (length$ ?array)))
    )
)

(deffunction PreguntasMod::ask-question-with-values-int (?question $?allowed-values) 
"Función para preguntas que se responden con un entero de entre una lista de valores posibles"

   (printout t ?question crlf)
   (printout t "Possible values: [" 1 "," (length$ ?allowed-values)"]")
   (printout t $?allowed-values crlf)
   (bind ?answer (read))
   (if (lexemep ?answer) then
       (bind ?answer -1)
   )
   (if (integerp ?answer) 
       then (bind ?answer ?answer)
   )
   (while (or (< ?answer 1) (> ?answer (length$ ?allowed-values))) do
      (printout t ?question crlf)
      (printout t "Possible values: [" 1 "," (length$ ?allowed-values)"]")
      (printout t $?allowed-values crlf)    
      (bind ?answer (read))
      (if (lexemep ?answer) then
          (bind ?answer -1)
      )
      (if (integerp ?answer) 
          then (bind ?answer ?answer))
   )
   ?answer)


(deffunction PreguntasMod::ask-question-with-values (?question $?allowed-values) 
"Función para preguntas que se responden con string y con una serie de valores posibles"

   (printout t ?question crlf)
   (printout t "Possible values: ")
   (printout t $?allowed-values crlf)
   (bind ?answer (readline))
   (if (lexemep ?answer) 
       then (bind ?answer ?answer))
   (while (not (member ?answer ?allowed-values)) do
      (printout t ?question crlf)
      (printout t "Possible values: ")
      (printout t $?allowed-values crlf)    
      (bind ?answer (readline))
      (if (lexemep ?answer) 
          then (bind ?answer ?answer)))
   ?answer)

(deffunction PreguntasMod::ask-question-string (?question) 
"Función para preguntas que se responden con una string"

   (printout t ?question)
   (bind ?answer (readline))
   (if (lexemep ?answer) 
       then (bind ?answer ?answer)
   )
   (while (not (lexemep ?answer)) do
      (printout t "Introduce a string" crlf)
      (printout t ?question)
      (bind ?answer (readline))
      (if (lexemep ?answer) 
          then (bind ?answer ?answer)
      )
   )
   ?answer)

(deffunction PreguntasMod::ask-question-integer (?question)
"Función para preguntas que se responden con un entero"

   (printout t ?question)
   (bind ?answer (read))
   (if (integerp ?answer) 
       then (if (> ?answer 1) then (bind ?answer ?answer))
   )
   (while (or(not (integerp ?answer)) (< ?answer 1))  do
      (if (not (integerp ?answer)) then (printout t "Introduce an integer" crlf)
      else (if (< ?answer 1) then (printout t "Introduce an integer bigger than 0" crlf) 
       ))
      (printout t ?question)
      (bind ?answer (read))
      (if (integerp ?answer) 
          then (bind ?answer ?answer)
      )
   )
   ?answer)

(deffunction PreguntasMod::yes-or-no-p (?question)
"Función para preguntas que se responden con sí o no"

   (bind ?response (ask-question-with-values ?question "yes" "no" "y" "n"))
   (if (or (eq ?response "yes") (eq ?response "y"))
       then TRUE 
       else FALSE)
)

;///////////
;REGLAS ///
;/////////

(defrule PreguntasMod::visitor-questions 
"Regla que se encarga de adquirir toda la información necesaria del visitante mediante
pretuntas."

(declare (salience -9999))
   =>
   (bind ?visitor_name
      (ask-question-string "What is your name? "))
   (bind ?number_of_people
      (ask-question-integer "How many people is your group composed of? "))
   (bind ?children
      (yes-or-no-p "Do you have children with you?"))
   (bind ?days
      (ask-question-integer "How many days are you going to stay? "))
   (bind ?time
      (ask-question-integer "How long are you going to stay each day (in hours)? "))
   ;//Filtro del Año 
  (bind ?yearfilter
      (yes-or-no-p "Do you wanna filter the paintings by year?"))
   (if(eq ?yearfilter TRUE) then
       (bind ?year1 (ask-question-integer "Introduce the first year of the range: "))
       (bind ?year2 (ask-question-integer "Introduce the final year of the range: "))
       (while (< ?year2 ?year1) 
           (printout t "The second year must be bigger than the first" crlf);
           (bind ?year2 (ask-question-integer "Introduce the final year of the range: "))
       )
       (assert (YearFilters (firstYear ?year1) (lastYear ?year2)))
   else 
       (assert (YearFilters (firstYear -1) (lastYear 9999)))
   ) 
   ;//Filtro de Nacionalidad
   (bind ?nationalityfilter
       (yes-or-no-p "Do you wanna filter the paintings by nationality of the author?"))
   (if (eq ?nationalityfilter TRUE) then
        (bind $?nationalities (find-all-instances((?m Country)) TRUE))
        (nationality-filter $?nationalities)
   )
   ;//////////////
   ;Empieza el test para determinar el conocimiento del visitante
   ;//////////////
   (bind ?points 0)
   (printout t "Let's see how much you know about art..." crlf)
   (printout t ?points crlf)
   (bind ?response 
      (ask-question-with-values-int "Who is the author of 'The Lily Pads'? "
                    "Monet" "Manet"))
      (if(eq ?response 1) then (bind ?points (+ ?points 10)))
   (printout t ?points crlf)
   (bind ?response
      (ask-question-with-values-int "Which style does the painting 'In the car' by Roy Lichtenstein belong to? "
                    "Hyperrealism" "Op-Art" "Pop-Art" "Graffiti"))
      (if(eq ?response 3) then (bind ?points (+ ?points 10)))
   (printout t ?points crlf) 
   (bind ?response
      (ask-question-with-values-int "Who composed 'Moonlight Sonata'? "
                    "Mozart" "Bach" "Beethoven" "Brahms"))
      (if(eq ?response 3) then (bind ?points (+ ?points 10)))
   (printout t ?points crlf)   
   (bind ?response
      (ask-question-with-values-int "Which of the following paintings belongs to the modernism? "
                    "Penitent Magdalena" "The Virgin" "Portrait of a philosopher" "Roe with a landscape in the background"))
      (if(eq ?response 2) then (bind ?points (+ ?points 10)))
   (printout t ?points crlf) 
   (bind ?response
      (ask-question-with-values-int "Where is the 'Monument to the Little Mermaid' located?" "Copenhague" "Berlin" "Stockholm" "Oslo"))
      (if(eq ?response 1) then (bind ?points (+ ?points 10)))
   (printout t ?points crlf)
   (bind ?response
      (ask-question-with-values-int "What's the name of a famous Edvard Munch picture?" "The Terror" "The Scream" "The Wind" "The Bridge"))
      (if(eq ?response 2) then (bind ?points (+ ?points 10)))
   (printout t ?points crlf)
   (bind ?response
      (ask-question-with-values-int "Which styles does the Notre Dame catheral combine?" "Romanic and gothic" "Gothic and baroque" "Romantic and rococo" "Byzantine and gothic"))
      (if(eq ?response 1) then (bind ?points (+ ?points 10)))
   (printout t ?points crlf)
   (bind ?response
      (ask-question-with-values-int "Which style does Gustav Klimpt represent?" "Postmodernism" "Art Nouveau"))
      (if(eq ?response 2) then (bind ?points (+ ?points 10)))
   (printout t ?points crlf)
   (bind ?response
      (ask-question-with-values-int "Sandro Botticelli painted the birth of which of these goddesses?" "Artemis" "Venus" "Hera" "Atenea"))
      (if(eq ?response 2) then (bind ?points (+ ?points 10)))  
   (printout t ?points crlf)
   (bind ?response
      (ask-question-with-values-int "Which of the following paintings from Dali features a melting clock?" "The first days of spring" "The persistence of memory" "Living dead nature" "The accomodations of the wishes"))
      (if(eq ?response 2) then (bind ?points (+ ?points 10)))  
   (printout t "Total points: " ?points crlf)   
    (if(> ?points 80)
        then(printout t "Well done you little art nerd!" crlf)
    else (if(> ?points 40)
        then(printout t "Meeeh, that was okay I guess..." crlf)
    else (printout t "I don't know why you are wasting your money in an art museum if you don't know anything, but hey, it's your money" crlf)))
   
    ;Se crea la instancia del visitante y se le añade la información que ya tenemos
    (bind ?visitor_instance (make-instance visitor of Visitor))
    (send ?visitor_instance put-Visitor+name ?visitor_name)
    (send ?visitor_instance put-Days ?days)
    (send ?visitor_instance put-Duration (* 3600 ?time))
    (send ?visitor_instance put-Number+of+people ?number_of_people)
    (send ?visitor_instance put-Knowledge ?points)
    (send ?visitor_instance put-Children ?children)

    ;Empezamos a comprobar las preferencias del visitante y a añadirlas

    ;Comprobamos las preferencias del visitante respecto a autores
    (bind ?count 1)
    (printout t "Alright, let's check your preferences now." crlf)
    (printout t "We'll start with the authors. For each author you like, type his number and press ENTER. Type 'done' when you are done" crlf);
    (printout t "Here are all the authors available:" crlf)
    (bind $?aux (find-all-instances((?m Author)) TRUE))
    (loop-for-count (?i 1 (length$ ?aux)) do
        (printout t ?i ". ")
        (printout t (send (nth$ ?i ?aux) get-Author+name) crlf)
    )
    (add-preference-number Author Author+name ?count ?visitor_instance $?aux)

    ;Comprobamos las preferencias del visitante respecto a estilos
    (printout t "Good. Now same thing for the styles. For each style you like, type its name and press ENTER. Type 'done' when you are done" crlf);
    (printout t "Here are all the styles available:" crlf)
    (bind $?aux (find-all-instances((?m Style)) TRUE))
    (loop-for-count (?i 1 (length$ ?aux)) do
        (printout t ?i ". ")
        (printout t (send (nth$ ?i ?aux) get-Style+name) crlf)
    )    
    (add-preference-number Style Style+name ?count ?visitor_instance $?aux)

    ;Comprobamos las preferencias del visitante respecto a periodos pictóricos
    (printout t "Almost done. We also need to know which periods you prefer. For each period you like, type its name and press ENTER. Type 'done' when you are done" crlf);
    (printout t "Here are all the periods available:" crlf)
    (bind $?aux (find-all-instances((?m Period)) TRUE))
    (loop-for-count (?i 1 (length$ ?aux)) do
        (printout t ?i ". ")
        (printout t (send (nth$ ?i ?aux) get-Period+name) crlf)
    )
    (add-preference-number Period Period+name ?count ?visitor_instance $?aux)

    ;Comprobamos las preferencias del visitante respecto a temas
    (printout t "Last step! Tell us about the topics you like the most. For each topic you like, type its name and press ENTER. Type 'done' when you are done" crlf);
    (printout t "Here are all the topic available:" crlf)
    (bind $?aux (find-all-instances((?m Topic)) TRUE))
    (loop-for-count (?i 1 (length$ ?aux)) do
        (printout t ?i ". ")
        (printout t (send (nth$ ?i ?aux) get-Topic+name) crlf)
    ) 
    (add-preference-number Topic Topic+name ?count ?visitor_instance $?aux)

)